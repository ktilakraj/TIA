//
//  calenderView.h
//  TIA
//
//  Created by Diwakar on 22/03/16.
//  Copyright © 2016 L7Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface calenderView : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *monthCollection;

@property (weak, nonatomic) IBOutlet UILabel *swtyaMonthLabel;

@property (weak, nonatomic) IBOutlet UITableView *holidayTable;

- (IBAction)lastMonthBtnClick:(id)sender;
- (IBAction)nextMonthBtnClick:(id)sender;

@end
