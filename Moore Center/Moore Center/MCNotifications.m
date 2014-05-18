//
//  MCNotifications.m
//  Moore Center
//
//  Created by Hackademy on 5/17/14.
//  Copyright (c) 2014 Moore Center. All rights reserved.
//

#import "MCNotifications.h"
#import "MCNotifInstance.h"
#import "MCNotificationCellTableViewCell.h"
#import "MCHistory.h"

@implementation MCNotifications


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.backItem.title = @"Home";
    
    // Set delegate
    // Set data source
    
    self.notifTable.delegate = self;
    self.notifTable.dataSource = self;

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.backItem.title = @"Home";
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
}


- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    MCHistory *sharedHistory = [MCHistory sharedManager];
    
    sharedHistory.arrIndex = 0;
    
    return sharedHistory.numNotifs;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*static NSString *CellIdentifier = @"cellidentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellidentifier"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = @"Test";    //etc.
    cell.detailTextLabel.text = @"Today"; */
    MCHistory *sharedHistory = [MCHistory sharedManager];
    
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    
    static NSString *CellIdentifier = @"Cell";
    
    if (sharedHistory.arrIndex < 5) {
      
        MCNotificationCellTableViewCell *cell = (MCNotificationCellTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
        NSUInteger ind = sharedHistory.arrIndex;
        MCNotifInstance *current = sharedHistory.notifications[ind];
    
        cell.title.text = current.title;
        cell.date.text = current.date;
        cell.description.text = current.desc;
    
        sharedHistory.arrIndex++;
    
        return cell;
        
    } else {
        MCNotificationCellTableViewCell *cell = (MCNotificationCellTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        return cell;
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
