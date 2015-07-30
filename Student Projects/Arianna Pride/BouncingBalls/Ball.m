//Arianna Pride pridea17@bishopodowd.org



//
//  Ball.m
//  BouncingBalls
//
//  Created by aluong on 7/28/15.
//  Copyright (c) 2015 BlackGirlsCode. All rights reserved.
//

#import "Ball.h"
#include <stdlib.h>

@interface Ball()

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravity;
@property (nonatomic, assign) CGPoint lastLocation;
@property (nonatomic, strong) UIImageView *ball;

@end

int ballIndex = 0;


@implementation Ball

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(removeBall:)
                                                     name:@"shake"
                                                   object:nil];
        
        // Challenge 2a: Add a pan recognizer so that the user can move the ball around on the screen
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        self.gestureRecognizers = @[panRecognizer];
        
    }
    return self;
}

- (void)layoutSubviews
{
    // Add ball image
    self.ball = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50.0, 50.0)];
    //    int r = arc4random_uniform([balls count]);
    
    
    NSArray *balls = @[@"stevensmall", @"Garnet", @"Pearl", @"amathest"];
    

    NSString *ballFile = balls[ballIndex];
    ballIndex = ballIndex + 1;
    
    if (ballIndex == [balls count]) {
        ballIndex = 0;
    }
    
    
    self.ball.image = [UIImage imageNamed:ballFile];
    [self addSubview:self.ball];
    [self addGravity];
    
    // Challenge 3a: Add gravity to the ball so that it will fall and bounce

}

- (void)handlePan:(UIPanGestureRecognizer *)panGestureRecognizer
{
    // Challenge 2b: Move the ball when the user pans the image on the screen
    CGPoint translation = [panGestureRecognizer translationInView:self.superview];
    self.center = CGPointMake(self.lastLocation.x + translation.x, self.lastLocation.y +translation.y);
    [self addGravity];    
    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        // Challenge 3b: After the user stops moving the object, then it should fall like a normal ball would, so add gravity!

    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.lastLocation = self.center;
}

-(void)removeBall:(UILongPressGestureRecognizer *)longGestureRecognizer {
    [UIView animateWithDuration:0.2
                     animations:^{self.ball.alpha = 0.0;}
                     completion:^(BOOL finished){
                         self.ball = nil;}];
}

- (void)addGravity
{
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.superview];
    self.gravity = [[UIGravityBehavior alloc] initWithItems:@[self]];
    [self.animator addBehavior:self.gravity];
    
    UIDynamicItemBehavior *elasticityBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self]];
    elasticityBehavior.elasticity = 0.7f;
    [self.animator addBehavior:elasticityBehavior];
    
    UICollisionBehavior* collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collisionBehavior];
}

@end
