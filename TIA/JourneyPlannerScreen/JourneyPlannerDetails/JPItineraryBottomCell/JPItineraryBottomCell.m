//
//  JPItineraryBottomCell.m
//  TIA
//
//  Created by Swtya on 27/03/16.
//  Copyright (c) 2016 Swtya. All rights reserved.
//

#import "JPItineraryBottomCell.h"

@implementation JPItineraryBottomCell

- (void)awakeFromNib
{
    self.swtyaDateLabel.layer.borderWidth = 2.0;
    self.swtyaConLabel.layer.borderWidth = 2.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
