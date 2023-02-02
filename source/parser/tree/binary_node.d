module parser.tree.binary_node;

import parser.tree.expression_node;

abstract class BinaryNode(T) : ExpressionNode!(T)
{
private:
    ExpressionNode!(T) _left;
    ExpressionNode!(T) _right;

public:
    this(ExpressionNode!(T) left, ExpressionNode!(T) right)
    {
        _left  = left;
        _right = right;
    }

    @property
    const(ExpressionNode!(T)) left() const
    {
        return _left;
    }

    @property
    const(ExpressionNode!(T)) right() const
    {
        return _right;
    }
}
