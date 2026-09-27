# AI Code Policy

AI-generated code is allowed from day one.

## Allowed

- scaffolding
- boilerplate
- example services
- Playwright experiments
- SQL examples
- test fixtures
- data-loading code
- model baselines
- debugging suggestions
- code review

## Required understanding

Before meaningful code is accepted, the learner should understand:

- purpose;
- input;
- output;
- state;
- key control flow;
- relevant dependency;
- one plausible failure mode.

## Manual code is selective

The learner may be asked to manually write:

- a small condition;
- a short function;
- a SQL query;
- a transformation;
- a formula;
- a debugging patch;
- a change to an existing program.

This is used to expose reasoning, not to test typing endurance.

## Demonstration principle

Prefer:

> Here is a 25-line experiment that proves a browser-state property.

over:

> Here is a 400-line application that happens to contain the same property.
