//
//  TCCalc.h
//  CVTest
//
//  Created by Wesley Yang on 15/9/22.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCElement.h"

@interface TCCalc : NSObject

//input
@property (nonatomic,strong) TCElement *startElement;
@property (nonatomic,strong) TCElement *endElement;
@property (nonatomic,assign) int steps;


//output
@property (nonatomic,strong) NSMutableArray *allResultSet;

//start
-(void)startCalc;

//helper
+(TCElement*)elementNamed:(NSString*)name;
+(NSArray*)getAllElements;

@end
