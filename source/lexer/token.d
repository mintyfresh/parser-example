module lexer.token;

import lexer.rule;

struct Token
{
private:
    Rule   _rule;
    string _value;
    size_t _offset;
    size_t _line;
    size_t _column;

public:
    this(Rule rule, string value, size_t offset, size_t line, size_t column)
    {
        _rule   = rule;
        _value  = value;
        _offset = offset;
        _line   = line;
        _column = column;
    }

    @property
    Rule rule() const
    {
        return _rule;
    }

    @property
    string value() const
    {
        return _value;
    }

    @property
    size_t offset() const
    {
        return _offset;
    }

    @property
    size_t line() const
    {
        return _line;
    }

    @property
    size_t column() const
    {
        return _column;
    }
}
