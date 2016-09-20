//
//  JourneyPlannerDetails.h
//  TIA
//
//  Created by Swtya on 24/03/16.
//  Copyright (c) 2016 Swtya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMCalendarController.h"
#import "PMCalendar.h"
#import "PMCalendarController.h"

@interface JourneyPlannerDetails : UIViewController <UITableViewDelegate, UITableViewDataSource,
                                    UITextFieldDelegate, PMCalendarControllerDelegate,PMCalendarViewDelegate>

@property (nonatomic, strong) IBOutlet UIButton *checklistBtn, *itineraryBtn, *budgetBtn, *saveBtn
                                        , *saveBtn1, *saveBtn2;
@property (nonatomic, weak) IBOutlet UILabel *checklistLabel, *itineraryLabel, *budgetLabel, *nameLabel, *fromLabel, *toLabel, *alabel, *blabel, *clabel, *dlabel,
    *nameLabel1, *fromLabel1, *toLabel1, *itemLabel, *costLabel, *plusLabel, *dtL, *locL;
@property (nonatomic, weak) IBOutlet UIView *upperView, *bottomView, *upperViewChk, *bottomViewChk,
                            *upperViewBug, *bottomViewBug;
@property (nonatomic, weak) IBOutlet UITextField *nameTF, *fromTF, *toTF, *nameTF1, *fromTF1, *toTF1;
@property (weak, nonatomic) IBOutlet UITableView *upperTableView,
                            *upperTableViewChk,
                            *upperTableViewBug;

@property (nonatomic, assign) NSInteger swtyaPlanIndex;

@property (nonatomic, strong) PMCalendarController *pmCC;

@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UIToolbar *datePickerToolbar;

@property (weak, nonatomic) IBOutlet UITextField *swtyaChkConTF1, *swtyaLocationTF, *swtyaDateTF1, *swtyaTF123, *swtyaTF456;
@property (weak, nonatomic) IBOutlet UIButton *swtyaPlusBtn1, *swtyaChkBtn1;

@property (nonatomic, strong) NSString *swtyaPlanName;

@end
