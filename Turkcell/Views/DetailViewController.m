//
//  DetailViewController.m
//  Turkcell
//
//  Created by Alaattin Bedir on 19.11.2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import "DetailViewController.h"
#import "MyDataController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *productDescLabel;
@end

@implementation DetailViewController
@synthesize product;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setViewForSetup];
}

- (void)setViewForSetup {
    self.nameLabel.text = self.product.name;
    self.priceLabel.text = [NSString stringWithFormat:@"%ld",self.product.price];
    self.productDescLabel.text = self.product.desc;
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *productId = [f numberFromString:self.product.productId];
    ProductMO *productMO = (ProductMO*)[[MyDataController sharedClient] getProduct:productId];

    // If image stored then use it
    if (productMO.image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_activityIndicator setHidden:YES];
            self.productImageView.image = [UIImage imageWithData: productMO.image];
        });
    }else{
        [_activityIndicator startAnimating];
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: self.product.image]];
            if ( data == nil )
                return;
            dispatch_async(dispatch_get_main_queue(), ^{
                [_activityIndicator stopAnimating];
                [_activityIndicator setHidden:YES];
                self.productImageView.image = [UIImage imageWithData: data];
            });
        });
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

