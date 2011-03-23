//
//  RandomProblemGenerator.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
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
