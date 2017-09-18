//
//  ViewController.h
//  ArExamples
//
//  Created by Pham Chi Cong on 9/15/17.
//  Copyright © 2017 Pham Chi Cong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>
#import <ARKit/ARKit.h>
#import "Plane.h"
#import "Cube.h"
#import "Config.h"

@interface ViewController : UIViewController
//- (void)setupScene;
//- (void)setupSession;
//- (void)setupRecognizers;
//- (void)insertGeometry:(ARHitTestResult *)hitResult;
//- (void)explode:(ARHitTestResult *)hitResult;
//- (void)handleTapFrom: (UITapGestureRecognizer *)recognizer;
//- (void)handleHoldFrom: (UILongPressGestureRecognizer *)recognizer;
//- (void)handleHidePlaneFrom: (UILongPressGestureRecognizer *)recognizer;
//
//@property NSMutableDictionary *planes;
//@property NSMutableArray *boxes;

- (void)setupScene;
- (void)setupLights;
- (void)setupPhysics;
- (void)setupRecognizers;
- (void)updateConfig;
- (void)hidePlanes;
- (void)disableTracking:(BOOL)disabled;
- (void)insertCube:(ARHitTestResult *)hitResult;
- (void)explode:(ARHitTestResult *)hitResult;
- (void)insertCubeFrom: (UITapGestureRecognizer *)recognizer;
- (void)explodeFrom: (UITapGestureRecognizer *)recognizer;
- (void)geometryConfigFrom: (UITapGestureRecognizer *)recognizer;
- (IBAction)settingsUnwind:(UIStoryboardSegue *)segue;
- (IBAction)detectPlanesChanged:(id)sender;

@property (nonatomic, retain) NSMutableDictionary<NSUUID *, Plane *> *planes;
@property (nonatomic, retain) NSMutableArray<Cube *> *cubes;
@property (nonatomic, retain) Config *config;
@property (nonatomic, retain) ARWorldTrackingConfiguration *arConfig;
@end
