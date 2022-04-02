<img src='https://user-images.githubusercontent.com/1423657/147935343-598c7dfd-1412-4bad-9ac6-636994810443.png' style="margin-left:-10px" width=180>

[![vlang-build-pipeline](https://github.com/lmangani/vpipe/actions/workflows/v.yml/badge.svg)](https://github.com/lmangani/vpipe/actions/workflows/v.yml)

# vpipe
experimental log pipeline chain parser in [vlang](https://vlang.io/)

#### Status
* Experimental, Hackish, Amateurish. Do _NOT_ use this. 💣

### Functions
- [x] logfmt
- [x] json
- [x] regex

### Usage
##### logfmt
```bash
echo "some=logs are=boring" | vpipe 'logfmt'

{ "some": "logs", "are": "boring" }
```
##### logfmt + json
```bash
echo "some=logs are=boring counter=100" | vpipe 'logfmt | json counter'

100
```
##### regex
```bash
echo 'http://www.ciao.mondo/pera.html' \
  | vpipe 'regex (?P<format>https?)|(?P<format>ftps?)://(?P<token>[\w_]+.)+'

{"format":"http","token":"html"}
```


#### 🕐 Benchmark
##### vpipe
```
# hyperfine --warmup 3 'cat /tmp/test.log | vpipe "logfmt"'
Benchmark 1: cat /tmp/test.log | vpipe "logfmt"
  Time (mean ± σ):       1.3 ms ±   0.1 ms    [User: 1.8 ms, System: 0.5 ms]
  Range (min … max):     1.1 ms …   1.7 ms    1428 runs
```
##### angle-grinder
```
# hyperfine --warmup 3 "cat /tmp/test.log |  ag '* | logfmt'"
Benchmark 1: cat /tmp/test.log |  agrind '* | logfmt'
  Time (mean ± σ):       4.5 ms ±   0.2 ms    [User: 2.4 ms, System: 3.2 ms]
  Range (min … max):     1.8 ms …   4.9 ms    544 runs
```
