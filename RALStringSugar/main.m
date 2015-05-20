//
//  main.m
//  RALStringSugar
//
//  Created by Riddle Ling on 2015/5/12.
//


#import <Foundation/Foundation.h>
#import "NSString+RALStringSugar.h"



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"%@", [@"  abc  " strip]);                   //=> "abc"
        NSLog(@"%@", [@"ab 123 ba" trimmingChars:@"ab "]);  //=> "123"
        NSLog(@"%@", [@"1, 2, 3, 4" split:@", "]);          //=> [1, 2, 3, 4]
        NSLog(@"%@", [@"date_of_birth" toCamelCase]);       //=> "dateOfBirth"
        
        NSString *langStr = @"ruby";
        if ([@"python, ruby, swift" isInclude:langStr]) {
            NSLog(@"\"python, ruby, swift\" include %@", langStr);
            //=> "python, ruby, swift" include ruby
        }
        
        NSLog(@"%d", [@"" isEmpty]);  //=> YES
        
        
        // gsub example 1
        NSRegularExpression *regex1 = [NSRegularExpression regularExpressionWithPattern:@"[aeiou]" options:0 error:nil];
        NSLog(@"%@", [@"hello" gsub:regex1 replacement:@"*"]);  //=> "h*ll*"
        
        
        // gsub example 2
        NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:@"([aeiou])" options:0 error:nil];
        NSLog(@"%@", [@"hello" gsub:regex2 replacement:@"<$1>"]);  //=> "h<e>ll<o>"
        
        
        // gsub example 3
        NSRegularExpression *regex3 = [NSRegularExpression regularExpressionWithPattern:@"y((.)(.)\\3\\2) d\\1" options:0 error:nil];
        NSLog(@"%@", [@"yabba dabba doo" gsub:regex3 replacement:@"-"]);  //=> "- doo"
        
        
        // gsub example 4
        NSRegularExpression *regex4 = [NSRegularExpression regularExpressionWithPattern:@"." options:0 error:nil];
        NSString *upcaseStr = [@"hello" gsub:regex4 block:^(NSString *match){
                                  return [match uppercaseString];
                              }];
        NSLog(@"%@", upcaseStr);  //=> "HELLO"
        
        
        // match example:
        NSRegularExpression *regex5 = [NSRegularExpression regularExpressionWithPattern:@"(.)\\1" options:0 error:nil];
        NSString *firstMatchStr = [@"hello" match:regex5 block:^(NSString *match){ return match; }];
        NSLog(@"%@", firstMatchStr);  //=> "ll"
        
        
        // scan example 1:
        NSLog(@"-- scan example 1 --");
        NSRegularExpression *regex6 = [NSRegularExpression regularExpressionWithPattern:@"\\w+" options:0 error:nil];
        NSLog(@"%@", [@"cruel world" scan:regex6]); //=> [["cruel"], ["world"]]
        
        
        // scan example 2:
        NSLog(@"-- scan example 2 --");
        NSRegularExpression *regex7 = [NSRegularExpression regularExpressionWithPattern:@"(..)(..)" options:0 error:nil];
        NSLog(@"%@", [@"cruel world" scan:regex7]);  //=> [["crue", "cr", "ue"], ["l wo", "l ", "wo"]]
        
        
        // scan example 3:
        NSLog(@"-- scan example 3 --");
        NSRegularExpression *regex8 = [NSRegularExpression regularExpressionWithPattern:@"(..)(..)" options:0 error:nil];
        [@"cruel world" scan:regex8 block:^(RALMatchResult* matchResult){
            NSLog(@"%@", matchResult.group);
        }];
        
    }
    return 0;
}
