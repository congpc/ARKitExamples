//
//  ViewController.m
//  ArExamples
//
//  Created by Pham Chi Cong on 9/15/17.
//  Copyright © 2017 Pham Chi Cong. All rights reserved.
//

#import "ViewController.h"
#import "CollisionCategory.h"
#import "PBRMaterial.h"
#import "ConfigViewController.h"

@interface ViewController () <ARSCNViewDelegate, UIGestureRecognizerDelegate, SCNPhysicsContactDelegate>

@property (nonatomic, strong) IBOutlet ARSCNView *sceneView;

@end

//typedef NS_OPTIONS(NSUInteger, CollisionCategory) {
//    CollisionCategoryBottom  = 1 << 0,
//    CollisionCategoryCube    = 1 << 1,
//};
    
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupScene];
    [self setupLights];
    [self setupPhysics];
    [self setupRecognizers];
    
    // Create a ARSession confi object we can re-use
    self.arConfig = [ARWorldTrackingConfiguration new];
    self.arConfig.lightEstimationEnabled = YES;
    self.arConfig.planeDetection = ARPlaneDetectionHorizontal;
    
    Config *config = [Config new];
    config.showStatistics = NO;
    config.showWorldOrigin = YES;
    config.showFeaturePoints = YES;
    config.showPhysicsBodies = NO;
    config.detectPlanes = YES;
    self.config = config;
    [self updateConfig];
    
    // Stop the screen from dimming while we are using the app
    [UIApplication.sharedApplication setIdleTimerDisabled:YES];
    
//    // Set the view's delegate
//    self.sceneView.delegate = self;
//
//    // Show statistics such as fps and timing information
//    self.sceneView.showsStatistics = YES;
//
//    // Create a new scene
//    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/ship.scn"];
//
//    // Set the scene to the view
//    self.sceneView.scene = scene;
    // Container to hold all of the 3D geometry
//    SCNScene *scene = [SCNScene new];
//
//    // The 3D cube geometry we want to draw
//    SCNBox *boxGeometry = [SCNBox boxWithWidth:0.1 height:0.1 length:0.1 chamferRadius:0.0];
//
//    // The node that wraps the geometry so we can add it to the scene
//    SCNNode *boxNode = [SCNNode nodeWithGeometry:boxGeometry];
//
//    // Position the box just in front of the camera
//    boxNode.position = SCNVector3Make(0, 0, -0.5);
//
//    // rootNode is a special node, it is the starting point of all
//    // the items in the 3D scene
//    [scene.rootNode addChildNode:boxNode];
//
//    // Set teh scene to the view
//    self.sceneView.scene = scene;
//
//    self.sceneView.autoenablesDefaultLighting = YES;
//    self.sceneView.debugOptions = ARSCNDebugOptionShowWorldOrigin | ARSCNDebugOptionShowFeaturePoints;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self setupSession];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    // Run the view's session
    [self.sceneView.session runWithConfiguration: self.arConfig options: 0];
    
//    // Create a session configuration
//    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];
//
//    // Run the view's session
//    [self.sceneView.session runWithConfiguration:configuration];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Pause the view's session
    [self.sceneView.session pause];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


//- (void)setupScene {
//    // Setup the ARSCNViewDelegate - this gives us callbacks to handle new
//    // geometry creation
//    self.sceneView.delegate = self;
//
//    // A dictionary of all the current planes being rendered in the scene
//    self.planes = [NSMutableDictionary new];
//
//    // Show statistics such as fps and timing information
//    self.sceneView.showsStatistics = YES;
//    self.sceneView.autoenablesDefaultLighting = YES;
//
//    // Turn on debug options to show the world origin and also render all
//    // of the feature points ARKit is tracking
//    self.sceneView.debugOptions =
//    ARSCNDebugOptionShowWorldOrigin |
//    ARSCNDebugOptionShowFeaturePoints;
//
//    SCNScene *scene = [SCNScene new];
//    self.sceneView.scene = scene;
//}

