//
//  ListViewController.m
//  trello-client
//
//  Created by Simon Chaffetz on 4/27/14.
//  Copyright (c) 2014 Simon Chaffetz. All rights reserved.
//

#import "ListViewController.h"
#import <Parse/Parse.h>
#import "CardCell.h"
#import "CardViewController.h"
#import "NewCardViewController.h"
#import "NewCardCell.h"

@interface ListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *cardListTable;

@property (strong, nonatomic) NSMutableArray *cards;

@end

@implementation ListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"My Cards";
        self.cards = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.cardListTable.delegate = self;
    self.cardListTable.dataSource = self;
    [self.cardListTable registerNib:[UINib nibWithNibName:@"CardCell" bundle:nil]
             forCellReuseIdentifier:@"cardCell"];

    void (^parseSuccessCallback)(NSArray*, NSError*) = ^void(NSArray *objects, NSError *error) {
        if (!error) {
            [objects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [self.cards addObject:obj];
            }];
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        [self.cardListTable reloadData];
    };
    
    PFQuery *query = [PFQuery queryWithClassName:@"Card"];
    [query findObjectsInBackgroundWithBlock:parseSuccessCallback];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cards.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.cards.count) {
        CardCell *cardCell = [self.cardListTable dequeueReusableCellWithIdentifier:@"cardCell"];
        PFObject *card = self.cards[indexPath.row];
        cardCell.titleLabel.text = card[@"title"];
        return cardCell;
    } else {
        NewCardCell *newCardCell = [[NewCardCell alloc] init];
        newCardCell.promptLabel.text = @"New Card";
        return newCardCell;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.cards.count) {
        PFObject *card = self.cards[indexPath.row];
        CardViewController *cardViewController = [[CardViewController alloc] initWithCard:card];
        [self.navigationController pushViewController:cardViewController animated:YES];
    } else {
        [self navigateToNewCardVC];
    }
}

- (void) navigateToNewCardVC {
    NewCardViewController *newCardVC = [[NewCardViewController alloc] init];
    newCardVC.delegate = self;
    [self.navigationController pushViewController:newCardVC animated:YES];
}

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) addCard:(PFObject*)card {
    [card saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self.cards addObject:card];
        [self.cardListTable reloadData];
    }];
}

@end
