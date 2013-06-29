//
//  KLPaperSlidingViewController.m
//  KLPaperSlidingViewController
//
//  Created by so898 on 13-3-7.
//  Copyright (c) 2013年 R3 Studio. All rights reserved.
//

#import "KLPaperSlidingViewController.h"

#define CHANGEPOINT ((float) 100.0f)
#define GESTUREAREA ((float) 20.0f)

@interface KLPaperSlidingViewController()

//@property (nonatomic, unsafe_unretained) CGFloat initialTouchPositionX;
//@property (nonatomic, unsafe_unretained) CGFloat initialHoizontalCenter;
//@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

- (NSUInteger)autoResizeToFillScreen;
- (UIView *)midView;
- (UIView *)leftView;
- (UIView *)rightView;
//- (void)updateShowViewHorizontalCenterWithRecognizer:(UIPanGestureRecognizer *)recognizer;
//- (void)showViewHorizontalCenterWillChange:(CGFloat)newHorizontalCenter;
//- (void)showViewHorizontalCenterDidChange:(CGFloat)newHorizontalCenter;

@end

@implementation UIViewController(SlidingViewExtension)

- (KLPaperSlidingViewController *)slidingViewController
{
    UIViewController *viewController = self.parentViewController;
    while (!(viewController == nil || [viewController isKindOfClass:[KLPaperSlidingViewController class]])) {
        viewController = viewController.parentViewController;
    }
    
    return (KLPaperSlidingViewController *)viewController;
}

@end

@implementation KLPaperSlidingViewController
@synthesize leftViewController  = _leftViewController;
@synthesize rightViewController = _rightViewController;
@synthesize midViewController   = _midViewController;
@synthesize canMove;

- (void)setMidViewController:(UIViewController *)theMidViewController
{
    [_midViewController.view removeFromSuperview];
    [_midViewController willMoveToParentViewController:nil];
    [_midViewController removeFromParentViewController];
    
    _midViewController = theMidViewController;
    
    [self addChildViewController:self.midViewController];
    [self.midViewController didMoveToParentViewController:self];
    
    [_midViewController.view setAutoresizingMask:self.autoResizeToFillScreen];
    [_midViewController.view setFrame:CGRectMake(0, 0, 320, Height)];
    
    [self.view addSubview:_midViewController.view];
    _midViewController.view.layer.position = CGPointMake(160, _midViewController.view.center.y);
    
    cardFrame1 = [UIImageView new];
    UIImage *backg1 = [[UIImage imageNamed:@"card_frame_left"] stretchableImageWithLeftCapWidth:8 topCapHeight:8];
    cardFrame1.image = backg1;
    cardFrame1.frame = CGRectMake(-3, -3, [[UIScreen mainScreen] bounds].size.width - 3, Height + 6);
    [_midViewController.view addSubview:cardFrame1];
    cardFrame1.alpha = 0;
    
    cardFrame2 = [UIImageView new];
    UIImage *backg2 = [[UIImage imageNamed:@"card_frame_right"] stretchableImageWithLeftCapWidth:8 topCapHeight:8];
    cardFrame2.image = backg2;
    cardFrame2.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - 6, -3, 9, Height + 6);
    [_midViewController.view addSubview:cardFrame2];
    cardFrame2.alpha = 0;
}

- (void)setLeftViewController:(UIViewController *)theLeftViewController
{
    [_leftViewController.view removeFromSuperview];
    [_leftViewController willMoveToParentViewController:nil];
    [_leftViewController removeFromParentViewController];
    
    _leftViewController = theLeftViewController;
    
    [self addChildViewController:self.leftViewController];
    [self.leftViewController didMoveToParentViewController:self];
    
    [_leftViewController.view setAutoresizingMask:self.autoResizeToFillScreen];
    [_leftViewController.view setFrame:CGRectMake(0, 0, 320, Height)];
    
    [self.view addSubview:_leftViewController.view];
    _leftViewController.view.layer.position = CGPointMake(-160, _leftViewController.view.center.y);
    
    cardFrame3 = [UIImageView new];
    UIImage *backg1 = [[UIImage imageNamed:@"card_frame_left"] stretchableImageWithLeftCapWidth:8 topCapHeight:8];
    cardFrame3.image = backg1;
    cardFrame3.frame = CGRectMake(-3, -3, [[UIScreen mainScreen] bounds].size.width - 3, Height + 6);
    [_leftViewController.view addSubview:cardFrame3];
    cardFrame3.alpha = 0;
    
    cardFrame4 = [UIImageView new];
    UIImage *backg2 = [[UIImage imageNamed:@"card_frame_right"] stretchableImageWithLeftCapWidth:8 topCapHeight:8];
    cardFrame4.image = backg2;
    cardFrame4.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - 6, -3, 9, Height + 6);
    [_leftViewController.view addSubview:cardFrame4];
    cardFrame4.alpha = 0;
}