//Part3
//- (void)setupScene {
//    // Setup the ARSCNViewDelegate - this gives us callbacks to handle new
//    // geometry creation
//    self.sceneView.delegate = self;
//
//    // A dictionary of all the current planes being rendered in the scene
//    self.planes = [NSMutableDictionary new];
//
//    // Contains a list of all the boxes rendered in the scene
//    self.boxes = [NSMutableArray new];
//
//    // Show statistics such as fps and timing information
//    self.sceneView.showsStatistics = YES;
//    self.sceneView.autoenablesDefaultLighting = YES;
//
//    // Turn on debug options to show the world origin and also render all
//    // of the feature points ARKit is tracking
//    self.sceneView.debugOptions =
//    ARSCNDebugOptionShowWorldOrigin |
//    ARSCNDebugOptionShowFeaturePoints;
//
//    // Add this to see bounding geometry for physics interactions
//    //SCNDebugOptionShowPhysicsShapes;
//
//    SCNScene *scene = [SCNScene new];
//    self.sceneView.scene = scene;
//
//    // For our physics interactions, we place a large node a couple of meters below the world
//    // origin, after an explosion, if the geometry we added has fallen onto this surface which
//    // is place way below all of the surfaces we would have detected via ARKit then we consider
//    // this geometry to have fallen out of the world and remove it
//    SCNBox *bottomPlane = [SCNBox boxWithWidth:1000 height:0.5 length:1000 chamferRadius:0];
//    SCNMaterial *bottomMaterial = [SCNMaterial new];
//    bottomMaterial.diffuse.contents = [UIColor colorWithWhite:1.0 alpha:0.0];
//    bottomPlane.materials = @[bottomMaterial];
//    SCNNode *bottomNode = [SCNNode nodeWithGeometry:bottomPlane];
//    bottomNode.position = SCNVector3Make(0, -10, 0);
//    bottomNode.physicsBody = [SCNPhysicsBody
//                              bodyWithType:SCNPhysicsBodyTypeKinematic
//                              shape: nil];
//    bottomNode.physicsBody.categoryBitMask = CollisionCategoryBottom;
//    bottomNode.physicsBody.contactTestBitMask = CollisionCategoryCube;
//    [self.sceneView.scene.rootNode addChildNode:bottomNode];
//    self.sceneView.scene.physicsWorld.contactDelegate = self;
//}
//
//- (void)setupSession {
//    // Create a session configuration
//    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];
//
//    // Specify that we do want to track horizontal planes. Setting this will cause the ARSCNViewDelegate
//    // methods to be called when scenes are detected
//    configuration.planeDetection = ARPlaneDetectionHorizontal;
//
//    // Run the view's session
//    [self.sceneView.session runWithConfiguration:configuration];
//}
//- (void)setupRecognizers {
//    // Single tap will insert a new piece of geometry into the scene
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
//    tapGestureRecognizer.numberOfTapsRequired = 1;
//    [self.sceneView addGestureRecognizer:tapGestureRecognizer];
//
//    // Press and hold will cause an explosion causing geometry in the local vicinity of the explosion to move
//    UILongPressGestureRecognizer *explosionGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleHoldFrom:)];
//    explosionGestureRecognizer.minimumPressDuration = 0.5;
//    [self.sceneView addGestureRecognizer:explosionGestureRecognizer];
//
//    UILongPressGestureRecognizer *hidePlanesGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleHidePlaneFrom:)];
//    hidePlanesGestureRecognizer.minimumPressDuration = 1;
//    hidePlanesGestureRecognizer.numberOfTouchesRequired = 2;
//    [self.sceneView addGestureRecognizer:hidePlanesGestureRecognizer];
//}
//
//- (void)handleTapFrom: (UITapGestureRecognizer *)recognizer {
//    // Take the screen space tap coordinates and pass them to the hitTest method on the ARSCNView instance
//    CGPoint tapPoint = [recognizer locationInView:self.sceneView];
//    NSArray<ARHitTestResult *> *result = [self.sceneView hitTest:tapPoint types:ARHitTestResultTypeExistingPlaneUsingExtent];
//
//    // If the intersection ray passes through any plane geometry they will be returned, with the planes
//    // ordered by distance from the camera
//    if (result.count == 0) {
//        return;
//    }
//
//    // If there are multiple hits, just pick the closest plane
//    ARHitTestResult * hitResult = [result firstObject];
//    [self insertGeometry:hitResult];
//}
//
//- (void)handleHoldFrom: (UILongPressGestureRecognizer *)recognizer {
//    if (recognizer.state != UIGestureRecognizerStateBegan) {
//        return;
//    }
//
//    // Perform a hit test using the screen coordinates to see if the user pressed on
//    // a plane.
//    CGPoint holdPoint = [recognizer locationInView:self.sceneView];
//    NSArray<ARHitTestResult *> *result = [self.sceneView hitTest:holdPoint types:ARHitTestResultTypeExistingPlaneUsingExtent];
//    if (result.count == 0) {
//        return;
//    }
//
//    ARHitTestResult * hitResult = [result firstObject];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self explode:hitResult];
//    });
//}
//
//- (void)handleHidePlaneFrom: (UILongPressGestureRecognizer *)recognizer {
//    if (recognizer.state != UIGestureRecognizerStateBegan) {
//        return;
//    }
//
//    // Hide all the planes
//    for(NSUUID *planeId in self.planes) {
//        [self.planes[planeId] hide];
//    }
//
//    // Stop detecting new planes or updating existing ones.
//    ARWorldTrackingConfiguration *configuration = (ARWorldTrackingConfiguration *)self.sceneView.session.configuration;
//    configuration.planeDetection = ARPlaneDetectionNone;
//    [self.sceneView.session runWithConfiguration:configuration];
//}
//
//- (void)explode:(ARHitTestResult *)hitResult {
//    // For an explosion, we take the world position of the explosion and the position of each piece of geometry
//    // in the world. We then take the distance between those two points, the closer to the explosion point the
//    // geometry is the stronger the force of the explosion.
//
//    // The hitResult will be a point on the plane, we move the explosion down a little bit below the
//    // plane so that the goemetry fly upwards off the plane
//    float explosionYOffset = 0.1;
//
//    SCNVector3 position = SCNVector3Make(
//                                         hitResult.worldTransform.columns[3].x,
//                                         hitResult.worldTransform.columns[3].y - explosionYOffset,
//                                         hitResult.worldTransform.columns[3].z
//                                         );
//
//    // We need to find all of the geometry affected by the explosion, ideally we would have some
//    // spatial data structure like an octree to efficiently find all geometry close to the explosion
//    // but since we don't have many items, we can just loop through all of the current geoemtry
//    for(SCNNode *cubeNode in self.boxes) {
//        // The distance between the explosion and the geometry
//        SCNVector3 distance = SCNVector3Make(
//                                             cubeNode.worldPosition.x - position.x,
//                                             cubeNode.worldPosition.y - position.y,
//                                             cubeNode.worldPosition.z - position.z
//                                             );
//
//        float len = sqrtf(distance.x * distance.x + distance.y * distance.y + distance.z * distance.z);
//
//        // Set the maximum distance that the explosion will be felt, anything further than 2 meters from
//        // the explosion will not be affected by any forces
//        float maxDistance = 2;
//        float scale = MAX(0, (maxDistance - len));
//
//        // Scale the force of the explosion
//        scale = scale * scale * 2;
//
//        // Scale the distance vector to the appropriate scale
//        distance.x = distance.x / len * scale;
//        distance.y = distance.y / len * scale;
//        distance.z = distance.z / len * scale;
//
//        // Apply a force to the geometry. We apply the force at one of the corners of the cube
//        // to make it spin more, vs just at the center
//        [cubeNode.physicsBody applyForce:distance atPosition:SCNVector3Make(0.05, 0.05, 0.05) impulse:YES];
//    }
//}
//
//- (void)insertGeometry:(ARHitTestResult *)hitResult {
//    // Right now we just insert a simple cube, later we will improve these to be more
//    // interesting and have better texture and shading
//
//    float dimension = 0.1;
//    SCNBox *cube = [SCNBox boxWithWidth:dimension height:dimension length:dimension chamferRadius:0];
//    SCNNode *node = [SCNNode nodeWithGeometry:cube];
//
//    // The physicsBody tells SceneKit this geometry should be manipulated by the physics engine
//    node.physicsBody = [SCNPhysicsBody bodyWithType:SCNPhysicsBodyTypeDynamic shape:nil];
//    node.physicsBody.mass = 2.0;
//    node.physicsBody.categoryBitMask = CollisionCategoryCube;
//
//    // We insert the geometry slightly above the point the user tapped, so that it drops onto the plane
//    // using the physics engine
//    float insertionYOffset = 0.5;
//    node.position = SCNVector3Make(
//                                   hitResult.worldTransform.columns[3].x,
//                                   hitResult.worldTransform.columns[3].y + insertionYOffset,
//                                   hitResult.worldTransform.columns[3].z
//                                   );
//    [self.sceneView.scene.rootNode addChildNode:node];
//    [self.boxes addObject:node];
//}

