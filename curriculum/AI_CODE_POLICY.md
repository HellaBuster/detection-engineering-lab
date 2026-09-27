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

## Generated code and mastery

Generated code may be used even during an assessment when implementation syntax is not the competency being tested.

The evaluator must separate:

- implementation assistance;
- conceptual assistance.

Example:

If the learner independently decides to compare pre/post-release score distributions and asks AI to write the plotting boilerplate, the reasoning may still belong to the learner.

If AI decides what data to inspect, which comparison to make, what result means, and what action to take, the attempt is substantially AI-led and cannot be treated as independent mastery evidence.
