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

@implementation MCNotifications

NSArray *notifications;

@synthesize responseData = _responseData;

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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.backItem.title = @"Home";
    
    NSLog(@"viewWillAppearCalled");
    self.responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString:@"http://dev.leifnode.com/history.php"]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *results = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    // show all values
    /*for(id key in results) {
        
        id value = [results objectForKey:key];
        
        NSString *keyAsString = (NSString *)key;
        NSString *valueAsString = (NSString *)value;
        
        NSLog(@"key: %@", keyAsString);
        NSLog(@"value: %@", valueAsString);
    }*/
    
    // extract specific value...
    NSArray *notifications = [results objectForKey:@"notifications"];
    NSMutableArray *store = [[NSMutableArray alloc] initWithCapacity:5];
    
    NSUInteger numNotifs = [notifications count];
    NSLog(@"numN: %lul", (unsigned long)numNotifs);
    NSUInteger counter = 0;
    
    //NSUserDefaults *sUD = [NSUserDefaults standardUserDefaults];
    
    //[sUD setInteger:numNotifs forKey:@"numNotifs"];
    
    for (NSDictionary *notification in notifications)
    {
        if ((numNotifs) > counter) {
        
            
            NSString *subject = notification[@"subject"];
            NSString *date = notification[@"date"];
            NSString *desc = notification[@"content"];
        
            /*
            NSLog(@"----");
            NSLog(@"Title: %@", subject);
            NSLog(@"Date: %@", date);
            NSLog(@"Description: %@", desc);
            NSLog(@"----");
            */
             
            MCNotifInstance *current = [MCNotifInstance alloc];
            current.title = subject;
            current.date = date;
            current.desc = desc;
             
            [store addObject:current];
            
            counter = counter + 1;
            
        } else {
            // Do Nothing
        }
    }
    
    notifications = store;
    
    
    /*[[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:store] forKey:@"currentNotifs"];
    
    NSData *data = [sUD objectForKey:@"currentNotifs"];
    NSInteger numNotifs2 = [sUD integerForKey:@"numNotifs"];
    NSInteger counter2 = 0;
    NS
    if (numNotifs2 > counter2) {
        
        MCNotifInstance *notif = array[counter2];
        NSString *title2 = notif.title;
        NSString *date2 = notif.date;
        NSString *desc2 = notif.desc;
        
        NSLog(@"----");
        NSLog(@"Title: %@", title2);
        NSLog(@"Date: %@", date2);
        NSLog(@"Description: %@", desc2);
        NSLog(@"----");
        
        counter2 = counter2 + 1;

    } else {
        // Do nothing
    }*/
    
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
    return 1;
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
    
    static NSString *CellIdentifier = @"Cell";
    MCNotificationCellTableViewCell *cell = (MCNotificationCellTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [cell.title setText:@"Test"];
    
    return cell;
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
