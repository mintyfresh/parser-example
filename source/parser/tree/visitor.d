module parser.tree.visitor;

import parser.tree.arithmetic_node;
import parser.tree.assignment_node;
import parser.tree.identifier_node;
import parser.tree.integer_node;
import parser.tree.puts_node;
import parser.tree.root_node;
import parser.tree.variable_declaration_node;

interface Visitor(T)
{
    T visit(const ArithmeticNode!(T) node);
    T visit(const AssignmentNode!(T) node);
    T visit(const IdentifierNode!(T) node);
    T visit(const IntegerNode!(T) node);
    T visit(const PutsNode!(T) node);
    T visit(const RootNode!(T) node);
    T visit(const VariableDeclarationNode!(T) node);
}
