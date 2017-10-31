# bnf-to-parsec
generate a parsec parser + datatype from a bnf grammar


GOAL: read this and spit out: ADT + parser (https://docs.python.org/3/reference/grammar.html)


Grammar:

```
(define <grammar>
  (many1 <production>))

(define <production>
  (<nonterm> (literal ':') <alts>))

(define <tokens>
  (many <token>))

(define <alts>
  <tokens> (many (literal '|') <tokens>))

(define <token>
  (anyof '(<term> <nonterm>
           (sequence (literal '[') <tokens> (literal ']'))
           (sequence (literal '(') <alts> (literal ')') (optional (or (literal '*') (literal '+'))))
          )))

(define <nonterm>
  snake_case_ident)

(define <term>
  (anyof '(literal_string ALL_CAPS_TOKEN)))
```