//Part4
- (void)setupScene {
    // Setup the ARSCNViewDelegate - this gives us callbacks to handle new
    // geometry creation
    self.sceneView.delegate = self;
    
    // A dictionary of all the current planes being rendered in the scene
    self.planes = [NSMutableDictionary new];
    
    // A list of all the cubes being rendered in the scene
    self.cubes = [NSMutableArray new];
    
    // Make things look pretty :)
    self.sceneView.antialiasingMode = SCNAntialiasingModeMultisampling4X;
    
    // This is the object that we add all of our geometry to, if you want
    // to render something you need to add it here
    SCNScene *scene = [SCNScene new];
    self.sceneView.scene = scene;
}

- (void)setupPhysics {
    
    // For our physics interactions, we place a large node a couple of meters below the world
    // origin, after an explosion, if the geometry we added has fallen onto this surface which
    // is place way below all of the surfaces we would have detected via ARKit then we consider
    // this geometry to have fallen out of the world and remove it
    SCNBox *bottomPlane = [SCNBox boxWithWidth:1000 height:0.5 length:1000 chamferRadius:0];
    SCNMaterial *bottomMaterial = [SCNMaterial new];
    
    // Make it transparent so you can't see it
    bottomMaterial.diffuse.contents = [UIColor colorWithWhite:1.0 alpha:0.0];
    bottomPlane.materials = @[bottomMaterial];
    SCNNode *bottomNode = [SCNNode nodeWithGeometry:bottomPlane];
    
    // Place it way below the world origin to catch all falling cubes
    bottomNode.position = SCNVector3Make(0, -10, 0);
    bottomNode.physicsBody = [SCNPhysicsBody
                              bodyWithType:SCNPhysicsBodyTypeKinematic
                              shape: nil];
    bottomNode.physicsBody.categoryBitMask = CollisionCategoryBottom;
    bottomNode.physicsBody.contactTestBitMask = CollisionCategoryCube;
    
    SCNScene *scene = self.sceneView.scene;
    [scene.rootNode addChildNode:bottomNode];
    scene.physicsWorld.contactDelegate = self;
}

