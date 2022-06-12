## Creating a profile


To profile Golang applications, `pprof` package is widely used. There's a nice wrapper around it [https://github.com/pkg/profile](https://github.com/pkg/profile) which allows you to just drop one line in your application and start generating profiles:

```go

package main

func main() {

  defer profile.Start(profile.ProfilePath("."), profile.NoShutdownHook).Stop()

  // rest of your application
}

```

- `profile.NoShutdownHook`: This is important to pass to `profile.Start` if you're shutting down your application with a SIGINT/SIGTERM and not handling profile storage directly. This will ensure the `.pprof` file gets saved correctly.


## Visualizing

`go tool pprof -http=":8000" ./cpu.pprof`

This allows you to visualize the `pprof` file in Graphviz and the more helpful Flamegraph visualizations.
