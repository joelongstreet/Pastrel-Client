//
//  AppDelegate.m
//  pastrel
//
//  Created by Joe Longstreet on 7/17/15.
//  Copyright (c) 2015 Joe Longstreet. All rights reserved.
//

#import "AppDelegate.h"
#import "ApplicationServices/ApplicationServices.h"
#import "MASShortcut/Shortcut.h"
#import "Notification.h"
#import "SettingsWindowController.h"
#import "KeyMonitor.h"
#import "JobNumbersController.h"
#import "JobNumber.h"
#import "TimeEntryWindowController.h"

static NSString *const shortcutName = @"GlobalShortcuts";
static BOOL SHOW_NOTIFICATIONS = NO;
static BOOL IMMEDIATELY_SHOW_INTERFACE_ON_SHORTCUT = YES;

@interface AppDelegate () <KeyMonitorDelegate>
@property (strong, nonatomic) NSStatusItem *statusItem;
@property (strong) SettingsWindowController* settingsWindowController;
@property (strong) TimeEntryWindowController* timeEntryWindowController;
@property (strong) KeyMonitor *keyMonitor;
@property (strong) JobNumbersController *jobNumbersController;
@end


@implementation AppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // go fetch all the job numbers for this particular user
    self.jobNumbersController = [[JobNumbersController alloc] init];
    [self.jobNumbersController fetch];
    
    // build the menu bar status item
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.statusItem.image = [NSImage imageNamed:@"menu-bar-icon.png"];
    self.statusItem.alternateImage = [NSImage imageNamed:@"menu-bar-icon-alt.png"];
    [self.statusItem setTarget:self];
    [self.statusItem setAction:@selector(openPrimaryInterface:)];
    
    // init the shortcut binder and listen for custom shortcuts
    [[MASShortcutBinder sharedBinder]
     bindShortcutWithDefaultsKey:shortcutName
     toAction:^{ [self handleShortcutEntry];
     }];

    // start the notification system
    if(SHOW_NOTIFICATIONS){
        Notification *notification = [[Notification alloc] init];
        [notification schedule:900];
    }
}



// open the primary interface when the icon is clicked
- (void) openPrimaryInterface:(id) sender{
    self.settingsWindowController = [[SettingsWindowController alloc] initWithWindowNibName:@"SettingsWindow"];
    self.settingsWindowController.shortcutName = shortcutName;
    [self.settingsWindowController showWindow:nil];
}



// after the shortcut is entered...
- (void)handleShortcutEntry{
    [[NSSound soundNamed:@"Pop"] play];

    // should we show the time entry interface or use the key monitor
    if(IMMEDIATELY_SHOW_INTERFACE_ON_SHORTCUT){
        self.timeEntryWindowController = [[TimeEntryWindowController alloc] initWithWindowNibName:@"TimeEntryWindow"];
        [self.timeEntryWindowController showWindow:nil];
        [NSApp activateIgnoringOtherApps:YES];
        self.timeEntryWindowController.jobNumbersController = self.jobNumbersController;
    } else {
        if(self.keyMonitor == nil){
            self.keyMonitor = [[KeyMonitor alloc] init];
            self.keyMonitor.delegate = self;
        }

        [self.keyMonitor listen];
    }
}



// listen to key presses from the key monitor
- (void) keyPressed:(KeyMonitor *)keyMonitor{
    NSString *keyz = [keyMonitor keyString];
    NSMutableArray *matches = [self.jobNumbersController search:keyz];
    
    for(id match in matches){
        NSLog(@"%@", [match clientDescription]);
    }
}


@end
