//
//  DataManager.h
//  TIA
//
//  Created by tilak raj verma on 20/09/16.
//  Copyright © 2016 Swtya. All rights reserved.
//

#import <Foundation/Foundation.h>
#define JOURNYPLANER @"JOURNYPLANER"

@interface DataManager : NSObject

+(id)sharedInstance;
-(NSMutableArray*)getJournyPlanner;
-(void)setJournyPlanner:(NSArray*)arrPlanner;

@end
