//
//  JobNumberViewController.h
//  pastrel
//
//  Created by Joe Longstreet on 8/20/15.
//  Copyright (c) 2015 Joe Longstreet. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JobNumber.h"

@interface JobNumberViewController : NSViewController
@property JobNumber *jobNumber;
@property (weak) IBOutlet NSView *viewContainer;
@end
