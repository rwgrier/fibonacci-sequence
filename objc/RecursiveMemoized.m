//  Fibonacci Sequence using recursion with memoization
//
//  Created by Ryan Grier on 03/03/16.
//  Copyright © 2016 Ryan Grier All rights reserved.

#import <Foundation/Foundation.h>

@interface Fibonacci : NSObject
@property (nonatomic, strong) NSArray *knownValues;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, strong) NSMutableDictionary *memoized;
- (NSUInteger) fibonacciAtIndex: (NSUInteger) index;
- (BOOL) validateSelf;
@end

@implementation Fibonacci
- (instancetype) init {
	self = [super init];
	
	if (self) {
		self.knownValues = @[ @0, @1, @1, @2, @3, @5, @8, @13, @21, @34, @55, @89, @144, @233, @377, @610, @987, @1597, @2584, @4181, @6765, @10946, @17711, @28657, @46368, @75025, @121393, @196418, @317811 ];
		self.count = 0;
		self.memoized = [NSMutableDictionary dictionary];
	}
	
	return self;
}

- (NSUInteger) fibonacciAtIndex: (NSUInteger) index {
	NSNumber *memoized = self.memoized[@(index)];
	if (memoized != nil) {
		return [memoized unsignedIntegerValue];
	}
	
	if (index < 2) {
		return index;
	}
	
	self.count++;
	NSUInteger fibonacci = [self fibonacciAtIndex: index - 1] + [self fibonacciAtIndex: index - 2];
	self.memoized[@(index)] = @(fibonacci);
	return fibonacci;
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
