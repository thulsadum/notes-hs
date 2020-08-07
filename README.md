# notes

My approach to the rosetta code task [Take notes on the command line](http://rosettacode.org/wiki/Take_notes_on_the_command_line).

## Lessons learned

  * It was actually fun.
  * Stack eases dependency hell of cabal.
  * Test-driven developement (TDD) with a strong type system is even more fun than TDD alone.

## Open issues

  * How to check for side effects with hspec? This application os actualy just a collection of side effects. The 'pure core' is solely the `prependTimeStamp` function.
  * What would TDD + dependently typed system feel like (i.e. TDD in Idris)?

## build
```
stack build
```

## run

Show NOTES.txt.

```
stack run
```

Add a note to NOTES.txt.

```
stack run -- memo to self: this is my first running haskell application.
```