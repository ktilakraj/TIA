//
//  SwtyaWebViewScreen.h
//  TIA
//
//  Created by Swtya on 20/03/16.
//  Copyright (c) 2016 Swtya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwtyaWebViewScreen : UIViewController <UIWebViewDelegate, NSURLConnectionDelegate>

@property (strong, atomic) IBOutlet UIWebView *swtyaWebView;
@property (strong, atomic) IBOutlet UIButton *swtyaExitBtn;
@property (nonatomic, strong) NSString *swtyaWebViewUrl;
@property (nonatomic, strong) NSString *swtya4mWhere;

@end