- (void)setRightViewController:(UIViewController *)theRightViewController
{
    [_rightViewController.view removeFromSuperview];
    [_rightViewController willMoveToParentViewController:nil];
    [_rightViewController removeFromParentViewController];
    
    _rightViewController = theRightViewController;
    
    [self addChildViewController:self.rightViewController];
    [self.rightViewController didMoveToParentViewController:self];
    
    [_rightViewController.view setAutoresizingMask:self.autoResizeToFillScreen];
    [_rightViewController.view setFrame:CGRectMake(0, 0, 320, Height)];
    
    [self.view addSubview:_rightViewController.view];
    _rightViewController.view.layer.position = CGPointMake(480, _rightViewController.view.center.y);
    
    cardFrame5 = [UIImageView new];
    UIImage *backg1 = [[UIImage imageNamed:@"card_frame_left"] stretchableImageWithLeftCapWidth:8 topCapHeight:8];
    cardFrame5.image = backg1;
    cardFrame5.frame = CGRectMake(-3, -3, [[UIScreen mainScreen] bounds].size.width - 3, Height + 6);
    [_rightViewController.view addSubview:cardFrame5];
    cardFrame5.alpha = 0;
    
    cardFrame6 = [UIImageView new];
    UIImage *backg2 = [[UIImage imageNamed:@"card_frame_right"] stretchableImageWithLeftCapWidth:8 topCapHeight:8];
    cardFrame6.image = backg2;
    cardFrame6.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width - 6, -3, 9, Height + 6);
    [_rightViewController.view addSubview:cardFrame6];
    cardFrame6.alpha = 0;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background"]];
        
        nowSide = KLMid;
        self.canMove = YES;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    if ([touches count] == 1 && canMove){
        CGPoint pt = [[touches anyObject] locationInView:self.view.window];
        if (pt.x < GESTUREAREA && nowSide != KLLeft){
            if (nowSide == KLMid && self.leftViewController)
                touchSide = KLLeft;
            else if (nowSide == KLRight)
                touchSide = KLLeft;
            else
                touchSide = KLMid;
        } else if (pt.x > 320 - GESTUREAREA && nowSide != KLRight){
            if (nowSide == KLMid && self.rightViewController)
                touchSide = KLRight;
            else if (nowSide == KLLeft)
                touchSide = KLRight;
            else
                touchSide = KLMid;
        } else {
            touchSide = KLMid;
        }
    } else {
        touchSide = KLMid;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    if (touchSide == KLMid){
        //[super touchesMoved:touches withEvent:event];
    } else if (touchSide == KLLeft){
        CGPoint pt = [[touches anyObject] locationInView:self.view.window];
        float x = pt.x / CHANGEPOINT;
        float y = 1 - (320 - pt.x) / CHANGEPOINT;
        if (x > 1)
            x = 1;
        if (y < 0)
            y = 0;
        if (nowSide == KLMid && self.leftViewController){
            cardFrame1.alpha = x;
            cardFrame2.alpha = x;
            cardFrame3.alpha = 1 - y;
            cardFrame4.alpha = 1 - y;
            self.leftView.transform = CGAffineTransformMakeScale(0.8 + 0.2 * y, 0.8 + 0.2 * y);
            self.midView.transform = CGAffineTransformMakeScale(1 - 0.2 * x, 1 - 0.2 * x);
            [self updateViewsHorizontalCenter:pt.x + 160];
        } else if (nowSide == KLRight){
            cardFrame1.alpha = 1 - y;
            cardFrame2.alpha = 1 - y;
            cardFrame5.alpha = x;
            cardFrame6.alpha = x;
            self.midView.transform = CGAffineTransformMakeScale(0.8 + 0.2 * y, 0.8 + 0.2 * y);
            self.rightView.transform = CGAffineTransformMakeScale(1 - 0.2 * x, 1 - 0.2 * x);
            [self updateViewsHorizontalCenter:pt.x - 160];
        }
    } else if (touchSide == KLRight){
        CGPoint pt = [[touches anyObject] locationInView:self.view.window];
        float x = (320 - pt.x) / CHANGEPOINT;
        float y = 1 - pt.x / CHANGEPOINT;
        if (x > 1)
            x = 1;
        if (y < 0)
            y = 0;
        if (nowSide == KLMid && self.rightViewController){
            cardFrame1.alpha = x;
            cardFrame2.alpha = x;
            cardFrame5.alpha = 1 - y;
            cardFrame6.alpha = 1 - y;
            self.rightView.transform = CGAffineTransformMakeScale(0.8 + 0.2 * y, 0.8 + 0.2 * y);
            self.midView.transform = CGAffineTransformMakeScale(1 - 0.2 * x, 1 - 0.2 * x);
            [self updateViewsHorizontalCenter:pt.x - 160];
        } else if (nowSide == KLLeft){
            cardFrame1.alpha = 1 - y;
            cardFrame2.alpha = 1 - y;
            cardFrame3.alpha = x;
            cardFrame4.alpha = x;
            self.midView.transform = CGAffineTransformMakeScale(0.8 + 0.2 * y, 0.8 + 0.2 * y);
            self.leftView.transform = CGAffineTransformMakeScale(1 - 0.2 * x, 1 - 0.2 * x);
            [self updateViewsHorizontalCenter:pt.x + 160];
        }
    }
}

