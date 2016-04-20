//
//  MLYTextAttachment.m
//  IBTest
//
//  Created by CafferyNeal on 16/4/18.
//  Copyright © 2016年 kaka. All rights reserved.
//

#import "MLYTextAttachment.h"

@implementation MLYTextAttachment


- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex{
    
    return CGRectMake( 0 , 0 , lineFrag.size.height, lineFrag.size.height);
}
@end
