# Most used shell commands

Using `history` and a bunch of other Linux-fu commands, we can find out the top `10` most used commands in the shell history: 

```sh
history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10
```

Here's mine (_last updated on Jun 2021_)

```sh
     1  761  9.72027%    clear
     2  760  9.7075%     git
     3  757  9.66918%    ls
     4  626  7.99591%    kcp
     5  488  6.23324%    cd
     6  464  5.92668%    make
     7  255  3.25712%    sudo
     8  244  3.11662%    kc
     9  221  2.82284%    exit
    10  200  2.5546%     kcl
```

There's a fancier output with bars too using:

```sh
history | tr -s ' ' | cut -d ' ' -f3 | sort | uniq -c | sort -n | tail | perl -lane 'print $F[1], "\t", $F[0], " ", "▄" x ($F[0] / 12)'
```

```sh
kcl     200 ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
exit    221 ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
kc      244 ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
sudo    255 ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
make    464 ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
cd      488 ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
kcp     626 ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
ls      757 ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
git     760 ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
clear   761 ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
```

!!! note
    `kc`, `kcl`, `kcp` etc are aliases for [kubectl](./../k8s/kubectl-cheatsheet.md) commands.

[Source](https://www.reddit.com/r/linux/comments/8vzr3y/whats_the_most_frequent_terminal_command_you_use/)
