//
//  BinaryTree.m
//  reserveTest
//
//  Created by zhouwei on 2018/8/31.
//  Copyright © 2018年 zhouwei. All rights reserved.
//

#import "BinaryTree.h"

@implementation BinaryTree

/**
 *  创建二叉排序树
 *  二叉排序树：左节点值全部小于根节点值，右节点值全部大于根节点值
 *
 *  @param values 数组
 *
 *  @return 二叉树根节点
 */
+ (BinaryTreeNode *)createTreeWithValues:(NSArray *)values {
    
    BinaryTreeNode *root = nil;
    for (NSInteger i=0; i<values.count; i++) {
        NSInteger value = [(NSNumber *)[values objectAtIndex:i] integerValue];
        root = [BinaryTree addTreeNode:root value:value];
    }
    return root;
}

/**
 *  向二叉排序树节点添加一个节点
 *
 *  @param treeNode 根节点
 *  @param value    值
 *
 *  @return 根节点
 */
+ (BinaryTreeNode *)addTreeNode:(BinaryTreeNode *)treeNode value:(NSInteger)value {
    //根节点不存在，创建节点
    if (!treeNode) {
        treeNode = [BinaryTreeNode new];
        treeNode.value = value;
        NSLog(@"node:%@", @(value));
    }
    else if (value <= treeNode.value) {
        NSLog(@"to left");
        //值小于根节点，则插入到左子树
        treeNode.leftNode = [BinaryTree addTreeNode:treeNode.leftNode value:value];
    }
    else {
        NSLog(@"to right");
        //值大于根节点，则插入到右子树
        treeNode.rightNode = [BinaryTree addTreeNode:treeNode.rightNode value:value];
    }
    
    return treeNode;
}


/**
 *  二叉树中某个位置的节点（按层次遍历）
 *
 *  @param index    按层次遍历树时的位置(从0开始算)
 *  @param rootNode 树根节点
 *
 *  @return 节点
 */
+ (BinaryTreeNode *)treeNodeAtIndex:(NSInteger)index inTree:(BinaryTreeNode *)rootNode {
    //按层次遍历
    if (!rootNode || index < 0) {
        return nil;
    }
    
    NSMutableArray *queueArray = [NSMutableArray array]; //数组当成队列
    [queueArray addObject:rootNode]; //压入根节点
    while (queueArray.count > 0) {
        
        BinaryTreeNode *node = [queueArray firstObject];
        if (index == 0) {
            return node;
        }
        [queueArray removeObjectAtIndex:0]; //弹出最前面的节点，仿照队列先进先出原则
        index--; //移除节点，index减少
        
        if (node.leftNode) {
            [queueArray addObject:node.leftNode]; //压入左节点
        }
        if (node.rightNode) {
            [queueArray addObject:node.rightNode]; //压入右节点
        }
    }
    //层次遍历完，仍然没有找到位置，返回nil
    return nil;
}


/**
 *  先序遍历
 *  先访问根，再遍历左子树，再遍历右子树
 *
 *  @param rootNode 根节点
 *  @param handler  访问节点处理函数
 */
+ (void)preOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler {
    if (rootNode) {
        
        if (handler) {
            handler(rootNode);
        }
        
        [self preOrderTraverseTree:rootNode.leftNode handler:handler];
        [self preOrderTraverseTree:rootNode.rightNode handler:handler];
    }
}


/**
 *  中序遍历
 *  先遍历左子树，再访问根，再遍历右子树
 *
 *  @param rootNode 根节点
 *  @param handler  访问节点处理函数
 */
+ (void)inOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler {
    if (rootNode) {
        [self inOrderTraverseTree:rootNode.leftNode handler:handler];
        
        if (handler) {
            handler(rootNode);
        }
        
        [self inOrderTraverseTree:rootNode.rightNode handler:handler];
    }
}



/**
 *  后序遍历
 *  先遍历左子树，再遍历右子树，再访问根
 *
 *  @param rootNode 根节点
 *  @param handler  访问节点处理函数
 */
+ (void)postOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler {
    if (rootNode) {
        [self postOrderTraverseTree:rootNode.leftNode handler:handler];
        [self postOrderTraverseTree:rootNode.rightNode handler:handler];
        
        if (handler) {
            handler(rootNode);
        }
    }
}



/**
 *  按照从上到下、从左到右的次序进行遍历
 *  层次遍历（广度优先）
 *
 *  @param rootNode 二叉树根节点
 *  @param handler  访问节点处理函数
 */
