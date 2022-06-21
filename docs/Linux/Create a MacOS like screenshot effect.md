One thing which I miss from my OSX (now called macOS) days is it's ability to create "pretty" screenshots out of the box. OSX screenshots have a nice drop-shadow effect and it centers the image with a faux border.

Not exactly same, but quite close is this `imagemagick` command to achieve the same on Linux systems:

```bash
convert screenshot.png \( +clone -background black -shadow 50x50+30+30 \) +swap -background white -layers merge +repage result.png
```

Source: [StackOverflow](https://stackoverflow.com/a/60681983)

Pretty happy with the result!
