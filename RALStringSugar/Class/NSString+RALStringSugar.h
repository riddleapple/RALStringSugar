//
//  NSString+RALStringSugar.h
//  RALStringSugar
//
//
//  Copyright (c) 2015 Wei-Chen Ling.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//



#import <Foundation/Foundation.h>
#import "RALMatchResult.h"



@interface NSString (RALStringSugar)

- (NSString *)strip;
- (NSString *)trimmingChars:(NSString *)chars;
- (NSArray *)split:(NSString *)separator;
- (BOOL)isInclude:(NSString *)string;
- (BOOL)isEmpty;
- (NSString *)toCamelCase;


/**
 *  -gsub:replacement:
 *
 *  example 1:
 *
 *    NSRegularExpression *regex1 = [NSRegularExpression regularExpressionWithPattern:@"[aeiou]" 
 *                                                                            options:0 
 *                                                                              error:nil];
 *    NSLog(@"%@", [@"hello" gsub:regex1 replacement:@"*"]); //=> "h*ll*"
 *
 *
 *
 *  example 2:
 *
 *    NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:@"([aeiou])" 
 *                                                                            options:0 
 *                                                                              error:nil];
 *    NSLog(@"%@", [@"hello" gsub:regex2 replacement:@"<$1>"]); //=> "h<e>ll<o>"
 *
 */
- (NSString *)gsub:(NSRegularExpression *)regex replacement:(NSString *)replacement;


/**
 *  -gsub:block:
 *
 *  example:
 *
 *    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"." 
 *                                                                           options:0 
 *                                                                             error:nil];
 *    [@"hello" gsub:regex block:^(NSString *match){
 *        return [match uppercaseString]; 
 *    }];  //=> "HELLO"
 *
 */
- (NSString *)gsub:(NSRegularExpression *)regex block:(NSString* (^)(NSString *match))block;


/**
 *  -match:block:
 *
 *  example:
 *
 *    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(.)\\1" 
 *                                                                           options:0 
 *                                                                             error:nil];
 *    [@"hello" match:regex5 block:^(NSString *match){ return match; }]; //=> "ll"
 *
 */
- (id)match:(NSRegularExpression *)regex block:(id (^)(NSString *match))block;


/**
 *  -scan:
 *
 *  example 1:
 *
 *    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\w+" options:0 error:nil];
 *    [@"cruel world" scan:regex]  //=> [["cruel"], ["world"]]
 *
 *
 *  example 2:
 *
 *    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(..)(..)" options:0 error:nil];
 *    [@"cruel world" scan:regex]  //=> [["crue", "cr", "ue"], ["l wo", "l ", "wo"]]
 *
 */
- (NSArray *)scan:(NSRegularExpression *)regex;


/**
 *  -scan:block:
 *
 *  example:
 *
 */
- (void)scan:(NSRegularExpression *)regex block:(void (^)(RALMatchResult* matchResult))block;

@end
