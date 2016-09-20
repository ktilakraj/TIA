//
//  NewspapersScreen.m
//  TIA
//
//  Created by Swtya on 22/03/16.
//  Copyright (c) 2016 Swtya. All rights reserved.
//

#import "NewspapersScreen.h"
#import "InfoScreen.h"
#import "EnglishNewspapers.h"
#import "GujaratiNewspapers.h"
#import "PunjabiNewspapers.h"

@interface NewspapersScreen ()
{
    CGRect screenBounds;
}

@end

@implementation NewspapersScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    screenBounds = [[UIScreen mainScreen] bounds];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)swtyaBckBtnClicked:(id)sender
{
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

- (IBAction)swtyaEngBtnClicked:(id)sender
{
    NSString *homeXIB;
    
    if (screenBounds.size.height == 667)
    {
        homeXIB = @"EnglishNewspapers";
    }
    else if(screenBounds.size.height == 1024)
    {
        homeXIB = @"EnglishNewspapers ipad";
    }
    else if(screenBounds.size.height == 568)
    {
        homeXIB = @"EnglishNewspapers 568";
    }
    else if(screenBounds.size.height == 480)
    {
        homeXIB = @"EnglishNewspapers 480";
    }
    else if(screenBounds.size.height == 736)
    {
        homeXIB = @"EnglishNewspapers 414";
    }
    
    EnglishNewspapers *swtyaEngScreen = [[EnglishNewspapers alloc] initWithNibName:homeXIB bundle:nil];
    [self presentViewController:swtyaEngScreen animated:NO completion:nil];
}

- (IBAction)swtyaGujBtnClicked:(id)sender
{
    NSString *homeXIB;
    
    if (screenBounds.size.height == 667)
    {
        homeXIB = @"GujaratiNewspapers";
    }
    else if(screenBounds.size.height == 1024)
    {
        homeXIB = @"GujaratiNewspapers ipad";
    }
    else if(screenBounds.size.height == 568)
    {
        homeXIB = @"GujaratiNewspapers 568";
    }
    else if(screenBounds.size.height == 480)
    {
        homeXIB = @"GujaratiNewspapers 480";
    }
    else if(screenBounds.size.height == 736)
    {
        homeXIB = @"GujaratiNewspapers 414";
    }
    
    GujaratiNewspapers *swtyaGujScreen = [[GujaratiNewspapers alloc] initWithNibName:homeXIB bundle:nil];
    [self presentViewController:swtyaGujScreen animated:NO completion:nil];
}

- (IBAction)swtyaPunBtnClicked:(id)sender
{
    NSString *homeXIB;
    
    if (screenBounds.size.height == 667)
    {
        homeXIB = @"PunjabiNewspapers";
    }
    else if(screenBounds.size.height == 1024)
    {
        homeXIB = @"PunjabiNewspapers ipad";
    }
    else if(screenBounds.size.height == 568)
    {
        homeXIB = @"PunjabiNewspapers 568";
    }
    else if(screenBounds.size.height == 480)
    {
        homeXIB = @"PunjabiNewspapers 480";
    }
    else if(screenBounds.size.height == 736)
    {
        homeXIB = @"PunjabiNewspapers 414";
    }
    
    PunjabiNewspapers *swtyaPunScreen = [[PunjabiNewspapers alloc] initWithNibName:homeXIB bundle:nil];
    [self presentViewController:swtyaPunScreen animated:NO completion:nil];
}

@end
