//
//  DirectoryScreen.h
//  TIA
//
//  Created by Swtya on 10/04/16.
//  Copyright (c) 2016 Swtya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"

@interface DirectoryScreen : UIViewController <NIDropDownDelegate>

@property (strong, atomic) IBOutlet UITableView *infoTableView;
@property (weak, nonatomic) IBOutlet UIButton *swtyaSelectCityBtn;

@end
