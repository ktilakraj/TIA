//
//  JourneyPlannerDetails.m
//  TIA
//
//  Created by Swtya on 24/03/16.
//  Copyright (c) 2016 Swtya. All rights reserved.
//

#import "JourneyPlannerDetails.h"
#import "JourneyPlannerScreen.h"
#import "JPItineraryCell.h"
#import "JPItineraryBottomCell.h"
#import "JPChkUpperCell.h"
#import "JPBudgetUpperCell.h"
#import "JPChkBottomCell.h"
#import "JPBudgetBottomCell.h"

@interface JourneyPlannerDetails ()
{
    NSUserDefaults *userDefaults;
    NSMutableArray *swtyaJPArray;
    NSDictionary *swtyaJPDict, *swtyaJPDict1, *swtyaJPDict2, *swtyaJPDict3;
    NSMutableArray *swtyaJPPreArrayI, *swtyaJPPreArrayC, *swtyaJPPreArrayB;
    NSMutableArray *iArray, *cArray, *bArray;
    int swtya;
    int swtyaCal;
    
    BOOL swtyaIsChk;
    
    CGRect screenBounds;
}

@end

@implementation JourneyPlannerDetails
@synthesize datePicker, datePickerToolbar;

- (IBAction)saveBtnClicked:(id)sender
{
    if(swtya == 2)
    {
//        if(self.nameTF.text.length <= 0)
//        {
//            [[[UIAlertView alloc] initWithTitle:nil message:@"Enter journey name" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
//            
//            return;
//        }
//
        
        NSArray *paths = [self.upperTableView indexPathsForVisibleRows];

        for (NSIndexPath *path in paths)
        {
            NSIndexPath *indexPath = path;// = [NSIndexPath indexPathForRow:paths[i] inSection: 0];
            
            UITableViewCell *cell = [self.upperTableView cellForRowAtIndexPath:indexPath];
            
            NSString *dtString, *conString;
            
            for (UIView *view in cell.contentView.subviews)
            {
                if ([view isKindOfClass:[UITextField class]])
                {
                    UITextField* txtField = (UITextField *)view;
                    
                    if (txtField.tag == 002)
                    {
                        //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
                        dtString = txtField.text;
                    }
                    
                    if (txtField.tag == 007)
                    {
                        //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
                        conString = txtField.text;
                    }
                }
            }
            
            if(self.fromTF.text.length <= 0 || self.toTF.text.length <= 0 ||
               dtString.length <= 0 || conString.length <= 0)
            {
                [[[UIAlertView alloc] initWithTitle:nil message:@"Enter all the fields" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
                
                return;
            }
            
            //        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
            //        [data setObject:dtString forKey:@"item"];
            //        [data setObject:conString forKey:@"cost"];
            //        [swtyaJPArray1 addObject:data];
            
            swtyaJPDict2 = [NSDictionary dictionaryWithDictionary:[iArray objectAtIndex:indexPath.row]];
            
            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
            [data setObject:self.fromTF.text forKey:@"from"];
            [data setObject:self.toTF.text forKey:@"to"];
            [data setObject:dtString forKey:@"date"];
            [data setObject:conString forKey:@"con"];
            [swtyaJPPreArrayI replaceObjectAtIndex:indexPath.row withObject:data];
            [iArray replaceObjectAtIndex:indexPath.row withObject:data];
        }
        
        
        NSArray *swtyaJPPreArray = [[NSArray alloc] init];
        
        swtyaJPPreArray = @[@{@"name":self.swtyaPlanName,@"checklist":cArray,@"itinerary":iArray,@"budget":bArray}];
        
        [swtyaJPArray replaceObjectAtIndex:self.swtyaPlanIndex withObject:swtyaJPPreArray];
        
        [self saveArrayToUserDefaults:swtyaJPArray forKey:@"swtyaJPArray"];
        
        [self.upperTableView reloadData];
        //[self.bottomTableView reloadData];
//
//        //        NSArray *swtyaJPPreArray = [[NSArray alloc] init];
//        //
//        //        NSMutableArray *swtyaJPArray1 = [[NSMutableArray alloc] init];
//        //
//        //        //    if(swtyaJPArray1.count > 0)
//        //        //        swtyaJPArray = swtyaJPArray1;
//        //        //    else
//        //        //        [swtyaJPArray addObject:swtyaJPPreArray];
//        //
//        //        for (int i = 0; i < swtyaJPPreArrayI.count; i++)
//        //        {
//        //            NSIndexPath *indexPath = [NSIndexPath indexPathForRow: i inSection: 0];
//        //
//        //            UITableViewCell *cell = [self.upperTableView cellForRowAtIndexPath:indexPath];
//        //
//        //            NSString *dtString, *conString;
//        //
//        //            for (UIView *view in cell.contentView.subviews)
//        //            {
//        //                if ([view isKindOfClass:[UITextField class]])
//        //                {
//        //                    UITextField* txtField = (UITextField *)view;
//        //
//        //                    if (txtField.tag == 002)
//        //                    {
//        //                        //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
//        //                        dtString = txtField.text;
//        //                    }
//        //
//        //                    if (txtField.tag == 007)
//        //                    {
//        //                        //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
//        //                        conString = txtField.text;
//        //                    }
//        //                }
//        //            }
//        //
//        //            if(self.fromTF.text.length <= 0 || self.toTF.text.length <= 0 ||
//        //               dtString.length <= 0 || conString.length <= 0)
//        //            {
//        //                [[[UIAlertView alloc] initWithTitle:nil message:@"Enter all the fields" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
//        //
//        //                return;
//        //            }
//        //
//        //            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
//        //            //@{@"from":self.fromTF.text,@"to":self.toTF.text,@"date":dtString,@"con":conString};
//        //            [data setObject:self.fromTF.text forKey:@"from"];
//        //            [data setObject:self.toTF.text forKey:@"to"];
//        //            [data setObject:dtString forKey:@"date"];
//        //            [data setObject:conString forKey:@"con"];
//        //            [swtyaJPArray1 addObject:data];
//        //        }
//        //
//        //        //swtyaJPPreArrayI = @[@{@"from":@"a",@"to":@"b",@"date":@"02-02-2016",@"con":@"swtya n baby"}];
//        //
//        //        swtyaJPPreArray = @[@{@"name":self.nameTF.text,@"checklist":cArray,@"itinerary":swtyaJPArray1,@"budget":bArray}];
//        //
//        //        if(self.swtyaPlanIndex == (swtyaJPArray.count - 1))
//        //        {
//        //            [swtyaJPArray removeLastObject];
//        //
//        //            [swtyaJPArray addObject:swtyaJPPreArray];
//        //
//        //            NSArray *swtyaJPPreArrayI27 = @[@{@"from":@"",@"to":@"",@"date":@"",@"con":@""}];
//        //
//        //            NSArray *swtyaJPPreArray27 = @[@{@"name":@"Plan New Journey",@"checklist":swtyaJPPreArrayC,@"itinerary":swtyaJPPreArrayI27,@"budget":swtyaJPPreArrayB}];
//        //
//        //            [swtyaJPArray addObject:swtyaJPPreArray27];
//        //        }
//        //        else
//        //            [swtyaJPArray replaceObjectAtIndex:self.swtyaPlanIndex withObject:swtyaJPPreArray];
//        //
//        //        [self saveArrayToUserDefaults:swtyaJPArray forKey:@"swtyaJPArray"];
//        //
//        //        swtyaJPDict = [NSDictionary dictionaryWithDictionary:[[swtyaJPArray objectAtIndex:self.swtyaPlanIndex] objectAtIndex:0]];
//        //
//        //        NSLog(@"Swtya : %@ ", swtyaJPDict);
//        //
//        //        NSString *name = [NSString stringWithFormat:@"%@", [swtyaJPDict objectForKey:@"name"]];
//        //
//        //        if(![name isEqualToString:@"Plan New Journey"])
//        //            self.nameTF.text = name;
//        //
//        //        iArray = [[NSMutableArray alloc] init];
//        //
//        //        iArray = [[swtyaJPDict objectForKey:@"itinerary"] mutableCopy];
//        //
//        //        [self.bottomTableView reloadData];
    }
    else if(swtya == 3)
    {
//        if(self.nameTF.text.length <= 0)
//        {
//            [[[UIAlertView alloc] initWithTitle:nil message:@"Enter journey name" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
//            
//            return;
//        }
//
        
        NSArray *paths = [self.upperTableViewBug indexPathsForVisibleRows];
        
        for (NSIndexPath *path in paths)
        {
            NSIndexPath *indexPath = path;//[NSIndexPath indexPathForRow:bArray.count - 1 inSection: 0];
            
            UITableViewCell *cell = [self.upperTableViewBug cellForRowAtIndexPath:indexPath];
            
            NSString *dtString, *conString;
            
            for (UIView *view in cell.contentView.subviews)
            {
                if ([view isKindOfClass:[UITextField class]])
                {
                    UITextField* txtField = (UITextField *)view;
                    
                    if (txtField.tag == 200)
                    {
                        //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
                        dtString = txtField.text;
                    }
                    
                    if (txtField.tag == 700)
                    {
                        //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
                        conString = txtField.text;
                    }
                }
            }
            
            if(self.fromTF1.text.length <= 0 || self.toTF1.text.length <= 0 ||
               dtString.length <= 0 || conString.length <= 0)
            {
                [[[UIAlertView alloc] initWithTitle:nil message:@"Enter all the fields" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
                
                return;
            }
            else if(![self isNumeric:dtString])
            {
                [[[UIAlertView alloc] initWithTitle:nil message:@"Enter valid cost" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
                
                return;
            }
            
            swtyaJPDict2 = [NSDictionary dictionaryWithDictionary:[bArray objectAtIndex:indexPath.row]];
            
            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
            [data setObject:self.fromTF.text forKey:@"from"];
            [data setObject:self.toTF.text forKey:@"to"];
            [data setObject:conString forKey:@"item"];
            [data setObject:dtString forKey:@"cost"];
            [swtyaJPPreArrayB replaceObjectAtIndex:indexPath.row withObject:data];
            [bArray replaceObjectAtIndex:indexPath.row withObject:data];
        }
        
        
        NSArray *swtyaJPPreArray = [[NSArray alloc] init];
        
        swtyaJPPreArray = @[@{@"name":self.swtyaPlanName,@"checklist":cArray,@"itinerary":iArray,@"budget":bArray}];
        
        [swtyaJPArray replaceObjectAtIndex:self.swtyaPlanIndex withObject:swtyaJPPreArray];
        
        [self saveArrayToUserDefaults:swtyaJPArray forKey:@"swtyaJPArray"];
        
        [self.upperTableViewBug reloadData];
//        //[self.bottomTableViewBug reloadData];
//        
//        //        NSArray *swtyaJPPreArray = [[NSArray alloc] init];
//        //
//        //        NSMutableArray *swtyaJPArray1 = [[NSMutableArray alloc] init];
//        //
//        //        //    if(swtyaJPArray1.count > 0)
//        //        //        swtyaJPArray = swtyaJPArray1;
//        //        //    else
//        //        //        [swtyaJPArray addObject:swtyaJPPreArray];
//        //
//        //        for (int i = 0; i < swtyaJPPreArrayB.count; i++)
//        //        {
//        //            NSIndexPath *indexPath = [NSIndexPath indexPathForRow: i inSection: 0];
//        //
//        //            UITableViewCell *cell = [self.upperTableViewBug cellForRowAtIndexPath:indexPath];
//        //
//        //            NSString *dtString, *conString;
//        //
//        //            for (UIView *view in cell.contentView.subviews)
//        //            {
//        //                if ([view isKindOfClass:[UITextField class]])
//        //                {
//        //                    UITextField* txtField = (UITextField *)view;
//        //
//        //                    if (txtField.tag == 200)
//        //                    {
//        //                        //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
//        //                        dtString = txtField.text;
//        //                    }
//        //
//        //                    if (txtField.tag == 700)
//        //                    {
//        //                        //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
//        //                        conString = txtField.text;
//        //                    }
//        //                }
//        //            }
//        //
//        //            if(self.fromTF1.text.length <= 0 || self.toTF1.text.length <= 0 ||
//        //               dtString.length <= 0 || conString.length <= 0)
//        //            {
//        //                [[[UIAlertView alloc] initWithTitle:nil message:@"Enter all the fields" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
//        //
//        //                return;
//        //            }
//        //
//        //            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
//        //            [data setObject:dtString forKey:@"item"];
//        //            [data setObject:conString forKey:@"cost"];
//        //            [swtyaJPArray1 addObject:data];
//        //        }
//        //
//        //        //swtyaJPPreArrayI = @[@{@"from":@"a",@"to":@"b",@"date":@"02-02-2016",@"con":@"swtya n baby"}];
//        //
//        //        swtyaJPPreArray = @[@{@"name":self.nameTF.text,@"checklist":cArray,@"itinerary":iArray,@"budget":swtyaJPArray1}];
//        //
//        //        if(self.swtyaPlanIndex == (swtyaJPArray.count - 1))
//        //        {
//        //            [swtyaJPArray removeLastObject];
//        //
//        //            [swtyaJPArray addObject:swtyaJPPreArray];
//        //
//        //            NSArray *swtyaJPPreArrayI27 = @[@{@"item":@"",@"cost":@""}];
//        //
//        //            NSArray *swtyaJPPreArray27 = @[@{@"name":@"Plan New Journey",@"checklist":swtyaJPPreArrayC,@"itinerary":swtyaJPPreArrayI,@"budget":swtyaJPPreArrayI27}];
//        //
//        //            [swtyaJPArray addObject:swtyaJPPreArray27];
//        //        }
//        //        else
//        //            [swtyaJPArray replaceObjectAtIndex:self.swtyaPlanIndex withObject:swtyaJPPreArray];
//        //
//        //        [self saveArrayToUserDefaults:swtyaJPArray forKey:@"swtyaJPArray"];
//        //
//        //        swtyaJPDict1 = [NSDictionary dictionaryWithDictionary:[[swtyaJPArray objectAtIndex:self.swtyaPlanIndex] objectAtIndex:0]];
//        //
//        //        NSLog(@"Swtya : %@ ", swtyaJPDict1);
//        //
//        //        NSString *name = [NSString stringWithFormat:@"%@", [swtyaJPDict1 objectForKey:@"name"]];
//        //
//        //        if(![name isEqualToString:@"Plan New Journey"])
//        //            self.nameTF.text = name;
//        //
//        //        bArray = [[NSMutableArray alloc] init];
//        //
//        //        bArray = [[swtyaJPDict1 objectForKey:@"budget"] mutableCopy];
//        //
//        //        [self.bottomTableViewBug reloadData];
    }
    else
    {
        NSArray *paths = [self.upperTableViewChk indexPathsForVisibleRows];
        
        for (NSIndexPath *path in paths)
        {
            NSIndexPath *indexPath = path;//[NSIndexPath indexPathForRow:cArray.count - 1 inSection: 0];
            
            UITableViewCell *cell = [self.upperTableViewChk cellForRowAtIndexPath:indexPath];
            
            NSString *conString;
            
            for (UIView *view in cell.contentView.subviews)
            {
                if ([view isKindOfClass:[UITextField class]])
                {
                    UITextField* txtField = (UITextField *)view;
                    
                    if (txtField.tag == 2)
                    {
                        //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
                        conString = txtField.text;
                    }
                }
            }
            
            if(conString.length <= 0)
            {
                [[[UIAlertView alloc] initWithTitle:nil message:@"Enter checklist" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
                
                return;
            }
            
            swtyaJPDict2 = [NSDictionary dictionaryWithDictionary:[cArray objectAtIndex:indexPath.row]];
            
            NSString *isChkVal = [swtyaJPDict2 objectForKey:@"isChk"];
            //NSString *chkCon = [swtyaJPDict2 objectForKey:@"chkCon"];
            
            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
            [data setObject:isChkVal forKey:@"isChk"];
            [data setObject:conString forKey:@"chkCon"];
            [swtyaJPPreArrayC replaceObjectAtIndex:indexPath.row withObject:data];
            [cArray replaceObjectAtIndex:indexPath.row withObject:data];
        }
        
        NSArray *swtyaJPPreArray = [[NSArray alloc] init];
        
        swtyaJPPreArray = @[@{@"name":self.swtyaPlanName,@"checklist":cArray,@"itinerary":iArray,@"budget":bArray}];
        
        [swtyaJPArray replaceObjectAtIndex:self.swtyaPlanIndex withObject:swtyaJPPreArray];
        
        [self saveArrayToUserDefaults:swtyaJPArray forKey:@"swtyaJPArray"];
        
        [self.upperTableViewChk reloadData];
        //[self.bottomTableViewChk reloadData];
        
        //        NSArray *swtyaJPPreArray = [[NSArray alloc] init];
        //
        //        NSMutableArray *swtyaJPArray1 = [[NSMutableArray alloc] init];
        //
        //        //[cArray removeLastObject];
        //
        ////        if(cArray.count > 1)
        ////        {
        ////            swtyaJPArray1 = cArray;
        ////
        ////            [swtyaJPArray1 removeLastObject];
        ////        }
        //
        //        NSLog(@"Swtya : %@", cArray);
        //
        //        for (int i = swtyaJPPreArrayC.count - 1; i < swtyaJPPreArrayC.count; i++)
        //        {
        //            NSIndexPath *indexPath = [NSIndexPath indexPathForRow: i inSection: 0];
        //
        //            UITableViewCell *cell = [self.upperTableViewChk cellForRowAtIndexPath:indexPath];
        //
        //            //static NSString *cellIdentifier = @"JPChkUpperCell";
        //
        //            //JPChkUpperCell *cell = (JPChkUpperCell *)[self.upperTableViewChk dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        //
        //            NSString *conString;
        //
        ////            UITextField *mTextField = (UITextField *) [cell viewWithTag:2];
        ////
        ////            conString = mTextField.text;
        //
        ////            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        ////            CustomCell *cell = (CustomCell *)[tableView cellForRowAtIndexPath:indexPath]; // Add This instead
        ////            NSString *userpassword = cell.textfield.text;
        //
        //            for (UIView *view in cell.contentView.subviews)
        //            {
        //                if ([view isKindOfClass:[UITextField class]])
        //                {
        //                    UITextField* txtField = (UITextField *)view;
        //
        //                    if (txtField.tag == 2)
        //                    {
        //                        //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
        //                        conString = txtField.text;
        //                    }
        //                }
        //            }
        //
        //            //            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        //            //            [data setObject:dtString forKey:@"isChk"];
        //            //            [data setObject:conString forKey:@"chkCon"];
        //            //            [swtyaJPArray1 addObject:data];
        //
        //            if(conString.length <= 0)
        //            {
        //                [[[UIAlertView alloc] initWithTitle:nil message:@"Enter checklist" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
        //
        //                return;
        //            }
        //
        //            swtyaJPDict2 = [NSDictionary dictionaryWithDictionary:[cArray objectAtIndex:i]];
        //
        //            NSString *isChkVal = [swtyaJPDict2 objectForKey:@"isChk"];
        //            NSString *chkCon = [swtyaJPDict2 objectForKey:@"chkCon"];
        //
        //            NSMutableDictionary *data1 = [[NSMutableDictionary alloc] init];
        //            [data1 setObject:isChkVal forKey:@"isChk"];
        //            [data1 setObject:conString forKey:@"chkCon"];
        //            [swtyaJPArray1 addObject:data1];
        //        }
        //        
        //        NSLog(@"Swtya : 002 : %@", swtyaJPArray1);
        //        
        //        //swtyaJPPreArrayI = @[@{@"from":@"a",@"to":@"b",@"date":@"02-02-2016",@"con":@"swtya n baby"}];
        //        
        //        swtyaJPPreArray = @[@{@"name":self.nameTF.text,@"checklist":swtyaJPArray1,@"itinerary":iArray,@"budget":bArray}];
        //        
        //        if(self.swtyaPlanIndex == (swtyaJPArray.count - 1))
        //        {
        //            [swtyaJPArray removeLastObject];
        //            
        //            [swtyaJPArray addObject:swtyaJPPreArray];
        //            
        //            //NSArray *swtyaJPPreArrayI27 = @[@{@"isChk":@"0",@"to":@"",@"date":@"",@"con":@""}];
        //            
        //            NSArray *swtyaJPPreArray27 = @[@{@"name":@"Plan New Journey",@"checklist":swtyaJPPreArrayC,@"itinerary":swtyaJPPreArrayI,@"budget":swtyaJPPreArrayB}];
        //            
        //            [swtyaJPArray addObject:swtyaJPPreArray27];
        //        }
        //        else
        //            [swtyaJPArray replaceObjectAtIndex:self.swtyaPlanIndex withObject:swtyaJPPreArray];
        //        
        //        [self saveArrayToUserDefaults:swtyaJPArray forKey:@"swtyaJPArray"];
        //        
        //        swtyaJPDict2 = [NSDictionary dictionaryWithDictionary:[[swtyaJPArray objectAtIndex:self.swtyaPlanIndex] objectAtIndex:0]];
        //        
        //        NSLog(@"Swtya : %@ ", swtyaJPDict2);
        //        
        //        NSString *name = [NSString stringWithFormat:@"%@", [swtyaJPDict2 objectForKey:@"name"]];
        //        
        //        if(![name isEqualToString:@"Plan New Journey"])
        //            self.nameTF.text = name;
        //        
        //        cArray = [[NSMutableArray alloc] init];
        //        
        //        cArray = [[swtyaJPDict2 objectForKey:@"checklist"] mutableCopy];
        //        
        //        [self.bottomTableViewChk reloadData];
    }
    
    [[[UIAlertView alloc] initWithTitle:nil message:@"Data saved successfully" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
}
//{
//    if(swtya == 2)
//    {
//        if(self.nameTF.text.length <= 0)
//        {
//            [[[UIAlertView alloc] initWithTitle:nil message:@"Enter journey name" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
//            
//            return;
//        }
//        
//        NSArray *swtyaJPPreArray = [[NSArray alloc] init];
//        
//        NSMutableArray *swtyaJPArray1 = [[NSMutableArray alloc] init];
//        
//        //    if(swtyaJPArray1.count > 0)
//        //        swtyaJPArray = swtyaJPArray1;
//        //    else
//        //        [swtyaJPArray addObject:swtyaJPPreArray];
//        
//        for (int i = 0; i < swtyaJPPreArrayI.count; i++)
//        {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow: i inSection: 0];
//            
//            UITableViewCell *cell = [self.upperTableView cellForRowAtIndexPath:indexPath];
//            
//            NSString *dtString, *conString;
//            
//            for (UIView *view in cell.contentView.subviews)
//            {
//                if ([view isKindOfClass:[UITextField class]])
//                {
//                    UITextField* txtField = (UITextField *)view;
//                    
//                    if (txtField.tag == 002)
//                    {
//                        //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
//                        dtString = txtField.text;
//                    }
//                    
//                    if (txtField.tag == 007)
//                    {
//                        //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
//                        conString = txtField.text;
//                    }
//                }
//            }
//            
//            if(self.fromTF.text.length <= 0 || self.toTF.text.length <= 0 ||
//               dtString.length <= 0 || conString.length <= 0)
//            {
//                [[[UIAlertView alloc] initWithTitle:nil message:@"Enter all the fields" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
//                
//                return;
//            }
//            
//            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
//            //@{@"from":self.fromTF.text,@"to":self.toTF.text,@"date":dtString,@"con":conString};
//            [data setObject:self.fromTF.text forKey:@"from"];
//            [data setObject:self.toTF.text forKey:@"to"];
//            [data setObject:dtString forKey:@"date"];
//            [data setObject:conString forKey:@"con"];
//            [swtyaJPArray1 addObject:data];
//        }
//        
//        //swtyaJPPreArrayI = @[@{@"from":@"a",@"to":@"b",@"date":@"02-02-2016",@"con":@"swtya n baby"}];
//        
//        swtyaJPPreArray = @[@{@"name":self.nameTF.text,@"checklist":cArray,@"itinerary":swtyaJPArray1,@"budget":bArray}];
//        
//        if(self.swtyaPlanIndex == (swtyaJPArray.count - 1))
//        {
//            [swtyaJPArray removeLastObject];
//            
//            [swtyaJPArray addObject:swtyaJPPreArray];
//            
//            NSArray *swtyaJPPreArrayI27 = @[@{@"from":@"",@"to":@"",@"date":@"",@"con":@""}];
//            
//            NSArray *swtyaJPPreArray27 = @[@{@"name":@"Plan New Journey",@"checklist":swtyaJPPreArrayC,@"itinerary":swtyaJPPreArrayI27,@"budget":swtyaJPPreArrayB}];
//            
//            [swtyaJPArray addObject:swtyaJPPreArray27];
//        }
//        else
//            [swtyaJPArray replaceObjectAtIndex:self.swtyaPlanIndex withObject:swtyaJPPreArray];
//        
//        [self saveArrayToUserDefaults:swtyaJPArray forKey:@"swtyaJPArray"];
//        
//        swtyaJPDict = [NSDictionary dictionaryWithDictionary:[[swtyaJPArray objectAtIndex:self.swtyaPlanIndex] objectAtIndex:0]];
//        
//        NSLog(@"Swtya : %@ ", swtyaJPDict);
//        
//        NSString *name = [NSString stringWithFormat:@"%@", [swtyaJPDict objectForKey:@"name"]];
//        
//        if(![name isEqualToString:@"Plan New Journey"])
//            self.nameTF.text = name;
//        
//        iArray = [[NSMutableArray alloc] init];
//        
//        iArray = [[swtyaJPDict objectForKey:@"itinerary"] mutableCopy];
//        
//        [self.bottomTableView reloadData];
//    }
//    else if(swtya == 3)
//    {
//        if(self.nameTF.text.length <= 0)
//        {
//            [[[UIAlertView alloc] initWithTitle:nil message:@"Enter journey name" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
//            
//            return;
//        }
//        
//        NSArray *swtyaJPPreArray = [[NSArray alloc] init];
//        
//        NSMutableArray *swtyaJPArray1 = [[NSMutableArray alloc] init];
//        
//        //    if(swtyaJPArray1.count > 0)
//        //        swtyaJPArray = swtyaJPArray1;
//        //    else
//        //        [swtyaJPArray addObject:swtyaJPPreArray];
//        
//        for (int i = 0; i < swtyaJPPreArrayB.count; i++)
//        {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow: i inSection: 0];
//            
//            UITableViewCell *cell = [self.upperTableViewBug cellForRowAtIndexPath:indexPath];
//            
//            NSString *dtString, *conString;
//            
//            for (UIView *view in cell.contentView.subviews)
//            {
//                if ([view isKindOfClass:[UITextField class]])
//                {
//                    UITextField* txtField = (UITextField *)view;
//                    
//                    if (txtField.tag == 200)
//                    {
//                        //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
//                        dtString = txtField.text;
//                    }
//                    
//                    if (txtField.tag == 700)
//                    {
//                        //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
//                        conString = txtField.text;
//                    }
//                }
//            }
//            
//            if(self.fromTF1.text.length <= 0 || self.toTF1.text.length <= 0 ||
//               dtString.length <= 0 || conString.length <= 0)
//            {
//                [[[UIAlertView alloc] initWithTitle:nil message:@"Enter all the fields" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
//                
//                return;
//            }
//            
//            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
//            [data setObject:dtString forKey:@"item"];
//            [data setObject:conString forKey:@"cost"];
//            [swtyaJPArray1 addObject:data];
//        }
//        
//        //swtyaJPPreArrayI = @[@{@"from":@"a",@"to":@"b",@"date":@"02-02-2016",@"con":@"swtya n baby"}];
//        
//        swtyaJPPreArray = @[@{@"name":self.nameTF.text,@"checklist":cArray,@"itinerary":iArray,@"budget":swtyaJPArray1}];
//        
//        if(self.swtyaPlanIndex == (swtyaJPArray.count - 1))
//        {
//            [swtyaJPArray removeLastObject];
//            
//            [swtyaJPArray addObject:swtyaJPPreArray];
//            
//            NSArray *swtyaJPPreArrayI27 = @[@{@"item":@"",@"cost":@""}];
//            
//            NSArray *swtyaJPPreArray27 = @[@{@"name":@"Plan New Journey",@"checklist":swtyaJPPreArrayC,@"itinerary":swtyaJPPreArrayI,@"budget":swtyaJPPreArrayI27}];
//            
//            [swtyaJPArray addObject:swtyaJPPreArray27];
//        }
//        else
//            [swtyaJPArray replaceObjectAtIndex:self.swtyaPlanIndex withObject:swtyaJPPreArray];
//        
//        [self saveArrayToUserDefaults:swtyaJPArray forKey:@"swtyaJPArray"];
//        
//        swtyaJPDict1 = [NSDictionary dictionaryWithDictionary:[[swtyaJPArray objectAtIndex:self.swtyaPlanIndex] objectAtIndex:0]];
//        
//        NSLog(@"Swtya : %@ ", swtyaJPDict1);
//        
//        NSString *name = [NSString stringWithFormat:@"%@", [swtyaJPDict1 objectForKey:@"name"]];
//        
//        if(![name isEqualToString:@"Plan New Journey"])
//            self.nameTF.text = name;
//        
//        bArray = [[NSMutableArray alloc] init];
//        
//        bArray = [[swtyaJPDict1 objectForKey:@"budget"] mutableCopy];
//        
//        [self.bottomTableViewBug reloadData];
//    }
//    else
//    {
//        NSArray *swtyaJPPreArray = [[NSArray alloc] init];
//        
//        NSMutableArray *swtyaJPArray1 = [[NSMutableArray alloc] init];
//        
//        for (int i = 0; i < swtyaJPPreArrayC.count; i++)
//        {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow: i inSection: 0];
//            
//            UITableViewCell *cell = [self.upperTableViewChk cellForRowAtIndexPath:indexPath];
//            
//            NSString *conString;
//            
//            for (UIView *view in cell.contentView.subviews)
//            {
//                if ([view isKindOfClass:[UITextField class]])
//                {
//                    UITextField* txtField = (UITextField *)view;
//                    
//                    if (txtField.tag == 2)
//                    {
//                        //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
//                        conString = txtField.text;
//                    }
//                }
//            }
//            
////            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
////            [data setObject:dtString forKey:@"isChk"];
////            [data setObject:conString forKey:@"chkCon"];
////            [swtyaJPArray1 addObject:data];
//            
//            if(conString.length <= 0)
//            {
//                [[[UIAlertView alloc] initWithTitle:nil message:@"Enter checklist" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
//                
//                return;
//            }
//            
//            swtyaJPDict2 = [NSDictionary dictionaryWithDictionary:[cArray objectAtIndex:i]];
//            
//            NSString *isChkVal = [swtyaJPDict2 objectForKey:@"isChk"];
//            NSString *chkCon = [swtyaJPDict2 objectForKey:@"chkCon"];
//            
//            NSMutableDictionary *data1 = [[NSMutableDictionary alloc] init];
//            [data1 setObject:isChkVal forKey:@"isChk"];
//            [data1 setObject:conString forKey:@"chkCon"];
//            [swtyaJPArray1 addObject:data1];
//        }
//        
//        //swtyaJPPreArrayI = @[@{@"from":@"a",@"to":@"b",@"date":@"02-02-2016",@"con":@"swtya n baby"}];
//        
//        swtyaJPPreArray = @[@{@"name":self.nameTF.text,@"checklist":swtyaJPArray1,@"itinerary":iArray,@"budget":bArray}];
//        
//        if(self.swtyaPlanIndex == (swtyaJPArray.count - 1))
//        {
//            [swtyaJPArray removeLastObject];
//            
//            [swtyaJPArray addObject:swtyaJPPreArray];
//            
//            //NSArray *swtyaJPPreArrayI27 = @[@{@"isChk":@"0",@"to":@"",@"date":@"",@"con":@""}];
//            
//            NSArray *swtyaJPPreArray27 = @[@{@"name":@"Plan New Journey",@"checklist":swtyaJPPreArrayC,@"itinerary":swtyaJPPreArrayI,@"budget":swtyaJPPreArrayB}];
//            
//            [swtyaJPArray addObject:swtyaJPPreArray27];
//        }
//        else
//            [swtyaJPArray replaceObjectAtIndex:self.swtyaPlanIndex withObject:swtyaJPPreArray];
//        
//        [self saveArrayToUserDefaults:swtyaJPArray forKey:@"swtyaJPArray"];
//        
//        swtyaJPDict2 = [NSDictionary dictionaryWithDictionary:[[swtyaJPArray objectAtIndex:self.swtyaPlanIndex] objectAtIndex:0]];
//        
//        NSLog(@"Swtya : %@ ", swtyaJPDict2);
//        
//        NSString *name = [NSString stringWithFormat:@"%@", [swtyaJPDict2 objectForKey:@"name"]];
//        
//        if(![name isEqualToString:@"Plan New Journey"])
//            self.nameTF.text = name;
//        
//        cArray = [[NSMutableArray alloc] init];
//        
//        cArray = [[swtyaJPDict2 objectForKey:@"checklist"] mutableCopy];
//        
//        [self.bottomTableViewChk reloadData];
//    }
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    screenBounds = [[UIScreen mainScreen] bounds];
    
    swtya = 1;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    self.swtyaChkConTF1.delegate = self;
    self.swtyaDateTF1.delegate = self;
    self.swtyaLocationTF.delegate = self;
    
    self.swtyaTF123.delegate = self;
    self.swtyaTF456.delegate = self;
    
    _swtyaChkConTF1.layer.borderWidth = 2.0;
    
    _swtyaTF123.layer.borderWidth = 2.0;
    _swtyaTF456.layer.borderWidth = 2.0;
    
    _upperView.layer.borderWidth = 2.0;
    _bottomView.layer.borderWidth = 2.0;
    _upperViewChk.layer.borderWidth = 2.0;
    _bottomViewChk.layer.borderWidth = 2.0;
    
    _upperViewBug.layer.borderWidth = 2.0;
    _bottomViewBug.layer.borderWidth = 2.0;
    
    _alabel.layer.borderWidth = 2.0;
    _blabel.layer.borderWidth = 2.0;
    
    _clabel.layer.borderWidth = 2.0;
    _dlabel.layer.borderWidth = 2.0;
    
    _dtL.layer.borderWidth = 2.0;
    _locL.layer.borderWidth = 2.0;
    
    _swtyaDateTF1.layer.borderWidth = 2.0;
    _swtyaLocationTF.layer.borderWidth = 2.0;
    
    _fromLabel.layer.borderWidth = 2.0;
    _fromTF.layer.borderWidth = 2.0;
    
    _toLabel.layer.borderWidth = 2.0;
    _toTF.layer.borderWidth = 2.0;
    
    _saveBtn.layer.borderWidth = 2.0;
    _saveBtn1.layer.borderWidth = 2.0;
    _saveBtn2.layer.borderWidth = 2.0;
    
    self.nameTF.delegate = self;
    self.fromTF.delegate = self;
    self.toTF.delegate = self;
    
    _nameLabel1.layer.borderWidth = 2.0;
    _nameTF1.layer.borderWidth = 2.0;
    
    _fromLabel1.layer.borderWidth = 2.0;
    _fromTF1.layer.borderWidth = 2.0;
    
    _toLabel1.layer.borderWidth = 2.0;
    _toTF1.layer.borderWidth = 2.0;
    
    _saveBtn.layer.borderWidth = 2.0;
    
    _itemLabel.layer.borderWidth = 2.0;
    _costLabel.layer.borderWidth = 2.0;
    _plusLabel.layer.borderWidth = 2.0;
    
    self.nameTF.delegate = self;
    self.fromTF.delegate = self;
    self.toTF.delegate = self;
    
    self.nameTF1.delegate = self;
    self.fromTF1.delegate = self;
    self.toTF1.delegate = self;
    
    self.nameTF1.enabled = NO;
    self.nameTF.enabled = NO;
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    
    datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(datePickerValueChanged1:) forControlEvents:UIControlEventValueChanged]; // method to respond to changes in the picker value
    
    // Setup UIToolbar for UIDatePicker
    datePickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    [datePickerToolbar setBarStyle:UIBarStyleBlackTranslucent];
    UIBarButtonItem *extraSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissPicker:)]; // method to dismiss the picker when the "Done" button is pressed
    
    doneButton.tag = 7777;
    datePicker.tag = 7777;
    
    [datePickerToolbar setItems:[[NSArray alloc] initWithObjects: extraSpace, doneButton, nil]];
    self.swtyaDateTF1.inputView = datePicker;
    // Set UITextfield's inputAccessoryView as UIToolbar
    self.swtyaDateTF1.inputAccessoryView = datePickerToolbar;
    
    NSString *homeXIB, *homeXIB1, *homeXIB2, *homeXIB3, *homeXIB4, *homeXIB5;
    
    if (screenBounds.size.height == 667)
    {
        homeXIB = @"JPChkUpperCell";
        homeXIB1 = @"JPChkBottomCell";
        homeXIB2 = @"JPItineraryCell";
        homeXIB3 = @"JPBudgetUpperCell";
        homeXIB4 = @"JPBudgetBottomCell";
        homeXIB5 = @"JPItineraryBottomCell";
    }
    else if(screenBounds.size.height == 1024)
    {
        homeXIB = @"JPChkUpperCell ipad";
        homeXIB1 = @"JPChkBottomCell ipad";
        homeXIB2 = @"JPItineraryCell ipad";
        homeXIB3 = @"JPBudgetUpperCell ipad";
        homeXIB4 = @"JPBudgetBottomCell ipad";
        homeXIB5 = @"JPItineraryBottomCell ipad";
    }
    else if(screenBounds.size.height == 568)
    {
        homeXIB = @"JPChkUpperCell 320";
        homeXIB1 = @"JPChkBottomCell";
        homeXIB2 = @"JPItineraryCell 320";
        homeXIB3 = @"JPBudgetUpperCell 320";
        homeXIB4 = @"JPBudgetBottomCell";
        homeXIB5 = @"JPItineraryBottomCell";
    }
    else if(screenBounds.size.height == 480)
    {
        homeXIB = @"JPChkUpperCell 320";
        homeXIB1 = @"JPChkBottomCell";
        homeXIB2 = @"JPItineraryCell 320";
        homeXIB3 = @"JPBudgetUpperCell 320";
        homeXIB4 = @"JPBudgetBottomCell";
        homeXIB5 = @"JPItineraryBottomCell";
    }
    else if(screenBounds.size.height == 736)
    {
        homeXIB = @"JPChkUpperCell 414";
        homeXIB1 = @"JPChkBottomCell";
        homeXIB2 = @"JPItineraryCell 414";
        homeXIB3 = @"JPBudgetUpperCell 414";
        homeXIB4 = @"JPBudgetBottomCell";
        homeXIB5 = @"JPItineraryBottomCell";
    }
    
    [self.upperTableViewChk registerNib:[UINib nibWithNibName:homeXIB bundle:nil] forCellReuseIdentifier:@"JPChkUpperCell"];
    
    //[self.bottomTableViewChk registerNib:[UINib nibWithNibName:homeXIB1 bundle:nil] forCellReuseIdentifier:@"JPChkBottomCell"];
    
    [self.upperTableView registerNib:[UINib nibWithNibName:homeXIB2 bundle:nil] forCellReuseIdentifier:@"JPItineraryCell"];
    
    [self.upperTableViewBug registerNib:[UINib nibWithNibName:homeXIB3 bundle:nil] forCellReuseIdentifier:@"JPBudgetUpperCell"];
    
    //[self.bottomTableViewBug registerNib:[UINib nibWithNibName:homeXIB4 bundle:nil] forCellReuseIdentifier:@"JPBudgetBottomCell"];
    
    //[self.bottomTableView registerNib:[UINib nibWithNibName:homeXIB5 bundle:nil] forCellReuseIdentifier:@"JPItineraryBottomCell"];
    
    //swtyaJPPreArrayI = @[@{@"from":@"",@"to":@"",@"date":@"",@"con":@""}];
    
    swtyaJPPreArrayI = [[NSMutableArray alloc] init];
    swtyaJPPreArrayC = [[NSMutableArray alloc] init];
    
//    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
//    //@{@"from":self.fromTF.text,@"to":self.toTF.text,@"date":dtString,@"con":conString};
//    [data setObject:@"" forKey:@"from"];
//    [data setObject:@"" forKey:@"to"];
//    [data setObject:@"" forKey:@"date"];
//    [data setObject:@"" forKey:@"con"];
//    [swtyaJPPreArrayI addObject:data];
    
//    NSMutableDictionary *data1 = [[NSMutableDictionary alloc] init];
//    [data1 setObject:@"0" forKey:@"isChk"];
//    [data1 setObject:@"" forKey:@"chkCon"];
//    [swtyaJPPreArrayC addObject:data1];
//    
//    NSMutableDictionary *data2 = [[NSMutableDictionary alloc] init];
//    [data2 setObject:@"" forKey:@"item"];
//    [data2 setObject:@"" forKey:@"cost"];
//    [swtyaJPPreArrayB addObject:data2];
    
    //NSArray *swtyaJPPreArrayB = @[@{@"item":@"",@"cost":@""}];
    
    NSArray *swtyaJPPreArray = @[@{@"name":@"Plan New Journey",@"checklist":@"",@"itinerary":swtyaJPPreArrayI,@"budget":@""}];
    
    swtyaJPArray = [[NSMutableArray alloc] init];
    
    NSMutableArray *swtyaJPArray1 = [self loadArrayFromUserDefaultsForKey:@"swtyaJPArray"];
    
    if(swtyaJPArray1.count > 0)
        swtyaJPArray = swtyaJPArray1;
//    else
//        [swtyaJPArray addObject:swtyaJPPreArray];
    
    //NSLog(@"Swtya : %@ ", swtyaJPArray);
    
    if(swtyaJPArray1.count > 1)
    {
        swtyaJPDict = [NSDictionary dictionaryWithDictionary:[[swtyaJPArray objectAtIndex:self.swtyaPlanIndex] objectAtIndex:0]];
        
        //NSLog(@"Swtya : %@ ", swtyaJPDict);
        
        NSString *name = [NSString stringWithFormat:@"%@", [swtyaJPDict objectForKey:@"name"]];
        
        if(![name isEqualToString:@"Plan New Journey"])
            self.swtyaPlanName = name;
        
        iArray = [[NSMutableArray alloc] init];
        cArray = [[NSMutableArray alloc] init];
        bArray = [[NSMutableArray alloc] init];
        
        iArray = [[swtyaJPDict objectForKey:@"itinerary"] mutableCopy];
        swtyaJPPreArrayI = [[swtyaJPDict objectForKey:@"itinerary"] mutableCopy];
        cArray = [[swtyaJPDict objectForKey:@"checklist"] mutableCopy];
        swtyaJPPreArrayC = [[swtyaJPDict objectForKey:@"checklist"] mutableCopy];
        bArray = [[swtyaJPDict objectForKey:@"budget"] mutableCopy];
        swtyaJPPreArrayB = [[swtyaJPDict objectForKey:@"budget"] mutableCopy];
        //[cArray addObject:data1];
        
        if(cArray.count > 0)
        {
            NSDictionary *swtyaJPDict2Temp = [NSDictionary dictionaryWithDictionary:[cArray objectAtIndex:0]];
            
            NSString *chkVal12 = [swtyaJPDict2Temp objectForKey:@"chkCon"];
            
            if(chkVal12.length <= 0)
            {
                [cArray removeObjectAtIndex:0];
                //swtyaJPDict2 = [[NSDictionary init] alloc];
            }
            else
                swtyaJPDict2 = [NSDictionary dictionaryWithDictionary:[cArray objectAtIndex:0]];
        }
        
        if(bArray.count > 0)
        {
            NSDictionary *swtyaJPDict2Temp = [NSDictionary dictionaryWithDictionary:[bArray objectAtIndex:0]];
            
            NSString *chkVal12 = [swtyaJPDict2Temp objectForKey:@"cost"];
            
            if(chkVal12.length <= 0)
            {
                [bArray removeObjectAtIndex:0];
                //swtyaJPDict2 = [[NSDictionary init] alloc];
            }
            else
                swtyaJPDict3 = [NSDictionary dictionaryWithDictionary:[bArray objectAtIndex:0]];
        }
        
        if(iArray.count > 0)
        {
            NSDictionary *swtyaJPDict1Temp = [NSDictionary dictionaryWithDictionary:[iArray objectAtIndex:0]];
            
            NSString *chkVal121 = [swtyaJPDict1Temp objectForKey:@"con"];
            
            if(chkVal121.length <= 0)
            {
                [iArray removeObjectAtIndex:0];
                //swtyaJPDict2 = [[NSDictionary init] alloc];
            }
            else
                swtyaJPDict1 = [NSDictionary dictionaryWithDictionary:[iArray objectAtIndex:0]];
        }
        
        self.fromTF.text = [swtyaJPDict1 objectForKey:@"from"];
        self.toTF.text = [swtyaJPDict1 objectForKey:@"to"];
        self.fromTF1.text = [swtyaJPDict1 objectForKey:@"from"];
        self.toTF1.text = [swtyaJPDict1 objectForKey:@"to"];
    }
    else
    {
        iArray = [[NSMutableArray alloc] init];
        cArray = [[NSMutableArray alloc] init];
        bArray = [[NSMutableArray alloc] init];
        
//        swtyaJPDict = [NSDictionary dictionaryWithDictionary:[[swtyaJPArray objectAtIndex:self.swtyaPlanIndex] objectAtIndex:0]];
//        
//        NSLog(@"Swtya : %@ ", swtyaJPDict);
//        
//        NSString *name = [NSString stringWithFormat:@"%@", [swtyaJPDict objectForKey:@"name"]];
//        
//        if(![name isEqualToString:@"Plan New Journey"])
//            self.nameTF.text = name;
//        
//        iArray = [[NSMutableArray alloc] init];
//        cArray = [[NSMutableArray alloc] init];
//        bArray = [[NSMutableArray alloc] init];
//        
//        cArray = [[swtyaJPDict objectForKey:@"checklist"] mutableCopy];
//        swtyaJPDict2 = [NSDictionary dictionaryWithDictionary:[cArray objectAtIndex:0]];
        
        //[iArray addObject:data];
        //[cArray addObject:data1];
        //[bArray addObject:data2];
        [self.upperTableView reloadData];
        [self.upperTableViewChk reloadData];
        [self.upperTableViewBug reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(swtya == 1)
        return cArray.count;
    else if(swtya == 2)
        return iArray.count;
    else
        return bArray.count;
}

- (bool)isNumeric:(NSString*) checkText
{
    return [[NSScanner scannerWithString:checkText] scanFloat:NULL];
}

- (UITableViewCell *)tableView:(UITableView *)localTableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    if(swtya == 2)
    {
        swtyaJPDict1 = [NSDictionary dictionaryWithDictionary:[iArray objectAtIndex:indexPath.row]];
        
        //if(localTableView == self.upperTableView)
        {
            static NSString *cellIdentifier = @"JPItineraryCell";
            
            JPItineraryCell *cell = (JPItineraryCell *)[self.upperTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            
            cell.swtyaConTF.delegate = self;
            cell.swtyaDateTF.delegate = self;
            
            cell.swtyaConTF.tag = 007;
            cell.swtyaDateTF.tag = 002;
            
            //UIDatePicker *yourdatePicker = [[UIDatePicker alloc]init];
            //cell.swtyaDateTF.inputView = yourdatePicker;
            
            cell.swtyaDateTF.text = [swtyaJPDict1 objectForKey:@"date"];
            cell.swtyaConTF.text = [swtyaJPDict1 objectForKey:@"con"];
            
            datePicker = [[UIDatePicker alloc] init];
            datePicker.tag = indexPath.row;
            datePicker.datePickerMode = UIDatePickerModeDate;
            [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged]; // method to respond to changes in the picker value
            
            // Setup UIToolbar for UIDatePicker
            datePickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
            [datePickerToolbar setBarStyle:UIBarStyleBlackTranslucent];
            UIBarButtonItem *extraSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissPicker:)]; // method to dismiss the picker when the "Done" button is pressed
            
            doneButton.tag = indexPath.row;
            [datePickerToolbar setItems:[[NSArray alloc] initWithObjects: extraSpace, doneButton, nil]];
            
            
            // Note: If you're using dynamic cells, the below 2 lines need to be in your cellForRowAtIndexPath method instead.
            
            // Set UITextfield's inputView as UIDatePicker
            cell.swtyaDateTF.inputView = datePicker;
            // Set UITextfield's inputAccessoryView as UIToolbar
            cell.swtyaDateTF.inputAccessoryView = datePickerToolbar;
            
            return cell;
        }
//        else
//        {
//            static NSString *cellIdentifier = @"JPItineraryBottomCell";
//            
//            JPItineraryBottomCell *cell = (JPItineraryBottomCell *)[self.bottomTableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
//            
//            NSString *date, *con;
//            
//            cell.swtyaDateLabel.text = date = [swtyaJPDict1 objectForKey:@"date"];
//            cell.swtyaConLabel.text = con = [swtyaJPDict1 objectForKey:@"con"];
//            
//            if(date.length <= 0 || con.length <= 0)
//            {
//                cell.swtyaDateLabel.hidden = YES;
//                cell.swtyaConLabel.hidden = YES;
//            }
//            else
//            {
//                cell.swtyaDateLabel.hidden = NO;
//                cell.swtyaConLabel.hidden = NO;
//            }
//            
//            return cell;
//        }
    }
    else if (swtya == 1)
    {
        swtyaJPDict2 = [NSDictionary dictionaryWithDictionary:[cArray objectAtIndex:indexPath.row]];
        
        //if(localTableView == self.upperTableViewChk)
        {
            static NSString *cellIdentifier = @"JPChkUpperCell";
            
            JPChkUpperCell *cell = (JPChkUpperCell *)[self.upperTableViewChk dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            
            cell.swtyaChkConTF.delegate = self;
            
            cell.swtyaChkConTF.tag = 2;
            cell.swtyaChkBtn.tag = indexPath.row;
            
            [cell.swtyaChkBtn addTarget:self action:@selector(swtyaChkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.swtyaChkConTF.text = [swtyaJPDict2 objectForKey:@"chkCon"];
            
            NSString *isChkVal = [swtyaJPDict2 objectForKey:@"isChk"];
            
            if([isChkVal isEqualToString:@"0"])
                [cell.swtyaChkBtn setBackgroundImage:[UIImage imageNamed:@"unchk.png"] forState:UIControlStateNormal];
            else
                [cell.swtyaChkBtn setBackgroundImage:[UIImage imageNamed:@"chked.png"] forState:UIControlStateNormal];
            
            return cell;
        }
//        else
//        {
//            static NSString *cellIdentifier = @"JPChkBottomCell";
//            
//            JPChkBottomCell *cell = (JPChkBottomCell *)[self.bottomTableViewChk dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
//            
//            NSString *con;
//            
//            cell.swtyaChkListLabel.text = con = [swtyaJPDict2 objectForKey:@"chkCon"];
//            
//            if(con.length <= 0)
//            {
//                cell.swtyaChkListLabel.hidden = YES;
//                cell.swtyaChkListChkBtn.hidden = YES;
//            }
//            else
//            {
//                cell.swtyaChkListLabel.hidden = NO;
//                cell.swtyaChkListChkBtn.hidden = NO;
//            }
//            
//            NSString *isChkVal = [swtyaJPDict2 objectForKey:@"isChk"];
//            
//            if([isChkVal isEqualToString:@"0"])
//                [cell.swtyaChkListChkBtn setBackgroundImage:[UIImage imageNamed:@"unchk.png"] forState:UIControlStateNormal];
//            else
//                [cell.swtyaChkListChkBtn setBackgroundImage:[UIImage imageNamed:@"chked.png"] forState:UIControlStateNormal];
//            
//            return cell;
//        }
    }
    else
    {
        swtyaJPDict1 = [NSDictionary dictionaryWithDictionary:[bArray objectAtIndex:indexPath.row]];
        
        //if(localTableView == self.upperTableViewBug)
        {
            static NSString *cellIdentifier = @"JPBudgetUpperCell";
            
            JPBudgetUpperCell *cell = (JPBudgetUpperCell *)[self.upperTableViewBug dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            
            cell.swtyaItemTF.delegate = self;
            cell.swtyaCostTF.delegate = self;
            
            cell.swtyaItemTF.tag = 700;
            cell.swtyaCostTF.tag = 200;
            
            //cell.swtyaPlusBtnBug.tag = indexPath.row;
            
            cell.swtyaItemTF.text = [swtyaJPDict1 objectForKey:@"item"];
            cell.swtyaCostTF.text = [swtyaJPDict1 objectForKey:@"cost"];
            
            [cell.swtyaPlusBtnBug addTarget:self action:@selector(swtyaPluBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }
//        else
//        {
//            static NSString *cellIdentifier = @"JPBudgetBottomCell";
//            
//            JPBudgetBottomCell *cell = (JPBudgetBottomCell *)[self.bottomTableViewBug dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
//            
//            NSString *item, *cost;
//            
//            cell.swtyaItemL.text = item = [swtyaJPDict1 objectForKey:@"item"];
//            cell.swtyaCostL.text = cost = [swtyaJPDict1 objectForKey:@"cost"];
//            
//            if(item.length <= 0 || cost.length <= 0)
//            {
//                cell.swtyaItemL.hidden = YES;
//                cell.swtyaCostL.hidden = YES;
//            }
//            else
//            {
//                cell.swtyaItemL.hidden = NO;
//                cell.swtyaCostL.hidden = NO;
//            }
//            
//            return cell;
//        }
    }
}

- (void)swtyaChkBtnClicked:(UIButton*)sender
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection: 0];
    
    UITableViewCell *cell = [self.upperTableViewChk cellForRowAtIndexPath:indexPath];
    
    NSString *conString;
    
    for (UIView *view in cell.contentView.subviews)
    {
        if ([view isKindOfClass:[UITextField class]])
        {
            UITextField* txtField = (UITextField *)view;
            
            if (txtField.tag == 2)
            {
                //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
                conString = txtField.text;
            }
        }
    }
    
    swtyaJPDict2 = [NSDictionary dictionaryWithDictionary:[cArray objectAtIndex:sender.tag]];
    
    NSString *isChkVal = [swtyaJPDict2 objectForKey:@"isChk"];
    //NSString *chkCon = [swtyaJPDict2 objectForKey:@"chkCon"];
    
    if([isChkVal isEqualToString:@"0"])
        isChkVal = @"1";
    else
        isChkVal = @"0";
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:isChkVal forKey:@"isChk"];
    [data setObject:conString forKey:@"chkCon"];
    [swtyaJPPreArrayC replaceObjectAtIndex:sender.tag withObject:data];
    [cArray replaceObjectAtIndex:sender.tag withObject:data];
    
    [self.upperTableViewChk reloadData];
    //[self.bottomTableViewChk reloadData];
}

- (IBAction)swtyaChksCheckBtnClicked:(id)sender
{
    if(swtyaIsChk)
    {
        swtyaIsChk = 0;
        
        [self.swtyaChkBtn1 setBackgroundImage:[UIImage imageNamed:@"unchk.png"] forState:UIControlStateNormal];
    }
    else
    {
        swtyaIsChk = 1;
        
        [self.swtyaChkBtn1 setBackgroundImage:[UIImage imageNamed:@"chked.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)swtyaChkPluBtnClicked:(id)sender
{
    NSString *conString = self.swtyaChkConTF1.text;
    
    if(conString.length <= 0 || [conString isEqualToString:@"Enter Checklist"])
    {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Enter checklist" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
        
        return;
    }
    
    NSString *isChkVal;
    
    if(swtyaIsChk)
        isChkVal = @"1";
    else
        isChkVal = @"0";
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:isChkVal forKey:@"isChk"];
    [data setObject:conString forKey:@"chkCon"];
    [swtyaJPPreArrayC addObject:data];
    [cArray addObject:data];
    
    NSArray *swtyaJPPreArray = [[NSArray alloc] init];
    
    swtyaJPPreArray = @[@{@"name":self.swtyaPlanName,@"checklist":cArray,@"itinerary":iArray,@"budget":bArray}];
    
    [swtyaJPArray replaceObjectAtIndex:self.swtyaPlanIndex withObject:swtyaJPPreArray];
    
    [self saveArrayToUserDefaults:swtyaJPArray forKey:@"swtyaJPArray"];
    
    [self.upperTableViewChk reloadData];
    
    self.swtyaChkConTF1.text = @"";
    self.swtyaChkConTF1.placeholder = @"Enter Checklist";
    
    swtyaIsChk = 0;
    
    [self.swtyaChkBtn1 setBackgroundImage:[UIImage imageNamed:@"unchk.png"] forState:UIControlStateNormal];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:cArray.count - 1 inSection: 0];
    [self.upperTableViewChk scrollToRowAtIndexPath:indexPath
                                  atScrollPosition:UITableViewScrollPositionTop
                                          animated:YES];
}

- (IBAction)swtyaItiPluBtnClicked:(id)sender
{
    NSString *dtString, *conString;
    
    dtString = self.swtyaDateTF1.text;
    conString = self.swtyaLocationTF.text;
    
    if(self.fromTF.text.length <= 0 || self.toTF.text.length <= 0 ||
       dtString.length <= 0 || conString.length <= 0 ||
       [dtString isEqualToString:@"Select Date"] ||
       [conString isEqualToString:@"Enter Location"])
    {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Enter all the fields" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
        
        return;
    }
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:self.fromTF.text forKey:@"from"];
    [data setObject:self.toTF.text forKey:@"to"];
    [data setObject:dtString forKey:@"date"];
    [data setObject:conString forKey:@"con"];
    [swtyaJPPreArrayI addObject:data];
    [iArray addObject:data];
    
    NSArray *swtyaJPPreArray = [[NSArray alloc] init];
    
    swtyaJPPreArray = @[@{@"name":self.swtyaPlanName,@"checklist":cArray,@"itinerary":iArray,@"budget":bArray}];
    
    [swtyaJPArray replaceObjectAtIndex:self.swtyaPlanIndex withObject:swtyaJPPreArray];
    
    [self saveArrayToUserDefaults:swtyaJPArray forKey:@"swtyaJPArray"];
    
    [self.upperTableView reloadData];
    
    self.swtyaDateTF1.text = @"";
    self.swtyaLocationTF.text = @"";
    
    self.swtyaDateTF1.placeholder = @"Select Date";
    self.swtyaLocationTF.placeholder = @"Enter Location";
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:iArray.count - 1 inSection: 0];
    [self.upperTableView scrollToRowAtIndexPath:indexPath
                                  atScrollPosition:UITableViewScrollPositionTop
                                          animated:YES];
}

- (IBAction)swtyaBudPluBtnClicked:(id)sender
{
    NSString *dtString, *conString;
    
    conString = self.swtyaTF456.text;
    dtString = self.swtyaTF123.text;
    
    if(self.fromTF1.text.length <= 0 || self.toTF1.text.length <= 0 ||
       dtString.length <= 0 || conString.length <= 0 ||
       [dtString isEqualToString:@"Enter Cost"] ||
       [conString isEqualToString:@"Enter Item"])
    {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Enter all the fields" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
        
        return;
    }
    else if(![self isNumeric:dtString])
    {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Enter valid cost" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
        
        return;
    }
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:self.fromTF.text forKey:@"from"];
    [data setObject:self.toTF.text forKey:@"to"];
    [data setObject:conString forKey:@"item"];
    [data setObject:dtString forKey:@"cost"];
    [swtyaJPPreArrayB addObject:data];
    [bArray addObject:data];
    
    NSArray *swtyaJPPreArray = [[NSArray alloc] init];
    
    swtyaJPPreArray = @[@{@"name":self.swtyaPlanName,@"checklist":cArray,@"itinerary":iArray,@"budget":bArray}];
    
    [swtyaJPArray replaceObjectAtIndex:self.swtyaPlanIndex withObject:swtyaJPPreArray];
    
    [self saveArrayToUserDefaults:swtyaJPArray forKey:@"swtyaJPArray"];
    
    [self.upperTableViewBug reloadData];
    
    self.swtyaTF123.text = @"";
    self.swtyaTF456.text = @"";
    
    self.swtyaTF456.placeholder = @"Enter Item";
    self.swtyaTF123.placeholder = @"Enter Cost";
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:bArray.count - 1 inSection: 0];
    [self.upperTableViewBug scrollToRowAtIndexPath:indexPath
                               atScrollPosition:UITableViewScrollPositionTop
                                       animated:YES];
}

- (void)swtyaPluBtnClicked:(UIButton*)sender
{
    if(swtya == 2)
    {
//        if(self.nameTF.text.length <= 0)
//        {
//            [[[UIAlertView alloc] initWithTitle:nil message:@"Enter journey name" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
//            
//            return;
//        }
//        
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection: 0];
//        
//        UITableViewCell *cell = [self.upperTableView cellForRowAtIndexPath:indexPath];
//        
//        NSString *dtString, *conString;
//        
//        for (UIView *view in cell.contentView.subviews)
//        {
//            if ([view isKindOfClass:[UITextField class]])
//            {
//                UITextField* txtField = (UITextField *)view;
//                
//                if (txtField.tag == 002)
//                {
//                    dtString = txtField.text;
//                }
//                
//                if (txtField.tag == 007)
//                {
//                    conString = txtField.text;
//                }
//            }
//        }
//        
////        if(iArray.count > 1)
////        {
////            swtyaJPDict2 = [NSDictionary dictionaryWithDictionary:[iArray objectAtIndex:iArray.count - 2]];
////            
////            NSString *dtVal1 = [swtyaJPDict2 objectForKey:@"date"];
////            NSString *conVal1 = [swtyaJPDict2 objectForKey:@"con"];
////            
////            if(self.fromTF1.text.length <= 0 || self.toTF1.text.length <= 0 ||
////               dtString.length <= 0 || conString.length <= 0
////               || dtVal1.length <= 0 || conVal1.length <= 0)
////            {
////                [[[UIAlertView alloc] initWithTitle:nil message:@"Enter all the fields" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
////                
////                return;
////            }
////        }
////        else
//        {
//            if(self.fromTF.text.length <= 0 || self.toTF.text.length <= 0 ||
//               dtString.length <= 0 || conString.length <= 0)
//            {
//                [[[UIAlertView alloc] initWithTitle:nil message:@"Enter all the fields" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
//                
//                return;
//            }
//        }
//        
//        //        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
//        //        [data setObject:dtString forKey:@"item"];
//        //        [data setObject:conString forKey:@"cost"];
//        //        [swtyaJPArray1 addObject:data];
//        
//        swtyaJPDict2 = [NSDictionary dictionaryWithDictionary:[iArray objectAtIndex:sender.tag]];
//        
//        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
//        [data setObject:self.fromTF.text forKey:@"from"];
//        [data setObject:self.toTF.text forKey:@"to"];
//        [data setObject:dtString forKey:@"date"];
//        [data setObject:conString forKey:@"con"];
//        [swtyaJPPreArrayI replaceObjectAtIndex:sender.tag withObject:data];
//        [iArray replaceObjectAtIndex:sender.tag withObject:data];
//        
//        NSArray *swtyaJPPreArray = [[NSArray alloc] init];
//        
//        swtyaJPPreArray = @[@{@"name":self.nameTF.text,@"checklist":cArray,@"itinerary":iArray,@"budget":bArray}];
//        
//        [swtyaJPArray replaceObjectAtIndex:self.swtyaPlanIndex withObject:swtyaJPPreArray];
//        
//        [self saveArrayToUserDefaults:swtyaJPArray forKey:@"swtyaJPArray"];
//        
//        [self.upperTableView reloadData];
//        [self.bottomTableView reloadData];
        
//        NSArray *swtyaJPPreArray = [[NSArray alloc] init];
//        
//        NSMutableArray *swtyaJPArray1 = [[NSMutableArray alloc] init];
//        
//        //    if(swtyaJPArray1.count > 0)
//        //        swtyaJPArray = swtyaJPArray1;
//        //    else
//        //        [swtyaJPArray addObject:swtyaJPPreArray];
//        
//        for (int i = 0; i < swtyaJPPreArrayI.count; i++)
//        {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow: i inSection: 0];
//            
//            UITableViewCell *cell = [self.upperTableView cellForRowAtIndexPath:indexPath];
//            
//            NSString *dtString, *conString;
//            
//            for (UIView *view in cell.contentView.subviews)
//            {
//                if ([view isKindOfClass:[UITextField class]])
//                {
//                    UITextField* txtField = (UITextField *)view;
//                    
//                    if (txtField.tag == 002)
//                    {
//                        //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
//                        dtString = txtField.text;
//                    }
//                    
//                    if (txtField.tag == 007)
//                    {
//                        //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
//                        conString = txtField.text;
//                    }
//                }
//            }
//            
//            if(self.fromTF.text.length <= 0 || self.toTF.text.length <= 0 ||
//               dtString.length <= 0 || conString.length <= 0)
//            {
//                [[[UIAlertView alloc] initWithTitle:nil message:@"Enter all the fields" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
//                
//                return;
//            }
//            
//            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
//            //@{@"from":self.fromTF.text,@"to":self.toTF.text,@"date":dtString,@"con":conString};
//            [data setObject:self.fromTF.text forKey:@"from"];
//            [data setObject:self.toTF.text forKey:@"to"];
//            [data setObject:dtString forKey:@"date"];
//            [data setObject:conString forKey:@"con"];
//            [swtyaJPArray1 addObject:data];
//        }
//        
//        //swtyaJPPreArrayI = @[@{@"from":@"a",@"to":@"b",@"date":@"02-02-2016",@"con":@"swtya n baby"}];
//        
//        swtyaJPPreArray = @[@{@"name":self.nameTF.text,@"checklist":cArray,@"itinerary":swtyaJPArray1,@"budget":bArray}];
//        
//        if(self.swtyaPlanIndex == (swtyaJPArray.count - 1))
//        {
//            [swtyaJPArray removeLastObject];
//            
//            [swtyaJPArray addObject:swtyaJPPreArray];
//            
//            NSArray *swtyaJPPreArrayI27 = @[@{@"from":@"",@"to":@"",@"date":@"",@"con":@""}];
//            
//            NSArray *swtyaJPPreArray27 = @[@{@"name":@"Plan New Journey",@"checklist":swtyaJPPreArrayC,@"itinerary":swtyaJPPreArrayI27,@"budget":swtyaJPPreArrayB}];
//            
//            [swtyaJPArray addObject:swtyaJPPreArray27];
//        }
//        else
//            [swtyaJPArray replaceObjectAtIndex:self.swtyaPlanIndex withObject:swtyaJPPreArray];
//        
//        [self saveArrayToUserDefaults:swtyaJPArray forKey:@"swtyaJPArray"];
//        
//        swtyaJPDict = [NSDictionary dictionaryWithDictionary:[[swtyaJPArray objectAtIndex:self.swtyaPlanIndex] objectAtIndex:0]];
//        
//        NSLog(@"Swtya : %@ ", swtyaJPDict);
//        
//        NSString *name = [NSString stringWithFormat:@"%@", [swtyaJPDict objectForKey:@"name"]];
//        
//        if(![name isEqualToString:@"Plan New Journey"])
//            self.nameTF.text = name;
//        
//        iArray = [[NSMutableArray alloc] init];
//        
//        iArray = [[swtyaJPDict objectForKey:@"itinerary"] mutableCopy];
//        
//        [self.bottomTableView reloadData];
    }
    else if(swtya == 3)
    {
//        if(self.nameTF.text.length <= 0)
//        {
//            [[[UIAlertView alloc] initWithTitle:nil message:@"Enter journey name" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
//            
//            return;
//        }
//        
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection: 0];
//        
//        UITableViewCell *cell = [self.upperTableViewBug cellForRowAtIndexPath:indexPath];
//        
//        NSString *dtString, *conString;
//        
//        for (UIView *view in cell.contentView.subviews)
//        {
//            if ([view isKindOfClass:[UITextField class]])
//            {
//                UITextField* txtField = (UITextField *)view;
//                
//                if (txtField.tag == 200)
//                {
//                    //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
//                    dtString = txtField.text;
//                }
//                
//                if (txtField.tag == 700)
//                {
//                    //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
//                    conString = txtField.text;
//                }
//            }
//        }
//        
//        if(self.fromTF1.text.length <= 0 || self.toTF1.text.length <= 0 ||
//           dtString.length <= 0 || conString.length <= 0)
//        {
//            [[[UIAlertView alloc] initWithTitle:nil message:@"Enter all the fields" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
//            
//            return;
//        }
//        else if(![self isNumeric:dtString])
//        {
//            [[[UIAlertView alloc] initWithTitle:nil message:@"Enter valid cost" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
//            
//            return;
//        }
//        
////        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
////        [data setObject:dtString forKey:@"item"];
////        [data setObject:conString forKey:@"cost"];
////        [swtyaJPArray1 addObject:data];
//        
//        swtyaJPDict2 = [NSDictionary dictionaryWithDictionary:[bArray objectAtIndex:sender.tag]];
//        
//        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
//        [data setObject:self.fromTF.text forKey:@"from"];
//        [data setObject:self.toTF.text forKey:@"to"];
//        [data setObject:conString forKey:@"item"];
//        [data setObject:dtString forKey:@"cost"];
//        [swtyaJPPreArrayB replaceObjectAtIndex:sender.tag withObject:data];
//        [bArray replaceObjectAtIndex:sender.tag withObject:data];
//        
//        NSArray *swtyaJPPreArray = [[NSArray alloc] init];
//        
//        swtyaJPPreArray = @[@{@"name":self.nameTF.text,@"checklist":cArray,@"itinerary":iArray,@"budget":bArray}];
//        
//        [swtyaJPArray replaceObjectAtIndex:self.swtyaPlanIndex withObject:swtyaJPPreArray];
//        
//        [self saveArrayToUserDefaults:swtyaJPArray forKey:@"swtyaJPArray"];
//        
//        [self.upperTableViewBug reloadData];
//        [self.bottomTableViewBug reloadData];
        
//        NSArray *swtyaJPPreArray = [[NSArray alloc] init];
//        
//        NSMutableArray *swtyaJPArray1 = [[NSMutableArray alloc] init];
//        
//        //    if(swtyaJPArray1.count > 0)
//        //        swtyaJPArray = swtyaJPArray1;
//        //    else
//        //        [swtyaJPArray addObject:swtyaJPPreArray];
//        
//        for (int i = 0; i < swtyaJPPreArrayB.count; i++)
//        {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow: i inSection: 0];
//            
//            UITableViewCell *cell = [self.upperTableViewBug cellForRowAtIndexPath:indexPath];
//            
//            NSString *dtString, *conString;
//            
//            for (UIView *view in cell.contentView.subviews)
//            {
//                if ([view isKindOfClass:[UITextField class]])
//                {
//                    UITextField* txtField = (UITextField *)view;
//                    
//                    if (txtField.tag == 200)
//                    {
//                        //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
//                        dtString = txtField.text;
//                    }
//                    
//                    if (txtField.tag == 700)
//                    {
//                        //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
//                        conString = txtField.text;
//                    }
//                }
//            }
//            
//            if(self.fromTF1.text.length <= 0 || self.toTF1.text.length <= 0 ||
//               dtString.length <= 0 || conString.length <= 0)
//            {
//                [[[UIAlertView alloc] initWithTitle:nil message:@"Enter all the fields" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
//                
//                return;
//            }
//            
//            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
//            [data setObject:dtString forKey:@"item"];
//            [data setObject:conString forKey:@"cost"];
//            [swtyaJPArray1 addObject:data];
//        }
//        
//        //swtyaJPPreArrayI = @[@{@"from":@"a",@"to":@"b",@"date":@"02-02-2016",@"con":@"swtya n baby"}];
//        
//        swtyaJPPreArray = @[@{@"name":self.nameTF.text,@"checklist":cArray,@"itinerary":iArray,@"budget":swtyaJPArray1}];
//        
//        if(self.swtyaPlanIndex == (swtyaJPArray.count - 1))
//        {
//            [swtyaJPArray removeLastObject];
//            
//            [swtyaJPArray addObject:swtyaJPPreArray];
//            
//            NSArray *swtyaJPPreArrayI27 = @[@{@"item":@"",@"cost":@""}];
//            
//            NSArray *swtyaJPPreArray27 = @[@{@"name":@"Plan New Journey",@"checklist":swtyaJPPreArrayC,@"itinerary":swtyaJPPreArrayI,@"budget":swtyaJPPreArrayI27}];
//            
//            [swtyaJPArray addObject:swtyaJPPreArray27];
//        }
//        else
//            [swtyaJPArray replaceObjectAtIndex:self.swtyaPlanIndex withObject:swtyaJPPreArray];
//        
//        [self saveArrayToUserDefaults:swtyaJPArray forKey:@"swtyaJPArray"];
//        
//        swtyaJPDict1 = [NSDictionary dictionaryWithDictionary:[[swtyaJPArray objectAtIndex:self.swtyaPlanIndex] objectAtIndex:0]];
//        
//        NSLog(@"Swtya : %@ ", swtyaJPDict1);
//        
//        NSString *name = [NSString stringWithFormat:@"%@", [swtyaJPDict1 objectForKey:@"name"]];
//        
//        if(![name isEqualToString:@"Plan New Journey"])
//            self.nameTF.text = name;
//        
//        bArray = [[NSMutableArray alloc] init];
//        
//        bArray = [[swtyaJPDict1 objectForKey:@"budget"] mutableCopy];
//        
//        [self.bottomTableViewBug reloadData];
    }
//    else
//    {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection: 0];
//        
//        UITableViewCell *cell = [self.upperTableViewChk cellForRowAtIndexPath:indexPath];
//        
//        NSString *conString;
//        
//        for (UIView *view in cell.contentView.subviews)
//        {
//            if ([view isKindOfClass:[UITextField class]])
//            {
//                UITextField* txtField = (UITextField *)view;
//                
//                if (txtField.tag == 2)
//                {
//                    //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
//                    conString = txtField.text;
//                }
//            }
//        }
//        
//        if(conString.length <= 0)
//        {
//            [[[UIAlertView alloc] initWithTitle:nil message:@"Enter checklist" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
//            
//            return;
//        }
//        
//        swtyaJPDict2 = [NSDictionary dictionaryWithDictionary:[cArray objectAtIndex:sender.tag]];
//        
//        NSString *isChkVal = [swtyaJPDict2 objectForKey:@"isChk"];
//        //NSString *chkCon = [swtyaJPDict2 objectForKey:@"chkCon"];
//        
//        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
//        [data setObject:isChkVal forKey:@"isChk"];
//        [data setObject:conString forKey:@"chkCon"];
//        [swtyaJPPreArrayC replaceObjectAtIndex:sender.tag withObject:data];
//        [cArray replaceObjectAtIndex:sender.tag withObject:data];
//        
//        NSArray *swtyaJPPreArray = [[NSArray alloc] init];
//        
//        swtyaJPPreArray = @[@{@"name":self.nameTF.text,@"checklist":cArray,@"itinerary":iArray,@"budget":bArray}];
//        
//        [swtyaJPArray replaceObjectAtIndex:self.swtyaPlanIndex withObject:swtyaJPPreArray];
//        
//        [self saveArrayToUserDefaults:swtyaJPArray forKey:@"swtyaJPArray"];
//        
//        [self.upperTableViewChk reloadData];
//        [self.bottomTableViewChk reloadData];
//        
////        NSArray *swtyaJPPreArray = [[NSArray alloc] init];
////        
////        NSMutableArray *swtyaJPArray1 = [[NSMutableArray alloc] init];
////        
////        //[cArray removeLastObject];
////        
//////        if(cArray.count > 1)
//////        {
//////            swtyaJPArray1 = cArray;
//////            
//////            [swtyaJPArray1 removeLastObject];
//////        }
////        
////        NSLog(@"Swtya : %@", cArray);
////        
////        for (int i = swtyaJPPreArrayC.count - 1; i < swtyaJPPreArrayC.count; i++)
////        {
////            NSIndexPath *indexPath = [NSIndexPath indexPathForRow: i inSection: 0];
////            
////            UITableViewCell *cell = [self.upperTableViewChk cellForRowAtIndexPath:indexPath];
////            
////            //static NSString *cellIdentifier = @"JPChkUpperCell";
////            
////            //JPChkUpperCell *cell = (JPChkUpperCell *)[self.upperTableViewChk dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
////            
////            NSString *conString;
////            
//////            UITextField *mTextField = (UITextField *) [cell viewWithTag:2];
//////            
//////            conString = mTextField.text;
////            
//////            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
//////            CustomCell *cell = (CustomCell *)[tableView cellForRowAtIndexPath:indexPath]; // Add This instead
//////            NSString *userpassword = cell.textfield.text;
////            
////            for (UIView *view in cell.contentView.subviews)
////            {
////                if ([view isKindOfClass:[UITextField class]])
////                {
////                    UITextField* txtField = (UITextField *)view;
////                    
////                    if (txtField.tag == 2)
////                    {
////                        //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
////                        conString = txtField.text;
////                    }
////                }
////            }
////            
////            //            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
////            //            [data setObject:dtString forKey:@"isChk"];
////            //            [data setObject:conString forKey:@"chkCon"];
////            //            [swtyaJPArray1 addObject:data];
////            
////            if(conString.length <= 0)
////            {
////                [[[UIAlertView alloc] initWithTitle:nil message:@"Enter checklist" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
////                
////                return;
////            }
////            
////            swtyaJPDict2 = [NSDictionary dictionaryWithDictionary:[cArray objectAtIndex:i]];
////            
////            NSString *isChkVal = [swtyaJPDict2 objectForKey:@"isChk"];
////            NSString *chkCon = [swtyaJPDict2 objectForKey:@"chkCon"];
////            
////            NSMutableDictionary *data1 = [[NSMutableDictionary alloc] init];
////            [data1 setObject:isChkVal forKey:@"isChk"];
////            [data1 setObject:conString forKey:@"chkCon"];
////            [swtyaJPArray1 addObject:data1];
////        }
////        
////        NSLog(@"Swtya : 002 : %@", swtyaJPArray1);
////        
////        //swtyaJPPreArrayI = @[@{@"from":@"a",@"to":@"b",@"date":@"02-02-2016",@"con":@"swtya n baby"}];
////        
////        swtyaJPPreArray = @[@{@"name":self.nameTF.text,@"checklist":swtyaJPArray1,@"itinerary":iArray,@"budget":bArray}];
////        
////        if(self.swtyaPlanIndex == (swtyaJPArray.count - 1))
////        {
////            [swtyaJPArray removeLastObject];
////            
////            [swtyaJPArray addObject:swtyaJPPreArray];
////            
////            //NSArray *swtyaJPPreArrayI27 = @[@{@"isChk":@"0",@"to":@"",@"date":@"",@"con":@""}];
////            
////            NSArray *swtyaJPPreArray27 = @[@{@"name":@"Plan New Journey",@"checklist":swtyaJPPreArrayC,@"itinerary":swtyaJPPreArrayI,@"budget":swtyaJPPreArrayB}];
////            
////            [swtyaJPArray addObject:swtyaJPPreArray27];
////        }
////        else
////            [swtyaJPArray replaceObjectAtIndex:self.swtyaPlanIndex withObject:swtyaJPPreArray];
////        
////        [self saveArrayToUserDefaults:swtyaJPArray forKey:@"swtyaJPArray"];
////        
////        swtyaJPDict2 = [NSDictionary dictionaryWithDictionary:[[swtyaJPArray objectAtIndex:self.swtyaPlanIndex] objectAtIndex:0]];
////        
////        NSLog(@"Swtya : %@ ", swtyaJPDict2);
////        
////        NSString *name = [NSString stringWithFormat:@"%@", [swtyaJPDict2 objectForKey:@"name"]];
////        
////        if(![name isEqualToString:@"Plan New Journey"])
////            self.nameTF.text = name;
////        
////        cArray = [[NSMutableArray alloc] init];
////        
////        cArray = [[swtyaJPDict2 objectForKey:@"checklist"] mutableCopy];
////        
////        [self.bottomTableViewChk reloadData];
//    }
    
    if (swtya == 2 && sender.tag == iArray.count - 1)
    {
//        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
//        //@{@"from":self.fromTF.text,@"to":self.toTF.text,@"date":dtString,@"con":conString};
//        [data setObject:@"" forKey:@"from"];
//        [data setObject:@"" forKey:@"to"];
//        [data setObject:@"" forKey:@"date"];
//        [data setObject:@"" forKey:@"con"];
//        [swtyaJPPreArrayI addObject:data];
//        [iArray addObject:data];
//        
//        [self.upperTableView reloadData];
//        
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:iArray.count - 1 inSection: 0];
//        [self.upperTableView scrollToRowAtIndexPath:indexPath
//                                   atScrollPosition:UITableViewScrollPositionTop
//                                           animated:YES];
    }
//    else if (swtya == 1 && sender.tag == cArray.count - 1)
//    {
//        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
//        //@{@"from":self.fromTF.text,@"to":self.toTF.text,@"date":dtString,@"con":conString};
//        [data setObject:@"0" forKey:@"isChk"];
//        [data setObject:@"" forKey:@"chkCon"];
//        [swtyaJPPreArrayC addObject:data];
//        [cArray addObject:data];
//        
//        [self.upperTableViewChk reloadData];
//        
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:cArray.count - 1 inSection: 0];
//        [self.upperTableViewChk scrollToRowAtIndexPath:indexPath
//                                   atScrollPosition:UITableViewScrollPositionTop
//                                           animated:YES];
//    }
    else if (swtya == 3 && sender.tag == bArray.count - 1)
    {
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        //@{@"from":self.fromTF.text,@"to":self.toTF.text,@"date":dtString,@"con":conString};
        [data setObject:@"" forKey:@"item"];
        [data setObject:@"" forKey:@"cost"];
        [swtyaJPPreArrayB addObject:data];
        [bArray addObject:data];
        
        [self.upperTableViewBug reloadData];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:bArray.count - 1 inSection: 0];
        [self.upperTableViewBug scrollToRowAtIndexPath:indexPath
                                   atScrollPosition:UITableViewScrollPositionTop
                                           animated:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)dismissKeyboard
{
    [self.nameTF resignFirstResponder];
    [self.fromTF resignFirstResponder];
    [self.toTF resignFirstResponder];
    
    for (int i = 0; i < swtyaJPPreArrayI.count; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow: i inSection: 0];
        
        UITableViewCell *cell = [self.upperTableView cellForRowAtIndexPath:indexPath];
        
        for (UIView *view in  cell.contentView.subviews)
        {
            if ([view isKindOfClass:[UITextField class]])
            {
                UITextField* txtField = (UITextField *)view;
                
                [txtField resignFirstResponder];
            }
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)checklist
{
    _checklistLabel.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    [_checklistBtn setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    _itineraryLabel.backgroundColor = [UIColor colorWithRed:53.0f/255.0f green:152.0f/255.0f blue:219.0f/255.0f alpha:1.0f];
    [_itineraryBtn setTitleColor:[UIColor colorWithRed:209.0f/255.0f green:202.0f/255.0f blue:202.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    _budgetLabel.backgroundColor = [UIColor colorWithRed:53.0f/255.0f green:152.0f/255.0f blue:219.0f/255.0f alpha:1.0f];
    [_budgetBtn setTitleColor:[UIColor colorWithRed:209.0f/255.0f green:202.0f/255.0f blue:202.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
}

- (void)itinerary
{
    _itineraryLabel.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    [_itineraryBtn setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    _checklistLabel.backgroundColor = [UIColor colorWithRed:53.0f/255.0f green:152.0f/255.0f blue:219.0f/255.0f alpha:1.0f];
    [_checklistBtn setTitleColor:[UIColor colorWithRed:209.0f/255.0f green:202.0f/255.0f blue:202.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    _budgetLabel.backgroundColor = [UIColor colorWithRed:53.0f/255.0f green:152.0f/255.0f blue:219.0f/255.0f alpha:1.0f];
    [_budgetBtn setTitleColor:[UIColor colorWithRed:209.0f/255.0f green:202.0f/255.0f blue:202.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
}

- (void)budget
{
    _budgetLabel.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    [_budgetBtn setTitleColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    _checklistLabel.backgroundColor = [UIColor colorWithRed:53.0f/255.0f green:152.0f/255.0f blue:219.0f/255.0f alpha:1.0f];
    [_checklistBtn setTitleColor:[UIColor colorWithRed:209.0f/255.0f green:202.0f/255.0f blue:202.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    _itineraryLabel.backgroundColor = [UIColor colorWithRed:53.0f/255.0f green:152.0f/255.0f blue:219.0f/255.0f alpha:1.0f];
    [_itineraryBtn setTitleColor:[UIColor colorWithRed:209.0f/255.0f green:202.0f/255.0f blue:202.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
}

- (IBAction)swtyaChecklistBtnClicked:(id)sender
{
    swtya = 1;
    
    self.upperViewChk.hidden = NO;
    self.bottomViewChk.hidden = NO;
    self.upperView.hidden = YES;
    self.bottomView.hidden = YES;
    
    self.upperViewBug.hidden = YES;
    self.bottomViewBug.hidden = YES;
    
    [self.upperTableViewChk reloadData];
    //[self.bottomTableViewChk reloadData];
    
    [self checklist];
}

- (IBAction)swtyaItineraryBtnClicked:(id)sender
{
    swtya = 2;
    
    self.upperViewChk.hidden = YES;
    self.bottomViewChk.hidden = YES;
    self.upperView.hidden = NO;
    self.bottomView.hidden = NO;
    
    self.upperViewBug.hidden = YES;
    self.bottomViewBug.hidden = YES;
    
    [self.upperTableView reloadData];
    //[self.bottomTableView reloadData];
    
    [self itinerary];
}

- (IBAction)swtyaBudgetBtnClicked:(id)sender
{
    swtya = 3;
    
    self.upperViewChk.hidden = YES;
    self.bottomViewChk.hidden = YES;
    self.upperView.hidden = YES;
    self.bottomView.hidden = YES;
    
    self.upperViewBug.hidden = NO;
    self.bottomViewBug.hidden = NO;
    
    [self.upperTableViewBug reloadData];
    //[self.bottomTableViewBug reloadData];
    
    [self budget];
}

- (IBAction)swtyaBckBtnClicked:(id)sender
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

- (IBAction)SelectDate:(id)sender
{
    swtyaCal = [sender tag];
    
    //CHECK=@"str";
    self.pmCC = [[PMCalendarController alloc] init];
    
    _pmCC.delegate = self;
    _pmCC.mondayFirstDayOfWeek = YES;
    
    [_pmCC presentCalendarFromView:sender
          permittedArrowDirections:PMCalendarArrowDirectionAny
                          animated:YES];
    [_pmCC presentCalendarFromRect:[sender frame]
                            inView:[sender superview]
          permittedArrowDirections:PMCalendarArrowDirectionAny
                          animated:YES];
    [self calendarController:_pmCC didChangePeriod:_pmCC.period];
    // [border1 removeFromSuperlayer];
    
    
    
}

- (void)calendarController:(PMCalendarController *)calendarController didChangePeriod:(PMPeriod *)newPeriod
{
    //NSLog(@"check ==%@",CHECK);
//    if ([CHECK isEqualToString:@"str"])
//    {
//        CHECK=@"strnot";
//        
//    }
//    else
    {
        
        
        NSDate *TodayDate =[NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
        
        NSString *stringFromDate = [formatter stringFromDate:TodayDate];
        
        NSLog(@"Totay date==%@", stringFromDate);
        
        NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
        [tempFormatter setDateFormat:@"yyyy-MM-dd"];
        
        
        NSDate *TodayDate1 =[tempFormatter dateFromString:stringFromDate];
        NSDate *StartDate =[tempFormatter dateFromString:[newPeriod.startDate dateStringWithFormat:@"yyyy-MM-dd"]];
        
        NSString *selectdate = [NSString stringWithFormat:@"%@", [newPeriod.startDate dateStringWithFormat:@"yyyy-MM-dd"]];
        NSLog(@"First Time Date=%@",selectdate);
        
        //if([TodayDate1 compare: StartDate] == NSOrderedDescending ||[TodayDate1 compare: StartDate] ==  NSOrderedDescending)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:swtyaCal inSection: 0];
            
            UITableViewCell *cell = [self.upperTableView cellForRowAtIndexPath:indexPath];
            
            NSString *dtString, *conString;
            
            for (UIView *view in cell.contentView.subviews)
            {
                if ([view isKindOfClass:[UITextField class]])
                {
                    UITextField* txtField = (UITextField *)view;
                    
                    if (txtField.tag == 002)
                    {
                        //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
                        //dtString = txtField.text;
                        
                        dtString = txtField.text = [NSString stringWithFormat:@"%@",[newPeriod.startDate dateStringWithFormat:@"dd-MM-yyyy"]];
                    }
                    
                    if (txtField.tag == 007)
                    {
                        //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
                        conString = txtField.text;
                    }
                }
            }
            
            swtyaJPDict2 = [NSDictionary dictionaryWithDictionary:[iArray objectAtIndex:swtyaCal]];
            
            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
            [data setObject:self.fromTF.text forKey:@"from"];
            [data setObject:self.toTF.text forKey:@"to"];
            [data setObject:dtString forKey:@"date"];
            [data setObject:conString forKey:@"con"];
            [swtyaJPPreArrayI replaceObjectAtIndex:swtyaCal withObject:data];
            [iArray replaceObjectAtIndex:swtyaCal withObject:data];
            
            NSArray *swtyaJPPreArray = [[NSArray alloc] init];
            
            swtyaJPPreArray = @[@{@"name":self.nameTF.text,@"checklist":cArray,@"itinerary":iArray,@"budget":bArray}];
            
            [swtyaJPArray replaceObjectAtIndex:self.swtyaPlanIndex withObject:swtyaJPPreArray];
            
            [self saveArrayToUserDefaults:swtyaJPArray forKey:@"swtyaJPArray"];
            
            [self.upperTableView reloadData];
            //[self.bottomTableView reloadData];
            
            //        if(iArray.count > 1)
            //        {
            //            swtyaJPDict2 = [NSDictionary dictionaryWithDictionary:[iArray objectAtIndex:iArray.count - 2]];
            //
            //            NSString *dtVal1 = [swtyaJPDict2 objectForKey:@"date"];
            //            NSString *conVal1 = [swtyaJPDict2 objectForKey:@"con"];
            //
            //            if(self.fromTF1.text.length <= 0 || self.toTF1.text.length <= 0 ||
            //               dtString.length <= 0 || conString.length <= 0
            //               || dtVal1.length <= 0 || conVal1.length <= 0)
            //            {
            //                [[[UIAlertView alloc] initWithTitle:nil message:@"Enter all the fields" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
            //                
            //                return;
            //            }
            //        }
            
            [self performSelector:@selector(viewload) withObject:nil afterDelay:1.0];
            //[self viewload];
            
        }
//        else
//        {
//            
//            [YRDropdownView showDropdownInView:self.view
//                                         title:@"Date Should Must Be Less Than Today's Date"
//                                        detail:@"Oops!"
//                                         image:nil
//                                      animated:YES
//                                     hideAfter:3];
//        }
//        CHECK=@"strnot";
//        NSLog(@"checek no");
    }
    
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
////    if (indexPath.section == 0 && indexPath.row == 2) { // this is my picker cell
////        if (editingStartTime) {
////            return 219;
////        } else {
////            return 0;
////        }
////    } else {
////        return self.tableView.rowHeight;
////    }
//    
//    return 600;
//}

- (void)viewload
{
    [_pmCC.view removeFromSuperview];
}

- (void)dismissPicker:(id)sender
{
    if([sender tag] == 7777)
    {
        NSDate *selectedDate = datePicker.date;
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd-MM-yyyy"];
        
        self.swtyaDateTF1.text = [df stringFromDate:selectedDate];
        
        [self.swtyaDateTF1 resignFirstResponder];
    }
    else
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[sender tag] inSection: 0];
        
        UITableViewCell *cell = [self.upperTableView cellForRowAtIndexPath:indexPath];
        
        for (UIView *view in cell.contentView.subviews)
        {
            if ([view isKindOfClass:[UITextField class]])
            {
                UITextField* txtField = (UITextField *)view;
                
                if (txtField.tag == 002)
                {
                    //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
                    //dtString = txtField.text;
                    
                    [txtField resignFirstResponder];
                }
            }
        }
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[sender tag] inSection: 0];
        
        //UITableViewCell *cell = [self.upperTableView cellForRowAtIndexPath:indexPath];
        
        NSString *dtString, *conString;
        
        for (UIView *view in cell.contentView.subviews)
        {
            if ([view isKindOfClass:[UITextField class]])
            {
                UITextField* txtField = (UITextField *)view;
                
                if (txtField.tag == 002)
                {
                    //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
                    //dtString = txtField.text;
                    
                    //dtString = txtField.text = [NSString stringWithFormat:@"%@",[newPeriod.startDate dateStringWithFormat:@"dd-MM-yyyy"]];
                    
                    NSDate *selectedDate = datePicker.date;
                    
                    NSDateFormatter *df = [[NSDateFormatter alloc] init];
                    [df setDateFormat:@"dd-MM-yyyy"];
                    
                    dtString = txtField.text= [df stringFromDate:selectedDate];
                    
                    //[txtField resignFirstResponder];
                }
                
                if (txtField.tag == 007)
                {
                    //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
                    conString = txtField.text;
                }
            }
        }
        
        swtyaJPDict2 = [NSDictionary dictionaryWithDictionary:[iArray objectAtIndex:[sender tag]]];
        
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        [data setObject:self.fromTF.text forKey:@"from"];
        [data setObject:self.toTF.text forKey:@"to"];
        [data setObject:dtString forKey:@"date"];
        [data setObject:conString forKey:@"con"];
        [swtyaJPPreArrayI replaceObjectAtIndex:[sender tag] withObject:data];
        [iArray replaceObjectAtIndex:[sender tag] withObject:data];
        
        NSArray *swtyaJPPreArray = [[NSArray alloc] init];
        
        swtyaJPPreArray = @[@{@"name":self.swtyaPlanName,@"checklist":cArray,@"itinerary":iArray,@"budget":bArray}];
        
        [swtyaJPArray replaceObjectAtIndex:self.swtyaPlanIndex withObject:swtyaJPPreArray];
        
        [self saveArrayToUserDefaults:swtyaJPArray forKey:@"swtyaJPArray"];
        
        [self.upperTableView reloadData];
    }
}

- (void)datePickerValueChanged:(id)sender
{
    if([sender tag] == 7777)
    {
        NSDate *selectedDate = datePicker.date;
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd-MM-yyyy"];
        
        self.swtyaDateTF1.text = [df stringFromDate:selectedDate];
        
        [self.swtyaDateTF1 resignFirstResponder];
    }
    else
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[sender tag] inSection: 0];
        
        UITableViewCell *cell = [self.upperTableView cellForRowAtIndexPath:indexPath];
        
        NSString *dtString, *conString;
        
        for (UIView *view in cell.contentView.subviews)
        {
            if ([view isKindOfClass:[UITextField class]])
            {
                UITextField* txtField = (UITextField *)view;
                
                if (txtField.tag == 002)
                {
                    //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
                    //dtString = txtField.text;
                    
                    //dtString = txtField.text = [NSString stringWithFormat:@"%@",[newPeriod.startDate dateStringWithFormat:@"dd-MM-yyyy"]];
                    
                    NSDate *selectedDate = datePicker.date;
                    
                    NSDateFormatter *df = [[NSDateFormatter alloc] init];
                    [df setDateFormat:@"dd-MM-yyyy"];
                    
                    dtString = txtField.text= [df stringFromDate:selectedDate];
                    
                    //[txtField resignFirstResponder];
                }
                
                if (txtField.tag == 007)
                {
                    //NSLog(@"TextField.tag:%u and Data %@", txtField.tag, txtField.text);
                    conString = txtField.text;
                }
            }
        }
        
        swtyaJPDict2 = [NSDictionary dictionaryWithDictionary:[iArray objectAtIndex:[sender tag]]];
        
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        [data setObject:self.fromTF.text forKey:@"from"];
        [data setObject:self.toTF.text forKey:@"to"];
        [data setObject:dtString forKey:@"date"];
        [data setObject:conString forKey:@"con"];
        [swtyaJPPreArrayI replaceObjectAtIndex:[sender tag] withObject:data];
        [iArray replaceObjectAtIndex:[sender tag] withObject:data];
        
        NSArray *swtyaJPPreArray = [[NSArray alloc] init];
        
        swtyaJPPreArray = @[@{@"name":self.swtyaPlanName,@"checklist":cArray,@"itinerary":iArray,@"budget":bArray}];
        
        [swtyaJPArray replaceObjectAtIndex:self.swtyaPlanIndex withObject:swtyaJPPreArray];
        
        [self saveArrayToUserDefaults:swtyaJPArray forKey:@"swtyaJPArray"];
        
        [self.upperTableView reloadData];
    }
}

- (void)dismissPicker1:(id)sender
{
    NSDate *selectedDate = datePicker.date;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd-MM-yyyy"];
    
    self.swtyaDateTF1.text = [df stringFromDate:selectedDate];
    
    [self.swtyaDateTF1 resignFirstResponder];
    
    //    NSString *dtString, *conString;
    //
    //    NSDate *selectedDate = datePicker.date;
    //
    //    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //    [df setDateFormat:@"dd-MM-yyyy"];
    //
    //    dtString = self.swtyaDateTF1.text= [df stringFromDate:selectedDate];
    //
    //    conString = self.swtyaLocationTF.text;
    //
    //    swtyaJPDict2 = [NSDictionary dictionaryWithDictionary:[iArray objectAtIndex:[sender tag]]];
    //
    //    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    //    [data setObject:self.fromTF.text forKey:@"from"];
    //    [data setObject:self.toTF.text forKey:@"to"];
    //    [data setObject:dtString forKey:@"date"];
    //    [data setObject:conString forKey:@"con"];
    //    [swtyaJPPreArrayI addObject:data];
    //    [iArray addObject:data];
    //
    //    NSArray *swtyaJPPreArray = [[NSArray alloc] init];
    //
    //    swtyaJPPreArray = @[@{@"name":self.nameTF.text,@"checklist":cArray,@"itinerary":iArray,@"budget":bArray}];
    //
    //    [swtyaJPArray replaceObjectAtIndex:self.swtyaPlanIndex withObject:swtyaJPPreArray];
    //
    //    [self saveArrayToUserDefaults:swtyaJPArray forKey:@"swtyaJPArray"];
    //
    //    [self.upperTableView reloadData];
}

//self.swtyaChkConTF1.delegate = self;
//self.swtyaDateTF1.delegate = self;
//self.swtyaLocationTF.delegate = self;
//
//self.swtyaTF123.delegate = self;
//self.swtyaTF456.delegate = self;

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField == self.swtyaChkConTF1 || textField == self.swtyaDateTF1 ||
       textField == self.swtyaLocationTF || textField == self.swtyaTF123 ||
       textField == self.swtyaTF456)
        [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == self.swtyaChkConTF1 || textField == self.swtyaDateTF1 ||
       textField == self.swtyaLocationTF || textField == self.swtyaTF123 ||
       textField == self.swtyaTF456)
        [self animateTextField:textField up:NO];
}

- (void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    const int movementDistance = -190; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (void)datePickerValueChanged1:(id)sender
{
    NSDate *selectedDate = datePicker.date;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd-MM-yyyy"];
    
    self.swtyaDateTF1.text = [df stringFromDate:selectedDate];
    
    [self.swtyaDateTF1 resignFirstResponder];
    
    //    swtyaJPDict2 = [NSDictionary dictionaryWithDictionary:[iArray objectAtIndex:[sender tag]]];
    //
    //    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    //    [data setObject:self.fromTF.text forKey:@"from"];
    //    [data setObject:self.toTF.text forKey:@"to"];
    //    [data setObject:dtString forKey:@"date"];
    //    [data setObject:conString forKey:@"con"];
    //    [swtyaJPPreArrayI replaceObjectAtIndex:[sender tag] withObject:data];
    //    [iArray replaceObjectAtIndex:[sender tag] withObject:data];
    //
    //    NSArray *swtyaJPPreArray = [[NSArray alloc] init];
    //
    //    swtyaJPPreArray = @[@{@"name":self.nameTF.text,@"checklist":cArray,@"itinerary":iArray,@"budget":bArray}];
    //
    //    [swtyaJPArray replaceObjectAtIndex:self.swtyaPlanIndex withObject:swtyaJPPreArray];
    //    
    //    [self saveArrayToUserDefaults:swtyaJPArray forKey:@"swtyaJPArray"];
    //    
    //    [self.upperTableView reloadData];
    //    [self.bottomTableView reloadData];
}

@end