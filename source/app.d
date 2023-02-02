import std;

import lexer;
import parser;

void main()
{
	auto lexer = Lexer(`
		let x = 5 + (3 * 2)

		x = x + 1

		puts x
	`);

	foreach (token; lexer.filter!(f => !f.rule.discard))
	{
		writeln(token);
	}

	auto parser = makeParser(lexer.filter!(f => !f.rule.discard));
	auto tree   = parser.parse();

	tree.writeln;
}
