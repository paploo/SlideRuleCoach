//
//  NumberFormatterFactory.m
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/16/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
//

#import "NumberFormatterFactory.h"


@implementation NumberFormatterFactory

+ (NSNumberFormatter *)decimalFormatter {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return [formatter autorelease];
}

+ (NSNumberFormatter *)percentageFormatter {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterPercentStyle];
    [formatter setUsesSignificantDigits:YES];
    [formatter setMaximumSignificantDigits:2];
    return [formatter autorelease]; 
}

+ (NSNumberFormatter *)decimalFormatterWithSigFigs:(NSUInteger)sigfigs {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setUsesSignificantDigits:YES];
    [formatter setMaximumSignificantDigits:sigfigs];
    return [formatter autorelease]; 
}

+ (NSNumberFormatter *)fixnumFormatterWithPlaces:(NSUInteger)places {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:places];
    [formatter setMinimumFractionDigits:places];
    return [formatter autorelease];
}

@end
