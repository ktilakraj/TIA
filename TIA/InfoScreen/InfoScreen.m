//
//  InfoScreen.m
//  TIA
//
//  Created by Swtya on 21/03/16.
//  Copyright (c) 2016 Swtya. All rights reserved.
//

#import "InfoScreen.h"
#import "HomeScreen.h"
#import "InfoScreenCell.h"
#import "NewspapersScreen.h"
#import "SwtyaWebViewScreen.h"
#import "calenderView.h"
#import "NSArray+SIAdditions.h"
#import "JourneyPlannerScreen.h"


@interface InfoScreen ()
{
    NSArray *headerArray;
    NSArray *footerArray;
    NSArray *imagesArray;
    NSArray *codeArray;
    
    CGRect screenBounds;
}

@end

@implementation InfoScreen

- (void)viewDidLoad
{
    [super viewDidLoad];
    ;
    
    screenBounds = [[UIScreen mainScreen] bounds];
    
    NSString *homeXIB;
    
    if (screenBounds.size.height == 667)
    {
        homeXIB = @"InfoScreenCell";
    }
    else if(screenBounds.size.height == 1024)
    {
        homeXIB = @"InfoScreenCell ipad";
    }
    else if(screenBounds.size.height == 568)
    {
        homeXIB = @"InfoScreenCell 320";
    }
    else if(screenBounds.size.height == 480)
    {
        homeXIB = @"InfoScreenCell 320";
    }
    else if(screenBounds.size.height == 736)
    {
        homeXIB = @"InfoScreenCell 414";
    }
    
    [self.infoTableView registerNib:[UINib nibWithNibName:homeXIB bundle:nil] forCellReuseIdentifier:@"InfoScreenCell"];
    
    headerArray = [self getInformation];
    
}

-(NSString*)getImageName:(NSString*)code
{
    NSString *strImageName=@"";
    switch (code.intValue) {
        case 101:
        {
            strImageName=@"journey_planner";
        }
            break;
        case 102:
        {
             strImageName=@"flights";
        }
            break;
        case 103:
        {
             strImageName=@"hotels";
        }
            break;
        case 104:
        {
             strImageName=@"exchange_rate";
        }
            break;
        case 105:
        {
            strImageName=@"s5.png";
        }
            break;
        case 106:
        {
            strImageName=@"s6.png";
        }
            break;
        case 107:
        {
           strImageName=@"s7.png";
        }
            break;
        case 108:
        {
            strImageName=@"s8.png";
        }
            break;
        case 109:
        {
            strImageName=@"s9.png";
        }
            break;
        case 110:
        {
            strImageName=@"s10.png";
        }
            break;
        default:
            break;
    }
    
    return strImageName;
}

