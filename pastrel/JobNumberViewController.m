//
//  JobNumberViewController.m
//  pastrel
//
//  Created by Joe Longstreet on 8/20/15.
//  Copyright (c) 2015 Joe Longstreet. All rights reserved.
//

#import "JobNumberViewController.h"
#import "JobNumber.h"

@interface JobNumberViewController ()
@property IBOutlet NSTextField *clientName;
@property IBOutlet NSTextField *jobDescription;
@property IBOutlet NSTextField *jobNumberComponent;
@end

@implementation JobNumberViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    _clientName.stringValue = _jobNumber.clientDescription;
    _jobDescription.stringValue = _jobNumber.jobDescription;
    _jobNumberComponent.stringValue = [NSString stringWithFormat:@"%i-%i", _jobNumber.job, _jobNumber.component];
}

@end
