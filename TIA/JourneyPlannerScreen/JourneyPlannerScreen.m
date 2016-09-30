//
//  JourneyPlannerScreen.m
//  TIA
//
//  Created by Swtya on 24/03/16.
//  Copyright (c) 2016 Swtya. All rights reserved.
//

#import "JourneyPlannerScreen.h"
#import "JourneyPlannerCell.h"
#import "HomeScreen.h"
#import "JourneyPlannerDetails.h"
#import "JourneyMainViewController.h"
#import "DataManager.h"


@interface JourneyPlannerScreen ()<UITableViewDataSource>
{
    NSUserDefaults *userDefaults;
    NSMutableArray *swtyaJPArray;
    NSDictionary *swtyaJPDict;
    UIView *baseView;
    UITextField *getEmail;
    UIView *alertview;
    CGRect screenBounds;
}

@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UIToolbar *datePickerToolbar;

@property (strong, nonatomic) UITextField *fromTxt;
@property (strong, nonatomic) UITextField *toTxt;
@property (assign, nonatomic) NSInteger editedTag;
@property (assign, nonatomic) BOOL isKeyBoardAppers;
@property (strong, nonatomic) NSMutableArray *arrRoots;
@end

@implementation JourneyPlannerScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    
    screenBounds = [[UIScreen mainScreen] bounds];
    
    NSString *homeXIB;
    
    if (screenBounds.size.height == 667)
    {
        homeXIB = @"JourneyPlannerCell";
    }
    else if(screenBounds.size.height == 1024)
    {
        homeXIB = @"JourneyPlannerCell ipad";
    }
    else if(screenBounds.size.height == 568)
    {
        homeXIB = @"JourneyPlannerCell 320";
    }
    else if(screenBounds.size.height == 480)
    {
        homeXIB = @"JourneyPlannerCell 320";
    }
    else if(screenBounds.size.height == 736)
    {
        homeXIB = @"JourneyPlannerCell 414";
    }
    
    [self.jpTableView registerNib:[UINib nibWithNibName:homeXIB bundle:nil] forCellReuseIdentifier:@"JourneyPlannerCell"];
    
    NSArray *swtyaJPPreArrayI = @[@{@"from":@"",@"to":@"",@"date":@"",@"con":@""}];
    
    NSArray *swtyaJPPreArrayC = @[@{@"isChk":@"0",@"chkCon":@""}];
    
    NSArray *swtyaJPPreArrayB = @[@{@"item":@"",@"cost":@""}];
    
    NSArray *swtyaJPPreArray = @[@{@"name":@"Plan New Journey",@"checklist":swtyaJPPreArrayC,@"itinerary":swtyaJPPreArrayI,@"budget":swtyaJPPreArrayB}];
    
    swtyaJPArray = [[NSMutableArray alloc] init];
    
    NSMutableArray *swtyaJPArray1 = [self loadArrayFromUserDefaultsForKey:@"swtyaJPArray"];
    
    if(swtyaJPArray1.count > 0)
        swtyaJPArray = swtyaJPArray1;
    else
        [swtyaJPArray addObject:swtyaJPPreArray];
    
    [self saveArrayToUserDefaults:swtyaJPArray forKey:@"swtyaJPArray"];
    
   
    

}

-(void)pickerinitlization
{
    _datePicker = [[UIDatePicker alloc] init];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    [_datePicker setMinimumDate:[NSDate date]];
    [_datePicker addTarget:self action:@selector(datePickerValueChanged1:) forControlEvents:UIControlEventValueChanged];
    
    _datePickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    [_datePickerToolbar setBarStyle:UIBarStyleBlackTranslucent];
    UIBarButtonItem *extraSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissPicker:)]; // method to dismiss the picker when the "Done" button is pressed
    
    doneButton.tag = 7777;
    _datePicker.tag = 7777;
    
    [_datePickerToolbar setItems:[[NSArray alloc] initWithObjects: extraSpace, doneButton, nil]];
    self.fromTxt.inputView = _datePicker;
    // Set UITextfield's inputAccessoryView as UIToolbar
    self.fromTxt.inputAccessoryView = _datePickerToolbar;
    
    self.toTxt.inputView = _datePicker;
    // Set UITextfield's inputAccessoryView as UIToolbar
    self.toTxt.inputAccessoryView = _datePickerToolbar;
}

- (void)datePickerValueChanged1:(id)sender
{
  [self updateTextFields];
}

-(void)updateTextFields
{
    NSDate *selectedDate = _datePicker.date;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd-MM-yyyy"];
    if (_editedTag == 101) {
        
        self.fromTxt.text = [df stringFromDate:selectedDate];
        [self.fromTxt resignFirstResponder];
        
    } else  if (_editedTag == 102) {
        
        self.toTxt.text = [df stringFromDate:selectedDate];
        [self.toTxt resignFirstResponder];
        
    }
}
- (void)dismissPicker:(id)sender
{
    [self updateTextFields];
}

