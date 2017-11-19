//
//  ProductsViewController.m
//  Turkcell
//
//  Created by Alaattin Bedir on 19.11.2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import "ProductsViewController.h"
#import "ProductCell.h"
#import "Product.h"
#import "ProductsViewOutput.h"
#import "ProductsViewInput.h"
#import "ProductPresenter.h"
#import "ProductInteractor.h"
#import "DetailViewController.h"


@interface ProductsViewController (){
    
}

@end

NSString *kDetailedViewControllerID = @"DetailView";    // view controller storyboard id
NSString *kCellID = @"cellID";                          // UICollectionViewCell storyboard id

@implementation ProductsViewController
@synthesize products;

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self build];
    [self.output didTriggerViewReadyEvent];
    [self.output setViewForSetup:self.view];
    
    [self.interactor requestProduct];
    
}

- (void)build {
    
    ProductPresenter *presenter = [ProductPresenter new];
    ProductInteractor *interactor = [ProductInteractor new];
    presenter.view = self;
    interactor.output = presenter;
    interactor.view = presenter;
    presenter.interactor = interactor;
    self.output = presenter;
    self.interactor = interactor;
    
}


#pragma mark - ProductsViewOutput
- (void)setData:(NSArray *)products {
    self.products = products;
    [self.collectionView reloadData];
}


#pragma mark - ProductViewInput
- (void)setupInitialState {
    self.navigationItem.title = @"Product List";
    self.view.backgroundColor = [UIColor darkGrayColor];
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
////    int cellWidth = ([UIScreen mainScreen].bounds.size.width - (3 * 20)) / 3;
////    return CGSizeMake(cellWidth, cellWidth);
//}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return self.products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    // we're going to use a custom UICollectionViewCell, which will hold an image and its label
    ProductCell *cell = [cv dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];    
    Product *product = [self.products objectAtIndex:indexPath.row];
    
    // load the image for this cell
    [cell.cellActivator startAnimating];
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: product.image]];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.cellActivator stopAnimating];
            [cell.cellActivator setHidden:YES];
            cell.productImage.image = [UIImage imageWithData: data];
        });
        
    });
    
    // make the cell's title the actual NSIndexPath value
    cell.productLabel.text = product.name;
    
    // make the cell's price the actual NSIndexPath value
    cell.productPrice.text = [NSString stringWithFormat:@"%ld", product.price];
    
    return cell;
}

// the user tapped a collection item, load and set the image on the detail view controller
//
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showDetail"])
    {
        NSIndexPath *selectedIndexPath = [self.collectionView indexPathsForSelectedItems][0];
        
        // load the product
        Product *product = [self.products objectAtIndex:(long)selectedIndexPath.row];
        DetailViewController *detailViewController = segue.destinationViewController;
        detailViewController.product = product;        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
