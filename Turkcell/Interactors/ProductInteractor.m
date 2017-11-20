//
//  ProductInteractor.m
//  Turkcell
//
//  Created by Alaattin Bedir on 19.11.2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import "ProductInteractor.h"
#import "ProductInteractorOutput.h"
#import "Product.h"
#import "ProductsViewOutput.h"
#import "Utilities.h"

@implementation ProductInteractor

@synthesize products;

- (void)setData:(NSArray *)products{
    NSLog(@"hop");
}

- (void)setViewForSetup:(UIView *)view {
    NSLog(@"lalala");
}

# pragma ProductInteractorInput methods

- (void) requestProduct {
    NSString *urlAsString = [NSString stringWithFormat:@"https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/list"];
    
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedUrlAsString = [urlAsString stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [[session dataTaskWithURL:[NSURL URLWithString:encodedUrlAsString]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                NSLog(@"RESPONSE: %@",response);
                NSLog(@"DATA: %@",data);
                
                if (!error) {
                    // Success
                    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                        NSError *jsonError;
                        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                        
                        if (jsonError) {
                            // Error Parsing JSON
                            [Utilities.sharedClient showMessage:@"Error occured while parsing JSON" withTitle:@"Error"];
                        } else {
                            // Success Parsing JSON
                            // Log NSDictionary response:
                            NSLog(@"%@",jsonResponse);
                            // Get product list from dictionaries
                            dispatch_async(dispatch_get_main_queue(), ^{
                                NSArray *products = [Product arrayWithDictionary:jsonResponse];
                                [self.view setData:products];
                            });
                            
                        }
                    }  else {
                        //Web server is returning an error
                        [Utilities.sharedClient showMessage:@"Server connection failed" withTitle:@"Error"];
                    }
                } else {
                    // Fail
                    [Utilities.sharedClient showMessage:error.description withTitle:@"Error"];
                    NSLog(@"error : %@", error.description);
                }
            }] resume];
}

@end
