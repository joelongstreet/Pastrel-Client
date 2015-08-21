//
//  TimeEntryWindowController.h
//  pastrel
//
//  Created by Joe Longstreet on 8/20/15.
//  Copyright (c) 2015 Joe Longstreet. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JobNumbersController.h"

@interface TimeEntryWindowController : NSWindowController
@property (nonatomic, weak) JobNumbersController* jobNumbersController;
@end
