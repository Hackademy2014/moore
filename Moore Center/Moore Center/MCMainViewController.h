//
//  MCMainViewController.h
//  Moore Center
//
//  Created by Hackademy on 5/16/14.
//  Copyright (c) 2014 Moore Center. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCMainViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton* notifBtn;
@property (nonatomic, strong) IBOutlet UIButton* subscribeBtn;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) IBOutlet UILabel* address;

- (IBAction)showWebsite;
- (IBAction)openFacebook;
- (IBAction)openTwitter;
- (IBAction)openYouTube;

@end