-(void)keyboardDidHideNShow:(NSNotification*)notification {
    
    if (notification.name == UIKeyboardWillShowNotification) {
        
        NSLog(@"SHOW");
        if (!_isKeyBoardAppers) {
            
            CGRect rect=alertview.frame;
            rect.origin.y=rect.origin.y-100;
            alertview.frame=rect;
            _isKeyBoardAppers=true;
        }
        
        
    } else if (notification.name == UIKeyboardDidHideNotification) {
        
        if (_isKeyBoardAppers) {
            
            CGRect rect=alertview.frame;
            rect.origin.y=rect.origin.y+100;
            alertview.frame=rect;
            _isKeyBoardAppers=false;
        }
      
         NSLog(@"HIDDEN");
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     _arrRoots=[[DataManager sharedInstance] getJournyPlanner];
    self.navigationController.navigationBar.hidden=YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHideNShow:) name:UIKeyboardDidHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHideNShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [_jpTableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name: UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name: UIKeyboardDidHideNotification object:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
         return _arrRoots.count;
    }
    else return  1;
}

- (UITableViewCell *)tableView:(UITableView *)localTableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"JourneyPlannerCell";
    
    JourneyPlannerCell *cell = (JourneyPlannerCell *)[self.jpTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        NSDictionary *dict=[_arrRoots objectAtIndex:indexPath.row];
        
        cell.swtyaJPLabel.text = [NSString stringWithFormat:@"%@", [dict valueForKey:@"name"]];
        
        if (cell.swtyaJPLabel.text.length<=0) {
            cell.swtyaJPLabel.text = [[NSString alloc] getFromToString:dict];
        }
        
        return cell;
    }
    
    cell.swtyaJPLabel.text = [NSString stringWithFormat:@"%@",@"Plan New Journey"];
    
 
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        JourneyMainViewController *journyDetailMain=[[JourneyMainViewController alloc]initWithNibName:@"JourneyMainViewController" bundle:nil];
        [journyDetailMain setDictRoot:[_arrRoots objectAtIndex:indexPath.row]];
        [[DataManager sharedInstance]setSelectedjourneyIndex:indexPath.row];
        [self.navigationController pushViewController:journyDetailMain animated:YES];

    }
    else
        [self showSwtyaPopUp];
}

