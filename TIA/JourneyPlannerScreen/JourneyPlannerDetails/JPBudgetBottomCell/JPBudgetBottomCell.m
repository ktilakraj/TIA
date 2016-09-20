//
//  JPBudgetBottomCell.m
//  TIA
//
//  Created by Swtya on 28/03/16.
//  Copyright (c) 2016 Swtya. All rights reserved.
//

#import "JPBudgetBottomCell.h"

@implementation JPBudgetBottomCell

- (void)awakeFromNib
{
    self.swtyaCostL.layer.borderWidth = 2.0;
    self.swtyaItemL.layer.borderWidth = 2.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
