//
//  ViewController.h
//  ArExamples
//
//  Created by Pham Chi Cong on 9/15/17.
//  Copyright © 2017 Pham Chi Cong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>
#import <ARKit/ARKit.h>

@interface ViewController : UIViewController
- (void)setupScene;
- (void)setupSession;
@property NSMutableDictionary *planes;
@end
