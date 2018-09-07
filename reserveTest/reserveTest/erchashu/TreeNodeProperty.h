//
//  TreeNodeProperty.h
//  reserveTest
//
//  Created by zhouwei on 2018/8/31.
//  Copyright © 2018年 zhouwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreeNodeProperty : NSObject
/**
 *  距离
 */
@property (nonatomic, assign) NSInteger distance;
/**
 *  深度
 */
@property (nonatomic, assign) NSInteger depth;

/**
 *  左节点
 */
@property (nonatomic, strong) TreeNodeProperty *left;
/**
 *  右节点
 */
@property (nonatomic, strong) TreeNodeProperty *right;

@end
