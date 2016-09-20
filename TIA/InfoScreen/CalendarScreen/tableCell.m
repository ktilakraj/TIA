//
//  tableCell.m
//  TIA
//
//  Created by Diwakar on 22/03/16.
//  Copyright © 2016 L7Software. All rights reserved.
//

#import "tableCell.h"

@implementation tableCell

- (void)awakeFromNib {
    // Initialization code
    _label1.layer.borderWidth = 2.0;
    _label2.layer.borderWidth = 2.0;
    _label3.layer.borderWidth = 2.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
