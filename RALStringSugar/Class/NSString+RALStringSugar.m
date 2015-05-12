//
//  NSString+RALStringSugar.m
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


#import "NSString+RALStringSugar.h"



@implementation NSString (RALStringSugar)

- (NSString *)strip {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimmingChars:(NSString *)string {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:string]];
}

- (NSArray *)split:(NSString *)separator {
    return [self componentsSeparatedByString:separator];
}

- (BOOL)isInclude:(NSString *)string {
    NSRange range = [self rangeOfString:string];
    if (range.location != NSNotFound) {
        return YES;
    }
    return NO;
}

- (BOOL)isEmpty {
    if ([self isEqualToString:@""]) {
        return YES;
    }
    return NO;
}


- (NSString *)gsub:(NSRegularExpression *)regex replacement:(NSString *)replacement {
    return [regex stringByReplacingMatchesInString:self
                                           options:0
                                             range:NSMakeRange(0, [self length])
                                      withTemplate:replacement];
}

- (NSString *)gsub:(NSRegularExpression *)regex block:(NSString* (^)(NSString *match))block {
    NSMutableString *resultString = [NSMutableString stringWithString:self];
    NSArray *matches = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    
    // each reverse matches array
    for (NSTextCheckingResult *result in [matches reverseObjectEnumerator]) {
        NSString *replacement = block([self substringWithRange:result.range]);
        [resultString replaceCharactersInRange:result.range withString:replacement];
    }
    return resultString;
}


- (id)match:(NSRegularExpression *)regex block:(id (^)(NSString *match))block {
    NSTextCheckingResult *result = [regex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
    return block([self substringWithRange:result.range]);
}


- (NSArray *)scan:(NSRegularExpression *)regex {
    NSMutableArray *resultArray = [NSMutableArray array];
    
    [regex
     enumerateMatchesInString:self
     options:0
     range:NSMakeRange(0,[self length])
     usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
         NSMutableArray *tmpArray = [NSMutableArray array];
         
         for (NSUInteger i = 0; i < result.numberOfRanges; ++i) {
             NSString *str = [self substringWithRange:[result rangeAtIndex:i]];
             [tmpArray addObject:str];
         }
         
         [resultArray addObject:tmpArray];
     }];
    
    return resultArray;
}

- (void)scan:(NSRegularExpression *)regex block:(void (^)(RALMatchResult* matchResult))block {
    [regex
     enumerateMatchesInString:self
     options:0
     range:NSMakeRange(0,[self length])
     usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop){
         RALMatchResult *matchResult = [[RALMatchResult alloc] initWithMatchInString:self
                                                               andTextCheckingResult:result];
         block(matchResult);
     }];
}

@end
