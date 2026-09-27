# Real-World Data Policy

## Priority order

Labs should prefer:

1. `REAL_PUBLIC_DATA`
2. `REAL_PERMITTED_SITE`
3. `REAL_OWN_LOGS`
4. `CONTROLLED_OPEN_SOURCE_ENV`
5. `SYNTHETIC`

## Real public data

Use real datasets when they are:

- legally/publicly available;
- suitable for the lesson;
- documented enough to interpret;
- safe to use.

Record:

- source;
- date accessed;
- license or usage note when known;
- key limitations.

## Real websites and APIs

Use real websites only when automation or testing is permitted.

Prefer:

- official demo sites;
- public test endpoints;
- public APIs;
- intentionally educational systems;
- the learner's own sites.

## Own logs

As the learner builds systems, prefer using their real logs and telemetry.

These are often more educational than synthetic datasets because they contain:

- missing values;
- timing noise;
- mistakes;
- unexpected behavior;
- schema changes;
- genuine debugging problems.

## Synthetic fallback

Synthetic data is allowed when:

- real labels are unavailable;
- privacy would be a problem;
- the real data is too large or complex for the lesson;
- a controlled edge case is needed;
- a security experiment must remain local.

Every synthetic lab must state:

- why synthetic data is used;
- which properties are simulated;
- which conclusions may not generalize.
