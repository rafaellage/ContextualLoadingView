//
//  LoadingView.m
//  ContextualLoadingView
//
//  Created by Eduardo Sanches Bocato on 01/03/17.
//  Copyright © 2017 bocato. All rights reserved.
//

#import "LoadingView.h"
#import "Masonry.h"

#pragma mark - Delegate Default Implemetation
@implementation NSObject(LoadingViewDelegate)

- (void)checkIfTheClassConformsWithLoadingViewDelegate {
    if (![self conformsToProtocol:@protocol(LoadingViewDelegate)]){
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"You must conform to protocol LoadingViewDelegate to access this method."] userInfo:nil];
    }
}

- (void)showLoadingView:(LoadingView *)loadingView {
    [self checkIfTheClassConformsWithLoadingViewDelegate];
    [loadingView showView];
}

- (void)hideLoadingView:(LoadingView *)loadingView {
    [self checkIfTheClassConformsWithLoadingViewDelegate];
    [loadingView hideView];
}

@end


@interface LoadingView ()
#pragma mark - View Elements
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@end

@implementation LoadingView

#pragma mark - View LifeCycle
- (instancetype)init {
    self = [super init];
    if (self) {
        [self configureViewElements];
    }
    return self;
}


#pragma mark - Layout Configuration
- (void)configureActivityIndicator {
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    self.activityIndicator.color = [UIColor grayColor];
    [self addSubview:self.activityIndicator];
}

- (void)makeConstraints {
    [self.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self);
        make.height.width.mas_equalTo(50);
    }];
}

- (void) configureViewElements {
    self.backgroundColor = [UIColor whiteColor];
    self.hidden = YES;
    [self configureActivityIndicator];
    [self makeConstraints];
}

- (void)configureForView:(UIView *)view {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.left.right.equalTo(view);
    }];
}

#pragma mark - View Behavior
- (void)hideView {
    self.alpha = 1.0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.activityIndicator stopAnimating];
            self.hidden = YES;
        }
    }];
}

- (void)showView {
    self.hidden = NO;
    self.alpha = 0.0;
    [self.activityIndicator startAnimating];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
    }];
}

@end