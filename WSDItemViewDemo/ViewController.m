//
//  ViewController.m
//  WSDSelectItemDemo
//
//  Created by Wang Shudao on 9/14/15.
//  Copyright (c) 2015 WSD. All rights reserved.
//

#import "ViewController.h"
#import "WSDItemView.h"
#import "WSDInputViewController.h"
#import "WSDSelectionViewController.h"

@interface ViewController () <WSDInputViewControllerDelegate, WSDItemViewDelegate,
WSDSelectionViewControllerDelegate>

@property (nonatomic, strong) WSDItemView *itemView1;
@property (nonatomic, strong) WSDItemView *itemView2;
@property (nonatomic, strong) WSDItemView *itemView3;
@property (nonatomic, strong) id lastItem;
@property (nonatomic, strong) NSMutableArray *addedItems;
@property (nonatomic, strong) NSLayoutConstraint *constraintForItemView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.addedItems = [NSMutableArray new];
    
    self.itemView1 =
    [[WSDItemView alloc] initWithTitle:@"111"
                            titleColor:[UIColor blueColor]
                             titleFont:[UIFont systemFontOfSize:18]
                               content:@"tap to add"
                          contentColor:[UIColor redColor]
                           contentFont:[UIFont systemFontOfSize:18]
                            leftMargin:10
                           rightMargin:10
                                 width:screenWidth
                                height:50
                       backgroundColor:[UIColor yellowColor]
                                  type:WSDItemViewTypeADD];
    self.itemView2 =
    [[WSDItemView alloc] initWithTitle:@"222"
                            titleColor:[UIColor blueColor]
                             titleFont:[UIFont systemFontOfSize:18]
                               content:@"go to input"
                          contentColor:[UIColor redColor]
                           contentFont:[UIFont systemFontOfSize:18]
                            leftMargin:10
                           rightMargin:10
                                 width:screenWidth
                                height:50
                       backgroundColor:[UIColor yellowColor]
                                  type:WSDItemViewTypeInput];
    self.itemView3 =
    [[WSDItemView alloc] initWithTitle:@"333"
                            titleColor:[UIColor blueColor]
                             titleFont:[UIFont systemFontOfSize:18]
                               content:@"tap to delete"
                          contentColor:[UIColor redColor]
                           contentFont:[UIFont systemFontOfSize:18]
                            leftMargin:10
                           rightMargin:10
                                 width:screenWidth
                                height:50
                       backgroundColor:[UIColor yellowColor]
                                  type:WSDItemViewTypeDelete];
    
    self.itemView1.delegate = self;
    self.itemView2.delegate = self;
    self.itemView3.delegate = self;
    self.lastItem = self.itemView1;
    
    [self.view addSubview:self.itemView1];
    [self.view addSubview:self.itemView2];
    [self.view addSubview:self.itemView3];
    
    [self.view
     addConstraint:[NSLayoutConstraint constraintWithItem:self.itemView1
                                                attribute:NSLayoutAttributeLeft
                                                relatedBy:NSLayoutRelationEqual
                                                   toItem:self.view
                                                attribute:NSLayoutAttributeLeft
                                               multiplier:1.f
                                                 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.itemView2
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.f
                                                           constant:0]];
    
    [self.view
     addConstraint:[NSLayoutConstraint constraintWithItem:self.itemView3
                                                attribute:NSLayoutAttributeLeft
                                                relatedBy:NSLayoutRelationEqual
                                                   toItem:self.view
                                                attribute:NSLayoutAttributeLeft
                                               multiplier:1.f
                                                 constant:0]];
    
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:
      @"V:|-100-[_itemView1]"
                                             options:NSLayoutFormatAlignAllCenterX
                                             metrics:nil
                                               views:NSDictionaryOfVariableBindings(
                                                                                    self.view, _itemView1,
                                                                                    _itemView2, _itemView3)]];
    
    self.constraintForItemView2 = [NSLayoutConstraint constraintWithItem:self.itemView2 attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.itemView1
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1.f
                                                                constant:30];
    [self.view addConstraint:self.constraintForItemView2];
    
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:
      @"V:[_itemView2]-30-[_itemView3]"
                                             options:NSLayoutFormatAlignAllCenterX
                                             metrics:nil
                                               views:NSDictionaryOfVariableBindings(
                                                                                    self.view, _itemView1,
                                                                                    _itemView2, _itemView3)]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WSDInputViewControllerDelegate

- (void)didInput:(NSString *)string {
    self.itemView2.itemContent = string;
}

#pragma mark - WSDItemViewDelegate

- (void)didTapItemViewRightIcon:(WSDItemView *)itemView {
    if ([itemView isEqual:self.itemView1]) {
        //        WSDSelectionViewController *selectionVC =
        //        [[WSDSelectionViewController alloc] init];
        //        selectionVC.view.backgroundColor = [UIColor whiteColor];
        //        selectionVC.delegate = self;
        //        [self.navigationController pushViewController:selectionVC animated:YES];
        [self didSelect:@"test"];
    } else if ([itemView isEqual:self.itemView2]) {
        WSDInputViewController *inputVC = [WSDInputViewController new];
        inputVC.delegate = self;
        [self.navigationController pushViewController:inputVC animated:YES];
    } else if ([itemView isEqual:self.itemView3]) {
        [itemView remove];
    } else {
        [self.addedItems removeObject:itemView];
        [itemView remove];
    }
}

- (void)didRemove:(WSDItemView *)itemView {
    [self reloadView];
}

#pragma mark - WSDSelectionViewControllerDelegate

- (void)didSelect:(NSString *)string {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    WSDItemView *newItem = [[WSDItemView alloc] initWithTitle:string
                                                   titleColor:[UIColor blueColor]
                                                    titleFont:[UIFont systemFontOfSize:12]
                                                      content:nil
                                                 contentColor:nil
                                                  contentFont:nil
                                                   leftMargin:10
                                                  rightMargin:10
                                                        width:screenWidth
                                                       height:30
                                              backgroundColor:[UIColor grayColor]
                                                         type:WSDItemViewTypeDelete];
    newItem.delegate = self;
    [self.view addSubview:newItem];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:newItem
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.lastItem
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.f
                                                           constant:15]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[newItem]"
                                                                      options:NSLayoutFormatDirectionLeftToRight
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(self.view, newItem)]];
    
    [self.addedItems addObject:newItem];
    [self reloadView];
}

#pragma mark - Private methods
- (void)reloadView {
    [self.view removeConstraint:self.constraintForItemView2];
    self.lastItem = self.itemView1;
    for (WSDItemView *itemView in self.addedItems) {
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:itemView
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.lastItem
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.f
                                                               constant:15]];
        self.lastItem = itemView;
    }
    
    self.constraintForItemView2 = [NSLayoutConstraint constraintWithItem:self.itemView2 attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.lastItem
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1.f
                                                                constant:30];
    [self.view addConstraint:self.constraintForItemView2];
    [self.view updateConstraintsIfNeeded];
}

@end