- (void)setupLights {
    // Turn off all the default lights SceneKit adds since we are handling it ourselves
    self.sceneView.autoenablesDefaultLighting = NO;
    self.sceneView.automaticallyUpdatesLighting = NO;
  
    UIImage *bg = [UIImage imageNamed: @"./Assets.scnassets/Environment/spherical.jpg"];
    self.sceneView.scene.background.contents = bg;
  
    UIImage *env = [UIImage imageNamed: @"./Assets.scnassets/Environment/spherical.jpg"];
    self.sceneView.scene.lightingEnvironment.contents = env;
    //self.sceneView.scene.lightingEnvironment.intensity = 2.0;
    
    //TODO: wantsHdr
}
- (void)insertSpotLight:(SCNVector3)position {
    SCNLight *spotLight = [SCNLight light];
    spotLight.type = SCNLightTypeSpot;
    spotLight.spotInnerAngle = 45;
    spotLight.spotOuterAngle = 45;
    SCNNode *spotNode = [SCNNode new];
    spotNode.light = spotLight;
    spotNode.position = position;
    // By default the stop light points directly down the negative
    // z-axis, we want to shine it down so rotate 90deg around the
    // x-axis to point it down
    spotNode.eulerAngles = SCNVector3Make(-M_PI / 2, 0, 0);
    [self.sceneView.scene.rootNode addChildNode: spotNode];
}

