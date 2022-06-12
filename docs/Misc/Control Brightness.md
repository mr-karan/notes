## Get a list of devices connected

```
xrandr | grep " connected" | cut -f1 -d " "
```

## Tweak the brightness value

```
xrandr --output eDP-1 --brightness 0.7
```
