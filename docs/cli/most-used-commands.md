# Find Top 10 shell commands from history

Using `history` and a bunch of other Linux-fu commands, we can find out the top `10` most used commands in the shell history: 

`history | awk '{print $1}' | sort  | uniq --count | sort --numeric-sort --reverse | head -10`

Here's mine (_on May 2021_)

```
    108 cd
     87 git
     71 curl
     64 ssh
     58 rm
     51 doggo
     50 yay
     49 cat
     37 kcl
     36 kc
```
