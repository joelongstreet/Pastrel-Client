//
//  JobNumbersController.m
//  pastrel
//
//  Created by Joe Longstreet on 8/19/15.
//  Copyright (c) 2015 Joe Longstreet. All rights reserved.
//

#import "JobNumbersController.h"
#import "JobNumber.h"
#import <objc/runtime.h>

@interface JobNumbersController()
@property NSMutableArray* list;
@end

@implementation JobNumbersController

-(id) init{
    self.list = [NSMutableArray array];
    return self;
}

-(void) fetch{
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL  URLWithString:@"http://localhost:3000/user/55d256272a8cd4ae3169de11/job-numbers"]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];

    NSError *err;
    NSURLResponse *response;

    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:responseData options: NSJSONReadingMutableContainers error: &err];
    NSArray *fetchedJobNumbers=[jsonArray objectForKey:@"jobNumbers"];

    for(id jobNum in fetchedJobNumbers){
        JobNumber *jobNumber = [[JobNumber alloc] init];
        for(NSString *key in [jobNum allKeys]){
            if(class_getProperty([JobNumber class], [key UTF8String])){
                [jobNumber valueForKey:key];
                [jobNumber setValue:[jobNum objectForKey:key] forKey:key];
            }
        }
        [self.list addObject:jobNumber];
    }
}


// loop over each job number, searching each property to determine
// if any of it's corresponding strings look like the search term
- (NSMutableArray *) search:(NSString *) searchTerm{
    NSMutableArray *matches = [NSMutableArray array];
    
    for(id jobNumber in self.list){
        int points = 0;
        
        // loop over the object properties
        int propertyCount = 0;
        objc_property_t *propertyArray = class_copyPropertyList([JobNumber class], &propertyCount);

        for(int i=0; i<propertyCount; i++){
            objc_property_t property = propertyArray[i];
            NSString *key = [[NSString alloc] initWithUTF8String:property_getName(property)];
            NSString *val = [jobNumber valueForKey:key];

            if([key rangeOfString:@"Description"].location != NSNotFound){
                if([val rangeOfString:searchTerm options:NSCaseInsensitiveSearch].location != NSNotFound){
                    points++;
                }
            }
        }

        if(points > 0){
            [matches addObject:jobNumber];
        }
    }
    
    return matches;
}


@end