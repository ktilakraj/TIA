//
//  DevDetailsScreen.m
//  TIA
//
//  Created by Swtya on 10/04/16.
//  Copyright (c) 2016 Swtya. All rights reserved.
//

#import "DevDetailsScreen.h"
#import "DevelopersScreen.h"

@interface DevDetailsScreen ()
{
    CGRect screenBounds;
}

@end

@implementation DevDetailsScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    screenBounds = [[UIScreen mainScreen] bounds];
    
    _swtyaDirView1.layer.borderWidth = 2.0;
    _swtyaDirView2.layer.borderWidth = 2.0;
    _swtyaImgView.layer.borderWidth = 2.0;
}

- (void)viewDidLayoutSubviews
{
    self.swtyaScrollView.frame = CGRectMake(0, 118, 768, 906);
    [self.swtyaScrollView setContentSize:CGSizeMake(768, 1303)];
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

@end
