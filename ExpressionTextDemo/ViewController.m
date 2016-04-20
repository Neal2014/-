//
//  ViewController.m
//  ExpressionTextDemo
//
//  Created by CafferyNeal on 16/4/20.
//  Copyright © 2016年 kaka. All rights reserved.
//

#import "ViewController.h"
#import "MLYTextAttachment.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.testLabel.attributedText = [self replaceExpressionWithStr:@"我[嘻嘻]你[呼呼]你[哭哭]我[拜拜]你[讨厌]我[可爱]你[滚蛋]我[亲亲]你[哈哈][123456]"];
    
}


- (NSAttributedString *)replaceExpressionWithStr:(NSString *)str{
    
    // 汉字对应表情的图片名字
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ImageSource" ofType:@"plist"];
    NSDictionary *imageSource = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    // 测试字符
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:str];
    // 正则匹配所有特殊字符
    NSString * pattern = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    NSError *error = nil;
    NSRegularExpression * re = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    if (!re) {
        NSLog(@"%@", [error localizedDescription]);
    }
    NSArray *resultArray = [re matchesInString:str options:0 range:NSMakeRange(0, str.length)];
    
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];
    
    // 替换表情附件
    for (NSTextCheckingResult *match in resultArray) {
        
        // 获取数组元素中得到range 、 对应的值
        NSRange range = [match range];
        NSString *subStr = [str substringWithRange:range];
        
        if ([imageSource objectForKey:subStr]) {
            
            MLYTextAttachment *textAttachment = [[MLYTextAttachment alloc] init];
            textAttachment.image = [UIImage imageNamed:[imageSource objectForKey:subStr]];
            
            NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
            //把图片和图片对应的位置存入字典中
            NSDictionary *imageDic = @{@"image":imageStr,
                                       @"range":[NSValue valueWithRange:range]};
            // 把字典存入数组中
            [imageArray addObject:imageDic];
        }
    }
    
    //从后往前替换
    for (NSInteger i = imageArray.count -1; i >= 0; i--){
        
        NSDictionary *imageDic = [imageArray objectAtIndex:i];
        NSRange range = [[imageDic objectForKey:@"range"] rangeValue];
        NSAttributedString *imageStr = [imageDic objectForKey:@"image"];
        // 进行替换
        [attributeString replaceCharactersInRange:range withAttributedString:imageStr];
    }
    return attributeString;
}


@end
