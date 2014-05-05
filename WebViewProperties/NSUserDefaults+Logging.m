//
//  NSUserDefaults+Logging.m
//  WebViewProperties
//
//  Created by Florin Pop on 12/11/13.
//  Copyright (c) 2013 Objective Self. All rights reserved.
//

#import "NSUserDefaults+Logging.h"
#import <objc/runtime.h>

@implementation NSUserDefaults (Logging)

/**
 * The new implementation of -[NSUserDefaults objectForKey:],
 * which relies on the original method to obtain the result
 * and displays the (key, result) pair using the console.
 */
- (id)swizzled_objectForKey:(NSString *)key
{
    static NSMutableArray *knownKeys;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        knownKeys = [[NSMutableArray alloc] init];
    });
    
    id result = [super performSelector:@selector(swizzled_objectForKey:) withObject:key];
    // Log the key if we didn't log it previously
    if ([key rangeOfString:@"WebKit"].location != NSNotFound && ![knownKeys containsObject:key])
    {
        [knownKeys addObject:key];
        NSLog(@"%@ = %@", key, result);
    }
    return result;
}

+ (void)load
{
    [super load];
    
    // Replace the -[NSUserDefaults objectForKey:] method with a custom implementation
    Method original, swizzled;
    
    original = class_getInstanceMethod(self, @selector(objectForKey:));
    swizzled = class_getInstanceMethod(self, @selector(swizzled_objectForKey:));
    method_exchangeImplementations(original, swizzled);
}

@end
