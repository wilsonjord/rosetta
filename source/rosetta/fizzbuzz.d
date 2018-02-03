/**
This module provides a generalised solution to the "fizzbuzz" problem as stated by http://rosettacode.org/wiki/General_FizzBuzz
*/
module rosetta.fizzbuzz;

import std.algorithm;
import std.range : array, empty, take;
import std.conv : to;
import std.typecons : Tuple, tuple;

struct FizzBuzz {
    private Tuple!(int,string)[] words;
    private uint index=1;

    enum empty = false; // inf range
    @property {
        auto front() {
            auto x = words.map!(a => index % a[0] == 0 ? a[1] : "").joiner.to!string;
            return (!x.empty) ? x : index.to!string;
        }
        auto popFront() { index++; }
    }

    this (Tuple!(int,string)[] w ...) {
        words = w.sort!((a,b) => a[0] < b[0]).array;
    }
}

/**
Produces a "fizzbuzz" range of strings, given a list of factors, and their associated words.

The value of an element depends upon it's index in the range, and arguments supplied.
If the index is a multiple of one of the arguments, then the element will be the word associated with that argument.
If the index is a multiple of several arguments, then the element will be a combination of the words associated with those argument, in ascending factor order.
If the index is not a multiple of any arguments, then the element will be a string representation of the index itself.

*/
auto fizzBuzz (Tuple!(int,string)[] w ...) {
    return FizzBuzz(w);
}

///
unittest {
    import std.typecons : tuple;
    import std.algorithm : equal;
    import std.range : drop, take;

    auto fb = fizzBuzz(tuple(2,"fizz"),tuple(4,"buzz"));
    assert (fb.front == "1");
    assert (fb.drop(1).front == "fizz");
    assert (fb.take(5)
              .equal(["1","fizz","3","fizzbuzz","5"]));

}