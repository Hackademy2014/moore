//
//  MCNotifications.m
//  Moore Center
//
//  Created by Hackademy on 5/17/14.
//  Copyright (c) 2014 Moore Center. All rights reserved.
//

#import "MCNotifications.h"
#import "MCNotificationCellTableViewCell.h"

@interface MCNotifications ()

@property (nonatomic, strong) NSMutableData *responseData;

@end

@implementation MCNotifications

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
    
    NSUInteger numNotifs = [notifications count];
    NSUInteger counter = 0;
    
    
    for (NSDictionary *notification in notifications)
    {
        if (numNotifs > counter) {
        
            NSString *subject = notification[@"subject"];
            NSString *date = notification[@"date"];
            NSString *desc = notification[@"content"];
        
            NSLog(@"----");
            NSLog(@"Title: %@", subject);
            NSLog(@"Date: %@", date);
            NSLog(@"Description: %@", desc);
            NSLog(@"----");
            
            
            
        } else {
            // Do Nothing
        }
        
        
        //NSString *icon = [result objectForKey:@"icon"];
        //NSLog(@"icon: %@", icon);
    }
    
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
