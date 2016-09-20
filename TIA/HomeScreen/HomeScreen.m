//
//  HomeScreen.m
//  TIA
//
//  Created by Swtya on 19/03/16.
//  Copyright (c) 2016 Swtya. All rights reserved.
//

#import "HomeScreen.h"
#import "SwtyaWebViewScreen.h"
#import "InfoScreen.h"
#import "JourneyPlannerScreen.h"
#import "DirectoryScreen.h"

@interface HomeScreen ()

@end

@implementation HomeScreen

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    //_titleLabel.font = [UIFont fontWithName:@"Roboto" size:21];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    NSString *homeXIB;
    
    if (screenBounds.size.height == 667)
    {
        homeXIB = @"SwtyaWebViewScreen";
    }
    else if(screenBounds.size.height == 1024)
    {
        homeXIB = @"SwtyaWebViewScreen ipad";
    }
    else if(screenBounds.size.height == 568)
    {
        homeXIB = @"SwtyaWebViewScreen 568";
    }
    else if(screenBounds.size.height == 480)
    {
        homeXIB = @"SwtyaWebViewScreen 480";
    }
    else if(screenBounds.size.height == 736)
    {
        homeXIB = @"SwtyaWebViewScreen 414";
    }
    
    if ([touch view] == self.nmImgView)
    {
        DirectoryScreen *swtyaWebViewScreen = [[DirectoryScreen alloc] initWithNibName:@"DirectoryScreen" bundle:nil];
        
        [self presentViewController:swtyaWebViewScreen animated:NO completion:nil];
        //[self.navigationController pushViewController:swtyaWebViewScreen animated:NO];
    }
    else if ([touch view] == self.flightsImgView)
    {
        SwtyaWebViewScreen *swtyaWebViewScreen = [[SwtyaWebViewScreen alloc] initWithNibName:homeXIB bundle:nil];
        
        swtyaWebViewScreen.swtyaWebViewUrl = @"http://www.skyscanner.net";
        swtyaWebViewScreen.swtya4mWhere = @"Home";
        
        [self presentViewController:swtyaWebViewScreen animated:NO completion:nil];
    }
    else if ([touch view] == self.hotelsImgView)
    {
        SwtyaWebViewScreen *swtyaWebViewScreen = [[SwtyaWebViewScreen alloc] initWithNibName:homeXIB bundle:nil];
        
        swtyaWebViewScreen.swtyaWebViewUrl = @"http://www.trivago.in";
        swtyaWebViewScreen.swtya4mWhere = @"Home";
        
        [self presentViewController:swtyaWebViewScreen animated:NO completion:nil];
    }
    else if ([touch view] == self.exchImgView)
    {
        SwtyaWebViewScreen *swtyaWebViewScreen = [[SwtyaWebViewScreen alloc] initWithNibName:homeXIB bundle:nil];
        
        swtyaWebViewScreen.swtyaWebViewUrl = @"http://www.remitrate.com";
        swtyaWebViewScreen.swtya4mWhere = @"Home";
        
        [self presentViewController:swtyaWebViewScreen animated:NO completion:nil];
    }
    else if ([touch view] == self.infoImgView)
    {//
        NSString *homeXIB;
        
        if (screenBounds.size.height == 667)
        {
            homeXIB = @"InfoScreen";
        }
        else if(screenBounds.size.height == 1024)
        {
            homeXIB = @"InfoScreen ipad";
        }
        else if(screenBounds.size.height == 568)
        {
            homeXIB = @"InfoScreen 568";
        }
        else if(screenBounds.size.height == 480)
        {
            homeXIB = @"InfoScreen 480";
        }
        else if(screenBounds.size.height == 736)
        {
            homeXIB = @"InfoScreen 414";
        }
        
        InfoScreen *swtyaInfoScreen = [[InfoScreen alloc] initWithNibName:homeXIB bundle:nil];
        [self presentViewController:swtyaInfoScreen animated:NO completion:nil];
    }
    else if ([touch view] == self.journeyImgView)
    {//
        NSString *homeXIB;
        
        if (screenBounds.size.height == 667)
        {
            homeXIB = @"JourneyPlannerScreen";
        }
        else if(screenBounds.size.height == 1024)
        {
            homeXIB = @"JourneyPlannerScreen ipad";
        }
        else if(screenBounds.size.height == 568)
        {
            homeXIB = @"JourneyPlannerScreen 568";
        }
        else if(screenBounds.size.height == 480)
        {
            homeXIB = @"JourneyPlannerScreen 480";
        }
        else if(screenBounds.size.height == 736)
        {
            homeXIB = @"JourneyPlannerScreen 414";
        }
        
        JourneyPlannerScreen *swtyaJPScreen = [[JourneyPlannerScreen alloc] initWithNibName:homeXIB bundle:nil];
        [self presentViewController:swtyaJPScreen animated:NO completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
