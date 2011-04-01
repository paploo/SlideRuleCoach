//
//  ScaleParameterizer.h
//  SlideRuleCoach
//
//  Created by Jeff Reinecke on 3/26/11.
//  Copyright (c) 2011, Jeffrey C. Reinecke, All rights reserved.
//

#import <Foundation/Foundation.h>


// When an answer is on a scale, it would be the value.
@interface ScaleParameterizer : NSObject {
    
}
+ (double)mainScaleValueForParameter:(double)u;
+ (double)mainScaleParameterForValue:(double)v;
+ (double)powerScaleValueForParameter:(double)u power:(double)p; //Delegate to main scale value, used for A,B,K.
+ (double)powerScaleParameterForValue:(double)v power:(double)p; //Delegate to main scale value, used for A,B,K.
+ (double)logScaleValueForParameter:(double)u; //L scale
+ (double)logScaleParameterForValue:(double)v; //L scale
+ (double)logLogScaleValueForParameter:(double)u; //LL scale
+ (double)logLogScaleParameterForValue:(double)v; //LL scale
+ (double)sinScaleValueForParameter:(double)u;
+ (double)sinScaleParameterForValue:(double)v;
+ (double)cosScaleValueForParameter:(double)u;
+ (double)cosScaleParameterForValue:(double)v;
+ (double)tanScaleValueForParameter:(double)u;
+ (double)tanScaleParameterForValue:(double)v;
@end
