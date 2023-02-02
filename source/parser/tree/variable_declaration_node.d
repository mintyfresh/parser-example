module parser.tree.variable_declaration_node;

import parser.tree.expression_node;
import parser.tree.identifier_node;
import parser.tree.node;
import parser.tree.visitable;

class VariableDeclarationNode(T) : Node!(T)
{
    mixin Visitable!(T);

private:
    IdentifierNode!(T) _left;
    ExpressionNode!(T) _right;

public:
    this(IdentifierNode!(T) left, ExpressionNode!(T) right)
    {
        _left  = left;
        _right = right;
    }

    @property
    const(IdentifierNode!(T)) left() const
    {
        return _left;
    }

    @property
    const(ExpressionNode!(T)) right() const
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
