//
//  MCHistory.h
//  Moore Center
//
//  Created by Hackademy on 5/18/14.
//  Copyright (c) 2014 Moore Center. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCHistory : NSObject {
    NSInteger numNotifs;
    NSInteger arrIndex;
    NSArray *notifications;
}

@property (nonatomic, assign) NSInteger numNotifs;
@property (nonatomic, assign) NSInteger arrIndex;
@property (nonatomic, strong) NSArray *notifications;

+ (id)sharedManager;

@end
