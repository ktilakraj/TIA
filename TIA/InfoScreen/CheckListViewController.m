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

@interface CheckListViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblFrmToDate;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UILabel *lblHeaderTitle;
- (IBAction)btnbackClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation CheckListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
   
    [self updateheader];
    
}

-(void)updateheader
{
    _lblTitle.text=[self.dictRoot valueForKey:@"name"];
    _lblFrmToDate.text=[NSString stringWithFormat:@"%@ to %@",[self.dictRoot valueForKey:@"fromDate"],[self.dictRoot valueForKey:@"toDate"]];
}


- (void)setDictRoot:(NSMutableDictionary *)dictRoot {
    _dictRoot = dictRoot;
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
//    [self presentViewController:swtyaJPDScreen animated:NO completion:nil];
    
    [self.navigationController pushViewController:swtyaJPDScreen animated:YES];

   
    switch (sender.tag) {
        case 101:
        {
            //Check
        }
            break;
        case 102:
        {
            //To Do
        }
            break;
        case 103:
        {
             //Itine
        }
            break;
        case 104:
        {
            //Budget
        }
            break;
            
        default:
            break;
    }
}
@end
