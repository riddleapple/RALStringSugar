# RALStringSugar

 Some methods additions for NSString. Ruby style.


## Examples

### Some string methods:
```objective-c
NSString *str1 = [@"  abc  " strip];                   //=> "abc"
NSString *str2 = [@"ab 123 ba" trimmingChars:@"ab "];  //=> "123"
NSArray *array = [@"1, 2, 3, 4" split:@", "];          //=> ["1", "2", "3", "4"]

BOOL isIncludeStr = [@"python, ruby, swift" isInclude:@"ruby"]; //=> YES
BOOL isEmptyStr = [@"" isEmpty];                                //=> YES
```

### gsub methods:
```objective-c
// example 1
NSRegularExpression *regex1 = [NSRegularExpression regularExpressionWithPattern:@"[aeiou]" options:0 error:nil];
NSString *str = [@"hello" gsub:regex1 replacement:@"*"]);  //=> "h*ll*"
	
// example 2
NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:@"([aeiou])" options:0 error:nil];
NSString *str =[@"hello" gsub:regex2 replacement:@"<$1>"]);  //=> "h<e>ll<o>"
	
// example 3
NSRegularExpression *regex3 = [NSRegularExpression regularExpressionWithPattern:@"y((.)(.)\\3\\2) d\\1" options:0 error:nil];
NSString *str = [@"yabba dabba doo" gsub:regex3 replacement:@"-"]);  //=> "- doo"

// example 4
NSRegularExpression *regex4 = [NSRegularExpression regularExpressionWithPattern:@"." options:0 error:nil];
NSString *upcaseStr = [@"hello" gsub:regex4 block:^(NSString *match){
    return [match uppercaseString];
}];  //=> "HELLO"
```

### match methods:
```objective-c
NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(.)\\1" options:0 error:nil];
NSString *firstMatchStr = [@"hello" match:regex block:^(NSString *match){ return match; }];  //=> "ll"
```

### scan methods:
```objective-c
// example 1
NSRegularExpression *regex1 = [NSRegularExpression regularExpressionWithPattern:@"\\w+" options:0 error:nil];
NSArray *array1 = [@"cruel world" scan:regex1]);  //=> [["cruel"], ["world"]]

// example 2
NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:@"(..)(..)" options:0 error:nil];
NSArray *array2 = [@"cruel world" scan:regex2]);  //=> [["crue", "cr", "ue"], ["l wo", "l ", "wo"]]

// example 3
NSRegularExpression *regex8 = [NSRegularExpression regularExpressionWithPattern:@"(..)(..)" options:0 error:nil];
[@"cruel world" scan:regex8 block:^(RALMatchResult* matchResult){
	NSLog(@"%@", matchResult.group);
}];
//=> ["crue", "cr", "ue"]
//=> ["l wo", "l ", "wo"]
```


## License

(MIT License)

Copyright (c) 2015 Wei-Chen Ling.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