- (void)setupRecognizers {
    // Single tap will insert a new piece of geometry into the scene
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(insertCubeFrom:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.sceneView addGestureRecognizer:tapGestureRecognizer];
    
    // Press and hold will open a config menu for the selected geometry
    UILongPressGestureRecognizer *materialGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(geometryConfigFrom:)];
    materialGestureRecognizer.minimumPressDuration = 0.5;
    [self.sceneView addGestureRecognizer:materialGestureRecognizer];
    
    // Press and hold with two fingers causes an explosion
    UILongPressGestureRecognizer *explodeGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(explodeFrom:)];
    explodeGestureRecognizer.minimumPressDuration = 1;
    explodeGestureRecognizer.numberOfTouchesRequired = 2;
    [self.sceneView addGestureRecognizer:explodeGestureRecognizer];
}

- (void)insertCubeFrom: (UITapGestureRecognizer *)recognizer {
    // Take the screen space tap coordinates and pass them to the hitTest method on the ARSCNView instance
    CGPoint tapPoint = [recognizer locationInView:self.sceneView];
    NSArray<ARHitTestResult *> *result = [self.sceneView hitTest:tapPoint types:ARHitTestResultTypeExistingPlaneUsingExtent];
    
    // If the intersection ray passes through any plane geometry they will be returned, with the planes
    // ordered by distance from the camera
    if (result.count == 0) {
        return;
    }
    
    // If there are multiple hits, just pick the closest plane
    ARHitTestResult * hitResult = [result firstObject];
    [self insertCube:hitResult];
}

- (void)explodeFrom: (UILongPressGestureRecognizer *)recognizer {
    if (recognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }
    
    // Perform a hit test using the screen coordinates to see if the user pressed on
    // a plane.
    CGPoint holdPoint = [recognizer locationInView:self.sceneView];
    NSArray<ARHitTestResult *> *result = [self.sceneView hitTest:holdPoint types:ARHitTestResultTypeExistingPlaneUsingExtent];
    if (result.count == 0) {
        return;
    }
    
    ARHitTestResult * hitResult = [result firstObject];
    [self explode:hitResult];
}

- (void)geometryConfigFrom: (UILongPressGestureRecognizer *)recognizer {
    if (recognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }
    
    // Perform a hit test using the screen coordinates to see if the user pressed on
    // any 3D geometry in the scene, if so we will open a config menu for that
    // geometry to customize the appearance
    
    CGPoint holdPoint = [recognizer locationInView:self.sceneView];
    NSArray<SCNHitTestResult *> *result = [self.sceneView hitTest:holdPoint
                                                          options:@{SCNHitTestBoundingBoxOnlyKey: @YES, SCNHitTestFirstFoundOnlyKey: @YES}];
    if (result.count == 0) {
        return;
    }
    
    SCNHitTestResult * hitResult = [result firstObject];
    SCNNode *node = hitResult.node;
    
    // We add all the geometry as children of the Plane/Cube SCNNode object, so we can
    // get the parent and see what type of geometry this is
    SCNNode *parentNode = node.parentNode;
    if ([parentNode isKindOfClass:[Cube class]]) {
        [((Cube *)parentNode) changeMaterial];
    } else if ([parentNode isKindOfClass:[Plane class]]) {
        [((Plane *)parentNode) changeMaterial];
    }
}

- (void)hidePlanes {
    for(NSUUID *planeId in self.planes) {
        [self.planes[planeId] hide];
    }
}

- (void)disableTracking:(BOOL)disabled {
    // Stop detecting new planes or updating existing ones.
    
    if (disabled) {
        self.arConfig.planeDetection = ARPlaneDetectionNone;
    } else {
        self.arConfig.planeDetection = ARPlaneDetectionHorizontal;
    }
    
    [self.sceneView.session runWithConfiguration:self.arConfig];
}

