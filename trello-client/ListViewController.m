//
//  ListViewController.m
//  trello-client
//
//  Created by Simon Chaffetz on 4/27/14.
//  Copyright (c) 2014 Simon Chaffetz. All rights reserved.
//

#import "ListViewController.h"
#import "Parse/Parse.h"
#import "CardCell.h"
#import "CardViewController.h"
#import "Card.h"

@interface ListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *cardListTable;
- (IBAction)tapNewCard:(id)sender;

@end

@implementation ListViewController

- (ListViewController *) initWithCards:(NSMutableArray *)cards {
    self = [super init];
    if (self) {
        _cards = cards;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"My Cards";
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
    [self.cardListTable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cards.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CardCell *cardCell = [self.cardListTable dequeueReusableCellWithIdentifier:@"cardCell"];
    Card *card = self.cards[indexPath.row];
    cardCell.titleLabel.text = card.title;
    return cardCell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Card *card = self.cards[indexPath.row];
    CardViewController *cardViewController = [[CardViewController alloc] initWithCard:card];
    [self.navigationController pushViewController:cardViewController animated:YES];
}

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)tapNewCard:(id)sender {
    NSLog(@"Can't touch this!");
}
@end