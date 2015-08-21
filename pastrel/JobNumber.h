//
//  JobNumber.h
//  pastrel
//
//  Created by Joe Longstreet on 8/19/15.
//  Copyright (c) 2015 Joe Longstreet. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JobNumberModel @end;
@interface JobNumber : NSObject
@property (nonatomic) int _id;
@property (retain) NSString* client;
@property (retain) NSString* clientDescription;
@property (retain) NSString* division;
@property (retain) NSString* divisionDescription;
@property (retain) NSString* product;
@property (retain) NSString* productDescription;
@property (nonatomic) int job;
@property (retain) NSString* jobDescription;
@property (nonatomic) int component;
@property (retain) NSString* componentDescription;
@end


