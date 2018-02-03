/**
This module provides a solution to the "Letter frequency" problem as stated by http://rosettacode.org/wiki/Letter_frequency
*/
module rosetta.lettercount;


auto getModeFunction (CountMode m) {
    import std.ascii : isAlpha, isAlphaNum;
    final switch (m) {
        case CountMode.alphaOnly: return &isAlpha;
        case CountMode.alphaNumeric: return &isAlphaNum;
        case CountMode.all: return (dchar) => true;
    }
}

/**
Given a character range, produces an associtive array (a key/value container)

Params:
    rng = A range of characters
    mode = Which characters to count

*/
auto letterCount(Range) (Range rng, CountMode mode=CountMode.alphaOnly) {
    import std.ascii : toLower, isAlpha, lowercase; // string a..z
    import std.algorithm : map, filter;
    import std.utf : byChar;
    import std.conv : to;

    int[string] freq;
    auto checkFunc = getModeFunction(mode);
    foreach (c; rng.map!(a => a.toLower).filter!(a => checkFunc(a))) {
        freq[c.to!string]++;
    }
    return freq;
}

///
enum CountMode {alphaOnly, alphaNumeric, all}

///
unittest {
    assert (letterCount ("hello world 123").get("l",0)==3);
    assert (letterCount ("hello world 123").get("2",0)==0);
    assert (letterCount ("hello world 123",CountMode.alphaNumeric).get("2",0)==1);
    assert (letterCount ("hello world 123",CountMode.alphaNumeric).get(" ",0)==0);
    assert (letterCount ("hello world 123",CountMode.all).get(" ",0)==2);
}