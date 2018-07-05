#import "DTWelcomeViewController.h"
#import <React/RCTRootView.h>
#import <React/RCTBridgeDelegate.h>
#import <React/RCTBridge.h>

// Let this View Controller handle getting the URL for the JS
@interface DTWelcomeViewController () <RCTBridgeDelegate>
@end

@implementation DTWelcomeViewController

// Set self.view on the VC to be an RCTRootView
- (void)loadView
{
    RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:@{}];
    self.view = [[RCTRootView alloc] initWithBridge:bridge
                                         moduleName:@"DoingThings"
                                  initialProperties:@{}];
}

// Use our bundled JS for now
- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
    NSBundle *gitdawgBundle = [NSBundle bundleForClass:DTWelcomeViewController.class];
    return [gitdawgBundle URLForResource:@"DoingThings" withExtension:@"js"];
}

@end