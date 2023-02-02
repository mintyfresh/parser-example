module parser.tree.root_node;

import parser.tree.node;

class RootNode : Node
{
private:
    Node[] _statements;

public:
    this(Node[] statements)
    {
        _statements = statements;
    }

    @property
    Node[] statements()
    {
        return _statements;
    }

    override string toString() const
    {
        import std.string : format;

        return "RootNode(statements: %s)".format(_statements);
    }
}
