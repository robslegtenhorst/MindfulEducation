//
//  VIMVimeoResponseSerializer.m
//  VIMNetworking
//
//  Created by Hanssen, Alfie on 9/19/14.
//  Copyright (c) 2014-2015 Vimeo (https://vimeo.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "VIMJSONResponseSerializer.h"

@implementation VIMJSONResponseSerializer

+ (instancetype)serializer
{
    VIMJSONResponseSerializer *serializer = [[self alloc] init];
    serializer.readingOptions = NSJSONReadingAllowFragments;
    [serializer setAcceptableContentTypes:[VIMJSONResponseSerializer acceptableContentTypes]];
    
    return serializer;
}

+ (NSSet *)acceptableContentTypes
{
    return [NSSet setWithObjects:@"application/json",
                                 @"text/json",
                                 @"text/html",
                                 @"text/javascript",
                                 @"application/vnd.vimeo.video+json",
                                 @"application/vnd.vimeo.cover+json",
                                 @"application/vnd.vimeo.service+json",
                                 @"application/vnd.vimeo.comment+json",
                                 @"application/vnd.vimeo.user+json",
                                 @"application/vnd.vimeo.picture+json",
                                 @"application/vnd.vimeo.activity+json",
                                 @"application/vnd.vimeo.uploadticket+json",
                                 @"application/vnd.vimeo.error+json",
                                 @"application/vnd.vimeo.trigger+json",
                                 @"application/vnd.vimeo.category+json",
                                 @"application/vnd.vimeo.channel+json",
                                 nil];
}

@end
