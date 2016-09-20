//
//  JourneyPlannerScreen.h
//  TIA
//
//  Created by Swtya on 24/03/16.
//  Copyright (c) 2016 Swtya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JourneyPlannerScreen : UIViewController <UITextFieldDelegate>

@property (strong, atomic) IBOutlet UITableView *jpTableView;

@end
