//
//  MCHistory.m
//  Moore Center
//
//  Created by Hackademy on 5/18/14.
//  Copyright (c) 2014 Moore Center. All rights reserved.
//

#import "MCHistory.h"

@implementation MCHistory 

@synthesize numNotifs;
@synthesize arrIndex;
@synthesize notifications;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static MCHistory *sharedHistory = nil;
    @synchronized(self) {
        if (sharedHistory == nil)
            sharedHistory = [[self alloc] init];
    }
    return sharedHistory;
}

- (id)init {
    if (self = [super init]) {
        numNotifs = 0;
        arrIndex = 0;
        notifications = [[NSArray alloc] init];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
