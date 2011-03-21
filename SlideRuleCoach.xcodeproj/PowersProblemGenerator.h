//
//  SimplePowersProblemGenerator.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProblemGenerator.h"

@interface PowersProblemGenerator : ProblemGenerator {
    NSNumber *power;
    NSNumber *coefficient;
}
- (id)initWithPower:(NSNumber *)p;
- (id)initWithPower:(NSNumber *)p coefficient:(NSNumber *)c;
@property(nonatomic, retain) NSNumber *power;
@property(nonatomic, retain) NSNumber *coefficient;
@end
