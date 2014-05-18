//
//  MCNotifInstance.m
//  Moore Center
//
//  Created by Hackademy on 5/17/14.
//  Copyright (c) 2014 Moore Center. All rights reserved.
//

#import "MCNotifInstance.h"

@implementation MCNotifInstance

- (void) encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.desc forKey:@"content"];

}

- (id)initWithCoder:(NSCoder *)aDecoder {

    if((self = [super init])) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.title = [aDecoder decodeObjectForKey:@"date"];
        self.title = [aDecoder decodeObjectForKey:@"desc"];
    }
    
    return self;
}

-(void) writeArrayWithCusomObjToUserDefaults:(NSString *)keyName withArray:(NSMutableArray *) myArray
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [defaults setObject:data forKey:keyName];
    [defaults synchronize];
}


-(NSArray *) readArrayWithCustomObjFromUserDefaults:(NSString*)keyName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:keyName];
    NSArray *myArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [defaults synchronize];
    return myArray;
}

@end
