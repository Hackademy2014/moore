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
    NSLog([NSString stringWithFormat:@"Connection failed."]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %lul bytes of data",[self.responseData length]);
    
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *results = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    MCHistory *sharedHistory = [MCHistory sharedManager];
    NSArray *notifications = [results objectForKey:@"notifications"];
    NSMutableArray *store = [[NSMutableArray alloc] init];
    
    sharedHistory.numNotifs = [notifications count];
    NSUInteger counter = 0;
    
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
    
    [_address setText: @"The Moore Center\n195 McGregor Street\nUnit 400\nManchester, NH 03102"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MCBG.png"]]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showWebsite
{
    //Open the default browser and load the website's url
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.moorecenter.org/"]];
}

/**
 *  Opens the default browser with the Granite State Dog Recovery Facebook Page. Due to Facebook behavior, if the user has Facebook installed, it may ask to open the Facebook app.
 */
- (IBAction)openFacebook {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/themoorecenter"]];
}

/**
 *  Opens the default browser with the Granite State Dog Recovery Twitter Page. Due to Twitter behavior, if the user has Twitter installed, it may ask to open the Twitter app.
 */
- (IBAction)openTwitter{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/mcsregion7"]];
}

/**
 *  Opens the default browser with the Granite State Dog Recovery YouTube Channel. Due to YouTube behavior, if the user has YouTube installed, it may ask to open the YouTube app.
 */
- (IBAction)openYouTube{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.youtube.com/user/MooreCenterServices"]];
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *) token
{
    
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return NO;
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
