# Current State

## Current phase

Phase 0 — System Orientation

## Current topic

0.1 — End-to-end system map

## Status

PROVISIONAL

## Current objective

Understand the relationship between:

browser
-> network
-> backend
-> telemetry
-> features
-> rules / model
-> risk decision

## Last completed experiment

`labs/0.1-end-to-end-system-map/` — synthetic threshold experiment and local browser/API observation.

## Known weak points

- distinguish telemetry event, feature, rule, decision, and evidence;
- place Playwright outside the production risk decision path;
- place ML after feature computation and before the final decision;
- reconstruct the full map without assistance.

## Next gate

Complete one unseen verification task for 0.1. The learner must reconstruct the system map, explain every layer at a high level, and distinguish where Playwright, telemetry, ML, and detection belong without a full solution.
