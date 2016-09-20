//
//  calenderView.m
//  TIA
//
//  Created by Diwakar on 22/03/16.
//  Copyright © 2016 L7Software. All rights reserved.
//

#import "calenderView.h"
#import "collectionCell.h"
#import "tableCell.h"
#import "InfoScreen.h"

@interface calenderView ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *calender;
    NSDictionary *currentMonth, *currM;
    int swtyaCM;
    NSArray *jan;
    NSArray *feb;
    NSArray *march;
    NSArray *april;
    NSArray *may;
    NSArray *june;
    NSArray *july;
    NSArray *aug;
    NSArray *sept;
    NSArray *oct;
    NSArray *nov;
    NSArray *dec;
    
    CGRect screenBounds;
}

@end

@implementation calenderView
@synthesize monthCollection,holidayTable;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    screenBounds = [[UIScreen mainScreen] bounds];
    
    NSString *homeXIB, *homeXIB1;
    
    if (screenBounds.size.height == 667)
    {
        homeXIB = @"collectionCell";
        homeXIB1 = @"tableCell";
    }
    else if(screenBounds.size.height == 1024)
    {
        homeXIB = @"collectionCell ipad";
        homeXIB1 = @"tableCell ipad";
    }
    else if(screenBounds.size.height == 568)
    {
        homeXIB = @"collectionCell 320";
        homeXIB1 = @"tableCell 320";
    }
    else if(screenBounds.size.height == 480)
    {
        homeXIB = @"collectionCell 320";
        homeXIB1 = @"tableCell 320";
    }
    else if(screenBounds.size.height == 736)
    {
        homeXIB = @"collectionCell";
        homeXIB1 = @"tableCell 414";
    }
    
    [holidayTable registerNib:[UINib nibWithNibName:homeXIB1 bundle:nil] forCellReuseIdentifier:@"Cell"];
    [monthCollection registerNib:[UINib nibWithNibName:homeXIB bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    
    //NSDate *today = [NSDate new];
    //NSLog(@"Today = %@",today);
    
    calender = @[@{@"month":@"Jan",@"startIndex":@4,@"days":@31},@{@"month":@"Feb",@"startIndex":@0,@"days":@29},@{@"month":@"March",@"startIndex":@1,@"days":@31},@{@"month":@"April",@"startIndex":@4,@"days":@30},@{@"month":@"May",@"startIndex":@-1,@"days":@31},@{@"month":@"June",@"startIndex":@2,@"days":@30},@{@"month":@"July",@"startIndex":@4,@"days":@31},@{@"month":@"Aug",@"startIndex":@0,@"days":@31},@{@"month":@"Sept",@"startIndex":@3,@"days":@30},@{@"month":@"Oct",@"startIndex":@5,@"days":@31},@{@"month":@"Nov",@"startIndex":@1,@"days":@30},@{@"month":@"Dec",@"startIndex":@3,@"days":@31}];
    
    jan = @[@{@"date":@"01",@"day":@"Friday",@"fest":@"English New Year"},
            @{@"date":@"14",@"day":@"Thursday",@"fest":@"Lohri"},
            @{@"date":@"15",@"day":@"Friday",@"fest":@"Pongal, Makar Sankranti"},
            @{@"date":@"16",@"day":@"Saturday",@"fest":@"Guru Gobind Singh Jayanti"},
            @{@"date":@"20",@"day":@"Wednesday",@"fest":@"Tailang Swami Jayanti"},
            @{@"date":@"23",@"day":@"Saturday",@"fest":@"Subhash Chandra Bose Jayanti"},
            @{@"date":@"26",@"day":@"Tuesday",@"fest":@"Republic Day"},
            @{@"date":@"31",@"day":@"Sunday",@"fest":@"Swami Vivekananda Jayanti"}];
    
    feb = @[@{@"date":@"12",@"day":@"Friday",@"fest":@"Vasant Panchami"},
            @{@"date":@"22",@"day":@"Monday",@"fest":@"Guru Ravidas Jayanti"}];
    
    march = @[@{@"date":@"04",@"day":@"Friday",@"fest":@"Maharishi Dayanand Saraswati Jayanti"},
            @{@"date":@"07",@"day":@"Monday",@"fest":@"Maha Shivaratri"},
            @{@"date":@"10",@"day":@"Thursday",@"fest":@"Ramakrishna Jayanti"},
            @{@"date":@"20",@"day":@"Sunday",@"fest":@"Vernal Equinox, Parsi New Year"},
            @{@"date":@"23",@"day":@"Wednesday",@"fest":@"Chhoti Holi, Holika Dahan"},
            @{@"date":@"24",@"day":@"Thursday",@"fest":@"Holi"},
            @{@"date":@"25",@"day":@"Friday",@"fest":@"Good Friday"},
            @{@"date":@"26",@"day":@"Saturday",@"fest":@"Shivaji Jayanti"},
            @{@"date":@"27",@"day":@"Sunday",@"fest":@"Easter"}];
    
    april = @[@{@"date":@"01",@"day":@"Friday",@"fest":@"Bank's Holiday"},
            @{@"date":@"08",@"day":@"Friday",@"fest":@"Gudi Padwa, Ugadi"},
            @{@"date":@"09",@"day":@"Saturday",@"fest":@"Jhulelal Jayanti"},
            @{@"date":@"13",@"day":@"Wednesday",@"fest":@"Solar New Year, Baisakhi"},
            @{@"date":@"14",@"day":@"Thursday",@"fest":@"Ambedkar Jayanti"},
            @{@"date":@"15",@"day":@"Friday",@"fest":@"Rama Navami"},
            @{@"date":@"19",@"day":@"Tuesday",@"fest":@"Mahavir Swami Jayanti"},
            @{@"date":@"21",@"day":@"Thursday",@"fest":@"Hazarat Ali's Birthday"}];
    
    may = @[@{@"date":@"03",@"day":@"Tuesday",@"fest":@"Vallabhacharya Jayanti"},
            @{@"date":@"07",@"day":@"Saturday",@"fest":@"Rabindranath Tagore Jayanti"},
            @{@"date":@"11",@"day":@"Wednesday",@"fest":@"Shankaracharya Jayanti, Surdas Jayanti"},
            @{@"date":@"21",@"day":@"Saturday",@"fest":@"Buddha Purnima"}];
    
    june = @[@{@"date":@"07",@"day":@"Tuesday",@"fest":@"Maharana Pratap Jayanti"},
            @{@"date":@"20",@"day":@"Monday",@"fest":@"Kabirdas Jayanti"},
            @{@"date":@"21",@"day":@"Tuesday",@"fest":@"Longest Day of Year"}];
    
    july = @[@{@"date":@"01",@"day":@"Friday",@"fest":@"Jamat Ul-Vida"},
            @{@"date":@"06",@"day":@"Wednesday",@"fest":@"Jagannath Rathyatra"},
            @{@"date":@"07",@"day":@"Thursday",@"fest":@"Eid al-Fitr, Ramadan"}];
    
    aug = @[@{@"date":@"10",@"day":@"Wednesday",@"fest":@"Tulsidas Jayanti"},
            @{@"date":@"15",@"day":@"Monday",@"fest":@"Independence Day"},
            @{@"date":@"18",@"day":@"Thursday",@"fest":@"Rakhi, Raksha Bandhan"},
            @{@"date":@"25",@"day":@"Thursday",@"fest":@"Krishna Janmashtami"}];
    
    sept = @[@{@"date":@"05",@"day":@"Monday",@"fest":@"Ganesh Chaturthi"},
            @{@"date":@"13",@"day":@"Tuesday",@"fest":@"Onam, Eid al-Adha, Bakrid"},
            @{@"date":@"22",@"day":@"Thursday",@"fest":@"Autumnal Equinox"}];
    
    oct = @[@{@"date":@"01",@"day":@"Saturday",@"fest":@"Maharaja Agresen Jayanti"},
            @{@"date":@"02",@"day":@"Sunday",@"fest":@"Gandhi Jayanti"},
            @{@"date":@"03",@"day":@"Monday",@"fest":@"Al-Hijra, Islamic New Year"},
            @{@"date":@"09",@"day":@"Sunday",@"fest":@"Durga Ashtami"},
            @{@"date":@"10",@"day":@"Monday",@"fest":@"Maha Navami"},
            @{@"date":@"11",@"day":@"Tuesday",@"fest":@"Dussehra, Madhvacharya Jayanti"},
            @{@"date":@"12",@"day":@"Wednesday",@"fest":@"Day of Ashura, Muharram"},
            @{@"date":@"16",@"day":@"Sunday",@"fest":@"Valmiki Jayanti, Meerabai Jayanti"},
            @{@"date":@"19",@"day":@"Wednesday",@"fest":@"Karwa Chauth"},
            @{@"date":@"29",@"day":@"Saturday",@"fest":@"Narak Chaturdashi"},
            @{@"date":@"30",@"day":@"Sunday",@"fest":@"Diwali, Lakshmi Puja"},
            @{@"date":@"31",@"day":@"Monday",@"fest":@"Gowardhan Puja"}];
    
    nov = @[@{@"date":@"01",@"day":@"Tuesday",@"fest":@"Bhaiya Dooj"},
            @{@"date":@"06",@"day":@"Sunday",@"fest":@"Chhath Puja"},
            @{@"date":@"14",@"day":@"Monday",@"fest":@"Guru Nanak Jayanti, Nehru Jayanti"}];
    
    dec = @[@{@"date":@"12",@"day":@"Monday",@"fest":@"Milad an-Nabi, Id-e-Milad"},
            @{@"date":@"21",@"day":@"Wednesday",@"fest":@"Shortest Day of Year"},
            @{@"date":@"25",@"day":@"Sunday",@"fest":@"Merry Christmas"}];
    
    swtyaCM = 2;
    
    currentMonth = [NSDictionary dictionaryWithDictionary:[calender objectAtIndex:swtyaCM]];
    
    self.swtyaMonthLabel.text = [NSString stringWithFormat:@"%@ 2016", [currentMonth objectForKey:@"month"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark tableview datasource & delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(swtyaCM == 0)
        return jan.count;
    else if(swtyaCM == 1)
        return feb.count;
    else if(swtyaCM == 2)
        return march.count;
    else if(swtyaCM == 3)
        return april.count;
    else if(swtyaCM == 4)
        return may.count;
    else if(swtyaCM == 5)
        return june.count;
    else if(swtyaCM == 6)
        return july.count;
    else if(swtyaCM == 7)
        return aug.count;
    else if(swtyaCM == 8)
        return sept.count;
    else if(swtyaCM == 9)
        return oct.count;
    else if(swtyaCM == 10)
        return nov.count;
    else
        return dec.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 51.0f;
}

- (IBAction)swtyaBckBtnClicked:(id)sender
{
    NSString *homeXIB;
    
    if (screenBounds.size.height == 667)
    {
        homeXIB = @"InfoScreen";
    }
    else if(screenBounds.size.height == 1024)
    {
        homeXIB = @"InfoScreen ipad";
    }
    else if(screenBounds.size.height == 568)
    {
        homeXIB = @"InfoScreen 568";
    }
    else if(screenBounds.size.height == 480)
    {
        homeXIB = @"InfoScreen 480";
    }
    else if(screenBounds.size.height == 736)
    {
        homeXIB = @"InfoScreen 414";
    }
    
    InfoScreen *swtyaInfoScreen = [[InfoScreen alloc] initWithNibName:homeXIB bundle:nil];
    [self presentViewController:swtyaInfoScreen animated:NO completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableCell *cell = [holidayTable dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil)
    {
        cell = [[tableCell alloc]init];
    }
    
    if(swtyaCM == 0)
        currM = [NSDictionary dictionaryWithDictionary:[jan objectAtIndex:indexPath.row]];
    else if(swtyaCM == 1)
        currM = [NSDictionary dictionaryWithDictionary:[feb objectAtIndex:indexPath.row]];
    else if(swtyaCM == 2)
        currM = [NSDictionary dictionaryWithDictionary:[march objectAtIndex:indexPath.row]];
    else if(swtyaCM == 3)
        currM = [NSDictionary dictionaryWithDictionary:[april objectAtIndex:indexPath.row]];
    else if(swtyaCM == 4)
        currM = [NSDictionary dictionaryWithDictionary:[may objectAtIndex:indexPath.row]];
    else if(swtyaCM == 5)
        currM = [NSDictionary dictionaryWithDictionary:[june objectAtIndex:indexPath.row]];
    else if(swtyaCM == 6)
        currM = [NSDictionary dictionaryWithDictionary:[july objectAtIndex:indexPath.row]];
    else if(swtyaCM == 7)
        currM = [NSDictionary dictionaryWithDictionary:[aug objectAtIndex:indexPath.row]];
    else if(swtyaCM == 8)
        currM = [NSDictionary dictionaryWithDictionary:[sept objectAtIndex:indexPath.row]];
    else if(swtyaCM == 9)
        currM = [NSDictionary dictionaryWithDictionary:[oct objectAtIndex:indexPath.row]];
    else if(swtyaCM == 10)
        currM = [NSDictionary dictionaryWithDictionary:[nov objectAtIndex:indexPath.row]];
    else if(swtyaCM == 11)
        currM = [NSDictionary dictionaryWithDictionary:[dec objectAtIndex:indexPath.row]];
    
    cell.label1.text = [NSString stringWithFormat:@"%@", [currM objectForKey:@"date"]];
    cell.label2.text = [NSString stringWithFormat:@"%@", [currM objectForKey:@"day"]];
    cell.label3.text = [NSString stringWithFormat:@"%@", [currM objectForKey:@"fest"]];
    
    return cell;
}

#pragma mark collection view datasource & delegates
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return 35;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    collectionCell *cell = [monthCollection dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[collectionCell alloc] init];
    }
    
    if (indexPath.row % 7 == 0)
    {
        cell.label.textColor = [UIColor redColor];
    }
    else
        cell.label.textColor = [UIColor blackColor];
   
    if (indexPath.row > [[currentMonth objectForKey:@"startIndex"]integerValue])
    {
        if (indexPath.row-[[currentMonth objectForKey:@"startIndex"]integerValue]-1<[[currentMonth objectForKey:@"days"]integerValue])
        {
            cell.label.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row-[[currentMonth objectForKey:@"startIndex"]integerValue]];
        }
        else
        {
            cell.label.text = @"";
        }
    }
    else
    {
        cell.label.text = @"";
    }
    return cell;
}

- (IBAction)lastMonthBtnClick:(id)sender
{
    if(swtyaCM > 0)
    {
        swtyaCM--;
        
        currentMonth = [NSDictionary dictionaryWithDictionary:[calender objectAtIndex:swtyaCM]];
        
        self.swtyaMonthLabel.text = [NSString stringWithFormat:@"%@ 2016", [currentMonth objectForKey:@"month"]];
        
        [monthCollection reloadData];
        [holidayTable reloadData];
    }
}

- (IBAction)nextMonthBtnClick:(id)sender
{
    if(swtyaCM < 11)
    {
        swtyaCM++;
        
        currentMonth = [NSDictionary dictionaryWithDictionary:[calender objectAtIndex:swtyaCM]];
        
        self.swtyaMonthLabel.text = [NSString stringWithFormat:@"%@ 2016", [currentMonth objectForKey:@"month"]];
        
        [monthCollection reloadData];
        [holidayTable reloadData];
    }
}

@end
