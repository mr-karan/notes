The following snippet is used to create a mini HTTP server to dump all HTTP headers of an incoming request which can be useful for debugging.

```go
package main  
  
import (  
       "fmt"  
       "log"  
       "net/http"  
       "net/http/httputil"  
)  
  
func index(w http.ResponseWriter, req *http.Request) {  
       // Save a copy of this request for debugging.  
       requestDump, err := httputil.DumpRequest(req, true)  
       if err != nil {  
               fmt.Println(err)  
               fmt.Fprintf(w, "oops! check logs\n")  
               return  
       }  
       fmt.Fprintf(w, "%v", string(requestDump))  
}  
  
func ping(w http.ResponseWriter, req *http.Request) {  
       fmt.Fprintf(w, "pong\n")  
}  
  
func main() {  
  
       http.HandleFunc("/", index)  
       http.HandleFunc("/ping", ping)  
  
       port := ":6666"  
       log.Printf("starting server at %s", port)  
       http.ListenAndServe(port, nil)  
}
```