See [[Golang/Open File Descriptors]] version for context.

```python
>>> [open("FD_TEST_%d.txt" % i, "w") for i in range(1, 1025)]

OSError: [Errno 24] Too many open files: 'FD_TEST_1021.txt'
>>> 
```