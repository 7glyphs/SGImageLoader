//
//  SGImageLoader.h
//  7 glyphs Ltd.
//  http://7glyphs.com
//
//  Created by Igor Anany on 24/12/13.
//  Copyright (c) 2014 7 glyphs Ltd. All rights reserved.
//

#import "SGImageLoader.h"

@interface SGImageLoader () {
    NSCache *_imageCache;
}
@end

@implementation SGImageLoader

+ (SGImageLoader *)sharedInstance {
    static dispatch_once_t onceToken;
    static SGImageLoader *shared = nil;
    dispatch_once(&onceToken, ^{
        shared = [[SGImageLoader alloc] init];
    });
    return shared;
}

- (id)init {
    self = [super init];
    if (self) {
        _imageCache = [[NSCache alloc] init];
    }
    return self;
}

- (void)loadImageFromURL:(NSString*)url completed:(void (^)(UIImage *image))completion {
    UIImage *image = [_imageCache objectForKey:url];
    if (image) {
        if (completion) {
            completion(image);
        }
    }
    else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            UIImage* image = [[UIImage alloc] initWithData:imageData];
            [_imageCache setObject:image forKey:url];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (completion) {
                    completion(image);
                }
            });
        });
    }
}

@end
