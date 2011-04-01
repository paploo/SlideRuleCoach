//
//  NumberFormatterFactory.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/16/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NumberFormatterFactory : NSObject {
    
}
+ (NSNumberFormatter *)decimalFormatter;
+ (NSNumberFormatter *)percentageFormatter;
+ (NSNumberFormatter *)decimalFormatterWithSigFigs:(NSUInteger)sigfigs;
+ (NSNumberFormatter *)fixnumFormatterWithPlaces:(NSUInteger)places;
@end
