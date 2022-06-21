Often I've felt the need to convert UTC time to IST but a quick google search reveals some shitty websites which makes such a seemingly simple task irritating and difficult. I tried to search for any small scripts or tools but thought I can whip one up real quick in Python and use it locally for myself. 

Here's the script I wrote, you can customise according to your needs if you wish to:

```python
import argparse
import time
from datetime import datetime
from sys import exit

from dateutil.parser import parse


def datetime_from_utc_to_local(utc_datetime):
    now = time.time()
    offset = datetime.fromtimestamp(now) - datetime.utcfromtimestamp(now)
    return utc_datetime + offset


parser = argparse.ArgumentParser(description="Convert UTC time to Local time.")
parser.add_argument(
    "--timestamp", required=True, help="timestamp of UTC string"
)

args = parser.parse_args()

try:
    utc = parse(args.timestamp)
except Exception as e:
    print(e)
    exit(1)

res = datetime_from_utc_to_local(utc)
print(res.strftime("%H:%M:%S"))
```

## Usage

- `python utc-ist.py --timestamp 03:00`
- `python utc-ist.py --timestamp 03:00:10`
- `python utc-ist.py --timestamp 03:00:15.100`

It takes a `--timestamp` parameter which should be a string depicting the UTC time format.

### Alias

```bash
ist: aliased to python /home/karan/Code/Infra/utc-ist/utc-ist.py --timestamp

$ ist 3:45
09:15
```
