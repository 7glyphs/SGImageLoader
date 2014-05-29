//
//  SGImageLoader.h
//  7 glyphs Ltd.
//	http://7glyphs.com
//
//  Created by Igor Anany on 24/12/13.
//  Copyright (c) 2014 7 glyphs Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGImageLoader : NSObject

+ (SGImageLoader *)sharedInstance;
- (void)loadImageFromURL:(NSString*)url completed:(void (^)(UIImage *image))completion;

@end
