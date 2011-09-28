//
//  SBViewController.h
//  SBIndeterminateProgressBarDemo
//
//  Created by Simon Blommegård on 2011-09-27.
//  Copyright (c) 2011 Simon Blommegård. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBIndeterminateProgressBar;

@interface SBViewController : UIViewController

@property (nonatomic, retain) IBOutlet SBIndeterminateProgressBar *bar1;
@property (nonatomic, retain) IBOutlet SBIndeterminateProgressBar *bar2;

- (IBAction)increase:(id)sender;
@end
