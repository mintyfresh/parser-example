module parser.tree.identifier_node;

import parser.tree.expression_node;

class IdentifierNode : ExpressionNode
{
private:
    string _value;

public:
    this(string value)
    {
        _value = value;
    }

    @property
    string value() const
    {
        return _value;
    }

    override string toString() const
    {
        import std.string : format;

        return "IdentifierNode(value: %s)".format(value);
    }
}