-(NSArray *)getInformation
{
    NSString *strPath=[[NSBundle mainBundle] pathForResource:@"information" ofType:@".txt"];
    NSData *data=[NSData dataWithContentsOfFile:strPath];
    if (data) {
        
        NSArray *jsonArray=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        return jsonArray;
        
    }
    
    return nil;
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return headerArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)localTableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"InfoScreenCell";
    
    InfoScreenCell *cell = (InfoScreenCell *)[self.infoTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dictInfo=[headerArray si_objectOrNilAtIndex:indexPath.row];
    cell.swtyaHeaderLabel.text = [dictInfo valueForKey:@"title"];
    cell.swtyaFooterLabel.text = [dictInfo valueForKey:@"subtitle"];
    
    cell.swtyaImgView.image = [UIImage imageNamed:[self getImageName:[dictInfo valueForKey:@"code"]]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    NSString *homeXIB;
    
    if (screenBounds.size.height == 667)
    {
        homeXIB = @"SwtyaWebViewScreen";
    }
    else if(screenBounds.size.height == 1024)
    {
        homeXIB = @"SwtyaWebViewScreen ipad";
    }
    else if(screenBounds.size.height == 568)
    {
        homeXIB = @"SwtyaWebViewScreen 568";
    }
    else if(screenBounds.size.height == 480)
    {
        homeXIB = @"SwtyaWebViewScreen 480";
    }
    else if(screenBounds.size.height == 736)
    {
        homeXIB = @"SwtyaWebViewScreen 414";
    }
    
     NSDictionary *dictInfo=[headerArray si_objectOrNilAtIndex:indexPath.row];
    
    if([[dictInfo valueForKey:@"code"] intValue] == 105)
    {
        NSString *homeXIB;
        
        if (screenBounds.size.height == 667)
        {
            homeXIB = @"NewspapersScreen";
        }
        else if(screenBounds.size.height == 1024)
        {
            homeXIB = @"NewspapersScreen ipad";
        }
        else if(screenBounds.size.height == 568)
        {
            homeXIB = @"NewspapersScreen 568";
        }
        else if(screenBounds.size.height == 480)
        {
            homeXIB = @"NewspapersScreen 480";
        }
        else if(screenBounds.size.height == 736)
        {
            homeXIB = @"NewspapersScreen 414";
        }
        
        NewspapersScreen *swtyaNPScreen = [[NewspapersScreen alloc] initWithNibName:homeXIB bundle:nil];
        
        [self presentViewController:swtyaNPScreen animated:NO completion:nil];
    }
    else if([[dictInfo valueForKey:@"code"] intValue] == 106)
    {
        SwtyaWebViewScreen *swtyaWebViewScreen = [[SwtyaWebViewScreen alloc] initWithNibName:homeXIB bundle:nil];
        
        swtyaWebViewScreen.swtyaWebViewUrl = @"http://nriinformation.com";
        swtyaWebViewScreen.swtya4mWhere = @"Info";
        
        [self presentViewController:swtyaWebViewScreen animated:NO completion:nil];
    }
    else if([[dictInfo valueForKey:@"code"] intValue] == 107)
    {
        SwtyaWebViewScreen *swtyaWebViewScreen = [[SwtyaWebViewScreen alloc] initWithNibName:homeXIB bundle:nil];
        
        swtyaWebViewScreen.swtyaWebViewUrl = @"https://www.lonelyplanet.com/india";
        swtyaWebViewScreen.swtya4mWhere = @"Info";
        
        [self presentViewController:swtyaWebViewScreen animated:NO completion:nil];
    }
    else if([[dictInfo valueForKey:@"code"] intValue] == 108)
    {
        NSString *homeXIB;
        
        if (screenBounds.size.height == 667)
        {
            homeXIB = @"calenderView";
        }
        else if(screenBounds.size.height == 1024)
        {
            homeXIB = @"calenderView ipad";
        }
        else if(screenBounds.size.height == 568)
        {
            homeXIB = @"calenderView 568";
        }
        else if(screenBounds.size.height == 480)
        {
            homeXIB = @"calenderView 480";
        }
        else if(screenBounds.size.height == 736)
        {
            homeXIB = @"calenderView 414";
        }
        
        calenderView *swtyaCalendarScreen = [[calenderView alloc] initWithNibName:homeXIB bundle:nil];
        
        [self presentViewController:swtyaCalendarScreen animated:NO completion:nil];
    }
    else if([[dictInfo valueForKey:@"code"] intValue] == 109)
    {
        SwtyaWebViewScreen *swtyaWebViewScreen = [[SwtyaWebViewScreen alloc] initWithNibName:homeXIB bundle:nil];
        
        swtyaWebViewScreen.swtyaWebViewUrl = @"https://www.nri.gujarat.gov.in/";
        swtyaWebViewScreen.swtya4mWhere = @"Info";
        
        [self presentViewController:swtyaWebViewScreen animated:NO completion:nil];
    }
    else if([[dictInfo valueForKey:@"code"] intValue] == 110)
    {
        SwtyaWebViewScreen *swtyaWebViewScreen = [[SwtyaWebViewScreen alloc] initWithNibName:homeXIB bundle:nil];
        
        swtyaWebViewScreen.swtyaWebViewUrl = @"http://www.nripunjab.gov.in/services.htm";
        swtyaWebViewScreen.swtya4mWhere = @"Info";
        
        [self presentViewController:swtyaWebViewScreen animated:NO completion:nil];
    } else if([[dictInfo valueForKey:@"code"] intValue] == 101)
    {
        [self loadJourneyPlannerViewController];
    } else if([[dictInfo valueForKey:@"code"] intValue] == 102)
    {
        [self loadFlightsViewController];
    } else if([[dictInfo valueForKey:@"code"] intValue] == 103)
    {
        [self loadHotelsViewController];
    }
    else if([[dictInfo valueForKey:@"code"] intValue] == 104)
    {
        [self loadExchangesRateViewController];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)swtyaBckBtnClicked:(id)sender
{
    NSString *homeXIB;
    
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
}

-(void)loadJourneyPlannerViewController
{
    NSString *homeXIB;
    
    if (screenBounds.size.height == 667)
    {
        homeXIB = @"JourneyPlannerScreen";
    }
    else if(screenBounds.size.height == 1024)
    {
        homeXIB = @"JourneyPlannerScreen ipad";
    }
    else if(screenBounds.size.height == 568)
    {
        homeXIB = @"JourneyPlannerScreen 568";
    }
    else if(screenBounds.size.height == 480)
    {
        homeXIB = @"JourneyPlannerScreen 480";
    }
    else if(screenBounds.size.height == 736)
    {
        homeXIB = @"JourneyPlannerScreen 414";
    }
    
    JourneyPlannerScreen *swtyaJPScreen = [[JourneyPlannerScreen alloc] initWithNibName:homeXIB bundle:nil];
    [self presentViewController:swtyaJPScreen animated:NO completion:nil];
}

-(void)loadFlightsViewController
{
    
    NSString *homeXIB;
    
    if (screenBounds.size.height == 667)
    {
        homeXIB = @"SwtyaWebViewScreen";
    }
    else if(screenBounds.size.height == 1024)
    {
        homeXIB = @"SwtyaWebViewScreen ipad";
    }
    else if(screenBounds.size.height == 568)
    {
        homeXIB = @"SwtyaWebViewScreen 568";
    }
    else if(screenBounds.size.height == 480)
    {
        homeXIB = @"SwtyaWebViewScreen 480";
    }
    else if(screenBounds.size.height == 736)
    {
        homeXIB = @"SwtyaWebViewScreen 414";
    }
    SwtyaWebViewScreen *swtyaWebViewScreen = [[SwtyaWebViewScreen alloc] initWithNibName:homeXIB bundle:nil];
    
    swtyaWebViewScreen.swtyaWebViewUrl = @"http://www.skyscanner.net";
    swtyaWebViewScreen.swtya4mWhere = @"Info";
    
    [self presentViewController:swtyaWebViewScreen animated:NO completion:nil];
}

-(void)loadHotelsViewController
{
    
    NSString *homeXIB;
    
    if (screenBounds.size.height == 667)
    {
        homeXIB = @"SwtyaWebViewScreen";
    }
    else if(screenBounds.size.height == 1024)
    {
        homeXIB = @"SwtyaWebViewScreen ipad";
    }
    else if(screenBounds.size.height == 568)
    {
        homeXIB = @"SwtyaWebViewScreen 568";
    }
    else if(screenBounds.size.height == 480)
    {
        homeXIB = @"SwtyaWebViewScreen 480";
    }
    else if(screenBounds.size.height == 736)
    {
        homeXIB = @"SwtyaWebViewScreen 414";
    }
    
    SwtyaWebViewScreen *swtyaWebViewScreen = [[SwtyaWebViewScreen alloc] initWithNibName:homeXIB bundle:nil];
    
    swtyaWebViewScreen.swtyaWebViewUrl = @"http://www.trivago.in";
    swtyaWebViewScreen.swtya4mWhere = @"Info";
    
    [self presentViewController:swtyaWebViewScreen animated:NO completion:nil];
}

-(void)loadExchangesRateViewController
{
    NSString *homeXIB;
    if (screenBounds.size.height == 667)
    {
        homeXIB = @"SwtyaWebViewScreen";
    }
    else if(screenBounds.size.height == 1024)
    {
        homeXIB = @"SwtyaWebViewScreen ipad";
    }
    else if(screenBounds.size.height == 568)
    {
        homeXIB = @"SwtyaWebViewScreen 568";
    }
    else if(screenBounds.size.height == 480)
    {
        homeXIB = @"SwtyaWebViewScreen 480";
    }
    else if(screenBounds.size.height == 736)
    {
        homeXIB = @"SwtyaWebViewScreen 414";
    }
    SwtyaWebViewScreen *swtyaWebViewScreen = [[SwtyaWebViewScreen alloc] initWithNibName:homeXIB bundle:nil];
    
    swtyaWebViewScreen.swtyaWebViewUrl = @"http://www.remitrate.com";
    swtyaWebViewScreen.swtya4mWhere = @"Info";
    
    [self presentViewController:swtyaWebViewScreen animated:NO completion:nil];
}


@end