- (void)explode:(ARHitTestResult *)hitResult {
    // For an explosion, we take the world position of the explosion and the position of each piece of geometry
    // in the world. We then take the distance between those two points, the closer to the explosion point the
    // geometry is the stronger the force of the explosion.
    
    // The hitResult will be a point on the plane, we move the explosion down a little bit below the
    // plane so that the goemetry fly upwards off the plane
    float explosionYOffset = 0.1;
    
    SCNVector3 position = SCNVector3Make(
                                         hitResult.worldTransform.columns[3].x,
                                         hitResult.worldTransform.columns[3].y - explosionYOffset,
                                         hitResult.worldTransform.columns[3].z
                                         );
    
    // We need to find all of the geometry affected by the explosion, ideally we would have some
    // spatial data structure like an octree to efficiently find all geometry close to the explosion
    // but since we don't have many items, we can just loop through all of the current geoemtry
    for(SCNNode *cubeNode in self.cubes) {
        // The distance between the explosion and the geometry
        SCNVector3 distance = SCNVector3Make(
                                             cubeNode.worldPosition.x - position.x,
                                             cubeNode.worldPosition.y - position.y,
                                             cubeNode.worldPosition.z - position.z
                                             );
        
        float len = sqrtf(distance.x * distance.x + distance.y * distance.y + distance.z * distance.z);
        
        // Set the maximum distance that the explosion will be felt, anything further than 2 meters from
        // the explosion will not be affected by any forces
        float maxDistance = 2;
        float scale = MAX(0, (maxDistance - len));
        
        // Scale the force of the explosion
        scale = scale * scale * 5;
        
        // Scale the distance vector to the appropriate scale
        distance.x = distance.x / len * scale;
        distance.y = distance.y / len * scale;
        distance.z = distance.z / len * scale;
        
        // Apply a force to the geometry. We apply the force at one of the corners of the cube
        // to make it spin more, vs just at the center
        [[cubeNode.childNodes firstObject].physicsBody applyForce:distance atPosition:SCNVector3Make(0.05, 0.05, 0.05) impulse:YES];
    }
}

