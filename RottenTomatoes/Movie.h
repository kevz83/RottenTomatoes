//
//  Movie.h
//  RottenTomatoes
//
//  Created by Kevin Shah on 6/6/14.
//  Copyright (c) 2014 KS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSString *movieName;
@property (nonatomic, strong) NSString *movieSynopsis;
@property (nonatomic, strong) NSString *profilePictureURL;
@property (nonatomic, strong) NSString *detailedPictureURL;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)moviesWithArray: (NSArray *)array;

@end