+ (void)levelTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler {
    if (!rootNode) {
        return;
    }
    
    NSMutableArray *queueArray = [NSMutableArray array]; //数组当成队列
    [queueArray addObject:rootNode]; //压入根节点
    while (queueArray.count > 0) {
        
        BinaryTreeNode *node = [queueArray firstObject];
        
        if (handler) {
            handler(node);
        }
        
        [queueArray removeObjectAtIndex:0]; //弹出最前面的节点，仿照队列先进先出原则
        if (node.leftNode) {
            [queueArray addObject:node.leftNode]; //压入左节点
        }
        if (node.rightNode) {
            [queueArray addObject:node.rightNode]; //压入右节点
        }
    }
}


/**
 *  二叉树的深度
 *
 *  @param rootNode 二叉树根节点
 *
 *  @return 二叉树的深度
 */
+ (NSInteger)depthOfTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return 1;
    }
    
    //左子树深度
    NSInteger leftDepth = [self depthOfTree:rootNode.leftNode];
    //右子树深度
    NSInteger rightDepth = [self depthOfTree:rootNode.rightNode];
    
    return MAX(leftDepth, rightDepth) + 1;
}


/**
 * 二叉树的宽度定义为各层节点数的最大值
 *  二叉树的宽度
 *
 *  @param rootNode 二叉树根节点
 *
 *  @return 二叉树宽度
 */
+ (NSInteger)widthOfTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    
    NSMutableArray *queueArray = [NSMutableArray array]; //数组当成队列
    [queueArray addObject:rootNode]; //压入根节点
    NSInteger maxWidth = 1; //最大的宽度，初始化为1（因为已经有根节点）
    NSInteger curWidth = 0; //当前层的宽度
    
    while (queueArray.count > 0) {
        
        curWidth = queueArray.count;
        //依次弹出当前层的节点
        for (NSInteger i=0; i<curWidth; i++) {
            BinaryTreeNode *node = [queueArray firstObject];
            [queueArray removeObjectAtIndex:0]; //弹出最前面的节点，仿照队列先进先出原则
            //压入子节点
            if (node.leftNode) {
                [queueArray addObject:node.leftNode];
            }
            if (node.rightNode) {
                [queueArray addObject:node.rightNode];
            }
        }
        //宽度 = 当前层节点数
        maxWidth = MAX(maxWidth, queueArray.count);
    }
    
    return maxWidth;
}



/**
 *  二叉树的所有节点数
 *
 *  @param rootNode 根节点
 *
 *  @return 所有节点数
 */
+ (NSInteger)numberOfNodesInTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    //节点数=左子树节点数+右子树节点数+1（根节点）
    return [self numberOfNodesInTree:rootNode.leftNode] + [self numberOfNodesInTree:rootNode.rightNode] + 1;
}


/**
 *  二叉树某层中的节点数
 *
 *  @param level    层
 *  @param rootNode 根节点
 *
 *  @return 层中的节点数
 */
+ (NSInteger)numberOfNodesOnLevel:(NSInteger)level inTree:(BinaryTreeNode *)rootNode {
    if (!rootNode || level < 1) { //根节点不存在或者level<0
        return 0;
    }
    if (level == 1) { //level=1，返回1（根节点）
        return 1;
    }
    //递归：level层节点数 = 左子树level-1层节点数+右子树level-1层节点数
    return [self numberOfNodesOnLevel:level-1 inTree:rootNode.leftNode] + [self numberOfNodesOnLevel:level-1 inTree:rootNode.rightNode];
}



/**
 * 叶子节点，又叫终端节点，是左右子树都是空的节点
 *  二叉树叶子节点数
 *
 *  @param rootNode 根节点
 *
 *  @return 叶子节点数
 */
+ (NSInteger)numberOfLeafsInTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    //左子树和右子树都是空，说明是叶子节点
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return 1;
    }
    //递归：叶子数 = 左子树叶子数 + 右子树叶子数
    return [self numberOfLeafsInTree:rootNode.leftNode] + [self numberOfLeafsInTree:rootNode.rightNode];
}


/**
 *  二叉树最大值节点
 *
 *  @param rootNode 根节点
 *
 *  @return 最大距离
 */
+ (BinaryTreeNode *)maxTreeNodeOfTree:(BinaryTreeNode *)rootNode{
    if (!rootNode) {
        return nil;
    }
    //当再无子节点，返回当前节点
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return rootNode;
    }
    BinaryTreeNode *leftNode = [self maxTreeNodeOfTree:rootNode.leftNode];
    BinaryTreeNode *rightNode =  [self maxTreeNodeOfTree:rootNode.rightNode];
    
    return [self maxNodeWidth:rootNode and:[self maxNodeWidth:leftNode and:rightNode]];
}

