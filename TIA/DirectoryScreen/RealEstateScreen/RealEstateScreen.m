//
//  RealEstateScreen.m
//  TIA
//
//  Created by Swtya on 10/04/16.
//  Copyright (c) 2016 Swtya. All rights reserved.
//

#import "RealEstateScreen.h"
#import "DirectoryScreen.h"
#import "DevelopersScreen.h"

@interface RealEstateScreen ()
{
    CGRect screenBounds;
}

@end

@implementation RealEstateScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    screenBounds = [[UIScreen mainScreen] bounds];
    
    _swtyaDirView1.layer.borderWidth = 2.0;
    _swtyaDirView2.layer.borderWidth = 2.0;
    _swtyaDirView3.layer.borderWidth = 2.0;
    
//    _swtyaDirView3.layer.borderColor = (__bridge CGColorRef)([UIColor colorWithRed:86.0f/255.0f green:90.0f/255.0f blue:135.0f/255.0f alpha:1.0f]);
//    _swtyaDirView2.layer.borderColor = (__bridge CGColorRef)([UIColor colorWithRed:86.0f/255.0f green:90.0f/255.0f blue:135.0f/255.0f alpha:1.0f]);
//    _swtyaDirView1.layer.borderColor = (__bridge CGColorRef)([UIColor colorWithRed:86.0f/255.0f green:90.0f/255.0f blue:135.0f/255.0f alpha:1.0f]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)swtyaDevViewBtnClicked:(id)sender
{
    NSString *homeXIB;
    
    if (screenBounds.size.height == 667)
    {
        homeXIB = @"DevelopersScreen";
    }
    else if(screenBounds.size.height == 1024)
    {
        homeXIB = @"DevelopersScreen";
    }
    else if(screenBounds.size.height == 568)
    {
        homeXIB = @"DevelopersScreen";
    }
    else if(screenBounds.size.height == 480)
    {
        homeXIB = @"DevelopersScreen";
    }
    else if(screenBounds.size.height == 736)
    {
        homeXIB = @"DevelopersScreen";
    }
    
    DevelopersScreen *swtyaHomeScreen = [[DevelopersScreen alloc] initWithNibName:homeXIB bundle:nil];
    [self presentViewController:swtyaHomeScreen animated:NO completion:nil];
}

- (IBAction)swtyaBckBtnClicked:(id)sender
{
    NSString *homeXIB;
    
    if (screenBounds.size.height == 667)
    {
        homeXIB = @"DirectoryScreen";
    }
    else if(screenBounds.size.height == 1024)
    {
        homeXIB = @"DirectoryScreen";
    }
    else if(screenBounds.size.height == 568)
    {
        homeXIB = @"DirectoryScreen";
    }
    else if(screenBounds.size.height == 480)
    {
        homeXIB = @"DirectoryScreen";
    }
    else if(screenBounds.size.height == 736)
    {
        homeXIB = @"DirectoryScreen";
    }
    
    DirectoryScreen *swtyaHomeScreen = [[DirectoryScreen alloc] initWithNibName:homeXIB bundle:nil];
    [self presentViewController:swtyaHomeScreen animated:NO completion:nil];
}

@end
