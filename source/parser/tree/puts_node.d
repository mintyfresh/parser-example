module parser.tree.puts_node;

import parser.tree.expression_node;
import parser.tree.node;

class PutsNode : Node
{
private:
    ExpressionNode _expression;

public:
    this(ExpressionNode expression)
    {
        _expression = expression;
    }

    @property
    const(ExpressionNode) expression() const
    {
        return _expression;
    }

    override string toString() const
    {
        import std.string : format;

        return "PutsNode(expression: %s)".format(expression);
    }
}
