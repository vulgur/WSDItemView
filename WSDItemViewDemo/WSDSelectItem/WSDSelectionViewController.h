//
//  WSDSelectionViewController.h
//  WSDSelectItemDemo
//
//  Created by Wang Shudao on 9/16/15.
//  Copyright (c) 2015 WSD. All rights reserved.
//

#import "ViewController.h"

@protocol WSDSelectionViewControllerDelegate <NSObject>

- (void)didSelect:(NSString *)string;

@end

@interface WSDSelectionViewController : UIViewController

@property(nonatomic, weak) id<WSDSelectionViewControllerDelegate> delegate;

@end
