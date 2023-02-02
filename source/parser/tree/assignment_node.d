module parser.tree.assignment_node;

import parser.tree.binary_node;
import parser.tree.expression_node;

class AssignmentNode : BinaryNode
{
private:
    string _operator;

public:
    this(string operator, ExpressionNode left, ExpressionNode right)
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

        return "AssignmentNode(operator: %s, left: %s, right: %s)".format(
            operator, left, right
        );
    }
}
