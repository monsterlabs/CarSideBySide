YISplashScreen 1.0.0
====================

Easy splash screen + animation maker for iOS5+.

<img src="https://raw.github.com/inamiy/YISplashScreen/master/Screenshots/screenshot1.png" alt="ScreenShot1" width="225px" style="width:225px;" />

- `YISplashScreen` creates another UIWindow on top of status-bar so that transition will be nicer, compared to adding splash image directly on `rootViewController.view`.
- `animationBlock` is used to hide splash image with two arguments:
  - `splashLayer`: splash image layer (superlayer = another window, by default)
  - `rootLayer`: equivalent to `rootViewController.view.layer` (superlayer = main window)

Normally, animating `splashLayer` and `rootLayer` individually on separate UIWindows is sufficient, 
but if you want to put them in one main window during animation, 
prepare it by setting `shouldMoveSplashLayerToMainWindowBeforeAnimation = YES` 
so that `splashLayer.superlayer` will be main window (below status-bar) instead,
and more importantly, it prevents from layer-flickering.

Install via [CocoaPods](http://cocoapods.org/)
----------

```
pod 'YISplashScreen'
```

How to use
----------

```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // show splash
    [YISplashScreen show];
    
    // simple fade out
    [YISplashScreen hide];
    
    return YES;
}
```

Hiding Animations
-----------------
```
// simple fade out
[YISplashScreen hide];

// cube
[YISplashScreen hideWithAnimation:[YISplashScreenAnimation cubeAnimation]];

// manually add animation
[YISplashScreen hideWithAnimationBlock:^(CALayer* splashLayer, CALayer* rootLayer) {
    
    // splashLayer moves up
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.7];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    splashLayer.position = CGPointMake(splashLayer.position.x, splashLayer.position.y-splashLayer.bounds.size.height);
    
    [CATransaction commit];
    
}];
```

CoreData Migration
------------------
By using `[YISplashScreen waitForMigration:completion:]` (optional), you can easily integrate simple UIAlertView-confirmation UI.

```
[YISplashScreen waitForMigration:^{
    
    //
    // NOTE: add CoreData migration logic here
    //
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                             configuration:nil
                                                       URL:url
                                                   options:options
                                                     error:nil];

} completion:^{
    
    [YISplashScreen hide];
    
}];
```

License
-------
`YISplashScreen` is available under the [Beerware](http://en.wikipedia.org/wiki/Beerware) license.

If we meet some day, and you think this stuff is worth it, you can buy me a beer in return.
