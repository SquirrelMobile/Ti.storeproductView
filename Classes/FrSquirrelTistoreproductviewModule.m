/**
 * tistoreproductSquirrel
 *
 * Created by Your Name
 * Copyright (c) 2019 Your Company. All rights reserved.
 */

#import "FrSquirrelTistoreproductviewModule.h"
#import "TiApp.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation FrSquirrelTistoreproductviewModule

#pragma mark Internal

// This is generated for your module, please do not change it
- (id)moduleGUID
{
  return @"a9427fef-1f89-4092-a42d-024f302d96bf";
}

// This is generated for your module, please do not change it
- (NSString *)moduleId
{
  return @"fr.squirrel.tistoreproductview";
}

#pragma mark Lifecycle

- (void)startup
{
  // This method is called when the module is first loaded
  // You *must* call the superclass
  [super startup];
  DebugLog(@"[DEBUG] %@ loaded", self);
}

#pragma Public APIs

- (void)showApp:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args, NSDictionary);
    
    int appId = [[args objectForKey:@"appId"] intValue];
    BOOL animated = YES;
    if([args objectForKey:@"animated"]){
        animated = [[args objectForKey:@"animated"] boolValue];
    }
    
    if([args objectForKey:@"success"]){
    }
    
    [self loadApp:appId animated:animated];
}

- (NSString *)example:(id)args
{
  // Example method. 
  // Call with "MyModule.example(args)"
  return @"hello world";
}

- (NSString *)exampleProp
{
  // Example property getter. 
  // Call with "MyModule.exampleProp" or "MyModule.getExampleProp()"
  return @"Titanium rocks!";
}

- (void)setExampleProp:(id)value
{
  // Example property setter. 
  // Call with "MyModule.exampleProp = 'newValue'" or "MyModule.setExampleProp('newValue')"
}
-(void)shutdown:(id)sender
{
    // this method is called when the module is being unloaded
    // typically this is during shutdown. make sure you don't do too
    // much processing here or the app will be quit forceably
    
    // you *must* call the superclass
    [super shutdown:sender];
}
#pragma mark Cleanup



#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
    // optionally release any resources that can be dynamically
    // reloaded once memory is available - such as caches
    [super didReceiveMemoryWarning:notification];
}


- (void)loadApp:(int)appId animated:(BOOL)animated
{
    NSDictionary *parameters = @{ SKStoreProductParameterITunesItemIdentifier:[NSNumber numberWithInt:appId] };
    
//    RELEASE_TO_NIL(storeProductViewController);
    storeProductViewController = [[SKStoreProductViewController alloc] init];
    storeProductViewController.delegate = self;
    
    storeProductViewControllerAppId = appId;
    storeProductViewControllerAnimated = animated;
    
    NSLog(@"[DEBUG] loading:%d...", appId);
    [storeProductViewController loadProductWithParameters:parameters completionBlock:^(BOOL result, NSError *error){
        if(result)
        {
            NSLog(@"[DEBUG] successfully loaded.");
            TiApp * tiApp = [TiApp app];
            
//            if ([TiUtils isIPad] == NO)
//            {
//                [[tiApp controller] manuallyRotateToOrientation:UIInterfaceOrientationPortrait
//                                                       duration:0.0];
//            }
            [tiApp showModalController:storeProductViewController
                              animated:storeProductViewControllerAnimated];
            [self fireEvent:@"success" withObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                   [NSNumber numberWithInt:appId], @"appId", nil]];
        }
        else
        {
            NSLog(@"[DEBUG] an error occurred.");
            [self fireEvent:@"error" withObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                 [NSNumber numberWithInt:appId], @"appId",
                                                 [error description], @"error", nil]];
        }
    }];
}
-(void)_listenerRemoved:(NSString *)type count:(int)count
{
    if (count == 0 && [type isEqualToString:@"my_event"])
    {
        // the last listener called for event named 'my_event' has
        // been removed, we can optionally clean up any resources
        // since no body is listening at this point for that event
    }
}
-(void)_listenerAdded:(NSString *)type count:(int)count
{
    if (count == 1 && [type isEqualToString:@"my_event"])
    {
        // the first (of potentially many) listener is being added
        // for event named 'my_event'
    }
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    TiApp * tiApp = [TiApp app];
    
    [tiApp hideModalController:storeProductViewController
                      animated:storeProductViewControllerAnimated];
    
    [self fireEvent:@"closed" withObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                          [NSNumber numberWithInt:storeProductViewControllerAppId], @"appId", nil]];
}



@end
