//
//  Element.h
//  CVTest
//
//  Created by Wesley Yang on 15/9/22.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCElement : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *alias;
@property (nonatomic,strong) NSMutableArray *composedElements;
@property (nonatomic,strong) NSMutableArray *composingElements;
@property (nonatomic,assign) int weight;

+(TCElement*)elementFromDescription:(NSString*)desc;
-(void)addComposingElement:(TCElement*)element;

-(void)calcWeightIfNeeded;


@end
