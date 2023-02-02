module parser.tree.puts_node;

import parser.tree.expression_node;
import parser.tree.node;
import parser.tree.visitable;

class PutsNode(T) : Node!(T)
{
    mixin Visitable!(T);

private:
    ExpressionNode!(T) _expression;

public:
    this(ExpressionNode!(T) expression)
    {
        _expression = expression;
    }

    @property
    const(ExpressionNode!(T)) expression() const
    {
        return _expression;
    }

    override string toString() const
    {
        import std.string : format;

        return "PutsNode(expression: %s)".format(expression);
    }
}