- (void)showSwtyaPopUp
{
    baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,
                                                       self.view.frame.size.height)];
    baseView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    baseView.opaque = NO;
    
    float h, f, bh;
    
    if(self.view.frame.size.height == 1024)
    {
        h = 240;
        bh = 36;
        f = 21;
    }
    else
    {
        h = 240;
        bh = 36;
        f = 16;
    }
    
    alertview = [[UIView alloc]init];
    alertview = [[UIView alloc]initWithFrame:CGRectMake(10,((self.view.frame.size.height/2) - 75), baseView.bounds.size.width-20, h)];
    alertview.backgroundColor = [UIColor whiteColor];
    //alertview.layer.cornerRadius = 10.0f;
    //alertview.layer.borderWidth = 1.0f;
    [baseView addSubview:alertview];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 9, alertview.bounds.size.width-20, 45)];
    title.text = @"New Journey Plan";
    title.font = [UIFont systemFontOfSize:f];
    title.textColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0];
    title.textAlignment = NSTextAlignmentCenter;
    [alertview addSubview:title];
    
    UIView *padding =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 30)];
    getEmail = [[UITextField alloc]initWithFrame:CGRectMake(10, 51, alertview.bounds.size.width-20, 60)];
    getEmail.placeholder = @"Enter name for your new Journey Plan";
    [getEmail setValue:[UIColor colorWithRed:97.0/255.0 green:97.0/255.0 blue:97.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    getEmail.textColor = [UIColor colorWithRed:97.0/255.0 green:97.0/255.0 blue:97.0/255.0 alpha:1.0];
    getEmail.font = [UIFont systemFontOfSize:f];
    [getEmail setLeftViewMode:UITextFieldViewModeAlways];
    [getEmail setLeftView:padding];
    getEmail.delegate = self;
    getEmail.leftView = padding;
    getEmail.layer.cornerRadius = 3;
    getEmail.layer.borderWidth = 0.5;
    getEmail.layer.borderColor = [[UIColor colorWithRed:185.0/255.0 green:185.0/255.0 blue:185.0/255.0 alpha:1.0]CGColor];
    getEmail.autocorrectionType = UITextAutocorrectionTypeNo;
    getEmail.keyboardType = UIKeyboardTypeEmailAddress;
    
    [alertview addSubview:getEmail];
    
    
    _fromTxt = [[UITextField alloc]initWithFrame:CGRectMake(5,120, alertview.bounds.size.width/2-10, bh)];
    [_fromTxt setPlaceholder:@"From Date"];
    
    [_fromTxt setValue:[UIColor colorWithRed:97.0/255.0 green:97.0/255.0 blue:97.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    _fromTxt.textColor = [UIColor colorWithRed:97.0/255.0 green:97.0/255.0 blue:97.0/255.0 alpha:1.0];
    _fromTxt.delegate = self;
    _fromTxt.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _fromTxt.layer.borderWidth=1.0f;
    _fromTxt.tag=101;
    _fromTxt.textAlignment=NSTextAlignmentCenter;
    [alertview addSubview:_fromTxt];
    
//    [fromDate addTarget:self action:@selector(btnSelectFromDate:) forControlEvents:UIControlEventTouchUpInside];
    

    _toTxt = [[UITextField alloc]initWithFrame:CGRectMake(alertview.bounds.size.width/2+5,120, alertview.bounds.size.width/2-10, bh)];
      [_toTxt setPlaceholder:@"To Date"];
    [_toTxt setValue:[UIColor colorWithRed:97.0/255.0 green:97.0/255.0 blue:97.0/255.0 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    _toTxt.textColor = [UIColor colorWithRed:97.0/255.0 green:97.0/255.0 blue:97.0/255.0 alpha:1.0];
    _toTxt.delegate = self;
    _toTxt.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _toTxt.layer.borderWidth=1.0f;
    _toTxt.tag=102;
    _toTxt.textAlignment=NSTextAlignmentCenter;
    [alertview addSubview:_toTxt];
    
    //[_toTxt addTarget:self action:@selector(btnSelectToDate:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, alertview.bounds.size.height-42, alertview.bounds.size.width/2-10, bh)];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelBtn.backgroundColor = [UIColor colorWithRed:53.0/255.0 green:152.0/255.0 blue:219.0/255.0 alpha:1.0];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn .titleLabel.font = [UIFont boldSystemFontOfSize:f];
    [alertview addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    

    UIButton *okBtn = [[UIButton alloc]initWithFrame:CGRectMake(alertview.bounds.size.width/2+5, alertview.bounds.size.height-42, alertview.bounds.size.width/2-10, bh)];
    [okBtn setTitle:@"Add" forState:UIControlStateNormal];
    okBtn.backgroundColor = [UIColor colorWithRed:53.0/255.0 green:152.0/255.0 blue:219.0/255.0 alpha:1.0];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    okBtn .titleLabel.font = [UIFont boldSystemFontOfSize:f];

    [alertview addSubview:okBtn];
    [okBtn addTarget:self action:@selector(onOkPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:baseView];
    
    [self pickerinitlization];
}

-(IBAction)btnSelectToDate:(id)sender
{
    NSLog(@"TO DATE");
    [self.view endEditing:YES];
}

-(IBAction)btnSelectFromDate:(id)sender
{
    NSLog(@"FROM DATE");
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"TExt field Edit");
    _editedTag=textField.tag;
    [textField becomeFirstResponder];
}

- (void)cancelBtnAction
{
    [baseView removeFromSuperview];
    //[collectLocation removeFromSuperview];
}

-(void)onOkPressed
{
    
    if (getEmail.text.length >0) {
        
        NSMutableArray *arrRoot=[[NSMutableArray alloc] initWithArray:[[DataManager sharedInstance] getJournyPlanner]];
        NSMutableDictionary *dictRoot=[[NSMutableDictionary alloc]init];
        [dictRoot setObject:getEmail.text forKey:@"name"];
        [dictRoot setObject:_fromTxt.text forKey:@"fromDate"];
        [dictRoot setObject:_toTxt.text forKey:@"toDate"];
        [dictRoot setObject:[[NSMutableArray alloc] init] forKey:@"chekcList"];
        [dictRoot setObject:[[NSMutableArray alloc] init] forKey:@"toDoList"];
        [dictRoot setObject:[[NSMutableArray alloc] init] forKey:@"budget"];
        [dictRoot setObject:[[NSMutableArray alloc] init] forKey:@"itinrary"];
        [arrRoot addObject:dictRoot];
        [[DataManager sharedInstance] setJournyPlanner:arrRoot];
        
        _arrRoots=[NSMutableArray arrayWithArray:arrRoot];
        [_jpTableView reloadData];
        [self.view endEditing:YES];
        [baseView removeFromSuperview];
    }
    else if (_fromTxt.text.length>0 && _toTxt.text.length>0) {
        
        NSMutableArray *arrRoot=[[NSMutableArray alloc] initWithArray:[[DataManager sharedInstance] getJournyPlanner]];
        NSMutableDictionary *dictRoot=[[NSMutableDictionary alloc]init];
        [dictRoot setObject:getEmail.text forKey:@"name"];
        [dictRoot setObject:_fromTxt.text forKey:@"fromDate"];
        [dictRoot setObject:_toTxt.text forKey:@"toDate"];
        [dictRoot setObject:[[NSMutableArray alloc] init] forKey:@"chekcList"];
        [dictRoot setObject:[[NSMutableArray alloc] init] forKey:@"toDoList"];
        [dictRoot setObject:[[NSMutableArray alloc] init] forKey:@"budget"];
        [dictRoot setObject:[[NSMutableArray alloc] init] forKey:@"itinrary"];
        [arrRoot addObject:dictRoot];
        [[DataManager sharedInstance] setJournyPlanner:arrRoot];
        
        _arrRoots=[NSMutableArray arrayWithArray:arrRoot];
        [_jpTableView reloadData];
        [self.view endEditing:YES];
        [baseView removeFromSuperview];
    }
    
}


- (void)okBtnAction
{
    NSArray *swtyaJPPreArrayI = @[@{@"from":@"",@"to":@"",@"date":@"",@"con":@""}];
    
    NSArray *swtyaJPPreArrayC = @[@{@"isChk":@"0",@"chkCon":@""}];
    
    NSArray *swtyaJPPreArrayB = @[@{@"item":@"",@"cost":@""}];
    
    NSArray *swtyaJPPreArray = @[@{@"name":getEmail.text,@"checklist":swtyaJPPreArrayC,@"itinerary":swtyaJPPreArrayI,@"budget":swtyaJPPreArrayB}];
    
    swtyaJPArray = [[NSMutableArray alloc] init];
    
    swtyaJPArray = [self loadArrayFromUserDefaultsForKey:@"swtyaJPArray"];
    
    [swtyaJPArray removeLastObject];
    [swtyaJPArray addObject:swtyaJPPreArray];
    
    swtyaJPPreArray = @[@{@"name":@"Plan New Journey",@"checklist":swtyaJPPreArrayC,@"itinerary":swtyaJPPreArrayI,@"budget":swtyaJPPreArrayB}];
    [swtyaJPArray addObject:swtyaJPPreArray];
    
    [self saveArrayToUserDefaults:swtyaJPArray forKey:@"swtyaJPArray"];
    NSLog(@"%@",getEmail.text);
    [baseView removeFromSuperview];
    
    NSString *homeXIB;
    
    if (screenBounds.size.height == 667)
    {
        homeXIB = @"JourneyPlannerDetails";
    }
    else if(screenBounds.size.height == 1024)
    {
        homeXIB = @"JourneyPlannerDetails ipad";
    }
    else if(screenBounds.size.height == 568)
    {
        homeXIB = @"JourneyPlannerDetails 568";
    }
    else if(screenBounds.size.height == 480)
    {
        homeXIB = @"JourneyPlannerDetails 480";
    }
    else if(screenBounds.size.height == 736)
    {
        homeXIB = @"JourneyPlannerDetails 414";
    }
    
    JourneyPlannerDetails *swtyaJPDScreen = [[JourneyPlannerDetails alloc] initWithNibName:homeXIB bundle:nil];
    
    swtyaJPDScreen.swtyaPlanIndex = swtyaJPArray.count - 2;
    
    [self presentViewController:swtyaJPDScreen animated:NO completion:nil];
}

- (NSMutableArray *)loadArrayFromUserDefaultsForKey:(NSString *)key
{
    return [[userDefaults valueForKey:key] mutableCopy];
}

- (void)saveArrayToUserDefaults:(NSMutableArray *)value forKey:(NSString *)key
{
    [userDefaults setObject:value forKey:key];
    [userDefaults synchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)swtyaBckBtnClicked:(id)sender
{
   /* NSString *homeXIB;
    
    if (screenBounds.size.height == 667)
    {
        homeXIB = @"HomeScreen";
    }
    else if(screenBounds.size.height == 1024)
    {
        homeXIB = @"HomeScreen ipad";
    }
    else if(screenBounds.size.height == 568)
    {
        homeXIB = @"HomeScreen 568";
    }
    else if(screenBounds.size.height == 480)
    {
        homeXIB = @"HomeScreen 480";
    }
    else if(screenBounds.size.height == 736)
    {
        homeXIB = @"HomeScreen 414";
    }
    
    HomeScreen *swtyaHomeScreen = [[HomeScreen alloc] initWithNibName:homeXIB bundle:nil];
    [self presentViewController:swtyaHomeScreen animated:NO completion:nil];
    */
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
