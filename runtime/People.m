//
//  People.m
//  runtime
//
//  Created by 李雀 on 2018/7/24.
//  Copyright © 2018年 com.meituan. All rights reserved.
//

#import "People.h"
#import "Bird.h"
#import "Monkey.h"
#import <objc/runtime.h>


@implementation People

void speak(id self, SEL _cmd){
    NSLog(@"Now I can speak.");
}

+(BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"resolveInstanceMethod: %@",NSStringFromSelector(sel));
    if(sel == @selector(speak)) {
        class_addMethod([self class], sel, (IMP)speak, "V@:");
    
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

-(id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"forwardingTargetForSelector: %@",NSStringFromSelector(aSelector));
    Bird *bird = [[Bird alloc] init];
    if([bird respondsToSelector:aSelector]) {
        return bird;
    }
    return [super forwardingTargetForSelector:aSelector];
}

-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSLog(@"method signature for selector: %@",NSStringFromSelector(aSelector));
    if(aSelector == @selector(code)) {
        return [NSMethodSignature signatureWithObjCTypes:"V@:@"];
    }
    return [super methodSignatureForSelector:aSelector];
}

-(void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"forwardInvocation: %@",NSStringFromSelector([anInvocation selector]));
    
    if([anInvocation selector] == @selector(code)) {
        Monkey *monkey = [[Monkey alloc] init];
        [anInvocation invokeWithTarget:monkey];
    }
}

-(void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"doesNotRecognizeSelector: %@",NSStringFromSelector(aSelector));
    [super doesNotRecognizeSelector:aSelector];
}

@end
