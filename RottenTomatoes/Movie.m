//
//  Movie.m
//  RottenTomatoes
//
//  Created by Kevin Shah on 6/6/14.
//  Copyright (c) 2014 KS. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(self)
    {
        self.movieName = dictionary[@"title"];
        self.movieSynopsis = dictionary[@"synopsis"];
        self.profilePictureURL = dictionary[@"posters"][@"profile"];
        self.detailedPictureURL = dictionary[@"posters"][@"detailed"];
    }
    
    return self;
}

+ (NSMutableArray *)moviesWithArray: (NSMutableArray *)array
{
    NSMutableArray *movies = [[NSMutableArray alloc] init];
    
    for(NSMutableDictionary *dictionary in array)
    {
        Movie *movie = [[Movie alloc] initWithDictionary:dictionary];
        [movies addObject:movie];
    }
    
    return movies;
    
}



@end
