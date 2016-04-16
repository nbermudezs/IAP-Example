//
//  ViewController.m
//  IAP-Example
//
//  Created by Nestor Bermudez Sarmiento on 4/15/16.
//  Copyright © 2016 Nestor Bermudez. All rights reserved.
//

#import "ViewController.h"
#import "ExtendedIAPHelper.h"

@interface ViewController ()
{
    NSArray *productIdentifiers;
    NSArray *productPrices;
    BOOL purchasingProduct;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [[ExtendedIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success) {
            // producs is an array of SKProduct objects.
            // the main three fields of a SKProduct are: productIdentifier, localizedDescription and price
            _products = products;

            // if the view is a table view that displays dynamically the possible items to purchase you can
            // call the refresh view here.
        }
    }];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productCanceled:) name:IAPHelperProductCanceledNotification object:nil];
}

- (void)productCanceled:(NSNotification *)notification {
    // unblock UI
    purchasingProduct = NO;
}

- (void)productPurchased:(NSNotification *)notification {
    // unblock UI
    // show success alert/update view to reflect new balance
    purchasingProduct = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper
-(void) restorePurchases
{
    [[ExtendedIAPHelper sharedInstance] restoreCompletedTransactions];
}

-(void) purchaseProduct:(NSString*)productIdentifier
{
    if (purchasingProduct) {
        return;
    }

    for (SKProduct *product in _products) {

        if ([product.productIdentifier isEqualToString:productIdentifier]) {
            purchasingProduct = YES;
            // block UI
            [[ExtendedIAPHelper sharedInstance] buyProduct:product];
        }
    }
}

#pragma mark - Example Methods
-(void) makeAPurchase{
    // this could be an IBAction.

    // retrieve the position from a tag in the sender if it is an IBAction
    // something like sender.view.tag
    int position = 0;
    SKProduct *product = [_products objectAtIndex:position];
    [self purchaseProduct:[product productIdentifier]];
}

@end
