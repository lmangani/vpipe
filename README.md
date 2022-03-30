<img src='https://user-images.githubusercontent.com/1423657/147935343-598c7dfd-1412-4bad-9ac6-636994810443.png' style="margin-left:-10px" width=180>

[![vlang-build-pipeline](https://github.com/lmangani/vpipe/actions/workflows/v.yml/badge.svg)](https://github.com/lmangani/vpipe/actions/workflows/v.yml)

# vpipe
experimental pipeline chain parser in [vlang](https://vlang.io/)

#### Status
* Experimental, Hackish, Amateurish. Do _NOT_ use this.

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
