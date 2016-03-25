//  Fibonacci Sequence using Binet's Fibonacci Number Formula
//
//  Created by Ryan Grier on 03/01/16.
//  Copyright © 2016 Ryan Grier All rights reserved.

#import <Foundation/Foundation.h>

#define SQRT_5 sqrt(5)
#define PHI ((1 + SQRT_5) / 2)

@interface Fibonacci : NSObject
@property (nonatomic, strong) NSArray *knownValues;
@property (nonatomic, assign) NSUInteger count;
- (NSUInteger) fibonacciAtIndex: (NSUInteger) index;
- (BOOL) validateSelf;
@end

@implementation Fibonacci
- (instancetype) init {
	self = [super init];
	
	if (self) {
		self.knownValues = @[ @0, @1, @1, @2, @3, @5, @8, @13, @21, @34, @55, @89, @144, @233, @377, @610, @987, @1597, @2584, @4181, @6765, @10946, @17711, @28657, @46368, @75025, @121393, @196418, @317811 ];
		self.count = 0;
	}
	
	return self;
}
- (NSUInteger) fibonacciAtIndex: (NSUInteger) index {
	if (index < 2) {
		self.count++;
		return index;
	}
	
	self.count++;
	// x(n) = (Phi^n - (-Phi)^-n) / √5
	long double numerator = powl(PHI, index) - powl((long double) (-1.0 * PHI), -1.0 * index);
	long double fibonacci = numerator / SQRT_5;
	
	return (unsigned long long) fibonacci;
}

- (BOOL) validateSelf {
	__block BOOL valid = YES;
	
	[self.knownValues enumerateObjectsUsingBlock:^(id item, NSUInteger index, BOOL *stop) {
		NSUInteger test = [self fibonacciAtIndex: index];
		NSNumber *fibonacci = (NSNumber *) item;
		
		if ([fibonacci unsignedIntegerValue] != test) {
			NSLog(@"Confimation failed at %lu. test: %lu; expected: %@", (unsigned long)index, (unsigned long)test, fibonacci);
			valid = NO;
			*stop = YES;
		}
	}];
	
	return valid;
}
@end

int main(int argc, char *argv[]) {
	@autoreleasepool {        
		Fibonacci *fibonacci = [[Fibonacci alloc] init];
		NSLog(@"fibonacciAtIndex: %lu", (unsigned long)[fibonacci fibonacciAtIndex: 20]);
		NSLog(@"validated?: %@", [fibonacci validateSelf] ? @"Yes" : @"No");
		NSLog(@"count: %lu", (unsigned long) fibonacci.count);
	}
}
