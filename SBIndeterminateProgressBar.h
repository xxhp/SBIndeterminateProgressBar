//
//  --------------------------------------------
//  Copyright (C) 2011 by Simon Blommegård
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//  --------------------------------------------
//
//  SBIndeterminateProgressBar.h
//  SBIndeterminateProgressBar
//
//  Created by Simon Blommegård on 2011-09-27.
//  Copyright (c) 2011 Simon Blommegård. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBIndeterminateProgressBar : UIView
@property (nonatomic, assign) float progress; //0.

@property (nonatomic, assign) BOOL border; // YES
@property (nonatomic, assign) CGFloat cornerRadius; /// 0. 
@property (nonatomic, assign) NSTimeInterval speed; // (1./50.)

@property (nonatomic, retain) UIColor *progressBorderColor;
@property (nonatomic, retain) UIColor *progressTintColor;
@property (nonatomic, retain) UIColor *trackBorderColor;
@property (nonatomic, retain) UIColor *trackBackgroundColor;

- (void)setProgress:(float)progress animated:(BOOL)animated;
@end
