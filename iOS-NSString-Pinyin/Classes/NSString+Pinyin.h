//
//  NSString+NSString_Pinyin.h
//  iOS-NSString-Pinyin
//
//  Created by Yang Zhang on 9/5/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, NSStringPinYinTransformOption) {
    NSStringPinYinTransformWithTone = 1 << 0,
    NSStringPinYinTransformWithSpaces = 1 << 1,
    NSStringPinYinTransformIgnoreNonChinese = 1 << 2,
};

@interface NSString (Pinyin)

- (nullable NSString *)pinyin;
- (nullable NSString *)pinyinWithOptions:(NSStringPinYinTransformOption)options;

- (nonnull NSArray<NSString *> *)pinyinArray;
- (nonnull NSArray<NSString *> *)pinyinArrayWithOptions:(NSStringPinYinTransformOption)options;

- (nullable NSString *)pinyinInitials;
- (nullable NSString *)pinyinInitialsWithOptions:(NSStringPinYinTransformOption)options;

- (nonnull NSArray<NSString *> *)pinyinInitialsArray;
- (nonnull NSArray<NSString *> *)pinyinInitialsArrayWithOptions:(NSStringPinYinTransformOption)options;

@end

NS_ASSUME_NONNULL_END
