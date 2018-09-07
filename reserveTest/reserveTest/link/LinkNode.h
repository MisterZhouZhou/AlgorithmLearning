//
//  LinkNode.h
//  reserveTest
//
//  Created by zhouwei on 2018/8/31.
//  Copyright © 2018年 zhouwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LinkNode : NSObject

/**
 *  值
 */
@property (nonatomic, assign) NSInteger value;
/**
 *  next节点
 */
@property (nonatomic, strong) LinkNode *nextNode;

@end