/**
 *  返回最大值节点
 *
 *  @param nodeA 节点1 nodeB 节点2
 *
 *  @return 最大值节点
 */
+ (BinaryTreeNode *)maxNodeWidth: (BinaryTreeNode *) nodeA and:(BinaryTreeNode *) nodeB {
    if (!nodeA) {
        return nodeB;
    }
    if (!nodeB) {
        return nodeA;
    }
    if (nodeA.value > nodeB.value) {
        return nodeA;
    }
    return nodeB;
}


/**
 *  二叉树最大距离（直径）
 *
 *  @param rootNode 根节点
 *
 *  @return 最大距离
 */
//+ (NSInteger)maxDistanceOfTree:(BinaryTreeNode *)rootNode {
//    if (!rootNode) {
//        return 0;
//    }
//    //    方案一：（递归次数较多，效率较低）
//    //分3种情况：
//    //1、最远距离经过根节点：距离 = 左子树深度 + 右子树深度
//    NSInteger distance = [self depthOfTree:rootNode.leftNode] + [self depthOfTree:rootNode.rightNode];
//    //2、最远距离在根节点左子树上，即计算左子树最远距离
//    NSInteger disLeft = [self maxDistanceOfTree:rootNode.leftNode];
//    //3、最远距离在根节点右子树上，即计算右子树最远距离
//    NSInteger disRight = [self maxDistanceOfTree:rootNode.rightNode];
//
//    return MAX(MAX(disLeft, disRight), distance);
//}



/**
 *  二叉树最大距离（直径）
 *
 *  @param rootNode 根节点
 *
 *  @return 最大距离
 */
+ (NSInteger)maxDistanceOfTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    //    方案2：将计算节点深度和最大距离放到一次递归中计算，方案一是分别单独递归计算深度和最远距离
    TreeNodeProperty *p = [self propertyOfTreeNode:rootNode];
    return p.distance;
}

/**
 *  计算树节点的最大深度和最大距离
 *
 *  @param rootNode 根节点
 *
 *  @return TreeNodeProperty
 */
+ (TreeNodeProperty *)propertyOfTreeNode:(BinaryTreeNode *)rootNode {
    
    if (!rootNode) {
        return nil;
    }
    
    TreeNodeProperty *left = [self propertyOfTreeNode:rootNode.leftNode];
    TreeNodeProperty *right = [self propertyOfTreeNode:rootNode.rightNode];
    TreeNodeProperty *p = [TreeNodeProperty new];
    //节点的深度depth = 左子树深度、右子树深度中最大值+1（+1是因为根节点占了1个depth）
    p.depth = MAX(left.depth, right.depth) + 1;
    //最远距离 = 左子树最远距离、右子树最远距离和横跨左右子树最远距离中最大值
    p.distance = MAX(MAX(left.distance, right.distance), left.depth+right.depth);
    
    return p;
}



/**
 *  二叉树中某个节点到根节点的路径
 *
 *  @param treeNode 节点
 *  @param rootNode 根节点
 *
 *  @return 存放路径节点的数组
 */
+ (NSArray *)pathOfTreeNode:(BinaryTreeNode *)treeNode inTree:(BinaryTreeNode *)rootNode {
    NSMutableArray *pathArray = [NSMutableArray array];
    [self isFoundTreeNode:treeNode inTree:rootNode routePath:pathArray];
    return pathArray;
}

/**
 *  查找某个节点是否在树中
 *
 *  @param treeNode 待查找的节点
 *  @param rootNode 根节点
 *  @param path  根节点到待查找节点的路径
 *
 *  @return YES：找到，NO：未找到
 */
+ (BOOL)isFoundTreeNode:(BinaryTreeNode *)treeNode inTree:(BinaryTreeNode *)rootNode routePath:(NSMutableArray *)path {
    
    if (!rootNode || !treeNode) {
        return NO;
    }
    
    //找到节点
    if (rootNode == treeNode) {
        [path addObject:rootNode];
        return YES;
    }
    //压入根节点，进行递归
    [path addObject:rootNode];
    //先从左子树中查找
    BOOL find = [self isFoundTreeNode:treeNode inTree:rootNode.leftNode routePath:path];
    //未找到，再从右子树查找
    if (!find) {
        find = [self isFoundTreeNode:treeNode inTree:rootNode.rightNode routePath:path];
    }
    //如果2边都没查找到，则弹出此根节点
    if (!find) {
        [path removeLastObject];
    }
    
    return find;
}





