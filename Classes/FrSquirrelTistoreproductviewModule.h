/**
 * tistoreproductSquirrel
 *
 * Created by Your Name
 * Copyright (c) 2019 Your Company. All rights reserved.
 */

#import <StoreKit/StoreKit.h>
#import "TiModule.h"

@interface FrSquirrelTistoreproductviewModule : TiModule <SKStoreProductViewControllerDelegate>{
    SKStoreProductViewController *storeProductViewController;
    BOOL storeProductViewControllerAppId;
    BOOL storeProductViewControllerAnimated;
}
- (void)showApp:(id)args;
@end
