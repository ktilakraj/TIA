//
//  JPItineraryCell.m
//  TIA
//
//  Created by Swtya on 24/03/16.
//  Copyright (c) 2016 Swtya. All rights reserved.
//

#import "JPItineraryCell.h"

@implementation JPItineraryCell

- (void)awakeFromNib
{
    self.swtyaDateTF.layer.borderWidth = 2.0;
    self.swtyaConTF.layer.borderWidth = 2.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
