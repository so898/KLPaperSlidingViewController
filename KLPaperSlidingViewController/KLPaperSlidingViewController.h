//
//  KLPaperSlidingViewController.h
//  KLPaperSlidingViewController
//
//  Created by so898 on 13-3-7.
//  Copyright (c) 2013年 R3 Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+ImageWithUIView.h"

#define Height ([[UIScreen mainScreen] bounds].size.height - 20)

typedef enum {
    /** Left side of screen */
    KLMid,
    /** Left side of screen */
    KLLeft,
    /** Right side of screen */
    KLRight
} KLSide;

@interface KLPaperSlidingViewController : UIViewController{
    KLSide touchSide, nowSide;
    UIImageView *cardFrame1, *cardFrame2, *cardFrame3, *cardFrame4, *cardFrame5, *cardFrame6;
}

@property (nonatomic, strong) UIViewController *leftViewController;
@property (nonatomic, strong) UIViewController *midViewController;
@property (nonatomic, strong) UIViewController *rightViewController;
@property (nonatomic, assign) BOOL canMove;

- (void)anchorShowViewTo:(KLSide)side;
- (void)anchorShowViewTo:(KLSide)side onComplete:(void(^)())complete;
- (void)resetShowViewToMid;

- (BOOL)leftShowing;
- (BOOL)rightShowing;
- (BOOL)midShowing;

@end

@interface UIViewController(SlidingViewExtension)
- (KLPaperSlidingViewController *)slidingViewController;
@end