- (void)insertCube:(ARHitTestResult *)hitResult {
    // We insert the geometry slightly above the point the user tapped, so that it drops onto the plane
    // using the physics engine
    float insertionYOffset = 0.5;
    SCNVector3 position = SCNVector3Make(
                                         hitResult.worldTransform.columns[3].x,
                                         hitResult.worldTransform.columns[3].y + insertionYOffset,
                                         hitResult.worldTransform.columns[3].z
                                         );
    Cube *cube = [[Cube alloc] initAtPosition:position withMaterial:[Cube currentMaterial]];
    [self.cubes addObject:cube];
    [self.sceneView.scene.rootNode addChildNode:cube];
    
//    [self insertSpotLight:position];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Called just before we transition to the config screen
    ConfigViewController *configController = (ConfigViewController *)segue.destinationViewController;
    
    // NOTE: I am using a popover so that we do't get the viewWillAppear method called when
    // we close the popover, if that gets called (like if you did a modal settings page), then
    // the session configuration is updated and we lose tracking. By default it shouldn't but
    // it still seems to.
    configController.modalPresentationStyle = UIModalPresentationPopover;
    configController.popoverPresentationController.delegate = self;
    configController.config = self.config;
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

- (IBAction)settingsUnwind:(UIStoryboardSegue *)segue {
    // Called after we navigate back from the config screen
    
    ConfigViewController *configView = (ConfigViewController *)segue.sourceViewController;
    Config *config = self.config;
    
    config.showPhysicsBodies = configView.physicsBodies.on;
    config.showFeaturePoints = configView.featurePoints.on;
    config.showWorldOrigin = configView.worldOrigin.on;
    config.showStatistics = configView.statistics.on;
    [self updateConfig];
}

- (IBAction)detectPlanesChanged:(id)sender {
    BOOL enabled = ((UISwitch *)sender).on;
    
    if (enabled == self.config.detectPlanes) {
        return;
    }
    
    self.config.detectPlanes = enabled;
    if (enabled) {
        [self disableTracking: NO];
    } else {
        [self disableTracking: YES];
    }
}

- (void)updateConfig {
    SCNDebugOptions opts = SCNDebugOptionNone;
    Config *config = self.config;
    if (config.showWorldOrigin) {
        opts |= ARSCNDebugOptionShowWorldOrigin;
    }
    if (config.showFeaturePoints) {
        opts = ARSCNDebugOptionShowFeaturePoints;
    }
    if (config.showPhysicsBodies) {
        opts |= SCNDebugOptionShowPhysicsShapes;
    }
    self.sceneView.debugOptions = opts;
    if (config.showStatistics) {
        self.sceneView.showsStatistics = YES;
    } else {
        self.sceneView.showsStatistics = NO;
    }
}

//#pragma mark - SCNPhysicsContactDelegate
//
//- (void)physicsWorld:(SCNPhysicsWorld *)world didBeginContact:(SCNPhysicsContact *)contact {
//    // Here we detect a collision between pieces of geometry in the world, if one of the pieces
//    // of geometry is the bottom plane it means the geometry has fallen out of the world. just remove it
//    CollisionCategory contactMask = contact.nodeA.physicsBody.categoryBitMask | contact.nodeB.physicsBody.categoryBitMask;
//
//    if (contactMask == (CollisionCategoryBottom | CollisionCategoryCube)) {
//        if (contact.nodeA.physicsBody.categoryBitMask == CollisionCategoryBottom) {
//            [contact.nodeB removeFromParentNode];
//        } else {
//            [contact.nodeA removeFromParentNode];
//        }
//    }
//}
//
//#pragma mark - ARSCNViewDelegate
///**
// Called when a new node has been mapped to the given anchor.
//
// @param renderer The renderer that will render the scene.
// @param node The node that maps to the anchor.
// @param anchor The added anchor.
// */
//- (void)renderer:(id <SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
//    if (![anchor isKindOfClass:[ARPlaneAnchor class]]) {
//        return;
//    }
//
//    // When a new plane is detected we create a new SceneKit plane to visualize it in 3D
////    Plane *plane = [[Plane alloc] initWithAnchor: (ARPlaneAnchor *)anchor];
////    [self.planes setObject:plane forKey:anchor.identifier];
////    [node addChildNode:plane];
//
//    // When a new plane is detected we create a new SceneKit plane to visualize it in 3D
//    Plane *plane = [[Plane alloc] initWithAnchor: (ARPlaneAnchor *)anchor isHidden: NO];
//    [self.planes setObject:plane forKey:anchor.identifier];
//    [node addChildNode:plane];
//}
//
///**
// Called when a node has been updated with data from the given anchor.
//
// @param renderer The renderer that will render the scene.
// @param node The node that was updated.
// @param anchor The anchor that was updated.
// */
//- (void)renderer:(id <SCNSceneRenderer>)renderer didUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
//    Plane *plane = [self.planes objectForKey:anchor.identifier];
//    if (plane == nil) {
//        return;
//    }
//
//    // When an anchor is updated we need to also update our 3D geometry too. For example
//    // the width and height of the plane detection may have changed so we need to update
//    // our SceneKit geometry to match that
//    [plane update:(ARPlaneAnchor *)anchor];
//}
//
///**
// Called when a mapped node has been removed from the scene graph for the given anchor.
//
// @param renderer The renderer that will render the scene.
// @param node The node that was removed.
// @param anchor The anchor that was removed.
// */
//- (void)renderer:(id <SCNSceneRenderer>)renderer didRemoveNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
//    // Nodes will be removed if planes multiple individual planes that are detected to all be
//    // part of a larger plane are merged.
//    [self.planes removeObjectForKey:anchor.identifier];
//}
//
///**
// Called when a node will be updated with data from the given anchor.
//
// @param renderer The renderer that will render the scene.
// @param node The node that will be updated.
// @param anchor The anchor that was updated.
// */
//- (void)renderer:(id <SCNSceneRenderer>)renderer willUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
//}

#pragma mark - SCNPhysicsContactDelegate

- (void)physicsWorld:(SCNPhysicsWorld *)world didBeginContact:(SCNPhysicsContact *)contact {
    // Here we detect a collision between pieces of geometry in the world, if one of the pieces
    // of geometry is the bottom plane it means the geometry has fallen out of the world. just remove it
    CollisionCategory contactMask = contact.nodeA.physicsBody.categoryBitMask | contact.nodeB.physicsBody.categoryBitMask;
    
    if (contactMask == (CollisionCategoryBottom | CollisionCategoryCube)) {
        if (contact.nodeA.physicsBody.categoryBitMask == CollisionCategoryBottom) {
            [contact.nodeB removeFromParentNode];
        } else {
            [contact.nodeA removeFromParentNode];
        }
    }
}

#pragma mark - ARSCNViewDelegate

- (void)renderer:(id <SCNSceneRenderer>)renderer updateAtTime:(NSTimeInterval)time {
    ARLightEstimate *estimate = self.sceneView.session.currentFrame.lightEstimate;
    if (!estimate) {
        return;
    }
    
    // A value of 1000 is considered neutral, lighting environment intensity normalizes
    // 1.0 to neutral so we need to scale the ambientIntensity value
    CGFloat intensity = estimate.ambientIntensity / 1000.0;
    self.sceneView.scene.lightingEnvironment.intensity = intensity;
}

/**
 Called when a new node has been mapped to the given anchor.
 
 @param renderer The renderer that will render the scene.
 @param node The node that maps to the anchor.
 @param anchor The added anchor.
 */
- (void)renderer:(id <SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    if (![anchor isKindOfClass:[ARPlaneAnchor class]]) {
        return;
    }
    
    // When a new plane is detected we create a new SceneKit plane to visualize it in 3D
    Plane *plane = [[Plane alloc] initWithAnchor: (ARPlaneAnchor *)anchor isHidden: NO withMaterial:[Plane currentMaterial]];
    [self.planes setObject:plane forKey:anchor.identifier];
    [node addChildNode:plane];
}

/**
 Called when a node has been updated with data from the given anchor.
 
 @param renderer The renderer that will render the scene.
 @param node The node that was updated.
 @param anchor The anchor that was updated.
 */
- (void)renderer:(id <SCNSceneRenderer>)renderer didUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    Plane *plane = [self.planes objectForKey:anchor.identifier];
    if (plane == nil) {
        return;
    }
    
    // When an anchor is updated we need to also update our 3D geometry too. For example
    // the width and height of the plane detection may have changed so we need to update
    // our SceneKit geometry to match that
    [plane update:(ARPlaneAnchor *)anchor];
}