- (void)updateViewsHorizontalCenter:(CGFloat)newHorizontalCenter
{
    CGPoint center = self.midView.center;
    center.x = newHorizontalCenter;
    self.midView.layer.position = center;
    center.x = center.x -320;
    self.leftView.layer.position = center;
    center.x = center.x + 640;
    self.rightView.layer.position = center;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    CGPoint pt = [[touches anyObject] locationInView:self.view.window];
    if (touchSide == KLLeft){
        if (pt.x > CHANGEPOINT){
            if (nowSide == KLMid)
                [self anchorShowViewTo:KLLeft];
            else if (nowSide == KLRight){
                [self anchorShowViewTo:KLMid];
            }
        } else {
            [self anchorShowViewTo:nowSide];
        }
    } else if (touchSide == KLRight){
        if (pt.x < 320 - CHANGEPOINT){
            if (nowSide == KLMid)
                [self anchorShowViewTo:KLRight];
            else if (nowSide == KLLeft){
                [self anchorShowViewTo:KLMid];
            }
        } else {
            [self anchorShowViewTo:nowSide];
        }
    }
    touchSide = KLMid;
}

- (void)anchorShowViewTo:(KLSide)side{
    [self anchorShowViewTo:side onComplete:nil];
}

- (void)anchorShowViewTo:(KLSide)side onComplete:(void(^)())complete{
    //NSNotification *notification = [NSNotification notificationWithName:KLSLIDECHANGED object:nil];
    //[[NSNotificationCenter defaultCenter] postNotification:notification];
    [UIView animateWithDuration:0.3 animations:^{
        if (side == KLMid){
            [self updateViewsHorizontalCenter:160];
            self.leftView.transform = CGAffineTransformMakeScale(0.8, 0.8);
            self.midView.transform = CGAffineTransformMakeScale(1, 1);
            self.rightView.transform = CGAffineTransformMakeScale(0.8, 0.8);
            cardFrame1.alpha = 0;
            cardFrame2.alpha = 0;
            cardFrame3.alpha = 1;
            cardFrame4.alpha = 1;
            cardFrame5.alpha = 1;
            cardFrame6.alpha = 1;
        } else if (side == KLRight && self.rightViewController){
            [self updateViewsHorizontalCenter:-160];
            self.leftView.transform = CGAffineTransformMakeScale(0.8, 0.8);
            self.midView.transform = CGAffineTransformMakeScale(0.8, 0.8);
            self.rightView.transform = CGAffineTransformMakeScale(1, 1);
            cardFrame1.alpha = 1;
            cardFrame2.alpha = 1;
            cardFrame3.alpha = 1;
            cardFrame4.alpha = 1;
            cardFrame5.alpha = 0;
            cardFrame6.alpha = 0;
        } else if (side == KLLeft && self.leftViewController){
            [self updateViewsHorizontalCenter:480];
            self.leftView.transform = CGAffineTransformMakeScale(1, 1);
            self.midView.transform = CGAffineTransformMakeScale(0.8, 0.8);
            self.rightView.transform = CGAffineTransformMakeScale(0.8, 0.8);
            cardFrame1.alpha = 1;
            cardFrame2.alpha = 1;
            cardFrame3.alpha = 0;
            cardFrame4.alpha = 0;
            cardFrame5.alpha = 1;
            cardFrame6.alpha = 1;
        }
        nowSide = side;
    } completion:^(BOOL comp){
        (void)complete;
    }];
}

- (void)resetShowViewToMid{
    [self anchorShowViewTo:KLMid onComplete:nil];
}

- (BOOL)leftShowing{
    return (nowSide == KLLeft);
}

- (BOOL)rightShowing{
    return (nowSide == KLRight);
}

- (BOOL)midShowing{
    return (nowSide == KLMid);
}

- (NSUInteger)autoResizeToFillScreen
{
    return (UIViewAutoresizingFlexibleWidth |
            UIViewAutoresizingFlexibleHeight |
            UIViewAutoresizingFlexibleTopMargin |
            UIViewAutoresizingFlexibleBottomMargin |
            UIViewAutoresizingFlexibleLeftMargin |
            UIViewAutoresizingFlexibleRightMargin);
}

- (UIView*) midView{
    return self.midViewController.view;
}

- (UIView *)leftView{
    return self.leftViewController.view;
}

- (UIView *)rightView{
    return self.rightViewController.view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
