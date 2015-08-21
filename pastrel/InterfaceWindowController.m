//
//  InterfaceWindowController.m
//  pastrel
//
//  Created by Joe Longstreet on 7/18/15.
//  Copyright (c) 2015 Joe Longstreet. All rights reserved.
//

#import "InterfaceWindowController.h"
#import "MASShortcut/MASShortcutView+Bindings.h"

@interface InterfaceWindowController ()
@property (nonatomic, weak) IBOutlet MASShortcutView *shortcutView;
@end

@implementation InterfaceWindowController


- (void)windowDidLoad {
    [super windowDidLoad];
    self.shortcutView.associatedUserDefaultsKey = self.shortcutName;
    
    [self.window setFrameTopLeftPoint:self.coordinates];
    [self.window makeKeyAndOrderFront:self];
    [self.window setOpaque:NO];
}

@end
