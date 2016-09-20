//
//  JPChkUpperCell.m
//  TIA
//
//  Created by Swtya on 27/03/16.
//  Copyright (c) 2016 Swtya. All rights reserved.
//

#import "JPChkUpperCell.h"

@implementation JPChkUpperCell

- (void)awakeFromNib
{
    self.swtyaChkConTF.layer.borderWidth = 2.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
