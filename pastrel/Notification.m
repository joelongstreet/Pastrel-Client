//
//  Notification.m
//  pastrel
//
//  Created by Joe Longstreet on 7/18/15.
//  Copyright (c) 2015 Joe Longstreet. All rights reserved.
//

#import "Notification.h"
#import "IOKit/graphics/IOGraphicsLib.h"


@interface Notification()
@property float current_brightness;
@property CGDirectDisplayID targetDisplay;
@property io_service_t displayService;
@property CFStringRef brightnessKey;
@property NSTimer *timer;
@end

@implementation Notification


- (void) schedule:(float) interval{
    if(_timer != nil){
        [_timer invalidate];
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(notify) userInfo:nil repeats:YES];

}


- (void) notify {
    // find the displays
    self.targetDisplay = CGMainDisplayID();
    self.displayService = CGDisplayIOServicePort(_targetDisplay);
    self.brightnessKey = CFSTR(kIODisplayBrightnessKey);
    
    // get current brightness
    self.current_brightness = HUGE_VALF;
    IODisplayGetFloatParameter(_displayService, kNilOptions, _brightnessKey, &_current_brightness);
    
    // fade the display in and out
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(fadeOut:) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(fadeIn:) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(fadeOut:) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(fadeIn:) userInfo:nil repeats:NO];
}


- (void)fadeOut:(NSTimer *)timer{
    float min_brightness = _current_brightness - .075;
    IODisplaySetFloatParameter(_displayService, kNilOptions, self.brightnessKey, min_brightness);
}


- (void)fadeIn:(NSTimer *)timer{
    IODisplaySetFloatParameter(_displayService, kNilOptions, self.brightnessKey, self.current_brightness);
}

@end
