module parser.tree.arithmetic_node;

import parser.tree.binary_node;
import parser.tree.expression_node;
import parser.tree.visitable;

class ArithmeticNode(T) : BinaryNode!(T)
{
    mixin Visitable!(T);

private:
    string _operator;

public:
    this(string operator, ExpressionNode!(T) left, ExpressionNode!(T) right)
    {
        super(left, right);

        _operator = operator;
    }

    @property
    string operator() const
    {
        return _operator;
    }

    override string toString() const
    {
        import std.string : format;

        return "ArithmeticNode(operator: %s, left: %s, right: %s)".format(
            operator, left, right
        );
    }
}
