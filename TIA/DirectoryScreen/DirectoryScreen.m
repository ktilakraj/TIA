//
//  DirectoryScreen.m
//  TIA
//
//  Created by Swtya on 10/04/16.
//  Copyright (c) 2016 Swtya. All rights reserved.
//

#import "DirectoryScreen.h"
#import "DirectoryCell.h"
#import "HomeScreen.h"
#import "RealEstateScreen.h"

@interface DirectoryScreen ()
{
    NSArray *headerArray;
    NSArray *imagesArray;
    NSArray *arr;
    
    CGRect screenBounds;
    
    NIDropDown *dropDown;
    NSString *swtyaCityName;
}

@end

@implementation DirectoryScreen

- (IBAction)locationDropDown:(id)sender
{
    //    arr = [NSArray arrayWithObjects:@"Hyderabad/ Secunderabad", @"Pune", @"Aurangabad", @"Bangalore", nil];
    NSArray *arrImage = [[NSArray alloc] init];
    
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    
    if(dropDown == nil)
    {
        CGFloat f;
        
        if(arr.count > 4)
            f = 200;
        else
            f = arr.count * 40;
        
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
        dropDown.delegate = self;
    }
    else
    {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

- (void)niDropDownDelegateMethod: (NIDropDown *)sender index : (NSInteger *)index
{
    swtyaCityName = [arr objectAtIndex:index];
    
    [self.swtyaSelectCityBtn setTitle:swtyaCityName forState:UIControlStateNormal];
    
    [self rel];
}

- (void)rel
{
    //[dropDown release];
    dropDown = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    screenBounds = [[UIScreen mainScreen] bounds];
    
    arr = [[NSArray alloc] initWithObjects:@"Mumbai", @"Pune", @"Nashik", @"Surat", @"Ahmedabad", nil];
    
    swtyaCityName = @"Select City";
    
    NSString *homeXIB;
    
    if (screenBounds.size.height == 667)
    {
        homeXIB = @"DirectoryCell";
    }
    else if(screenBounds.size.height == 1024)
    {
        homeXIB = @"DirectoryCell";
    }
    else if(screenBounds.size.height == 568)
    {
        homeXIB = @"DirectoryCell";
    }
    else if(screenBounds.size.height == 480)
    {
        homeXIB = @"DirectoryCell";
    }
    else if(screenBounds.size.height == 736)
    {
        homeXIB = @"DirectoryCell";
    }
    
    [self.infoTableView registerNib:[UINib nibWithNibName:homeXIB bundle:nil] forCellReuseIdentifier:@"DirectoryCell"];
    
    headerArray = [[NSArray alloc] initWithObjects:@"Real Estate", @"Weddings", @"Wedding Destinations", @"Health Tourism", @"Bankings", @"Eating Out", @"Hotels", @"Tours & Travels", nil];
    
    imagesArray = [[NSArray alloc] initWithObjects:@"s18.png", @"s20.png", @"wedding.png", @"s19.png", @"banking.png", @"eating.png", @"hotels.png", @"travels.png", nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return headerArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)localTableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DirectoryCell";
    
    DirectoryCell *cell = (DirectoryCell *)[self.infoTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.swtyaFooterLabel.text = headerArray[indexPath.row];
    
    cell.swtyaImgView.image = [UIImage imageNamed:imagesArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(![swtyaCityName isEqualToString:@"Select City"])
    {
        NSString *homeXIB;
        
        if (screenBounds.size.height == 667)
        {
            homeXIB = @"RealEstateScreen";
        }
        else if(screenBounds.size.height == 1024)
        {
            homeXIB = @"RealEstateScreen";
        }
        else if(screenBounds.size.height == 568)
        {
            homeXIB = @"RealEstateScreen";
        }
        else if(screenBounds.size.height == 480)
        {
            homeXIB = @"RealEstateScreen";
        }
        else if(screenBounds.size.height == 736)
        {
            homeXIB = @"RealEstateScreen";
        }
        
        RealEstateScreen *swtyaNPScreen = [[RealEstateScreen alloc] initWithNibName:homeXIB bundle:nil];
        [self presentViewController:swtyaNPScreen animated:NO completion:nil];
    }
    else
    {
        UIAlertView *swtyaAlert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Please select city"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [swtyaAlert show];
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
        homeXIB = @"HomeScreen";
    }
    else if(screenBounds.size.height == 480)
    {
        homeXIB = @"HomeScreen";
    }
    else if(screenBounds.size.height == 736)
    {
        homeXIB = @"HomeScreen";
    }
    
    HomeScreen *swtyaHomeScreen = [[HomeScreen alloc] initWithNibName:homeXIB bundle:nil];
    [self presentViewController:swtyaHomeScreen animated:NO completion:nil];
}

@end
