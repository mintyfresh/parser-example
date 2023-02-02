import std;

import lexer;

void main()
{
	auto l = Lexer(`
		let x = 5 + (3 * 2)
	`);

	foreach (token; l.filter!(f => !f.rule.discard))
	{
		writeln(token);
	}
}
