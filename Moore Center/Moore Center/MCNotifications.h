//
//  MCNotifications.h
//  Moore Center
//
//  Created by Hackademy on 5/17/14.
//  Copyright (c) 2014 Moore Center. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCNotifications : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView* notifTable;
@property (nonatomic, strong) NSMutableData *responseData;

@end
