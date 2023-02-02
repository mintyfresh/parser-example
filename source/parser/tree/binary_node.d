module parser.tree.binary_node;

import parser.tree.expression_node;

abstract class BinaryNode : ExpressionNode
{
private:
    ExpressionNode _left;
    ExpressionNode _right;

public:
    this(ExpressionNode left, ExpressionNode right)
    {
        _left  = left;
        _right = right;
    }

    @property
    const(ExpressionNode) left() const
    {
        return _left;
    }

    @property
    const(ExpressionNode) right() const
    {
        return _right;
    }
}
