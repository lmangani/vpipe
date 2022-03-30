<img src='https://user-images.githubusercontent.com/1423657/147935343-598c7dfd-1412-4bad-9ac6-636994810443.png' style="margin-left:-10px" width=180>

# vpipe
cLoki log parser [vlang](https://vlang.io/)


### Functions
- [x] logfmt
- [x] json
- [x] regex

### Usage
##### logfmt
```
# echo "some=logs are=boring" | vpipe 'logfmt'
{ "some": "logs", "are": "boring" }
```
##### regex
```
echo 'http://www.ciao.mondo/pera.html' | vpipe 'regex (?P<format>https?)|(?P<format>ftps?)://(?P<token>[\w_]+.)+'
{"format":"http","token":"html"}
```
