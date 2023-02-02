module interpreter;

import parser.tree;
import parser.tree.visitor;

class Interpreter : Visitor!(long)
{
private:
    long[string] variables;

public:
    override long visit(const ArithmeticNode!(long) node)
    {
        switch(node.operator)
        {
            case "+":
                return node.left.accept(this) + node.right.accept(this);

            case "-":
                return node.left.accept(this) - node.right.accept(this);

            case "*":
                return node.left.accept(this) * node.right.accept(this);

            case "**":
                return node.left.accept(this) ^^ node.right.accept(this);

            case "/":
                return node.left.accept(this) / node.right.accept(this);

            case "%":
                return node.left.accept(this) % node.right.accept(this);

            case "^":
                return node.left.accept(this) ^ node.right.accept(this);

            case "&":
                return node.left.accept(this) & node.right.accept(this);

            case "|":
                return node.left.accept(this) | node.right.accept(this);

            default:
                assert(0);
        }
    }

    override long visit(const AssignmentNode!(long) node)
    {
        // this is a hack done for the purposes of speed
        if (auto variable = cast(const IdentifierNode!(long)) node.left)
        {
            if (auto ptr = variable.name in variables)
            {
                return *ptr = node.right.accept(this);
            }
            else
            {
                assert(0, "Variable " ~ variable.name ~ " not declared");
            }
        }
        else
        {
            assert(0, "Expected an identifier");
        }
    }

    override long visit(const IdentifierNode!(long) node)
    {
        if (auto ptr = node.name in variables)
        {
            return *ptr;
        }
        else
        {
            assert(0, "Variable " ~ node.name ~ " not declared");
        }
    }

    override long visit(const IntegerNode!(long) node)
    {
        return node.value;
    }

    override long visit(const PutsNode!(long) node)
    {
        import std.stdio;
        
        long value = node.expression.accept(this);
        writeln("puts: ", value);

        return value;
    }

    override long visit(const RootNode!(long) node)
    {
        long value = 0;

        foreach (statement; node.statements)
        {
            value = statement.accept(this);
        }

        return value;
    }

    override long visit(const VariableDeclarationNode!(long) node)
    {
        if (node.left.name in variables)
        {
            assert(0, "Variable " ~ node.left.name ~ " already declared");
        }
        else
        {
            return variables[node.left.name] = node.right.accept(this);
        }
    }
}
