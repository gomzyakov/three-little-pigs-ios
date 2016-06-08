//
//  SKLabelNode+Utils.h
//  ThreeLittlePigs
//
//  Created by Gomzyakov on 23.02.14.
//  Copyright (c) 2014 Tammy Coron. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKLabelNode (Utils)

/**
 Возвращает метку с тенью.
 @note Учитывая то, что по-нормальному нарисовать тень для SKLabelNode возможности
 нет, создаем вторую метку, потемнее, и подкладываем ее под основную с небольшим смещением.
 */
+ (SKLabelNode *)labelNodeWithShadowFromString:(NSString *)myString withSize:(CGFloat)fontSize;

@end
