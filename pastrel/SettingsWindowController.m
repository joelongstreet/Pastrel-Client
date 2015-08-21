//
//  InterfaceWindowController.m
//  pastrel
//
//  Created by Joe Longstreet on 7/18/15.
//  Copyright (c) 2015 Joe Longstreet. All rights reserved.
//

#import "SettingsWindowController.h"
#import "MASShortcut/MASShortcutView+Bindings.h"

@interface SettingsWindowController ()
@property (nonatomic, weak) IBOutlet MASShortcutView *shortcutView;
@end

@implementation SettingsWindowController


- (void)windowDidLoad {
    [super windowDidLoad];
    self.shortcutView.associatedUserDefaultsKey = self.shortcutName;
    
    [self.window setFrameTopLeftPoint:self.coordinates];
    [self.window makeKeyAndOrderFront:self];
    [self.window setOpaque:NO];
}

@end
