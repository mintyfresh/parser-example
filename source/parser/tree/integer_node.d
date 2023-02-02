module parser.tree.integer_node;

import parser.tree.expression_node;
import parser.tree.visitable;

class IntegerNode(T) : ExpressionNode!(T)
{
    mixin Visitable!(T);

private:
    long _value;

public:
    this(long value)
    {
        _value = value;
    }

    @property
    long value() const
    {
        return _value;
    }

    override string toString() const
    {
        import std.string : format;

        return "IntegerNode(value: %s)".format(value);
    }
}
