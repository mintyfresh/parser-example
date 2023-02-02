module parser.tree.identifier_node;

import parser.tree.expression_node;
import parser.tree.visitable;

class IdentifierNode(T) : ExpressionNode!(T)
{
    mixin Visitable!(T);

private:
    string _name;

public:
    this(string name)
    {
        _name = name;
    }

    @property
    string name() const
    {
        return _name;
    }

    override string toString() const
    {
        import std.string : format;

        return "IdentifierNode(name: %s)".format(name);
    }
}
