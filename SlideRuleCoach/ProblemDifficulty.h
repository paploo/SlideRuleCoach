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
    ProblemDifficulyIntroductory = 0,
    ProblemDifficultyEasy = 1,
    ProblemDifficultyNormal = 2,
    ProblemDifficultyAdvanced = 3,
    ProblemDifficultyMaster = 4
} ProblemDifficulty;