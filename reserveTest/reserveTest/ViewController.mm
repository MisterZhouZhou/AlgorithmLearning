//
//  ViewController.m
//  reserveTest
//
//  Created by zhouwei on 2018/8/31.
//  Copyright © 2018年 zhouwei. All rights reserved.
//

#import "ViewController.h"
#include<iostream>
#import "BinaryTree.h"
#import "LinkTree.h"

//char g_buf[];
char g_buf[10] ="";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    stringReverse("hello world");
    
    [self testDemo];
}


void inverser_stack(char *p){
    if(p == NULL){
        return;
    }
    if(*p == '\0'){
        return;
    }
    inverser_stack(p+1);
    printf("%c", *p);
    strncat(g_buf, p, 1);
}

-(void)testDemo {
    char p[] = "123456789";
    inverser_stack(p);
}




-(void)testlink {
    //    [self test3];
    
    BinaryTreeNode *root = [BinaryTree createTreeWithValues:@[@1,@3,@2,@2,@8,@4]];
    
    //    BinaryTreeNode *indexNode = [BinaryTree treeNodeAtIndex:3 inTree:root];
    //    NSLog(@"%@", indexNode);
    
    
    //    BinaryTreeNode *root2 = [BinaryTree invertBinaryTree:root];
    //    NSMutableArray *orderArray = [NSMutableArray array];
    //    [BinaryTree preOrderTraverseTree:root2 handler:^(BinaryTreeNode *treeNode) {
    //        [orderArray addObject:@(treeNode.value)];
    //    }];
    
    
    //    BinaryTreeNode *maxvaluenode = [BinaryTree maxTreeNodeOfTree:root];
    //    NSLog(@"===");
    //    NSLog(@"遍历结果：%@", [orderArray componentsJoinedByString:@","]);
    
    
    LinkNode *tree = [LinkTree createLinkTreeWithValues:@[@1,@3,@2,@2,@8,@4]];
    LinkNode *invtree = [LinkTree invertBinaryTree:tree];
    NSMutableArray *orderArray = [NSMutableArray array];
    [LinkTree preOrderTraverseTree:invtree handler:^(LinkNode *treeNode) {
        [orderArray addObject:@(treeNode.value)];
    }];
    NSLog(@"遍历结果：%@", [orderArray componentsJoinedByString:@","]);
}


struct Node{
    int data;
    Node *next;
};

//Node *pNode;
//
////递归法实现链表的逆置
//pNode reverseList_reverse(pNode head)
//{
//    pNode current_head, head_next;
//    if (head == NULL)
//        return NULL;
//
//    if (head->next == NULL)//边界条件
//        return head;
//    else{
//        current_head = head;//记下当前的头结点a0
//        head_next = head->next;//记下当前头结点后面的结点a1
//        head = reverseList_reverse(head_next);//返回(a1...an)逆转后的头结点
//        head_next->next = current_head;//用上面保存的地址（逆转后的尾结点）指向原来的头结点a0
//        current_head->next = NULL;//将a0的next域置零
//    }
//    return head;//返回a0
//}

#pragma mark - 数组交换
- (void)test3{
    int b1 = 3;
    int b2 = 5;
    b1 ^= b2;
    b2 ^= b1;
    b1 ^= b2;
    NSLog(@"%d-%d", b1, b2);
}

- (void)test2{
    int a1 = 3;
    int a2 = 5;
    a1 = a1 + a2;
    a2 = a1 - a2;
    a1 = a1 - a2;
    NSLog(@"%d-%d", a1, a2);
}

- (void)test1{
    NSInteger number = 123;
    NSLog(@"%ld-%ld-%ld",(number%10),(number/10)%10,(number/100));
}



void stringReverse(char *p)
{
    char c[200][100];   // 2, 10    10, 10   200, 200
    int i=0;
    int j=0;
    while (*p!='\0') {
        if(*p==' '){
            i++;
            j=0;
        }else
        {
            c[i][j] = *p;
            j++;
        }
        p++;
    }
    
    for (int k=i; k>=0; k--) {
        printf("%s",c[k]);
        if (k>0) {
            printf(" ");
        }else
        {
            printf("\n");
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
