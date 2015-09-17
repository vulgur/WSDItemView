//
//  WSDItemView.h
//  WSDSelectItemDemo
//
//  Created by Wang Shudao on 9/14/15.
//  Copyright (c) 2015 WSD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WSDItemViewType) {
    WSDItemViewTypeDelete,
    WSDItemViewTypeADD,
    WSDItemViewTypeInput,
};

@class WSDItemView;

@protocol WSDItemViewDelegate <NSObject>

@optional
- (void)didTapItemViewRightIcon:(WSDItemView *)itemView;
-(void)didRemove:(WSDItemView *)itemView;

@end

@interface WSDItemView : UIView

@property(nonatomic, strong) NSString *itemTitle;
@property(nonatomic, strong) NSString *itemContent;
@property(nonatomic, assign, readonly) WSDItemViewType itemType;
@property(nonatomic, weak) id<WSDItemViewDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                    titleFont:(UIFont *)titleFont
                      content:(NSString *)content
                 contentColor:(UIColor *)contentColor
                  contentFont:(UIFont *)contentFont
                   leftMargin:(CGFloat)leftMargin
                  rightMargin:(CGFloat)rightMargin
                        width:(CGFloat)width
                       height:(CGFloat)height
              backgroundColor:(UIColor *)backgroundColor
                         type:(WSDItemViewType)type;

- (void)remove;

@end