/**
 Called when a mapped node has been removed from the scene graph for the given anchor.
 
 @param renderer The renderer that will render the scene.
 @param node The node that was removed.
 @param anchor The anchor that was removed.
 */
- (void)renderer:(id <SCNSceneRenderer>)renderer didRemoveNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    // Nodes will be removed if planes multiple individual planes that are detected to all be
    // part of a larger plane are merged.
    [self.planes removeObjectForKey:anchor.identifier];
}

/**
 Called when a node will be updated with data from the given anchor.
 
 @param renderer The renderer that will render the scene.
 @param node The node that will be updated.
 @param anchor The anchor that was updated.
 */
- (void)renderer:(id <SCNSceneRenderer>)renderer willUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
}

#pragma mark - ARSCNViewDelegate

/*
// Override to create and configure nodes for anchors added to the view's session.
- (SCNNode *)renderer:(id<SCNSceneRenderer>)renderer nodeForAnchor:(ARAnchor *)anchor {
    SCNNode *node = [SCNNode new];
 
    // Add geometry to the node...
 
    return node;
}
*/

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    // Present an error message to the user
    
}

- (void)sessionWasInterrupted:(ARSession *)session {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay
    
}

- (void)sessionInterruptionEnded:(ARSession *)session {
    // Reset tracking and/or remove existing anchors if consistent tracking is required
    
}

@end
