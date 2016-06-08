//
//  SKLabelNode+Utils.m
//  ThreeLittlePigs
//
//  Created by Gomzyakov on 23.02.14.
//  Copyright (c) 2014 Tammy Coron. All rights reserved.
//

#import "SKLabelNode+Utils.h"

@implementation SKLabelNode (Utils)

/**
 Возвращает метку с тенью.
 @note Учитывая то, что по-нормальному нарисовать тень для SKLabelNode возможности
 нет, создаем вторую метку, потемнее, и подкладываем ее под основную с небольшим смещением.
 */
+ (SKLabelNode *)labelNodeWithShadowFromString:(NSString *)myString withSize:(CGFloat)fontSize
{
    CGFloat offSetX      = 0.0;
    CGFloat offSetY      = 1.5;
    UIColor *fontColor   = [UIColor colorWithRed:241.0/256.0 green:90.0/256.0 blue:41.0/256.0 alpha:1.0];;
    UIColor *shadowColor = [UIColor colorWithRed:170.0/256.0 green:30.0/256.0 blue:37.0/256.0 alpha:1.0];;

    SKLabelNode *completedString = [SKLabelNode labelNodeWithFontNamed:@"PTSerif-Caption"];
    completedString.fontSize                = fontSize;
    completedString.fontColor               = fontColor;
    completedString.text                    = myString;
    completedString.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    completedString.zPosition               = 0;

    SKLabelNode *dropShadow = [SKLabelNode labelNodeWithFontNamed:@"PTSerif-Caption"];
    dropShadow.fontSize  = fontSize;
    dropShadow.fontColor = shadowColor;
    dropShadow.text      = myString;
    dropShadow.zPosition = completedString.zPosition - 1;
    dropShadow.position  = CGPointMake(dropShadow.position.x - offSetX, dropShadow.position.y - offSetY);

    [completedString addChild:dropShadow];

    return completedString;
}

@end
