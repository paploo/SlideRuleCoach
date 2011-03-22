//
//  NumberFormatterFactory.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/16/11.
//  Copyright 2011 Jeffrey C Reinecke. Released under the BSD license.
//

#import <Foundation/Foundation.h>


@interface NumberFormatterFactory : NSObject {
    
}
+ (NSNumberFormatter *)decimalFormatter;
+ (NSNumberFormatter *)percentageFormatter;
+ (NSNumberFormatter *)decimalFormatterWithSigFigs:(NSUInteger)sigfigs;
+ (NSNumberFormatter *)fixnumFormatterWithPlaces:(NSUInteger)places;
@end
