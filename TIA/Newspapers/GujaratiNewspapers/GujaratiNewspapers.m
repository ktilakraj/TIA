//
//  GujaratiNewspapers.m
//  TIA
//
//  Created by Swtya on 22/03/16.
//  Copyright (c) 2016 Swtya. All rights reserved.
//

#import "GujaratiNewspapers.h"
#import "HomeScreen.h"
#import "NewspapersScreen.h"
#import "SwtyaWebViewScreen.h"

@interface GujaratiNewspapers ()
{
    CGRect screenBounds;
    NSString *homeXIB;
}

@end

@implementation GujaratiNewspapers

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    screenBounds = [[UIScreen mainScreen] bounds];
    
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)swtyaBckBtnClicked:(id)sender
{
    NSString *homeXIB1;
    
    if (screenBounds.size.height == 667)
    {
        homeXIB1 = @"NewspapersScreen";
    }
    else if(screenBounds.size.height == 1024)
    {
        homeXIB1 = @"NewspapersScreen ipad";
    }
    else if(screenBounds.size.height == 568)
    {
        homeXIB1 = @"NewspapersScreen 568";
    }
    else if(screenBounds.size.height == 480)
    {
        homeXIB1 = @"NewspapersScreen 480";
    }
    else if(screenBounds.size.height == 736)
    {
        homeXIB1 = @"NewspapersScreen 414";
    }
    
    NewspapersScreen *swtyaNPScreen = [[NewspapersScreen alloc] initWithNibName:homeXIB1 bundle:nil];
    [self presentViewController:swtyaNPScreen animated:NO completion:nil];
}

- (IBAction)swtyaBtn1Clicked:(id)sender
{
    SwtyaWebViewScreen *swtyaWebViewScreen = [[SwtyaWebViewScreen alloc] initWithNibName:homeXIB bundle:nil];
    
    swtyaWebViewScreen.swtyaWebViewUrl = @"http://www.sandesh.com/";
    swtyaWebViewScreen.swtya4mWhere = @"Gujarat";
    
    [self presentViewController:swtyaWebViewScreen animated:NO completion:nil];
}

- (IBAction)swtyaBtn2Clicked:(id)sender
{
    SwtyaWebViewScreen *swtyaWebViewScreen = [[SwtyaWebViewScreen alloc] initWithNibName:homeXIB bundle:nil];
    
    swtyaWebViewScreen.swtyaWebViewUrl = @"http://www.divyabhaskar.co.in/";
    swtyaWebViewScreen.swtya4mWhere = @"Gujarat";
    
    [self presentViewController:swtyaWebViewScreen animated:NO completion:nil];
}

- (IBAction)swtyaBtn3Clicked:(id)sender
{
    SwtyaWebViewScreen *swtyaWebViewScreen = [[SwtyaWebViewScreen alloc] initWithNibName:homeXIB bundle:nil];
    
    swtyaWebViewScreen.swtyaWebViewUrl = @"http://www.gujaratsamachar.com/";
    swtyaWebViewScreen.swtya4mWhere = @"Gujarat";
    
    [self presentViewController:swtyaWebViewScreen animated:NO completion:nil];
}

- (IBAction)swtyaBtn4Clicked:(id)sender
{
    SwtyaWebViewScreen *swtyaWebViewScreen = [[SwtyaWebViewScreen alloc] initWithNibName:homeXIB bundle:nil];
    
    swtyaWebViewScreen.swtyaWebViewUrl = @"http://gujarati.economictimes.indiatimes.com/";
    swtyaWebViewScreen.swtya4mWhere = @"Gujarat";
    
    [self presentViewController:swtyaWebViewScreen animated:NO completion:nil];
}

- (IBAction)swtyaBtn5Clicked:(id)sender
{
    SwtyaWebViewScreen *swtyaWebViewScreen = [[SwtyaWebViewScreen alloc] initWithNibName:homeXIB bundle:nil];
    
    swtyaWebViewScreen.swtyaWebViewUrl = @"http://gstv.in/gujarati";
    swtyaWebViewScreen.swtya4mWhere = @"Gujarat";
    
    [self presentViewController:swtyaWebViewScreen animated:NO completion:nil];
}

@end
