//
// explicit-ivar.m: test properties backed by explicit ivars
// synthaway
//
// Copyright (c) 2012 Inkling Systems, Inc.
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
//    http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import <Foundation/Foundation.h>

@interface Foo : NSObject
{
	NSString *a;
}
@property (retain) NSString *a;
@property (retain) NSString *b;
@property (retain) NSString *c;
@end

@implementation Foo
@synthesize a;
@synthesize b;
@synthesize c;
- (void)dealloc
{
	[a release];
	[b release];
	[c release];
	[super dealloc];
}
- (BOOL)test
{
	return [a isEqual:b] && [self.b isEqual:self->c] && [self->a isEqual:self.c];
}
@end

int main()
{
    @autoreleasepool {
        Foo *foo = [[[Foo alloc] init] autorelease];
        foo.a = @"a";
        foo.b = @"a";
        foo.c = @"a";
        assert([foo.a isEqual:foo.b]);
        assert([foo.a isEqual:foo.c]);
        assert([foo test]);
    }
}
