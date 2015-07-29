//
//  Ball.m
//  BouncingBalls
//
//  Created by aluong on 7/28/15.
//  Copyright (c) 2015 BlackGirlsCode. All rights reserved.
//

#import "Ball.h"
@import AudioToolbox;

@interface Ball()

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravity;
@property (nonatomic, assign) CGPoint lastLocation;
@property (nonatomic, strong) UIImageView *ball;
@property (nonatomic, assign) SystemSoundID sound;

@end


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
        

        
    }
    return self;
}

- (void)layoutSubviews
{
    // Add ball image
    self.ball = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50.0, 50.0)];
    self.ball.image = [UIImage imageNamed:@"red_ball"];
    [self addSubview:self.ball];
    
    // Challenge 3a: Add gravity to the ball so that it will fall and bounce

}

- (void)handlePan:(UIPanGestureRecognizer *)panGestureRecognizer
{
    // Challenge 2b: Move the ball when the user pans the image on the screen

    
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
    collisionBehavior.collisionDelegate = self;
    [self.animator addBehavior:collisionBehavior];
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    // Challenge 4: Change the image of the ball when it bounces by replacing the image name.
    //self.ball.image = [UIImage imageNamed:@"sun"];
    
    // Challenge 5: Add sound when the ball bounces to the ground by downloading an audio file and copying it to the bundle (drag to the folder)
    // Rename the sound resource below
//    NSString *soundPath = [[NSBundle mainBundle]
//                            pathForResource:@"doorBellSound" ofType:@"mp3"];
//    NSURL *soundPathURL = [NSURL fileURLWithPath:soundPath];
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundPathURL, &_sound);
//    AudioServicesPlaySystemSound(_sound);

}

@end
