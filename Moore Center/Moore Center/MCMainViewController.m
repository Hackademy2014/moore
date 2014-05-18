//
//  MCMainViewController.m
//  Moore Center
//
//  Created by Hackademy on 5/16/14.
//  Copyright (c) 2014 Moore Center. All rights reserved.
//

#import "MCMainViewController.h"
#import "MCNotifInstance.h"
#import "MCHistory.h"

@implementation MCMainViewController

@synthesize responseData = _responseData;

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
    MCHistory *sharedHistory = [MCHistory sharedManager];
    NSArray *notifications = [results objectForKey:@"notifications"];
    NSMutableArray *store = [[NSMutableArray alloc] init];
    
    sharedHistory.numNotifs = [notifications count];
    NSUInteger counter = 0;
    
    //NSUserDefaults *sUD = [NSUserDefaults standardUserDefaults];
    
    //[sUD setInteger:numNotifs forKey:@"numNotifs"];
    
    for (NSDictionary *notification in notifications)
    {
        if ((sharedHistory.numNotifs) > counter) {
            
            
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
    
    sharedHistory.notifications = store;
    
}

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
    
    [self.navigationController setNavigationBarHidden:YES];
    
    NSLog(@"viewWillAppearCalled");
    self.responseData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString:@"http://dev.leifnode.com/history.php"]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *) token
{
    
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
