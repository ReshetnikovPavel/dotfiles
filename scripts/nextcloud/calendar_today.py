import datetime
import os

import dateutil
from icalendar import Calendar
from nc_py_api import Nextcloud


def get_env_var(name: str) -> str:
    env_var = os.environ.get(name)
    if not env_var:
        raise RuntimeError(f"{name} environment variable is not set")
    return env_var


def utc2local(utc):
    local_tz = dateutil.tz.tzlocal()
    return utc.astimezone(local_tz)


NEXTCLOUD_URL = get_env_var("NEXTCLOUD_URL")
NEXTCLOUD_AUTH_USER = get_env_var("NEXTCLOUD_AUTH_USER")
NEXTCLOUD_AUTH_PASSWORD = get_env_var("NEXTCLOUD_AUTH_PASSWORD")


nc = Nextcloud(
    nextcloud_url=NEXTCLOUD_URL,
    nc_auth_user=NEXTCLOUD_AUTH_USER,
    nc_auth_pass=NEXTCLOUD_AUTH_PASSWORD,
)

principal = nc.cal.principal()
calendars = principal.calendars()
if not calendars:
    raise RuntimeError("No calendars found")

calendar = calendars[0]

start_date = datetime.datetime.now()
end_date = start_date + datetime.timedelta(days=1)
events = calendar.date_search(start=start_date, end=end_date)

print("TODO:")
print()

for event in events:
    raw_data = str(event.data)

    calendar = Calendar.from_ical(raw_data)

    for event in calendar.walk("VEVENT"):
        summary = event.get("SUMMARY")
        start_time = utc2local(event.get("DTSTART").dt)
        end_time = utc2local(event.get("DTEND").dt)
        print(
            f"{start_time.hour:02}:{start_time.minute:02}"
            f" - {end_time.hour:02}:{end_time.minute:02}"
            f"\t{summary}"
        )
