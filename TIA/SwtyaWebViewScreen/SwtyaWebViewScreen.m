//
//  SwtyaWebViewScreen.m
//  TIA
//
//  Created by Swtya on 20/03/16.
//  Copyright (c) 2016 Swtya. All rights reserved.
//

#import "SwtyaWebViewScreen.h"
#import "HomeScreen.h"
#import "InfoScreen.h"
#import "EnglishNewspapers.h"
#import "GujaratiNewspapers.h"
#import "PunjabiNewspapers.h"
#import "Reachability.h"

@interface SwtyaWebViewScreen ()
{
    UIActivityIndicatorView *activityIndicator;
    BOOL isDone;
    NSURLConnection *con;
    NSURLRequest *req;
    CGRect screenBounds;
}

@end

@implementation SwtyaWebViewScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    screenBounds = [[UIScreen mainScreen] bounds];
    
    _swtyaExitBtn.layer.cornerRadius = 3;
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.alpha = 1.0;
    
    if(screenBounds.size.width == 768)
        activityIndicator.center = CGPointMake(screenBounds.size.width - 121, 67.0f);
    else if(screenBounds.size.width == 320)
        activityIndicator.center = CGPointMake(screenBounds.size.width - 100, 42.0f);
    else
        activityIndicator.center = CGPointMake(screenBounds.size.width - 109, 42.0f);
    
    activityIndicator.hidesWhenStopped = NO;
    
    self.swtyaWebView.delegate = self;
    
//    if([self.swtyaWebViewUrl containsString:@"https"])
//    {
//        NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.swtyaWebViewUrl]];
//        NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:req delegate:self];
//        [urlConnection start];
//        self.swtyaWebView.scalesPageToFit = YES;
//        [self.swtyaWebView loadRequest:req];
//    }
//    else
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Interent"
                                                        message:@"Please check your internet connection & try again!"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        req = [NSURLRequest requestWithURL:
                                        [NSURL URLWithString:self.swtyaWebViewUrl]];
        [self.swtyaWebView loadRequest:req];
    }
    
//    [self.swtyaWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.swtyaWebViewUrl]]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if(!isDone)
    {
        isDone = NO;
        
        con = [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES];
        [con start];
        
        return NO;
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [activityIndicator stopAnimating];
    [activityIndicator removeFromSuperview];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicator stopAnimating];
    [activityIndicator removeFromSuperview];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if([challenge previousFailureCount] == 0)
    {
        isDone = YES;
        
        NSURLCredential *swtyaCre = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        
        [challenge.sender useCredential:swtyaCre forAuthenticationChallenge:challenge];
    }
    else
    {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    isDone = YES;
    [self.swtyaWebView loadRequest:req];
    [con cancel];
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (IBAction)swtyaBckBtnClicked:(id)sender
{
    if ([self.swtyaWebView canGoBack])
    {
        [self.swtyaWebView goBack];
    }
    else
        [self exitCall];
}

- (IBAction)swtyaExitBtnClicked:(id)sender
{
    [self exitCall];
}

- (void)exitCall
{
    if([self.swtya4mWhere isEqualToString:@"Home"])
    {
        NSString *homeXIB;
        
        if (screenBounds.size.height == 667)
        {
            homeXIB = @"HomeScreen";
        }
        else if(screenBounds.size.height == 1024)
        {
            homeXIB = @"HomeScreen ipad";
        }
        else if(screenBounds.size.height == 568)
        {
            homeXIB = @"HomeScreen 568";
        }
        else if(screenBounds.size.height == 480)
        {
            homeXIB = @"HomeScreen 480";
        }
        else if(screenBounds.size.height == 736)
        {
            homeXIB = @"HomeScreen 414";
        }
        
        HomeScreen *swtyaHomeScreen = [[HomeScreen alloc] initWithNibName:homeXIB bundle:nil];
        [self presentViewController:swtyaHomeScreen animated:NO completion:nil];
    }
    else if([self.swtya4mWhere isEqualToString:@"Info"])
    {
       /* NSString *homeXIB;
        
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
        [self presentViewController:swtyaInfoScreen animated:NO completion:nil];*/
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    else if([self.swtya4mWhere isEqualToString:@"English"])
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
    else if([self.swtya4mWhere isEqualToString:@"Gujarat"])
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
    else if([self.swtya4mWhere isEqualToString:@"Punjab"])
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
    
    //[self.navigationController dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
