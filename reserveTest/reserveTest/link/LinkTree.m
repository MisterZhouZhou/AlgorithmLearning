//
//  LinkTree.m
//  reserveTest
//
//  Created by zhouwei on 2018/8/31.
//  Copyright © 2018年 zhouwei. All rights reserved.
//

#import "LinkTree.h"

@implementation LinkTree

+ (LinkNode *)createLinkTreeWithValues:(NSArray *)values{
    LinkNode *header = nil;
    for (NSInteger i=0; i<values.count; i++) {
        NSInteger value = [(NSNumber *)[values objectAtIndex:i] integerValue];
        header = [LinkTree addLinkeTreeNode:header value:value];
    }
    return header;
}


+ (LinkNode *)addLinkeTreeNode:(LinkNode *)treeNode value:(NSInteger)value {
    if(!value) return nil;
    //根节点不存在，创建节点
    if (!treeNode) {
        treeNode = [LinkNode new];
        treeNode.value = value;
    }else{
        treeNode.nextNode = [LinkTree addLinkeTreeNode:treeNode.nextNode value:value];
    }
    return treeNode;
}


+ (void)preOrderTraverseTree:(LinkNode *)rootNode handler:(void(^)(LinkNode *treeNode))handler {
    if (rootNode) {
        
        if (handler) {
            handler(rootNode);
        }
        [self preOrderTraverseTree:rootNode.nextNode handler:handler];
    }
}


+ (LinkNode *)invertBinaryTree:(LinkNode *)header{
    if (!header){
        return nil;
    }
    if (!header.nextNode){
        return header;
    }else{
        LinkNode *current_header;
        LinkNode *header_next;
        current_header = header;
        header_next = header.nextNode;
        header = [LinkTree invertBinaryTree: header_next];
        header_next.nextNode = current_header;
        current_header.nextNode = nil;
    }
    return header;
}

@end
