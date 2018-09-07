//
//  LinkTree.h
//  reserveTest
//
//  Created by zhouwei on 2018/8/31.
//  Copyright © 2018年 zhouwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LinkNode.h"

@interface LinkTree : NSObject

+ (LinkNode *)createLinkTreeWithValues:(NSArray *)values;

+ (LinkNode *)addLinkeTreeNode:(LinkNode *)treeNode value:(NSInteger)value;


+ (void)preOrderTraverseTree:(LinkNode *)rootNode handler:(void(^)(LinkNode *treeNode))handler;

+ (LinkNode *)invertBinaryTree:(LinkNode *)header;

@end
