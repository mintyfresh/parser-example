module parser.tree.visitable;

mixin template Visitable(T)
{
    import parser.tree.visitor;

    override T accept(Visitor!(T) visitor) const
    {
        return visitor.visit(this);
    }
}
