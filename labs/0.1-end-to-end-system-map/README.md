# Lab 0.1: From telemetry events to a risk decision

## Gate

0.1 - End-to-end system map

## Question

How does a count of failed login events become an `Allow` or `Challenge` decision?

## Source type

`SYNTHETIC`

## Source

A small in-memory list of login events created only for this controlled experiment.

## Why this source

The repository has no real authentication event stream yet. Synthetic events let us isolate one variable—the number of `login_failed` events—without mixing in unrelated signals.

## Before the computer

Prediction from the discussion:

- two failed-login events in the last 10 minutes produce `failed_logins_last_10m = 2`;
- with the rule `feature >= 3 -> Challenge`, the decision is `Allow`;
- adding one failed-login event should change the feature to `3` and the decision to `Challenge`.

## Experiment

Run:

```powershell
uv run python labs/0.1-end-to-end-system-map/experiment.py
```

The script counts matching events in a time window and then applies one threshold rule. It changes only the event count between the two cases.

## What to observe

- input events;
- calculated feature;
- rule result;
- effect of adding one event.

## Transfer task

Change the third event to another `user_id`. Predict whether user `66`'s feature changes before running the script, then verify it.

## Mastery criteria

- distinguish an event from a feature;
- explain why the threshold changes the decision;
- identify what the experiment does not prove about a real backend or production detector.

## Assistance rule

The script is laboratory equipment, not mastery evidence by itself. The learner must explain the inputs, state, control flow, output, and one failure mode.
