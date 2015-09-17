//
//  WSDInputViewController.m
//  WSDSelectItemDemo
//
//  Created by Wang Shudao on 9/15/15.
//  Copyright (c) 2015 WSD. All rights reserved.
//

#import "WSDInputViewController.h"

@interface WSDInputViewController () <UITextViewDelegate>

@property(weak, nonatomic) IBOutlet UITextView *inputTextView;

@end

@implementation WSDInputViewController

static NSString *kTextViewPlaceholder = @"Type Something Here";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Input";
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                     style:UIBarButtonItemStyleDone
                                    target:self
                                    action:@selector(didTapDone)];
    self.inputTextView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didTapDone {
    [self.delegate didInput:self.inputTextView.text];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextViewDelegate

-(void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:kTextViewPlaceholder]) {
        textView.text = @"";
    }
}

@end
