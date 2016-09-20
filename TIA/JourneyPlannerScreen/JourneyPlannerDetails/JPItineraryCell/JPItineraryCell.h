//
//  JPItineraryCell.h
//  TIA
//
//  Created by Swtya on 24/03/16.
//  Copyright (c) 2016 Swtya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPItineraryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *swtyaDateTF;
@property (weak, nonatomic) IBOutlet UITextField *swtyaConTF;
@property (weak, nonatomic) IBOutlet UIButton *swtyaPlusBtn, *swtyaCalendarBtn;

@end
