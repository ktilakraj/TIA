//
//  JourneyMainViewController.m
//  TIA
//
//  Created by tilak raj verma on 20/09/16.
//  Copyright © 2016 Swtya. All rights reserved.
//

#import "BudgetViewController.h"
#import "JourneyPlannerDetails.h"
#import "DataManager.h"
#import "BudgetTableViewCell.h"

@interface BudgetViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *txtDate;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblFrmToDate;
@property (weak, nonatomic) IBOutlet UITextField *txtcost;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UILabel *lblHeaderTitle;
- (IBAction)btnbackClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *viewBottom;
@property (weak, nonatomic) IBOutlet UITextField *txtChecklist;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (assign, nonatomic) BOOL isKeyBoardAppers;
@property (strong, nonatomic)  NSMutableArray *arrCheckListItem;
@property (strong,nonatomic) NSString *strKey;
@property (strong,nonatomic) UITapGestureRecognizer *tap;

- (IBAction)btnAddClick:(id)sender;

@property (assign, nonatomic) NSInteger txtSelected;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomspace;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UIToolbar *datePickerToolbar;

@end

@implementation BudgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _txtChecklist.delegate=self;
     _txtcost.delegate=self;
     _txtDate.delegate=self;
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    _txtChecklist.tag=100;
    _txtcost.tag=200;
     _txtDate.tag=300;
    [self updateheader];
    
    
  _tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:_tap];
    
        [self.tableView registerNib:[UINib nibWithNibName:@"BudgetTableViewCell" bundle:nil] forCellReuseIdentifier:@"checkListCell"];
    
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
    self.txtDate.inputView = _datePicker;
    // Set UITextfield's inputAccessoryView as UIToolbar
    //self.txtDate.inputAccessoryView = _datePickerToolbar;
    
   // self.txtcost.inputAccessoryView = nil;
     //self.txtChecklist.inputAccessoryView = nil;
    
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
    if (_txtSelected == 300) {
        
        self.txtDate.text = [df stringFromDate:selectedDate];
        //[self.txtChecklist resignFirstResponder];
        
    }
}

- (void)dismissPicker:(id)sender
{
    [self updateTextFields];
}

-(void)dismissKeyboard {
    
    [_txtChecklist resignFirstResponder];
     [_txtcost resignFirstResponder];
    [_txtDate resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_txtcost resignFirstResponder];
    [_txtChecklist resignFirstResponder];
     [_txtDate resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    _txtSelected = textField.tag;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHideNShow:) name:UIKeyboardDidHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHideNShow:) name:UIKeyboardWillShowNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name: UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name: UIKeyboardDidHideNotification object:nil];
}

-(void)updateheader
{
    if (_selctedCheckListOrToDo == 2) {
        
        _strKey=@"item";
        _lblTitle.text=@"BUDGET";
        _lblFrmToDate.text=@"";
        
    }
    
    /*_lblTitle.text=[self.dictRoot valueForKey:@"name"];
    if (_lblTitle.text.length <= 0) {
        _lblTitle.text=[[NSString alloc] getFromToString:self.dictRoot];
        _lblFrmToDate.text=@"";
    } else {
        _lblFrmToDate.text=[[NSString alloc] getFromToString:self.dictRoot];
    }*/
    _arrCheckListItem=[[NSMutableArray alloc] initWithArray:[_dictRoot valueForKey:_strKey]];
    _viewBottom.layer.cornerRadius=2.0f;
    _viewBottom.layer. borderColor=[UIColor lightGrayColor].CGColor;
    _viewBottom.layer.borderWidth=1.0f;
    
    [_txtChecklist setPlaceholder:[NSString stringWithFormat:@"Enter %@",_strKey.lowercaseString]];
    [self pickerinitlization];
    
}

