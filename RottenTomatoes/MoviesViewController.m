//
//  MoviesViewController.m
//  RottenTomatoes
//
//  Created by Kevin Shah on 6/6/14.
//  Copyright (c) 2014 KS. All rights reserved.
//

#import "MoviesViewController.h"
#import "MoviesTableViewCell.h"
#import "MovieDetailsViewController.h"
#import "Movie.h"
#import "UIImageView+AFNetworking.h"
#import "ProgressHUD.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *movies;
@property (weak, nonatomic) IBOutlet UIView *networkError;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

- (void)networkCall;

@end

@implementation MoviesViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 130;

    self.refreshControl = [[UIRefreshControl alloc]init];
  //  self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(160, 5, 20, 10)];
    
    [self.networkError setFrame:CGRectMake(0, 0, 0, 0)];
    
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MoviesTableViewCell" bundle:nil] forCellReuseIdentifier:@"MoviesTableViewCell"];
    
    self.tableView.delegate = self;
    
    [ProgressHUD show:@"Loading..."];
    [self networkCall];
    
    self.navigationItem.title = @"Movies";
}

- (void)networkCall
{
    //[ self.movies removeAllObjects];
    
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=tznqjf985n6cyegkfubhbrzz";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(data != nil)
        {
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@", object);
            
            id moviesObject = object[@"movies"];
            
            if(moviesObject != nil)
            {
                self.networkError.hidden = YES;
                [self.networkError setFrame:CGRectMake(0, 0, 0, 0)];
                
                self.movies = [Movie moviesWithArray:moviesObject];
                [ProgressHUD dismiss];
                [self.refreshControl endRefreshing];
                [self.tableView reloadData];
            }
            else
            {
                self.networkError.hidden = NO;
                [self.networkError setFrame:CGRectMake(0, 0, 320, 24)];
            }
        }
        else
        {
            self.networkError.hidden = NO;
             [self.networkError setFrame:CGRectMake(0, 0, 320, 24)];
        }
    }];
}

- (void)refreshTable
{
    //[ProgressHUD dismiss];
    [self.refreshControl endRefreshing];
    [self networkCall];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movies.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoviesTableViewCell *movieCell = [tableView dequeueReusableCellWithIdentifier:@"MoviesTableViewCell"];
    
    Movie *rowMovie = self.movies[indexPath.row];
    
    movieCell.movieName.text = rowMovie.movieName;
    movieCell.description.text = rowMovie.movieSynopsis;
    [movieCell.moviePoster setImageWithURL:[NSURL URLWithString:rowMovie.profilePictureURL ]];
        
    return movieCell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieDetailsViewController *detailsViewController = [[MovieDetailsViewController alloc] init];
    
    detailsViewController.selectedMovie = self.movies[indexPath.row];
    
    //call the delegate to pass information.
    [self.navigationController pushViewController:detailsViewController animated:YES];
    
}

-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] ;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
