//
//  NSString+NSString_Pinyin.m
//  iOS-NSString-Pinyin
//
//  Created by Yang Zhang on 9/5/18.
//

#import "NSString+Pinyin.h"

@implementation NSString (Pinyin)

- (nullable NSString *)pinyin {
    return [self pinyinWithOptions:NSStringPinYinTransformWithSpaces | NSStringPinYinTransformIgnoreNonChinese];
}

- (nullable NSString *)pinyinWithOptions:(NSStringPinYinTransformOption)options {
    if (!self.length) { return nil; }
    
    NSMutableString *str = [self mutableCopy];
    [str replaceOccurrencesOfString:@"[!\\p{Han}]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, str.length - 1)];

    CFMutableStringRef strRef = (__bridge CFMutableStringRef)str;
    if (!CFStringTransform(strRef, NULL, kCFStringTransformMandarinLatin, NO)) {
        return nil;
    }

    if (!(options & NSStringPinYinTransformWithTone)) {
        if (!CFStringTransform(strRef, NULL, kCFStringTransformStripDiacritics, NO)) {
            return nil;
        }
    }

    NSMutableString *finalStr = (__bridge NSMutableString *)(strRef);

    if (!(options & NSStringPinYinTransformWithSpaces)) {
        [finalStr replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, finalStr.length - 1)];
    }
    return finalStr;
}

- (nonnull NSArray<NSString *> *)pinyinArray {
    return [self pinyinArrayWithOptions:NSStringPinYinTransformIgnoreNonChinese];
}

- (nonnull NSArray<NSString *> *)pinyinArrayWithOptions:(NSStringPinYinTransformOption)options {
    NSString *str = [self pinyinWithOptions:options | NSStringPinYinTransformWithSpaces];
    if (!str.length) {
        return @[];
    }

    return [str componentsSeparatedByString:@" "];
}

@end
