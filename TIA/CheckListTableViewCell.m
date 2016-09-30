//
//  CheckListTableViewCell.m
//  TIA
//
//  Created by tilak raj verma on 29/09/16.
//  Copyright © 2016 Swtya. All rights reserved.
//

#import "CheckListTableViewCell.h"
#import "DataManager.h"

@implementation CheckListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _btnCheck.tag=CHECK;
    _btnDelete.tag=DELETE;
    [_btnDelete setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
    [_btnCheck setImage:[UIImage imageNamed:@"checkmark"] forState:UIControlStateSelected];
    [_btnCheck setImage:[UIImage imageNamed:@"checkmark_un"] forState:UIControlStateNormal];
    _btnCheck.layer.borderColor=SMCUIColorFromRGB(0xe0e0e0).CGColor;
    _btnCheck.layer.borderWidth=1.0f;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




-(void)setDict:(NSDictionary *)dict withIndexpath:(NSIndexPath*)indexpath Onselection:(OnSelection)onSelection {
    
    _dict=dict;
    _indexPath=indexpath;
    _onSelection=onSelection;
}
-(IBAction)btnSelection:(UIButton*)sender {
    
    switch (sender.tag) {
        case DELETE:
        {
            //self.onSelection(DELETE,_indexPath,_dict);
            if ([_delegate respondsToSelector:@selector(didSelectWith:atIndexPath:isType:)]) {
                
                [_delegate didSelectWith:_dict atIndexPath:_indexPath isType:DELETE];
            }
        }
            break;
        case CHECK:
        {
             // self.onSelection(CHECK,_indexPath,_dict);
            if ([_delegate respondsToSelector:@selector(didSelectWith:atIndexPath:isType:)]) {
                
                [_delegate didSelectWith:_dict atIndexPath:_indexPath isType:CHECK];
            }
        }
            break;
        default:
            break;
    }
}


@end
