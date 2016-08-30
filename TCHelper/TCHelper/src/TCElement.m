//
//  Element.m
//  CVTest
//
//  Created by Wesley Yang on 15/9/22.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "TCElement.h"
#import "TCCalc.h"

@implementation TCElement

-(void)calcWeightIfNeeded
{
    if (_weight>0) {
        return;
    }
    
    if (self.composedElements.count>0) {
        int total = 0;
        for (TCElement *ele in self.composedElements) {
            TCElement *trueEle = [TCCalc elementNamed:ele.name];
            [trueEle calcWeightIfNeeded];
            total += trueEle.weight;
        }
        self.weight = total;
    }else{
        self.weight = 1;
    }
}

-(NSMutableArray *)composedElements
{
    if (_composedElements == nil) {
        _composedElements = [NSMutableArray array];
    }
    return _composedElements;
}



-(void)addComposingElement:(TCElement *)element
{
    if (_composingElements == nil) {
        _composingElements = [NSMutableArray array];
    }
    for (TCElement *anEle in self.composingElements) {
        if ([anEle.name isEqualToString:element.name]) {
            return;
        }
    }
    [self.composingElements addObject:element];
}

+(TCElement *)elementFromDescription:(NSString *)desc
{
    if (desc == nil || desc.length == 0) {
        return nil;
    }
    
    NSRegularExpression *exp = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z]+" options:0 error:nil];
    NSTextCheckingResult *resul = [exp firstMatchInString:desc options:0 range:NSMakeRange(0, desc.length)];
    if (resul && resul.range.location!=NSNotFound) {
        TCElement *ele = [TCElement new];
        ele.name = [desc substringWithRange:resul.range];
        ele.alias = [desc substringFromIndex:resul.range.length+resul.range.location];
        return ele;
    }else{
        return nil;
    }
    
    
    
}

-(NSString *)description
{
    NSString *result = [NSString stringWithFormat:@"%@<%d>",self.name,self.weight];
    if (self.composedElements) {
        for (TCElement *ele in self.composedElements) {
            result = [result stringByAppendingFormat:@"[s:%@]",ele.name ];
        }    }
    if (self.composingElements) {
        for (TCElement *ele in self.composingElements) {
            result = [result stringByAppendingFormat:@"[p:%@]",ele.name ];
        }
    }
    return result;
//    return [NSString stringWithFormat:@"%@(%@)=%@ < %@",self.name,self.alias,self.composedElements,self.composingElements];
}

@end
