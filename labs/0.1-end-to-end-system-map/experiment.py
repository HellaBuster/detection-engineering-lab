from datetime import datetime, timedelta


NOW = datetime.fromisoformat("2026-09-28T10:06:00")
WINDOW_MINUTES = 10
THRESHOLD = 3


def failed_logins_last_10m(events, user_id, now):
    window_start = now - timedelta(minutes=WINDOW_MINUTES)
    count = 0

    for event in events:
        if event["user_id"] != user_id:
            continue
        if event["type"] != "login_failed":
            continue
        if window_start <= event["time"] <= now:
            count += 1

    return count


def decide(failed_count):
    if failed_count >= THRESHOLD:
        return "Challenge"
    return "Allow"


def run_case(name, events):
    feature = failed_logins_last_10m(events, user_id=66, now=NOW)
    print(f"{name}: failed_logins_last_10m={feature}; decision={decide(feature)}")


def main():
    baseline = [
        {"user_id": 66, "type": "login_failed", "time": datetime.fromisoformat("2026-09-28T10:00:00")},
        {"user_id": 66, "type": "login_failed", "time": datetime.fromisoformat("2026-09-28T10:05:00")},
    ]
    run_case("baseline", baseline)

    one_more_event = baseline + [
        {"user_id": 66, "type": "login_failed", "time": datetime.fromisoformat("2026-09-28T10:06:00")},
    ]
    run_case("after_one_new_event", one_more_event)

    different_user_event = baseline + [
        {"user_id": 99, "type": "login_failed", "time": datetime.fromisoformat("2026-09-28T10:06:00")},
    ]
    run_case("after_different_user_event", different_user_event)


if __name__ == "__main__":
    main()
