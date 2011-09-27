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
//  SBIndeterminateProgressBar.m
//  SBIndeterminateProgressBar
//
//  Created by Simon Blommegård on 2011-09-27.
//  Copyright (c) 2011 Simon Blommegård. All rights reserved.
//

#import "SBIndeterminateProgressBar.h"

@interface SBIndeterminateProgressView : UIView
@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, assign) NSTimeInterval speed;
@property (nonatomic, assign) NSTimer *speedTimer;

- (void)update:(NSTimer *)timer;
@end

@implementation SBIndeterminateProgressView 
@synthesize offset = _offset;
@synthesize speed = _speed;
@synthesize speedTimer = _speedTimer;

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		[self setBackgroundColor:[UIColor clearColor]];
		[self setClipsToBounds:YES];
	}
	return self;
}

- (void)dealloc {
	[self setSpeedTimer:nil];	
	
	[super dealloc];
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	SBIndeterminateProgressBar *bar = (SBIndeterminateProgressBar *)[self superview];
	
	// Progress
	UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:(bar.border)? CGRectInset(self.bounds, .5, .5):self.bounds
																						 byRoundingCorners:(bar.progress == 1.)? UIRectCornerAllCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft)
																		 cornerRadii:CGSizeMake(bar.cornerRadius, bar.cornerRadius)];
	
	CGContextSaveGState(context);
	CGContextSetPatternPhase(context, CGSizeMake(_offset, 1.));
	
	[bar.progressTintColor setFill];
	[path fill];
	
	CGContextRestoreGState(context);
	
	[bar.progressBorderColor setStroke];
	[path stroke];
}

#pragma mark - Properties

- (void)setSpeed:(NSTimeInterval)speed {
	_speed = speed;
	
	[_speedTimer invalidate];
	[_speedTimer release], _speedTimer = nil;
	
	[self setSpeedTimer:[NSTimer scheduledTimerWithTimeInterval:_speed target:self selector:@selector(update:) userInfo:nil repeats:YES]];
}

#pragma mark - Private

- (void)update:(NSTimer *)timer {
	_offset+=1.;
	
	if ([UIImage imageNamed:@"bar"].size.width == _offset)
		_offset = 0.;
	
	[self setNeedsDisplay];
}

@end

@interface SBIndeterminateProgressBar ()
@property (nonatomic, retain) SBIndeterminateProgressView *progressView;
- (void)setup;
@end

@implementation SBIndeterminateProgressBar
@synthesize progress = _progress;
@synthesize cornerRadius = _cornerRadius;
@synthesize border = _border;
@dynamic speed;

@synthesize progressBorderColor = _progressBorderColor;
@synthesize progressTintColor = _progressTintColor;
@synthesize trackBorderColor = _trackBorderColor;
@synthesize trackBackgroundColor = _trackBackgroundColor;

@synthesize progressView = _progressView;

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		[self setup];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super initWithCoder:aDecoder])) {
		[self setup];
	}
	return self;
}

- (void)dealloc {
	[self setProgressBorderColor:nil];
	[self setProgressTintColor:nil];
	[self setTrackBorderColor:nil];
	[self setTrackBackgroundColor:nil];
	
	[super dealloc];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	CGFloat width = self.bounds.size.width * _progress;
	[self.progressView setFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, width, self.bounds.size.height)];
}

- (void)drawRect:(CGRect)rect {	
	// Background
	UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:_border? CGRectInset(self.bounds, .5, .5):self.bounds
																						 byRoundingCorners:UIRectCornerAllCorners
																									 cornerRadii:CGSizeMake(_cornerRadius, _cornerRadius)];
	
	[self.trackBorderColor setStroke];
	[path stroke];
	
	[self.trackBackgroundColor setFill];
	[path fill];
}

#pragma mark - Private

- (void)setup {
	[self setBackgroundColor:[UIColor clearColor]];
	[self setClipsToBounds:YES];

	_border = YES;
	_progress = 0.;
	
	[self setSpeed:1./50.];
}

#pragma mark - Properties

- (void)setProgress:(float)progress {
	[self setProgress:progress animated:NO];
}

- (void)setProgress:(float)progress animated:(BOOL)animated {
	if (progress < 0.)
		progress = 0.;
	if (progress > 1.)
		progress = 1.;

	[UIView animateWithDuration:(animated)? 0.:0. animations:^{
		_progress = progress;		
		CGFloat width = self.bounds.size.width * progress;
		[self.progressView setFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, width, self.bounds.size.height)];
	}];
}

- (UIColor *)progressBorderColor {
	if (!_progressBorderColor)
		[self setProgressBorderColor:[UIColor colorWithRed:.906 green:.561 blue:.031 alpha:1.]];
	
	return _progressBorderColor;
}

- (UIColor *)progressTintColor {
	if (!_progressTintColor)
		[self setProgressTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bar"]]];
	
	return _progressTintColor;
}

- (UIColor *)trackBorderColor {
	if (!_trackBorderColor)
		[self setTrackBorderColor:[UIColor colorWithWhite:.827 alpha:1.]];
	
	return _trackBorderColor;
}

- (UIColor *)trackBackgroundColor {
	if (!_trackBackgroundColor)
		[self setTrackBackgroundColor:[UIColor colorWithWhite:.961 alpha:1.]];
	
	return _trackBackgroundColor;
}

- (SBIndeterminateProgressView *)progressView {
	if (!_progressView) {
		_progressView = [[SBIndeterminateProgressView alloc] initWithFrame:CGRectZero];
		[self addSubview:_progressView];
	}
	
	return _progressView;
}

- (NSTimeInterval)speed {
	return self.progressView.speed;
}

- (void)setSpeed:(NSTimeInterval)speed {
	[self.progressView setSpeed:speed];
}

@end
