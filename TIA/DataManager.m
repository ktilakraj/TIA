//
//  DataManager.m
//  TIA
//
//  Created by tilak raj verma on 20/09/16.
//  Copyright © 2016 Swtya. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

+(id)sharedInstance {
 
    static DataManager *sharedmanager;;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedmanager=[[self alloc]init];
    });
    return sharedmanager;
}


-(NSMutableArray*)getJournyPlanner
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSMutableArray *arr=[defaults valueForKey:JOURNYPLANER];
    if ( arr == nil || arr.count ==0 ) {
        arr=[[NSMutableArray alloc]init];
        [defaults setObject:arr forKey:JOURNYPLANER];
        [defaults synchronize];
        
    }
    return arr;
}

-(void)setJournyPlanner:(NSMutableArray*)arrPlanner
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:arrPlanner forKey:JOURNYPLANER];
    [defaults synchronize];
}

@end
