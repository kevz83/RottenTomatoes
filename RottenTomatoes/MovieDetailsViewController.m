//
//  MovieDetailsViewController.m
//  RottenTomatoes
//
//  Created by Kevin Shah on 6/6/14.
//  Copyright (c) 2014 KS. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailsViewController ()


@end

@implementation MovieDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = self.selectedMovie.movieName;
    
    [self.posterImage setImageWithURL:[NSURL URLWithString:self.selectedMovie.detailedPictureURL ]];
    self.movieTitleLabel.text = self.selectedMovie.movieName;
    self.synopsisLabel.text = self.selectedMovie.movieSynopsis;
    [self.synopsisLabel sizeToFit];
    
    self.scrollViewSynposis.contentSize = CGSizeMake(320, 900);
 
    self.scrollViewSynposis.scrollEnabled = YES;
    self.scrollViewSynposis.frame = self.view.frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
