//
//  DataManager.h
//  TIA
//
//  Created by tilak raj verma on 20/09/16.
//  Copyright © 2016 Swtya. All rights reserved.
//

#import <Foundation/Foundation.h>

#define JOURNYPLANER @"JOURNYPLANER"
#define SMCUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SMCUIColorFromRGBA(rgbValue,alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

#define color_3598DB 0x3598DB

@interface DataManager : NSObject

+(id)sharedInstance;
-(NSMutableArray*)getJournyPlanner;
-(void)setJournyPlanner:(NSArray*)arrPlanner;

@end