/**
 *  二叉树中两个节点最近的公共父节点
 *
 *  @param nodeA    第一个节点
 *  @param nodeB    第二个节点
 *  @param rootNode 二叉树根节点
 *
 *  @return 最近的公共父节点
 */
+ (BinaryTreeNode *)parentOfNode:(BinaryTreeNode *)nodeA andNode:(BinaryTreeNode *)nodeB inTree:(BinaryTreeNode *)rootNode {
    if (!rootNode || !nodeA || !nodeB) {
        return nil;
    }
    if (nodeA == nodeB) {
        return nodeA;
    }
    //从根节点到节点A的路径
    NSArray *pathA = [self pathOfTreeNode:nodeA inTree:rootNode];
    //从根节点到节点B的路径
    NSArray *pathB = [self pathOfTreeNode:nodeB inTree:rootNode];
    //其中一个节点不在树中，则没有公共父节点
    if (pathA.count == 0 || pathB == 0) {
        return nil;
    }
    //从后往前推，查找第一个出现的公共节点
    for (NSInteger i = pathA.count-1; i>=0; i--) {
        for (NSInteger j = pathB.count - 1; j>=0; j--) {
            if ([pathA objectAtIndex:i] == [pathB objectAtIndex:j]) {
                //找到
                return [pathA objectAtIndex:i];
            }
        }
    }
    return nil;
}




/**
 *  二叉树中两个节点之间的路径
 *
 *  @param nodeA    第一个节点
 *  @param nodeB    第二个节点
 *  @param rootNode 二叉树根节点
 *
 *  @return 两个节点间的路径
 */
+ (NSArray *)pathFromNode:(BinaryTreeNode *)nodeA toNode:(BinaryTreeNode *)nodeB inTree:(BinaryTreeNode *)rootNode {
    if (!rootNode || !nodeA || !nodeB) {
        return nil;
    }
    NSMutableArray *path = [NSMutableArray array];
    if (nodeA == nodeB) {
        [path addObject:nodeA];
        [path addObject:nodeB];
        return path;
    }
    //从根节点到节点A的路径
    NSArray *pathA = [self pathOfTreeNode:nodeA inTree:rootNode];
    //从根节点到节点B的路径
    NSArray *pathB = [self pathOfTreeNode:nodeB inTree:rootNode];
    //其中一个节点不在树中，则没有路径
    if (pathA.count == 0 || pathB == 0) {
        return nil;
    }
    //从后往前推，查找第一个出现的公共节点
    for (NSInteger i = pathA.count-1; i>=0; i--) {
        [path addObject:[pathA objectAtIndex:i]];
        for (NSInteger j = pathB.count - 1; j>=0; j--) {
            //找到公共父节点，则将pathB中后面的节点压入path
            if ([pathA objectAtIndex:i] == [pathB objectAtIndex:j]) {
                j++; //j++是为了避开公共父节点
                while (j<pathB.count) {
                    [path addObject:[pathB objectAtIndex:j]];
                    j++;
                }
                
                return path;
            }
        }
    }
    return nil;
}




/**
 *  二叉树两个节点之间的距离
 *
 *  @param nodeA    第一个节点
 *  @param nodeB    第二个节点
 *  @param rootNode 二叉树根节点
 *
 *  @return 两个节点间的距离（-1：表示没有找到路径）
 */
+ (NSInteger)distanceFromNode:(BinaryTreeNode *)nodeA toNode:(BinaryTreeNode *)nodeB inTree:(BinaryTreeNode *)rootNode {
    if (!rootNode || !nodeA || !nodeB) {
        return -1;
    }
    if (nodeA == nodeB) {
        return 0;
    }
    //从根节点到节点A的路径
    NSArray *pathA = [self pathOfTreeNode:nodeA inTree:rootNode];
    //从根节点到节点B的路径
    NSArray *pathB = [self pathOfTreeNode:nodeB inTree:rootNode];
    //其中一个节点不在树中，则没有路径
    if (pathA.count == 0 || pathB == 0) {
        return -1;
    }
    //从后往前推，查找第一个出现的公共节点
    for (NSInteger i = pathA.count-1; i>=0; i--) {
        for (NSInteger j = pathB.count - 1; j>=0; j--) {
            //找到公共父节点
            if ([pathA objectAtIndex:i] == [pathB objectAtIndex:j]) {
                //距离=路径节点数-1 （这里要-2，因为公共父节点重复了一次）
                return (pathA.count - i) + (pathB.count - j) - 2;
            }
        }
    }
    return -1;
}


