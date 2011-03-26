//
//  RandomProblemGenerator.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/22/11.
//  Copyright 2011 Jeffrey C Reinecke. Released under the BSD license.
//

#import <Foundation/Foundation.h>
#import "ProblemGenerator.h"


@interface RandomProblemGenerator : ProblemGenerator {
    NSArray *problemGenerators;
    NSArray *weights;
}
- (id)initWIthProblemGenerators:(NSArray *)generators;
- (id)initWIthProblemGenerators:(NSArray *)generators weights:w;
@end
