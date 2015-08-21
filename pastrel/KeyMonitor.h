//
//  KeyMonitor.h
//  pastrel
//
//  Created by Joe Longstreet on 7/19/15.
//  Copyright (c) 2015 Joe Longstreet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <appkit/NSEvent.h>

@class KeyMonitor;

@protocol KeyMonitorDelegate
- (void) keyPressed:(KeyMonitor *) keyMonitor;
@end


@interface KeyMonitor : NSObject{
    
}

@property (nonatomic, assign) id delegate;
@property NSString *keyString;
@property int lastKeyPressed;
- (void) listen;
@end
