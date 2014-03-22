//
//  MarkerView.m
//  Around Me
//
//  Created by inin on 3/12/14.
//  Copyright (c) 2014 Jean-Pierre Distler. All rights reserved.
//

#import "MarkerView.h"
#import "ARGeoCoordinate.h"

const float kWidth = 200.0f;
const float kHeight = 100.0f;

@interface MarkerView ()

@property (nonatomic, strong) UILabel *lblDistance;

@end

@implementation MarkerView


- (id)initWithCoordinate:(ARGeoCoordinate *)coordinate delegate:(id<MarkerViewDelegate>)delegate {
	//1
	if((self = [super initWithFrame:CGRectMake(0.0f, 0.0f, kWidth, kHeight)])) {
        
		//2
		_coordinate = coordinate;
		_delegate = delegate;
        
		[self setUserInteractionEnabled:YES];
        
		//3
		UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kWidth, 40.0f)];
		[title setBackgroundColor:[UIColor colorWithWhite:0.3f alpha:0.7f]];
		[title setTextColor:[UIColor whiteColor]];
		[title setTextAlignment:NSTextAlignmentCenter];
		[title setText:[coordinate title]];
		[title sizeToFit];
        
		//4
		_lblDistance = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 45.0f, kWidth, 40.0f)];
		[_lblDistance setBackgroundColor:[UIColor colorWithWhite:0.3f alpha:0.7f]];
		[_lblDistance setTextColor:[UIColor whiteColor]];
		[_lblDistance setTextAlignment:NSTextAlignmentCenter];
		[_lblDistance setText:[NSString stringWithFormat:@"%.2f km", [coordinate distanceFromOrigin] / 1000.0f]];
		[_lblDistance sizeToFit];
        
		//5
		[self addSubview:title];
		[self addSubview:_lblDistance];
        
		[self setBackgroundColor:[UIColor clearColor]];
	}
    
	return self;
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	
    [[self lblDistance] setText:[NSString stringWithFormat:@"%.2f km", [[self coordinate] distanceFromOrigin] / 1000.0f]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if(_delegate && [_delegate conformsToProtocol:@protocol(MarkerViewDelegate)]) {
		[_delegate didTouchMarkerView:self];
	}
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
	CGRect theFrame = CGRectMake(0, 0, kWidth, kHeight);
    
	return CGRectContainsPoint(theFrame, point);
}

@end
