//
//  JobNumbersController.h
//  pastrel
//
//  Created by Joe Longstreet on 8/19/15.
//  Copyright (c) 2015 Joe Longstreet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JobNumbersController : NSObject
- (void) fetch;
- (NSMutableArray *) search:(NSString *) searchTerm;
@end
