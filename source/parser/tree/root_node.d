module parser.tree.root_node;

import parser.tree.node;
import parser.tree.visitable;

class RootNode(T) : Node!(T)
{
    mixin Visitable!(T);

private:
    Node!(T)[] _statements;

public:
    this(Node!(T)[] statements)
    {
        _statements = statements;
    }

    @property
    const(Node!(T)[]) statements() const
    {
        return _statements;
    }

    override string toString() const
    {
        import std.string : format;

        return "RootNode(statements: %s)".format(_statements);
    }
}
