//
//  CheckListTableViewCell.h
//  TIA
//
//  Created by tilak raj verma on 29/09/16.
//  Copyright © 2016 Swtya. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    DELETE,
    CHECK,
} TYPEOFBUTTON;

typedef void(^OnSelection)(TYPEOFBUTTON typeOfButton,NSIndexPath *indxpath,NSDictionary* dict);

@protocol CheckListTableViewCellDelegete <NSObject>

-(void)didSelectWith:(NSDictionary*)dict atIndexPath:(NSIndexPath*)indexPath isType:(TYPEOFBUTTON)type;

@end

@interface CheckListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbltext;
@property (weak, nonatomic) IBOutlet UIButton *btnCheck;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;
@property(nonatomic,strong) NSDictionary *dict;
@property(nonatomic,strong) NSIndexPath *indexPath;
@property (assign, nonatomic) OnSelection onSelection;
@property (strong, nonatomic) id <CheckListTableViewCellDelegete> delegate;

-(void)setDict:(NSDictionary *)dict withIndexpath:(NSIndexPath*)indexpath Onselection:(OnSelection)onSelection;

@end
