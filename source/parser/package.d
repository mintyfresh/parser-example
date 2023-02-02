module parser;

public
{
    import parser.tree;
}

import lexer.rule;
import lexer.token;

import std.traits : ForeachType;

struct Parser(TokenStream)
    if (is(ForeachType!(TokenStream) == Token))
{
private:
    TokenStream _tokens;
    Token       _prev;

public:
    this(TokenStream tokens)
    {
        _tokens = tokens;
    }

    Node parse()
    {
        Node[] statements;

        while (!accept(Rules.eof))
        {
            statements ~= statement();
        }

        expect(Rules.eof);

        return new RootNode(statements);
    }

    Node statement()
    {
        if (accept(Rules.keyLet))
        {
            expect(Rules.identifier);
            auto left = new IdentifierNode(_prev.value);

            expect(Rules.opAssign);
            auto right = expression();

            return new VariableDeclarationNode(left, right);
        }

        if (accept(Rules.keyPuts))
        {
            auto expr = expression();
            return new PutsNode(expr);
        }

        return expression();
    }

    ExpressionNode expression()
    {
        return assignment();
    }

    ExpressionNode assignment()
    {
        auto left = bitwise();

        if (accept(Rules.opAssign))
        {
            auto operator = _prev.value;
            auto right = bitwise();

            return new AssignmentNode(operator, left, right);
        }

        return left;
    }

    ExpressionNode bitwise()
    {
        auto left = additive();

        if (accept(Rules.opBitAnd, Rules.opBitOr, Rules.opBitXor))
        {
            auto operator = _prev.value;
            auto right = bitwise();

            return new ArithmeticNode(operator, left, right);
        }

        return left;
    }

    ExpressionNode additive()
    {
        auto left = multiplicative();

        if (accept(Rules.opAdd, Rules.opSubtract))
        {
            auto operator = _prev.value;
            auto right = additive();

            return new ArithmeticNode(operator, left, right);
        }

        return left;
    }

    ExpressionNode multiplicative()
    {
        auto left = terminal();

        if (accept(Rules.opMultiply, Rules.opDivide, Rules.opModulo))
        {
            auto operator = _prev.value;
            auto right = multiplicative();

            return new ArithmeticNode(operator, left, right);
        }

        return left;
    }

    ExpressionNode terminal()
    {
        import std.string : format;

        if (accept(Rules.litInteger))
        {
            import std.conv : to;

            return new IntegerNode(_prev.value.to!(long));
        }
        if (accept(Rules.identifier))
        {
            return new IdentifierNode(_prev.value);
        }
        if (accept(Rules.parenLeft))
        {
            auto inner = expression();
            expect(Rules.parenRight);

            return inner;
        }

        assert(false, "Expected terminal, got %s".format(_tokens.front));
    }

private:
    void advance()
    {
        _prev = _tokens.front;
        _tokens.popFront;
    }

    bool accept(Rule[] rules...)
    {
        foreach (rule; rules)
        {
            if (_tokens.empty)
            {
                return rule == Rules.eof;
            }
            else if (_tokens.front.rule == rule)
            {
                advance();

                return true;
            }
        }

        return false;
    }

    void expect(Rule[] rules...)
    {
        import std.string : format;

        assert(accept(rules), "Expected one of: %s".format(rules));
    }
}

auto makeParser(TokenStream)(TokenStream tokens)
    if (is(ForeachType!(TokenStream) == Token))
{
    return Parser!(TokenStream)(tokens);
}
