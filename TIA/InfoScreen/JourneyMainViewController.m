//
//  JourneyMainViewController.m
//  TIA
//
//  Created by tilak raj verma on 20/09/16.
//  Copyright © 2016 Swtya. All rights reserved.
//

#import "JourneyMainViewController.h"
#import "JourneyPlannerDetails.h"
#import "CheckListViewController.h"
#import "BudgetViewController.h"
#import "ItineraryViewController.h"
#import "DataManager.h"

#define SMCUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SMCUIColorFromRGBA(rgbValue,alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

#define color_3598DB 0x3598DB
#define color_123579 0x123579

@interface JourneyMainViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblFrmToDate;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UILabel *lblHeaderTitle;
- (IBAction)btnbackClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckList;
@property (weak, nonatomic) IBOutlet UIButton *btnToDoList;
@property (weak, nonatomic) IBOutlet UIButton *btnItinerary;
@property (weak, nonatomic) IBOutlet UIButton *btnBudget;
- (IBAction)optionsSelected:(id)sender;

@end

@implementation JourneyMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    [self getLayer];
    [self updateheader];
    
}

-(void)updateheader
{
    _lblTitle.text=[self.dictRoot valueForKey:@"name"];
    
    if (_lblTitle.text.length <= 0) {
        _lblTitle.text=[[NSString alloc] getFromToString:self.dictRoot];
        _lblFrmToDate.text=@"";
    } else {
      _lblFrmToDate.text=[[NSString alloc] getFromToString:self.dictRoot];
    }
    
   
}


-(void)getLayer {
    
    self.btnCheckList.layer.cornerRadius=3.0f;
    self.btnCheckList.layer.borderWidth=1.0f;
    self.btnCheckList.layer.borderColor=SMCUIColorFromRGB(color_123579).CGColor;
   
    self.btnToDoList.layer.cornerRadius=3.0f;
    self.btnToDoList.layer.borderWidth=1.0f;
    self.btnToDoList.layer.borderColor=SMCUIColorFromRGB(color_123579).CGColor;
    
    self.btnItinerary.layer.cornerRadius=3.0f;
    self.btnItinerary.layer.borderWidth=1.0f;
    self.btnItinerary.layer.borderColor=SMCUIColorFromRGB(color_123579).CGColor;
    
    self.btnBudget.layer.cornerRadius=3.0f;
    self.btnBudget.layer.borderWidth=1.0f;
    self.btnBudget.layer.borderColor=SMCUIColorFromRGB(color_123579).CGColor;
}

- (void)setDictRoot:(NSMutableDictionary *)dictRoot {
    _dictRoot = dictRoot;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear: animated];
    NSMutableArray* arrRoots=[[DataManager sharedInstance] getJournyPlanner];
    [self setDictRoot:[arrRoots objectAtIndex:[[DataManager sharedInstance]selectedjourneyIndex]]];
    
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

- (IBAction)optionsSelected:(UIButton*)sender {
    
    CGRect screenBounds;
    screenBounds = [[UIScreen mainScreen] bounds];
    
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
    

    switch (sender.tag) {
        case 101:
        {
            //Check
            CheckListViewController *chekListVC=[[CheckListViewController alloc] initWithNibName:@"CheckListViewController" bundle:nil];
            [chekListVC setDictRoot:self.dictRoot];
            [chekListVC setSelctedCheckListOrToDo:0];
             [self.navigationController pushViewController:chekListVC animated:YES];
        }
            break;
        case 102:
        {
            //To Do
            CheckListViewController *chekListVC=[[CheckListViewController alloc] initWithNibName:@"CheckListViewController" bundle:nil];
             [chekListVC setDictRoot:self.dictRoot];
             [chekListVC setSelctedCheckListOrToDo:1];
            [self.navigationController pushViewController:chekListVC animated:YES];
        }
            break;
        case 103:
        {
             //Itine
     
            ItineraryViewController *chekListVC=[[ItineraryViewController alloc] initWithNibName:@"ItineraryViewController" bundle:nil];
            [chekListVC setDictRoot:self.dictRoot];
            [chekListVC setSelctedCheckListOrToDo:3];
            
            [self.navigationController pushViewController:chekListVC animated:YES];
        }
            break;
        case 104:
        {
            //Budget
            //BudgetViewController.h
            
            BudgetViewController *chekListVC=[[BudgetViewController alloc] initWithNibName:@"BudgetViewController" bundle:nil];
            [chekListVC setDictRoot:self.dictRoot];
            [chekListVC setSelctedCheckListOrToDo:2];
       
            [self.navigationController pushViewController:chekListVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}
@end
