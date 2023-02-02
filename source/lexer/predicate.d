module lexer.predicate;

alias LexerPredicate = bool function(string input, out string match);

enum LexerPredicate exact(string str) = (string input, out string match) {
    import std.algorithm : startsWith;

    if (input.length > 0 && input.startsWith(str))
    {
        match = str;

        return true;
    }

    return false;
};

enum LexerPredicate range(char from, char to) = (string input, out string match) {
    if (input.length > 0 && input[0] >= from && input[0] <= to)
    {
        match = input[0..1];

        return true;
    }

    return false;
};

enum LexerPredicate sequence(predicates...) = (string input, out string match) {
    string result;

    foreach (predicate; predicates)
    {
        string submatch;

        if (!predicate(input, submatch))
        {
            return false;
        }

        result ~= submatch;
        input = input[submatch.length..$];
    }

    match = result;

    return true;
};

enum LexerPredicate optional(LexerPredicate predicate) = (string input, out string match) {
    string submatch;

    if (predicate(input, submatch))
    {
        match = submatch;

        return true;
    }

    match = "";

    return true;
};

enum LexerPredicate anyOf(predicates...) = (string input, out string match) {
    string submatch;

    static foreach (predicate; predicates)
    {
        if (predicate(input, submatch))
        {
            match = submatch;

            return true;
        }
    }

    return false;
};

enum LexerPredicate oneOrMore(LexerPredicate predicate) = (string input, out string match) {
    string result;
    string submatch;

    while (predicate(input, submatch))
    {
        result ~= submatch;
        input = input[submatch.length..$];
    }

    if (result.length == 0)
    {
        return false;
    }

    match = result;

    return true;
};

enum LexerPredicate zeroOrMore(LexerPredicate predicate) = (string input, out string match) {
    string result;
    string submatch;

    while (predicate(input, submatch))
    {
        result ~= submatch;
        input = input[submatch.length..$];
    }

    match = result;

    return true;
};

enum LexerPredicate not(LexerPredicate predicate) = (string input, out string match) {
    string submatch;

    if (predicate(input, submatch))
    {
        return false;
    }

    if (input.length > 0)
    {
        match = input[0..1];
    }
    else
    {
        match = "";
    }

    return true;
};

enum LexerPredicate custom(bool function (string input) callback) = (string input, out string match) {
    if (callback(input))
    {
        match = input[0..1];

        return true;
    }

    return false;
};

enum LexerPredicate boolean(LexerPredicate predicate) = (string input, out string match) {
    string submatch;

    if (predicate(input, submatch))
    {
        match = "";

        return true;
    }

    return false;
};
