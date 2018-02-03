import rosetta.fizzbuzz;
import rosetta.lettercount;

import std.stdio : writeln;
void main(){
	import std.typecons : tuple;
	import std.range : take;
	fizzBuzz (tuple(5,"test"),tuple(6,"test2")).take(100).writeln;
	
	letterCount ("hello world").writeln;
}
