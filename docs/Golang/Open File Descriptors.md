I wanted a quick way to test if `ulimit -n` (max number of open files per process) works or not.

This Go snippet creates `n`  files and opens them. It prints the underlyng File Descriptor ID but doesn't close the file handle. This way we can test the max number of open files this Go program can ever create:

### Running

```go
package main

import (
	"fmt"
	"os"
)

var (
	FILES_TO_OPEN = 99999
)

func main() {
	fmt.Println("writing")
	for i := 1; i < FILES_TO_OPEN; i++ {
		fdF, err := os.Create(fmt.Sprintf("/tmp/fd_go%d.txt", i))
		if err != nil {
			panic(err)
		}
		_, err = fdF.Write([]byte("a"))
		if err != nil {
			panic(err)
		}
		fdF.Close()
	}
	fmt.Println("opening")
	for i := 1; i < FILES_TO_OPEN; i++ {
		fdF, err := os.Open(fmt.Sprintf("/tmp/fd_go%d.txt", i))
		if err != nil {
			panic(err)
		}
		fmt.Println(fdF.Fd())
	}
}
``` 

### Exceeding the Limit

If you exceed the limit, it'll give an error like:

```bash
1018
1019
1020
1021
1022
1023
panic: open /tmp/fd_go1018.txt: too many open files

goroutine 1 [running]:
main.main()
	/home/karan/Code/Infra/fd-test/main.go:29 +0x286
exit status 2
```

In my host `ulimit -n` was set to `1024`, so it failed to create more files than that.

### Python Version

See [[Python/Open File Descriptors]]