/**
 *  翻转二叉树（又叫：二叉树的镜像）
 *
 *  @param rootNode 根节点
 *
 *  @return 翻转后的树根节点（其实就是原二叉树的根节点）
 */
+ (BinaryTreeNode *)invertBinaryTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return nil;
    }
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return rootNode;
    }
    
    [self invertBinaryTree:rootNode.leftNode];
    [self invertBinaryTree:rootNode.rightNode];
    
    BinaryTreeNode *tempNode = rootNode.leftNode;
    rootNode.leftNode = rootNode.rightNode;
    rootNode.rightNode = tempNode;
    
//    [self invertBinaryTree:rootNode.leftNode];
//    [self invertBinaryTree:rootNode.rightNode];
    
    return rootNode;
}




/**
 *  是否完全二叉树
 *  完全二叉树：若设二叉树的高度为h，除第h层外，其它各层的结点数都达到最大个数，第h层有叶子结点，并且叶子结点都是从左到右依次排布
 *
 *  @param rootNode 根节点
 *
 *  @return YES：是完全二叉树，NO：不是完全二叉树
 */
+ (BOOL)isCompleteBinaryTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return NO;
    }
    //左子树和右子树都是空，则是完全二叉树
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return YES;
    }
    //左子树是空，右子树不是空，则不是完全二叉树
    if (!rootNode.leftNode && rootNode.rightNode) {
        return NO;
    }
    
    //按层次遍历节点，找到满足完全二叉树的条件：
    //条件1：如果某个节点的右子树不为空，则它的左子树必须不为空
    //条件2：如果某个节点的右子树为空，则排在它后面的节点必须没有孩子节点
    //排在该节点后面的节点有2种：1）同层次的后面的节点 2）同层次的前面的节点的孩子节点（因为遍历前面的节点的时候，会将节点从队列里pop，同时把它的孩子节点push到队列里）
    NSMutableArray *queue = [NSMutableArray array];
    [queue addObject:rootNode];
    BOOL isComplete = NO; //是否已经满足完全二叉树
    while (queue.count > 0) {
        BinaryTreeNode *node = [queue firstObject];
        [queue removeObjectAtIndex:0];
        
        //左子树为空且右子树不为空，则不是完全二叉树
        if (!node.leftNode && node.rightNode) {
            return NO;
        }
        if (isComplete && (node.leftNode || node.rightNode)) {
            //前面的节点已满足完全二叉树,如果还有孩子节点，则不是完全二叉树
            return NO;
        }
        
        //右子树为空，则已经满足完全二叉树
        if (!node.rightNode) {
            isComplete = YES;
        }
        
        //压入
        if (node.leftNode) {
            [queue addObject:node.leftNode];
        }
        if (node.rightNode) {
            [queue addObject:node.rightNode];
        }
    }
    return isComplete;
}




/**
 *  是否满二叉树
 *  满二叉树：除了叶结点外每一个结点都有左右子叶且叶子结点都处在最底层的二叉树
 *
 *  @param rootNode 根节点
 *
 *  @return YES：满二叉树，NO：非满二叉树
 */
+ (BOOL)isFullBinaryTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return NO;
    }
    
    //二叉树深度
    NSInteger depth = [self depthOfTree:rootNode];
    //二叉树叶子节点数
    NSInteger leafNum = [self numberOfLeafsInTree:rootNode];
    
    //满二叉树特性：叶子数=2^(深度-1)
    if (leafNum == pow(2, (depth - 1))) {
        return YES;
    }
    return NO;
}




/**
 *  是否平衡二叉树
 *  平衡二叉树：即AVL树，它是一棵空树或它的左右两个子树的高度差的绝对值不超过1，并且左右两个子树都是一棵平衡二叉树
 *
 *  @param rootNode 根节点
 *
 *  @return YES：平衡二叉树，NO：非平衡二叉树
 */
+ (BOOL)isAVLBinaryTree:(BinaryTreeNode *)rootNode {
    static NSInteger height;
    if (!rootNode) {
        height = 0;
        return YES;
    }
    if (!rootNode.leftNode && !rootNode.rightNode) {
        height = 1;
        return YES;
    }
    
    BOOL isAVLLeft = [self isAVLBinaryTree:rootNode.leftNode];
    NSInteger heightLeft = height;
    BOOL isAVLRight = [self isAVLBinaryTree:rootNode.rightNode];
    NSInteger heightRight = height;
    
    height = MAX(heightLeft, heightRight)+1;
    
    if (isAVLLeft && isAVLRight && ABS(heightLeft-heightRight) <= 1) {
        return YES;
    }
    return NO;
}

@end
