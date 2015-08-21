//
//  TimeEntryWindowController.m
//  pastrel
//
//  Created by Joe Longstreet on 8/20/15.
//  Copyright (c) 2015 Joe Longstreet. All rights reserved.
//

#import "TimeEntryWindowController.h"
#import "JobNumbersController.h"
#import "JobNumber.h"
#import "JobNumberViewController.h"

@interface TimeEntryWindowController ()
@property (weak) IBOutlet NSTextField *jobNameField;
@property (weak) IBOutlet NSTextField *hoursField;
@property (weak) IBOutlet NSWindow *containerWindow;
@property (weak) IBOutlet NSView *containerView;
@property (strong) IBOutlet NSViewController *containerViewController;
@property BOOL shouldClose;
@end

@implementation TimeEntryWindowController

- (id)initWithWindowNibName:(NSString *)windowNibName{
    return [super initWithWindowNibName:windowNibName];
}


- (void)windowDidLoad {
    [super windowDidLoad];

    // tweak default ui states
    _containerWindow.backgroundColor = [NSColor clearColor];
    _containerWindow.opaque = NO;
    [_jobNameField setDelegate:self];
    [_jobNameField setFocusRingType:NSFocusRingTypeNone];
    [_hoursField setFocusRingType:NSFocusRingTypeNone];
    
    // close the window if it loses focus
    self.shouldClose = NO;
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver:self selector:@selector(closeWindow:) name:NSWorkspaceDidDeactivateApplicationNotification object:nil];
    
    // listen for key events
    [NSEvent addLocalMonitorForEventsMatchingMask:NSKeyDownMask handler:^(NSEvent *e) {
        if([e keyCode] == 53){
           // esc
            [_containerWindow close];
        } else if([e keyCode] == 126){
            // up
        } else if([e keyCode] == 125){
            // down
        } else if([e keyCode] == 36){
            // return
            [_containerWindow close];
        }
        return e;
    } ];

}



// close the window if it loses focus
- (void) closeWindow:(NSNotification *) note{
    // for some reason this method gets called both when the window loads as well as when the window closes
    if(self.shouldClose){
        [_containerWindow close];
    }
    self.shouldClose = YES;
}



-(void) controlTextDidChange:(NSNotification *)notification{
    if([notification object] == _jobNameField){
        NSString *searchTerm = [_jobNameField stringValue];
        NSMutableArray *matches = [self.jobNumbersController search:searchTerm];
        NSMutableArray *subViews = [[NSMutableArray alloc] init];
        
        [self.containerView setSubviews:subViews];

        for(id match in matches){
            JobNumberViewController *viewController = [[JobNumberViewController alloc] initWithNibName:@"JobNumberView" bundle:nil];
            viewController.jobNumber = match;
            [subViews addObject:[viewController view]];
        }

        [self.containerView setSubviews:subViews];
    } else if([notification object] == _hoursField){
        NSLog(@"%@", [_hoursField stringValue]);
    }
}


@end
