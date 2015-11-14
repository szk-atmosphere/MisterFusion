//
//  ViewController.m
//  MisterFusionObjcSample
//
//  Created by 鈴木大貴 on 2015/11/14.
//  Copyright © 2015年 Taiki Suzuki. All rights reserved.
//

#import "ViewController.h"
#import <MisterFusion/MisterFusion-Swift.h>

@interface ViewController ()
@property (strong, nonatomic) UIView *greenView;
@property (strong, nonatomic) NSLayoutConstraint *greenViewBottomConstraint;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *redView = [UIView new];
    redView.backgroundColor = [UIColor redColor];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: redView];
    //Ordinary AutoLayout code
    [self.view addConstraints:@[
        [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeTop    relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop    multiplier:1.0f constant:10.0f],
        [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeRight  relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight  multiplier:1.0f constant:-10.0f],
        [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeLeft   relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft   multiplier:1.0f constant:10.0f],
        [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.5f constant:-15.0f]
   ]];
    
    UIView *yellowView = [UIView new];
    yellowView.backgroundColor = [UIColor yellowColor];
    yellowView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:yellowView];
    //MisterFusion code
    [self.view addLayoutConstraints:@[
        yellowView.Top   .Equal(redView.Bottom)  .Constant(10.0f),
        yellowView.Right .Equal(self.view.Right) .Constant(-10.0f),
        yellowView.Left  .Equal(self.view.Left)  .Constant(10.0f),
        yellowView.Height.Equal(self.view.Height).Multiplier(0.5f).Constant(-15.0f)
    ]];
    
    UIView *greenView = [UIView new];
    greenView.backgroundColor = [UIColor greenColor];
    greenView.translatesAutoresizingMaskIntoConstraints = NO;
    [yellowView addSubview:greenView];
    //Advanced MisterFusion code
    NSArray<NSLayoutConstraint *> *constraints = [yellowView addLayoutConstraints:@[
        greenView.Top,
        greenView.Right,
        greenView.Bottom,
        greenView.Width.Multiplier(0.5f)
    ]];
    
    for (NSLayoutConstraint *constraint in constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeBottom) {
            self.greenViewBottomConstraint = constraint;
            break;
        }
    }
    self.greenView = greenView;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self reduceAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)stretchAnmation {
    self.greenViewBottomConstraint.constant = 0.0f;
    [UIView animateWithDuration:2.0f animations:^{
        [self.greenView.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self reduceAnimation];
    }];
}

-(void)reduceAnimation {
    CGFloat constant = self.greenView.superview.frame.size.height;
    self.greenViewBottomConstraint.constant = -constant / 2.0f;
    [UIView animateWithDuration:2.0f animations:^{
        [self.greenView.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self stretchAnmation];
    }];
}

@end
