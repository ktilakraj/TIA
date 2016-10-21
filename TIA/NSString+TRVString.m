//
//  NSString+TRVString.m
//  TIA
//
//  Created by tilak raj verma on 24/09/16.
//  Copyright © 2016 Swtya. All rights reserved.
//

#import "NSString+TRVString.h"

@implementation NSString (TRVString)


-(NSString*)getFromToString:(NSMutableDictionary*)dict
{
    
    NSString *strFromDate=[self getdate:@"fromDate" withDict:dict];
    NSString *strToDate=[self getdate:@"toDate" withDict:dict];
    if (strFromDate.length>0 && strToDate.length>0) {
        
        return [NSString stringWithFormat:@"%@ to %@",strFromDate,strToDate];
    }
    
    if (!(strToDate.length > 0) && strFromDate.length>0 ) {
         return [NSString stringWithFormat:@"%@",strFromDate];
    }
    
    if ((strToDate.length > 0) && !(strFromDate.length>0) ) {
        return [NSString stringWithFormat:@"%@",strToDate];
    }
    
    return  @"";
}

-(NSString*)getdate:(NSString*)strdatekey withDict:(NSDictionary*)dict
{
    
    NSString *str=[dict valueForKey:strdatekey];
    
    return str;
}

@end
