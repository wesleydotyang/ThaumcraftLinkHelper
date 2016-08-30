//
//  TCCalc.m
//  CVTest
//
//  Created by Wesley Yang on 15/9/22.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "TCCalc.h"

static NSMutableDictionary *allElements;

@interface TCCalc ()



@end

@implementation TCCalc

+(void)initialize
{
    if (self == [TCCalc self]) {
        // ... do the initialization ...
        [self initElements];

    }
}

+(NSArray*)getAllElements
{
    return allElements.allValues;
}

+(TCElement*)elementNamed:(NSString*)name
{
    return allElements[name];
}

-(instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

+(void)initElements{
    
    NSString *filePath= [[NSBundle mainBundle] pathForResource:@"TCElements" ofType:@"txt"];
    NSError *error;
    NSString *allStr = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    NSArray *lines = [allStr componentsSeparatedByString:@"\n"];
    
    allElements = [NSMutableDictionary dictionary];
    
    for (NSString *aLine in lines) {
        if (aLine.length==0) {
            continue;
        }
        
        NSArray *comps = [aLine componentsSeparatedByString:@" "];
        if (comps.count>0) {
            TCElement *thisEle = [TCElement elementFromDescription:comps[0]];
            
            if (thisEle) {
                for (int i=1;i<comps.count ; ++i) {
                    TCElement *subEle = [TCElement elementFromDescription:comps[i]];
                    if (subEle) {
                        [thisEle.composedElements addObject:subEle];
                    }
                }
                
                allElements[thisEle.name] = thisEle;
            }
        }
        
    }
    NSEnumerator *en = allElements.objectEnumerator;
    TCElement *anElement;
    while ((anElement = en.nextObject)) {
        for (TCElement* subElement in anElement.composedElements) {
            [allElements[subElement.name] addComposingElement:anElement];
        }
        [anElement calcWeightIfNeeded];
    }
    
    NSLog(@"init finish:%@",allElements);
}

-(void)startCalc
{
    _allResultSet = [NSMutableArray array];
    
    NSMutableArray *queue = [NSMutableArray array];
    [queue addObject:self.startElement];
    [self nextStepWithQueue:queue currentStep:-1];
    
    
    //sort result
    [_allResultSet sortUsingComparator:^NSComparisonResult(NSArray *obj1, NSArray *obj2) {
        int w1 = 0,w2=0;
        for (TCElement *ele in obj1) {
            w1+=ele.weight;
        }
        for (TCElement *ele in obj2) {
            w2+=ele.weight;
        }
        return w1-w2;
        
    }];
}

-(void)nextStepWithQueue:(NSMutableArray*)queue currentStep:(int)step
{
    step ++;
    TCElement *lastElement = [queue lastObject];
//    NSLog(@"[%d]trying:%@",step,lastElement.name);
    
    BOOL isFinalStep = step==self.steps;
    
    for (TCElement *subEle in lastElement.composedElements) {
        NSMutableArray *newQueue = [queue mutableCopy];
        [newQueue addObject:allElements[subEle.name]];
        if (isFinalStep) {
            if ([subEle.name isEqualToString:self.endElement.name]) {
                //success match
                [_allResultSet addObject:newQueue];
            }else{
                //fail
                continue;
            }
        }else{
            [self nextStepWithQueue:newQueue currentStep:step];
        }
    }
    
    for (TCElement *subEle in lastElement.composingElements) {
        NSMutableArray *newQueue = [queue mutableCopy];
        [newQueue addObject:allElements[subEle.name]];
        if (isFinalStep) {
            if ([subEle.name isEqualToString:self.endElement.name]) {
                //success match
                [_allResultSet addObject:newQueue];
            }else{
                //fail
                continue;
            }
        }else{
            [self nextStepWithQueue:newQueue currentStep:step];
        }
    }
    
}

-(void)test{
    self.startElement = allElements[@"aqua"];
    self.endElement = allElements[@"iter"];
    self.steps = 3;
    
    [self startCalc];
    
    NSLog(@"result:%@",self.allResultSet);
}


@end
