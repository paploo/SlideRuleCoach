//
//  ProblemDifficulty.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


// We have an odd number of difficulties, with
// the first being 0 and NORMAL right in the middle
// so that we have the option of a simple way to find
// average difficulty.
typedef enum ProblemDifficulty {
    INTRODUCTORY = 0,
    EASY = 1,
    NORMAL = 2,
    ADVANCED = 3,
    MASTER = 4
} ProblemDifficulty;