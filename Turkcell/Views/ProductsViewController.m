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
#import "MyDataController.h"


@interface ProductsViewController (){
    NSCache *_imageCache;
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
    
    // Build VIPER structure
    ProductPresenter *presenter = [ProductPresenter new];
    ProductInteractor *interactor = [ProductInteractor new];
    presenter.view = self;
    presenter.interactor = interactor;
    interactor.output = presenter;
    interactor.view = presenter;
    self.output = presenter;
    self.interactor = interactor;
    
}


#pragma mark - ProductsViewOutput
- (void)setData:(NSArray *)products {
    self.products = products;
    [self.collectionView reloadData];
    
    // DB operations should be process in background thread to prevent to lock ui thread.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^{
        [[MyDataController sharedClient] saveProducts:products];
    });
    
}


#pragma mark - ProductViewInput
- (void)setupInitialState {
    self.navigationItem.title = @"Product List";
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    // Setting collection view layout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(170, 190)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setMinimumInteritemSpacing:2];
    [flowLayout setMinimumLineSpacing:2];
    [flowLayout setHeaderReferenceSize:CGSizeMake(0, 2)];
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    // Initialize image cache
    if(_imageCache==nil)
    {
        _imageCache=[[NSCache alloc]init];        
    }
    [_imageCache setEvictsObjectsWithDiscardedContent:NO];
    
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return self.products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    // We will use a custom UICollectionViewCell
    ProductCell *cell = [cv dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    Product *product = [self.products objectAtIndex:indexPath.row];
    
    // We should cache image to use it later while scrolling.
    UIImage *image = [_imageCache objectForKey:product.productId];
    if(image)
    {
        cell.productImage.image = image;
    }
    else
    {
        // load the image for this cell
        [cell.cellActivator startAnimating];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0), ^{
            NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: product.image]];
            if ( data == nil )
                return;
            
            UIImage *image = [UIImage imageWithData: data];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [cell.cellActivator stopAnimating];
                    [cell.cellActivator setHidden:YES];
                    cell.productImage.image = image;
                });
                
                // Set image to cache with productId so that it can be use later while scrolling content
                [_imageCache setObject:image forKey:product.productId];
            }
        });
    }
    
    // set the product's name
    cell.productLabel.text = product.name;
    
    // set the product's price
    cell.productPrice.text = [NSString stringWithFormat:@"%ld", product.price];
    
    return cell;
}

// User pressed a collection item, load and set the image on the detailViewController
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
