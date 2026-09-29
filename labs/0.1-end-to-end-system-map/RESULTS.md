# Results

## Prediction

Two failed-login events for user `66` should produce `failed_logins_last_10m=2` and `Allow`. Adding a third event for the same user should produce `3` and `Challenge`. Adding an event for user `99` should not change user `66`'s result.

## Observation

The experiment produced:

```text
baseline: failed_logins_last_10m=2; decision=Allow
after_one_new_event: failed_logins_last_10m=3; decision=Challenge
after_different_user_event: failed_logins_last_10m=2; decision=Allow
```

The local Playwright smoke test also passed. The running API exposed request counters and latency metrics at `/metrics`.

## Was the prediction correct?

Yes.

## Explanation

The feature counts only `login_failed` events for the selected `user_id` inside the time window. The rule applies `feature >= 3`; the resulting branch is the decision.

## What I initially misunderstood

The learner initially mixed event, feature, rule, decision, and test result. The time-window boundary and the distinction between a backend log and telemetry also required remediation.

## Transfer task result

An event for `user_id=99` was excluded by the user filter, so user `66` remained at feature `2` and decision `Allow`.

## Evidence for mastery

Partial only. The learner correctly handled the controlled threshold experiment and parts of the local browser/API map, but did not independently reconstruct all detection layers in the unseen scenario.

## Final conclusion

The end-to-end system map is partially understood. A short unseen verification task remains mandatory.

## Assistance used

Level:
FULL_SOLUTION

What assistance was provided:
The assistant supplied the corrected full classification after the final unseen attempt and provided repeated targeted hints during threshold, time-window, and event/feature remediation.

Who performed the key reasoning?
MIXED

## If a full solution was shown

Was a new unseen verification task completed?
NO

Verification result:
Pending.

## Gate decision

PROVISIONAL

Reason:
Core relationships are present, but independent reconstruction of telemetry, feature, rule, evidence, Playwright, and ML placement is incomplete.
