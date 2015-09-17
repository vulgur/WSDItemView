//
//  WSDInputViewController.h
//  WSDSelectItemDemo
//
//  Created by Wang Shudao on 9/15/15.
//  Copyright (c) 2015 WSD. All rights reserved.
//

#import "ViewController.h"

@protocol WSDInputViewControllerDelegate <NSObject>

- (void)didInput:(NSString *)string;

@end

@interface WSDInputViewController : UIViewController

@property (nonatomic, weak) id<WSDInputViewControllerDelegate> delegate;

@end
