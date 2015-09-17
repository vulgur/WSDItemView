//
//  WSDItemView.m
//  WSDSelectItemDemo
//
//  Created by Wang Shudao on 9/14/15.
//  Copyright (c) 2015 WSD. All rights reserved.
//

#import "WSDItemView.h"

@interface WSDItemView ()

@property (nonatomic, strong) UIImageView *rightIconImageView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation WSDItemView

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
                         type:(WSDItemViewType)type {
    self = [WSDItemView new];
    if (self) {
        self.backgroundColor = backgroundColor;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        _itemTitle = title;
        _itemContent = content;
        _itemType = type;
        
        // Set size of the item
        NSLayoutConstraint *widthConstraint =
        [NSLayoutConstraint constraintWithItem:self
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                      constant:width];
        NSLayoutConstraint *heightConstraint =
        [NSLayoutConstraint constraintWithItem:self
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:nil
                                     attribute:NSLayoutAttributeNotAnAttribute
                                    multiplier:1.0
                                      constant:height];
        [self addConstraint:widthConstraint];
        [self addConstraint:heightConstraint];
        
        // Label for title
        _titleLabel = [UILabel new];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.text = title;
        _titleLabel.textColor = titleColor;
        _titleLabel.font = titleFont;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel sizeToFit];
        
        // Label for content
        _contentLabel = [UILabel new];
        _contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _contentLabel.text = content;
        _contentLabel.textColor = contentColor;
        _contentLabel.font = contentFont;
        _contentLabel.textAlignment = NSTextAlignmentRight;
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        // ImageView for right icon
        _rightIconImageView = [UIImageView new];
        _rightIconImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _rightView = [UIView new];
        _rightView.backgroundColor = [UIColor clearColor];
        _rightView.translatesAutoresizingMaskIntoConstraints = NO;
        [_rightView addSubview:_rightIconImageView];
        
        switch (type) {
            case WSDItemViewTypeDelete:
                _rightIconImageView.image = [UIImage imageNamed:@"delete"];
                break;
            case WSDItemViewTypeADD:
                _rightIconImageView.image = [UIImage imageNamed:@"add"];
                break;
            case WSDItemViewTypeInput:
                _rightIconImageView.image = [UIImage imageNamed:@"arrow"];
        }
        
        // Autolayouts
        [self addSubview:_titleLabel];
        [self addSubview:_contentLabel];
        [self addSubview:_rightView];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(
                                                             self, _titleLabel, _contentLabel, _rightView);
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:_contentLabel
                             attribute:NSLayoutAttributeWidth
                             relatedBy:NSLayoutRelationEqual
                             toItem:nil
                             attribute:NSLayoutAttributeNotAnAttribute
                             multiplier:1.0f
                             constant:120]];
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:_rightView
                             attribute:NSLayoutAttributeWidth
                             relatedBy:NSLayoutRelationEqual
                             toItem:nil
                             attribute:NSLayoutAttributeNotAnAttribute
                             multiplier:1.0f
                             constant:height]];
        
        [self addConstraint:[NSLayoutConstraint
                             constraintWithItem:_rightView
                             attribute:NSLayoutAttributeHeight
                             relatedBy:NSLayoutRelationEqual
                             toItem:nil
                             attribute:NSLayoutAttributeNotAnAttribute
                             multiplier:1.0f
                             constant:height]];
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:
                              [NSString
                               stringWithFormat:@"|-%f-[_titleLabel]", leftMargin]
                              options:
                              NSLayoutFormatDirectionLeadingToTrailing
                              metrics:nil
                              views:views]];
        
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"V:|-[_titleLabel]-|"
                              options:
                              NSLayoutFormatDirectionLeadingToTrailing
                              metrics:nil
                              views:views]];
        
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"V:|-[_contentLabel]-|"
                              options:
                              NSLayoutFormatDirectionLeadingToTrailing
                              metrics:nil
                              views:views]];
        
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"V:|[_rightView]|"
                              options:
                              NSLayoutFormatDirectionLeadingToTrailing
                              metrics:nil
                              views:views]];
        
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"[_contentLabel]-[_rightView]|"
                              options:
                              NSLayoutFormatDirectionLeadingToTrailing
                              metrics:nil
                              views:views]];
        
        [_rightView addConstraints:[NSLayoutConstraint
                                    constraintsWithVisualFormat:
                                    [NSString stringWithFormat:@"[_rightIconImageView]-%f-|",
                                     rightMargin]
                                    options:
                                    NSLayoutFormatDirectionLeadingToTrailing
                                    metrics:nil
                                    views:NSDictionaryOfVariableBindings(
                                                                         _rightView,
                                                                         _rightIconImageView)]];
        
        [_rightView addConstraint:[NSLayoutConstraint
                                   constraintWithItem:_rightIconImageView
                                   attribute:NSLayoutAttributeCenterY
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:_rightView
                                   attribute:NSLayoutAttributeCenterY
                                   multiplier:1.0f
                                   constant:0]];
        // Gestures
        UITapGestureRecognizer *tapIcon = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(didTapRightIcon)];
        [_rightView addGestureRecognizer:tapIcon];
    }
    
    return self;
}

- (void)didTapRightIcon {
    [self.delegate didTapItemViewRightIcon:self];
}

#pragma mark - Setters
- (void)setItemTitle:(NSString *)title {
    _itemTitle = title;
    _titleLabel.text = title;
    [self setNeedsDisplay];
}

- (void)setItemContent:(NSString *)content {
    _itemContent = content;
    _contentLabel.text = content;
    [self setNeedsDisplay];
}

- (void)remove {
    CGRect frame = self.frame;
    CGFloat width = frame.size.width;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.frame = CGRectMake(frame.origin.x + width, frame.origin.y, width,
                                                 frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         [self.delegate didRemove:self];
                     }];
}

@end
