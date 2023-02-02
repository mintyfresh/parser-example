import std;

import lexer;
import parser;
import interpreter;

void main()
{
	auto lexer = Lexer(`
		let x = 5 + (3 * 2)
		puts x

		x = x + 1
		puts x

		let y = (5 + 3) * 2
		puts y
		puts x + y
	`);

	foreach (token; lexer.filter!(f => !f.rule.discard))
	{
		writeln(token);
	}

	auto parser = makeParser!(long)(lexer.filter!(f => !f.rule.discard));
	auto tree   = parser.parse();
	tree.writeln;

	auto interpreter = new Interpreter;
	tree.accept(interpreter);
}
