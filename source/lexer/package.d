module lexer;

public
{
    import lexer.rule;
    import lexer.token;
}

struct Lexer
{
private:
    string _input;
    string _front;

    size_t _offset;
    size_t _line;
    size_t _column;

public:
    this(string input)
    {
        _input  = input;
        _offset = 0;
        _line   = 1;
        _column = 1;
    }

    this(Lexer lexer)
    {
        _input  = lexer._input;
        _offset = lexer._offset;
        _line   = lexer._line;
        _column = lexer._column;
    }

    @property
    bool empty() const
    {
        return buffer.length == 0;
    }

    @property
    Token front()
    {
        import std.traits : EnumMembers;

        if (empty)
        {
            return token(Rules.eof, "");
        }

        static foreach (rule; EnumMembers!(Rules))
        {
            static if (rule.standard || rule.discard)
            {
                if (rule.predicate(buffer, _front))
                {
                    return token(rule, _front);
                }
            }
        }

        return token(Rules.error, buffer);
    }

    void popFront()
    {
        foreach (ch; _front)
        {
            switch (ch)
            {
                case '\n':
                    _line++;
                    _column = 1;
                    break;

                case '\t':
                    _column += 4 - (_column - 1) % 4;
                    break;

                default:
                    _column++;
                    break;
            }
        }

        _offset += _front.length;
        _front   = null;
    }

    @property
    Lexer save() const
    {
        return Lexer(this);
    }

private:
    @property
    string buffer() const
    {
        return _input[_offset .. $];
    }

    Token token(Rule rule, string value)
    {
        return Token(rule, value, _offset, _line, _column);
    }
}
