# Physical Notebook Protocol

The physical notebook is the learner's primary thinking surface.

## One spread = one important idea

Recommended structure:

### Left page
- topic name
- explanation in own words
- diagram
- formula
- key vocabulary

### Right page
- hypothesis
- experiment
- observation
- mistake
- conclusion

## Mandatory handwritten content

Prefer handwriting for:

- system diagrams
- causal chains
- formulas
- confusion matrices
- short comparison tables
- predictions
- mistakes
- final conclusions

## Do not copy by hand

Avoid copying:

- large code listings
- dependency lists
- boilerplate
- API references
- raw logs
- long documentation excerpts

## "I thought / actually" block

Use whenever a misconception is corrected.

Example:

I thought:
HttpOnly prevents a cookie from being sent.

Actually:
The browser can still send the cookie to the server; JavaScript cannot read it.

Why it matters:
Transport behavior and JavaScript access are different layers.

## Connection rule

Every major topic should be connected to at least one earlier concept.

Example:

BrowserContext
-> cookies
-> session isolation
-> automation
-> telemetry
-> detection signals
