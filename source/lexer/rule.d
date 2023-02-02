module lexer.rule;

import lexer.predicate;

import std.ascii;

enum RuleType
{
    standard,
    discard,
    system,
    fragment
}

struct Rule
{
    string name;
    LexerPredicate predicate;
    RuleType type;

    alias predicate this;

    this(string name, LexerPredicate predicate, RuleType type = RuleType.standard)
    in
    {
        assert(name);

        if (predicate is null)
        {
            assert(type == RuleType.system);
        }
        else
        {
            assert(type != RuleType.system);
        }
    }
    do
    {
        this.name      = name;
        this.predicate = predicate;
        this.type      = type;
    }

    @property
    bool standard() const
    {
        return type == RuleType.standard;
    }

    @property
    bool discard() const
    {
        return type == RuleType.discard;
    }

    @property
    bool system() const
    {
        return type == RuleType.system;
    }

    @property
    bool fragment() const
    {
        return type == RuleType.fragment;
    }

    string toString() const
    {
        return "Rule(" ~ name ~ ")";
    }
}

enum Rules : Rule
{
    // Discardable

    whitespace = Rule(
        "whitespace",
        oneOrMore!(
            custom!((input) => input.length > 0 && input[0].isWhite)
        ),
        RuleType.discard
    ),

    inlineComment = Rule(
        "inlineComment",
        sequence!(
            exact!("//"),
            zeroOrMore!(
                not!(exact!("\n"))
            )
        ),
        RuleType.discard
    ),

    // Keywords

    // Ensures that keywords are not part of an identifer
    // e.g. "if" is not part of "iffy"
    notPartOfAnIdentifier = Rule(
        "notPartOfAnIdentifier",
        boolean!(
            not!(
                identifierFollow
            )
        ),
        RuleType.fragment
    ),

    keyLet = Rule(
        "keyLet",
        sequence!(
            exact!("let"),
            notPartOfAnIdentifier
        )
    ),

    keyPuts = Rule(
        "keyPuts",
        sequence!(
            exact!("puts"),
            notPartOfAnIdentifier
        )
    ),

    // Operators

    opAssign = Rule(
        "opAssign",
        exact!("=")
    ),

    opShiftLeft = Rule(
        "opShiftLeft",
        exact!("<<")
    ),
    opShiftRight = Rule(
        "opShiftRight",
        exact!(">>")
    ),

    opAdd = Rule(
        "opAdd",
        exact!("+")
    ),
    opSubtract = Rule(
        "opSubtract",
        exact!("-")
    ),
    opExponent = Rule(
        "opExponent",
        exact!("**")
    ),
    opMultiply = Rule(
        "opMultiply",
        exact!("*")
    ),
    opDivide = Rule(
        "opDivide",
        exact!("/")
    ),
    opModulo = Rule(
        "opModulo",
        exact!("%")
    ),

    opBitAnd = Rule(
        "opBitAnd",
        exact!("&")
    ),
    opBitOr = Rule(
        "opBitOr",
        exact!("|")
    ),
    opBitXor = Rule(
        "opBitXor",
        exact!("^")
    ),

    // Syntax

    parenLeft = Rule(
        "parenLeft",
        exact!("(")
    ),
    parenRight = Rule(
        "parenRight",
        exact!(")")
    ),

    // Literals

    litIntegerDigit = Rule(
        "litIntegerDigit",
        range!('0', '9'),
        RuleType.fragment
    ),

    litInteger = Rule(
        "litInteger",
        sequence!(
            litIntegerDigit,
            zeroOrMore!(
                sequence!(
                    zeroOrMore!(
                        exact!("_")
                    ),
                    litIntegerDigit
                )
            )
        )
    ),

    // Identifiers

    identifierFirst = Rule(
        "identifierFirst",
        anyOf!(
            exact!("_"),
            range!('a', 'z'),
            range!('A', 'Z')
        ),
        RuleType.fragment
    ),

    identifierFollow = Rule(
        "identifierFollow",
        anyOf!(
            identifierFirst,
            range!('0', '9')
        ),
        RuleType.fragment
    ),

    identifier = Rule(
        "identifier",
        sequence!(
            identifierFirst,
            zeroOrMore!(
                identifierFollow
            )
        )
    ),

    // Internal

    eof = Rule(
        "EOF",
        null,
        RuleType.system
    ),

    error = Rule(
        "error",
        null,
        RuleType.system
    )
}
