module parser.tree.node;

import parser.tree.visitor;

abstract class Node(T)
{
    abstract T accept(Visitor!(T) v) const;

    abstract override string toString() const;
}
