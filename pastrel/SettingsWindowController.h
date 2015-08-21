//
//  InterfaceWindowController.h
//  pastrel
//
//  Created by Joe Longstreet on 7/18/15.
//  Copyright (c) 2015 Joe Longstreet. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SettingsWindowController : NSWindowController
@property (readwrite) NSPoint coordinates;
@property (readwrite) NSString* shortcutName;
@end
