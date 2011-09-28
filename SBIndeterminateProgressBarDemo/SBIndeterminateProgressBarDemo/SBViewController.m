//
//  SBViewController.m
//  SBIndeterminateProgressBarDemo
//
//  Created by Simon Blommegård on 2011-09-27.
//  Copyright (c) 2011 Simon Blommegård. All rights reserved.
//

#import "SBViewController.h"
#import "SBIndeterminateProgressBar.h"

@implementation SBViewController
@synthesize bar1;
@synthesize bar2;

#pragma mark - View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// Bar 1
	[bar1 setBorder:NO];
	[bar1 setProgress:0.];
	
	// Bar 2
	[bar2 setCornerRadius:5.];
	[bar2 setProgress:0.];
	
	[NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(increaseTimer:) userInfo:nil repeats:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)increase:(id)sender {
	if (bar2.progress != 1.) {
		[bar2 setProgress:bar2.progress+.2 animated:YES];
	} else {
		[bar1 setProgress:0. animated:YES];
		[bar2 setProgress:0. animated:YES];
	}
}

- (void)increaseTimer:(NSTimer *)timer {
	[bar1 setProgress:(bar1.progress+.0005)];
}

@end
