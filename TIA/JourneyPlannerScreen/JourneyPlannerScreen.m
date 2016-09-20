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

@interface JourneyPlannerScreen ()
{
    NSUserDefaults *userDefaults;
    NSMutableArray *swtyaJPArray;
    NSDictionary *swtyaJPDict;
    UIView *baseView;
    UITextField *getEmail;
    
    CGRect screenBounds;
}

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return swtyaJPArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)localTableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"JourneyPlannerCell";
    
    JourneyPlannerCell *cell = (JourneyPlannerCell *)[self.jpTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSLog(@"Swtya : %i, %@ ", swtyaJPArray.count, swtyaJPArray);
    
    swtyaJPDict = [NSDictionary dictionaryWithDictionary:[[swtyaJPArray objectAtIndex:indexPath.row] objectAtIndex:0]];
    
    NSLog(@"Swtya : %@ ", swtyaJPDict);
    
    cell.swtyaJPLabel.text = [NSString stringWithFormat:@"%@", [swtyaJPDict objectForKey:@"name"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row != swtyaJPArray.count - 1)
    {
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
        
        swtyaJPDScreen.swtyaPlanIndex = indexPath.row;
        
        [self presentViewController:swtyaJPDScreen animated:NO completion:nil];
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
        h = 165;
        bh = 36;
        f = 21;
    }
    else
    {
        h = 160;
        bh = 36;
        f = 16;
    }
    
    UIView *alertview = [[UIView alloc]init];
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
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, alertview.bounds.size.height-42, alertview.bounds.size.width/2-10, bh)];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelBtn.backgroundColor = [UIColor colorWithRed:53.0/255.0 green:152.0/255.0 blue:219.0/255.0 alpha:1.0];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //cancelBtn.layer.borderWidth = 1.0f;
    cancelBtn .titleLabel.font = [UIFont boldSystemFontOfSize:f];
    //cancelBtn.layer.cornerRadius = 10;
    [alertview addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *okBtn = [[UIButton alloc]initWithFrame:CGRectMake(alertview.bounds.size.width/2+5, alertview.bounds.size.height-42, alertview.bounds.size.width/2-10, bh)];
    [okBtn setTitle:@"Add" forState:UIControlStateNormal];
    okBtn.backgroundColor = [UIColor colorWithRed:53.0/255.0 green:152.0/255.0 blue:219.0/255.0 alpha:1.0];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    okBtn .titleLabel.font = [UIFont boldSystemFontOfSize:f];
    //okBtn.layer.borderWidth = 1.0f;
    //okBtn.layer.cornerRadius = 10;
    [alertview addSubview:okBtn];
    [okBtn addTarget:self action:@selector(okBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:baseView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)cancelBtnAction
{
    [baseView removeFromSuperview];
    //[collectLocation removeFromSuperview];
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
