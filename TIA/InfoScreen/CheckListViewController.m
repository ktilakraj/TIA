//
//  JourneyMainViewController.m
//  TIA
//
//  Created by tilak raj verma on 20/09/16.
//  Copyright © 2016 Swtya. All rights reserved.
//

#import "CheckListViewController.h"
#import "JourneyPlannerDetails.h"
#import "DataManager.h"

@interface CheckListViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblFrmToDate;
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

- (IBAction)btnAddClick:(id)sender;


@end

@implementation CheckListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _txtChecklist.delegate=self;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self updateheader];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
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
    if (_selctedCheckListOrToDo == 0) {
        
        _strKey=@"chekcList";
        
    } else {
        
         _strKey=@"toDoList";
    }
    _lblTitle.text=[self.dictRoot valueForKey:@"name"];
    _lblFrmToDate.text=[NSString stringWithFormat:@"%@ to %@",[self.dictRoot valueForKey:@"fromDate"],[self.dictRoot valueForKey:@"toDate"]];
    _arrCheckListItem=[[NSMutableArray alloc] initWithArray:[_dictRoot valueForKey:_strKey]];
    _viewBottom.layer.cornerRadius=2.0f;
    _viewBottom.layer. borderColor=[UIColor lightGrayColor].CGColor;
    _viewBottom.layer.borderWidth=1.0f;
    
    [_txtChecklist setPlaceholder:[NSString stringWithFormat:@"Enter %@",_strKey.lowercaseString]];
    
}

-(void)keyboardDidHideNShow:(NSNotification*)notification {
    
    if (notification.name == UIKeyboardWillShowNotification) {
        
        NSLog(@"SHOW");
        if (!_isKeyBoardAppers) {
            
            CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
            
            [UIView animateWithDuration:0.3 animations:^{
                CGRect f = self.view.frame;
                f.origin.y = -keyboardSize.height;
                self.view.frame = f;
            }];
            _isKeyBoardAppers=true;
        }
        
        
    } else if (notification.name == UIKeyboardDidHideNotification) {
        
        if (_isKeyBoardAppers) {
            
            [UIView animateWithDuration:0.1 animations:^{
                CGRect f = self.view.frame;
                f.origin.y = 0.0f;
                self.view.frame = f;
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
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"checkListCell"];
    if (!cell) {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"checkListCell"];
    }
    
    NSDictionary *dict =[_arrCheckListItem objectAtIndex:indexPath.row];
    cell.textLabel.text=[dict valueForKey:@"name"];
    cell.contentView.clipsToBounds=YES;
    
    bool isChecked=[[dict valueForKey:@"ischekced"] boolValue];
    
    if (_selctedCheckListOrToDo == 0) {
        if (isChecked) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
   
    
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
        bool isChecked=[[dict valueForKey:@"ischekced"] boolValue];
        if (isChecked) {
            [dict setValue:@"0" forKey:@"ischekced"];
        } else {
            [dict setValue:@"1" forKey:@"ischekced"];
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
    
    if (_txtChecklist.text.length > 0) {
       
        NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
        [dict setObject:self.txtChecklist.text forKey:@"name"];
        [dict setObject:@"0" forKey:@"ischekced"];
        [_arrCheckListItem addObject:dict];
        self.txtChecklist.text=@"";
        [_tableView reloadData];
        [self updateInPreference];
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
