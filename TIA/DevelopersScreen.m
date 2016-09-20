//
//  DevelopersScreen.m
//  TIA
//
//  Created by Swtya on 10/04/16.
//  Copyright (c) 2016 Swtya. All rights reserved.
//

#import "DevelopersScreen.h"
#import "RealEstateScreen.h"
#import "DevDetailsScreen.h"

@interface DevelopersScreen ()
{
    CGRect screenBounds;
}

@end

@implementation DevelopersScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    screenBounds = [[UIScreen mainScreen] bounds];
    
    _swtyaDirView1.layer.borderWidth = 2.0;
    _swtyaDirView2.layer.borderWidth = 2.0;
    _swtyaDirView3.layer.borderWidth = 2.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)swtyaDevViewBtnClicked:(id)sender
{
    NSString *homeXIB;
    
    if (screenBounds.size.height == 667)
    {
        homeXIB = @"DevDetailsScreen";
    }
    else if(screenBounds.size.height == 1024)
    {
        homeXIB = @"DevDetailsScreen";
    }
    else if(screenBounds.size.height == 568)
    {
        homeXIB = @"DevDetailsScreen";
    }
    else if(screenBounds.size.height == 480)
    {
        homeXIB = @"DevDetailsScreen";
    }
    else if(screenBounds.size.height == 736)
    {
        homeXIB = @"DevDetailsScreen";
    }
    
    DevDetailsScreen *swtyaHomeScreen = [[DevDetailsScreen alloc] initWithNibName:homeXIB bundle:nil];
    [self presentViewController:swtyaHomeScreen animated:NO completion:nil];
}

- (IBAction)swtyaBckBtnClicked:(id)sender
{
    NSString *homeXIB;
    
    if (screenBounds.size.height == 667)
    {
        homeXIB = @"RealEstateScreen";
    }
    else if(screenBounds.size.height == 1024)
    {
        homeXIB = @"RealEstateScreen";
    }
    else if(screenBounds.size.height == 568)
    {
        homeXIB = @"RealEstateScreen";
    }
    else if(screenBounds.size.height == 480)
    {
        homeXIB = @"RealEstateScreen";
    }
    else if(screenBounds.size.height == 736)
    {
        homeXIB = @"RealEstateScreen";
    }
    
    RealEstateScreen *swtyaHomeScreen = [[RealEstateScreen alloc] initWithNibName:homeXIB bundle:nil];
    [self presentViewController:swtyaHomeScreen animated:NO completion:nil];
}

@end
