//
//  KeyMonitor.m
//  pastrel
//
//  Created by Joe Longstreet on 7/19/15.
//  Copyright (c) 2015 Joe Longstreet. All rights reserved.
//

#import "KeyMonitor.h"

@interface KeyMonitor()
@property NSMutableArray *keys;
@end

@implementation KeyMonitor

@synthesize delegate;

- (void) listen{
    self.keys = [[NSMutableArray alloc] init];
    [NSEvent addGlobalMonitorForEventsMatchingMask:(NSKeyDownMask) handler:^(NSEvent *event){
        [self detectKeys: event];
    }];
}


- (void) detectKeys :(NSEvent *) keyEvent{
    if([keyEvent keyCode] == 51){
        [self.keys removeLastObject];
    } else{
        [self.keys addObject:[keyEvent characters]];
    }
    
    self.keyString = [_keys componentsJoinedByString:@""];
    self.lastKeyPressed = [keyEvent keyCode];
    [delegate keyPressed:self];
}

@end
