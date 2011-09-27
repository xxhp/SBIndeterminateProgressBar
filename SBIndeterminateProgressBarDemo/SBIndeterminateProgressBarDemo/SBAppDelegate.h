//
//  SBAppDelegate.h
//  SBIndeterminateProgressBarDemo
//
//  Created by Simon Blommegård on 2011-09-27.
//  Copyright (c) 2011 Simon Blommegård. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBViewController;

@interface SBAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SBViewController *viewController;

@end
