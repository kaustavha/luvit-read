# Luvit-read

A file reader wrapper for luvit  
`> lit install kaustavha/luvit-read`  

`local reader = require('luvit-read')`  

## readStream
Returns a lightweight stream

## readStreamClean
Returns a lightweight stream that will discard any empty lines or lines starting with #

## read
Returns the file contents in a table in the callback.

## readClean
Similiar to readStreamClean but returns file contents in a callback instead of as a stream

One can extend readStream and create their own cleaner e.g. to exclude comments starting with a character that isnt # or using any lua regex.
This library relies on virgo-agent-toolkit/line-emitter which only parses lines that end in a newline (\n) character therefore the last line in files with no newline at the end will be left unparsed. 
The best way to circumvent this limitation is to use `fs.createReadStream` and write your own line-emitter implementation or other chunking mechanism.

## Testing
```
lit install luvit-tap
luvit test.lua
```

## License
(The MIT License)

Copyright (c) 2011-2016 Kaustav Haldar <hi@kaustav.me>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