-(void)keyboardDidHideNShow:(NSNotification*)notification {
    
    if (notification.name == UIKeyboardWillShowNotification) {
        
        NSLog(@"SHOW");
        if (!_isKeyBoardAppers) {
            
            CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
            
            [UIView animateWithDuration:0.3 animations:^{
                /*CGRect f = self.view.frame;
                f.origin.y = -keyboardSize.height;
                self.view.frame = f;*/
                
                _bottomspace.constant=keyboardSize.height+40;
                  [self.view addGestureRecognizer:_tap];
            }];
            _isKeyBoardAppers=true;
        }
        
        
    } else if (notification.name == UIKeyboardDidHideNotification) {
        
        if (_isKeyBoardAppers) {
            
            [UIView animateWithDuration:0.1 animations:^{
                /*CGRect f = self.view.frame;
                f.origin.y = 0.0f;
                self.view.frame = f;*/
                _bottomspace.constant=8.0;
                  [self.view removeGestureRecognizer:_tap];
                
            }];
            _isKeyBoardAppers=false;
        }
        
        NSLog(@"HIDDEN");
    }
}

- (void)setDictRoot:(NSMutableDictionary *)dictRoot {
    _dictRoot = dictRoot;
}
-(void)setSelctedCheckListOrToDo:(NSInteger)selctedCheckListOrToDo {

    _selctedCheckListOrToDo=selctedCheckListOrToDo;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  _arrCheckListItem.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BudgetTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"checkListCell"];
   /* if (!cell) {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"checkListCell"];
    }
    */
    NSDictionary *dict =[_arrCheckListItem objectAtIndex:indexPath.row];
    cell.lblTitle.text=[dict valueForKey:@"name"];
    cell.contentView.clipsToBounds=YES;
    
    cell.lblCost.text=[dict valueForKey:@"budget"];
    cell.lbldate.text=[dict valueForKey:@"date"];
   
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict =[_arrCheckListItem objectAtIndex:indexPath.row];
    NSString *strTxt = [dict valueForKey:@"name"];
    if (strTxt.length > 0) {
        return 44;
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_selctedCheckListOrToDo == 0) {
        
        NSMutableDictionary *dict =[[NSMutableDictionary alloc]initWithDictionary:[_arrCheckListItem objectAtIndex:indexPath.row]];;
        bool isChecked=[[dict valueForKey:@"budget"] boolValue];
        if (isChecked) {
            [dict setValue:@"0" forKey:@"budget"];
        } else {
            [dict setValue:@"1" forKey:@"budget"];
        }
        
        NSMutableArray *arr=[[NSMutableArray alloc] initWithArray:_arrCheckListItem];
        [arr replaceObjectAtIndex:indexPath.row withObject:dict];
        [_tableView reloadData];
        
        _arrCheckListItem=[[NSMutableArray alloc] initWithArray:arr];
        
        [self updateInPreference];
    }
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnbackClick:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnAddClick:(id)sender {
    
    if (_txtChecklist.text.length > 0 && _txtcost.text.length > 0 && _txtDate.text.length>0) {
       
        NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
        [dict setObject:self.txtChecklist.text forKey:@"name"];
        [dict setObject:self.txtcost.text forKey:@"budget"];
        [dict setObject:self.txtDate.text forKey:@"date"];
        [_arrCheckListItem addObject:dict];
        self.txtChecklist.text=@"";
        self.txtcost.text=@"";
        self.txtDate.text=@"";
        NSIndexPath *pathindex = [NSIndexPath indexPathForRow:self.arrCheckListItem.count-1 inSection:0];
        
        [_tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:pathindex] withRowAnimation:UITableViewRowAnimationTop];
        [_tableView scrollToRowAtIndexPath:pathindex atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        [self updateInPreference];
        [self.view endEditing:YES];
    }
}

-(void)updateInPreference {
    
    NSMutableDictionary *dictRoot1=[[NSMutableDictionary alloc] initWithDictionary:_dictRoot];
    [dictRoot1 setObject:[NSArray arrayWithArray:_arrCheckListItem] forKey:_strKey];
    
    NSMutableArray * arrRoots=[[NSMutableArray alloc] initWithArray:[[DataManager sharedInstance] getJournyPlanner]];
    [arrRoots replaceObjectAtIndex:[[DataManager sharedInstance]selectedjourneyIndex] withObject:dictRoot1];
    [[DataManager sharedInstance] setJournyPlanner:arrRoots];
}

@end
