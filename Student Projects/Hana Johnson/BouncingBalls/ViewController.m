//
//  ViewController.m
//  BouncingBalls
//
//  Created by aluong on 7/28/15.
//  Copyright (c) 2015 BlackGirlsCode. All rights reserved.
//

#import "ViewController.h"
#import "Ball.h"
#import <AVFoundation/AVFoundation.h>

CGFloat howLong = 5;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *birdImageView;
@end

@implementation ViewController {
    AVAudioPlayer *myAudioPlayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Challenge 1a: Add a tap recognizer to add a ball at the tap location
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:(@selector(createBall:))];
    [self.view addGestureRecognizer:tapGesture];
    
    [NSTimer scheduledTimerWithTimeInterval:howLong target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    [self timerFired];
}

- (void)timerFired
{
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"Crow-call" ofType: @"mp3"];
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath ];
    myAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    [myAudioPlayer prepareToPlay];
    [myAudioPlayer play];
    
    self.birdImageView.frame = CGRectMake(0, 150, 50, 50);
    self.birdImageView.alpha = 1.0;
    [UIView animateWithDuration:howLong animations:^{
        self.birdImageView.frame = CGRectMake(300, 100, 500, 500);
        self.birdImageView.alpha = 0.0;
    }];
}


- (void)createBall:(UITapGestureRecognizer *)gestureRecognizer
{
    // Challenge 1b: Create a ball and add it to the view where the tap was made
    CGPoint tapLocation = [gestureRecognizer locationInView:self.view];
    UIView *ball = [[Ball alloc] initWithFrame:CGRectMake(tapLocation.x, tapLocation.y, 50.0, 50.0)];
    [self.view addSubview:ball];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// Shake motion ended, so notify the balls to dissappear
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake )
    {
        // User was shaking the device. Post a notification named "shake".
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shake" object:self];
    }
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}
@end
