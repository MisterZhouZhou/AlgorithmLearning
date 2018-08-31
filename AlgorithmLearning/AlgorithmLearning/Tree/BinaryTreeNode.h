//
//  BinaryTreeNode.h
//  reserveTest
//
//  Created by zhouwei on 2018/8/31.
//  Copyright © 2018年 zhouwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BinaryTreeNode : NSObject

/**
 *  值
 */
@property (nonatomic, assign) NSInteger value;
/**
 *  左节点
 */
@property (nonatomic, strong) BinaryTreeNode *leftNode;
/**
 *  右节点
 */
@property (nonatomic, strong) BinaryTreeNode *rightNode;


@end
