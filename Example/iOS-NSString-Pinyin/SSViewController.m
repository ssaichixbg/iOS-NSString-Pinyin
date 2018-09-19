//
//  SSViewController.m
//  iOS-NSString-Pinyin
//
//  Created by Yang Zhang on 09/05/2018.
//  Copyright (c) 2018 Yang Zhang. All rights reserved.
//

#import "SSViewController.h"

#import "NSString+Pinyin.h"

@interface SSViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UISwitch *toneSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *spaceSwitch;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation SSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *arr = [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
    NSArray *data = @[@"a", @"a啊", @"啊😁",@"啊a",@"啊aaaa", @"aa",@"a1", @"😁", @"1", @"="];
    NSMutableDictionary *dict = [@{} mutableCopy];
    [data enumerateObjectsUsingBlock:^(NSString  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger i = [[UILocalizedIndexedCollation currentCollation] sectionForObject:obj collationStringSelector:@selector(copy)];
        NSLog(@"%@: %@", obj, arr[i]);
        if (!dict[@(i)]) {
            dict[@(i)] = [@[] mutableCopy];
        }
        [(NSMutableArray *)dict[@(i)] addObject:obj];
    }];

    [[dict allValues] enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *newArr = [[UILocalizedIndexedCollation currentCollation] sortedArrayFromArray:obj collationStringSelector:@selector(copy)];
        NSLog(@"%@", [newArr description]);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)switchChanged:(id)sender {
    [self _updateWithSrcString:self.textField.text];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [self _updateWithSrcString:[textField.text stringByReplacingCharactersInRange:range withString:string]];
    return YES;
}

#pragma mark - Private Methods

- (void)_updateWithSrcString:(NSString *)string {
    NSStringPinYinTransformOption options = NSStringPinYinTransformIgnoreNonChinese;
    if (self.toneSwitch.on) {
        options |= NSStringPinYinTransformWithTone;
    }
    if (self.spaceSwitch.on) {
        options |= NSStringPinYinTransformWithSpaces;
    }
    self.resultLabel.text = [string pinyinWithOptions:options];
}

@end
