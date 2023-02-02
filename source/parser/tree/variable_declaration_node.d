module parser.tree.variable_declaration_node;

import parser.tree.expression_node;
import parser.tree.identifier_node;
import parser.tree.node;

class VariableDeclarationNode : Node
{
private:
    IdentifierNode _left;
    ExpressionNode _right;

public:
    this(IdentifierNode left, ExpressionNode right)
    {
        _left  = left;
        _right = right;
    }

    @property
    const(IdentifierNode) left() const
    {
        return _left;
    }

    @property
    const(ExpressionNode) right() const
    {
        return _right;
    }

    override string toString() const
    {
        import std.string : format;

        return "VariableDeclarationNode(left: %s, right: %s)".format(
            left, right
        );
    }
}
