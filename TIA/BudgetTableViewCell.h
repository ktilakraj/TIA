//
//  BudgetTableViewCell.h
//  TIA
//
//  Created by tilak raj verma on 29/09/16.
//  Copyright © 2016 Swtya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BudgetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblCost;
@property (weak, nonatomic) IBOutlet UILabel *lbldate;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end
