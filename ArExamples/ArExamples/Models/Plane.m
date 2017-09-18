//
//  Plane.m
//  arkit-by-example
//
//  Created by md on 6/9/17.
//  Copyright © 2017 ruanestudios. All rights reserved.
//

#import "Plane.h"

@implementation Plane
//Part2
//- (instancetype)initWithAnchor:(ARPlaneAnchor *)anchor {
//  self = [super init];
//  
//  self.anchor = anchor;
//    
//  // Create the 3D plane geometry with the dimensions reported
//  // by ARKit in the ARPlaneAnchor instance
//  self.planeGeometry = [SCNPlane planeWithWidth:anchor.extent.x height:anchor.extent.z];
//  
//  // Instead of just visualizing the grid as a gray plane, we will render
//  // it in some Tron style colours.
//  SCNMaterial *material = [SCNMaterial new];
//  UIImage *img = [UIImage imageNamed:@"tron_grid"];
//  material.diffuse.contents = img;
//  self.planeGeometry.materials = @[material];
//  
//  SCNNode *planeNode = [SCNNode nodeWithGeometry:self.planeGeometry];
//  planeNode.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z);
//  
//  // Planes in SceneKit are vertical by default so we need to rotate 90degrees to match
//  // planes in ARKit
//  planeNode.transform = SCNMatrix4MakeRotation(-M_PI / 2.0, 1.0, 0.0, 0.0);
//
//  [self setTextureScale];
//  [self addChildNode:planeNode];
//  return self;
//}
//
//- (void)update:(ARPlaneAnchor *)anchor {
//  // As the user moves around the extend and location of the plane
//  // may be updated. We need to update our 3D geometry to match the
//  // new parameters of the plane.
//  self.planeGeometry.width = anchor.extent.x;
//  self.planeGeometry.height = anchor.extent.z;
//  
//  // When the plane is first created it's center is 0,0,0 and the nodes
//  // transform contains the translation parameters. As the plane is updated
//  // the planes translation remains the same but it's center is updated so
//  // we need to update the 3D geometry position
//  self.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z);
//  [self setTextureScale];
//}
//
//- (void)setTextureScale {
//  CGFloat width = self.planeGeometry.width;
//  CGFloat height = self.planeGeometry.height;
//  
//  // As the width/height of the plane updates, we want our tron grid material to
//  // cover the entire plane, repeating the texture over and over. Also if the
//  // grid is less than 1 unit, we don't want to squash the texture to fit, so
//  // scaling updates the texture co-ordinates to crop the texture in that case
//  SCNMaterial *material = self.planeGeometry.materials.firstObject;
//  material.diffuse.contentsTransform = SCNMatrix4MakeScale(width, height, 1);
//  material.diffuse.wrapS = SCNWrapModeRepeat;
//  material.diffuse.wrapT = SCNWrapModeRepeat;
//}

//Part3
- (instancetype)initWithAnchor:(ARPlaneAnchor *)anchor isHidden:(BOOL)hidden {
    self = [super init];
    
    self.anchor = anchor;
    float width = anchor.extent.x;
    float length = anchor.extent.z;
    
    // Using a SCNBox and not SCNPlane to make it easy for the geometry we add to the
    // scene to interact with the plane.
    
    // For the physics engine to work properly give the plane some height so we get interactions
    // between the plane and the gometry we add to the scene
    float planeHeight = 0.01;
    
    self.planeGeometry = [SCNBox boxWithWidth:width height:planeHeight length:length chamferRadius:0];
    
    // Instead of just visualizing the grid as a gray plane, we will render
    // it in some Tron style colours.
    SCNMaterial *material = [SCNMaterial new];
    UIImage *img = [UIImage imageNamed:@"tron_grid"];
    material.diffuse.contents = img;
    
    // Since we are using a cube, we only want to render the tron grid
    // on the top face, make the other sides transparent
    SCNMaterial *transparentMaterial = [SCNMaterial new];
    transparentMaterial.diffuse.contents = [UIColor colorWithWhite:1.0 alpha:0.0];
    
    if (hidden) {
        self.planeGeometry.materials = @[transparentMaterial, transparentMaterial, transparentMaterial, transparentMaterial, transparentMaterial, transparentMaterial];
    } else {
        self.planeGeometry.materials = @[transparentMaterial, transparentMaterial, transparentMaterial, transparentMaterial, material, transparentMaterial];
    }
    
    SCNNode *planeNode = [SCNNode nodeWithGeometry:self.planeGeometry];
    
    // Since our plane has some height, move it down to be at the actual surface
    planeNode.position = SCNVector3Make(0, -planeHeight / 2, 0);
    
    // Give the plane a physics body so that items we add to the scene interact with it
    planeNode.physicsBody = [SCNPhysicsBody
                             bodyWithType:SCNPhysicsBodyTypeKinematic
                             shape: [SCNPhysicsShape shapeWithGeometry:self.planeGeometry options:nil]];
    
    [self setTextureScale];
    [self addChildNode:planeNode];
    return self;
}

- (void)update:(ARPlaneAnchor *)anchor {
    // As the user moves around the extend and location of the plane
    // may be updated. We need to update our 3D geometry to match the
    // new parameters of the plane.
    self.planeGeometry.width = anchor.extent.x;
    self.planeGeometry.length = anchor.extent.z;
    
    // When the plane is first created it's center is 0,0,0 and the nodes
    // transform contains the translation parameters. As the plane is updated
    // the planes translation remains the same but it's center is updated so
    // we need to update the 3D geometry position
    self.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z);
    
    SCNNode *node = [self.childNodes firstObject];
    //self.physicsBody = nil;
    node.physicsBody = [SCNPhysicsBody
                        bodyWithType:SCNPhysicsBodyTypeKinematic
                        shape: [SCNPhysicsShape shapeWithGeometry:self.planeGeometry options:nil]];
    [self setTextureScale];
}

- (void)setTextureScale {
    CGFloat width = self.planeGeometry.width;
    CGFloat height = self.planeGeometry.length;
    
    // As the width/height of the plane updates, we want our tron grid material to
    // cover the entire plane, repeating the texture over and over. Also if the
    // grid is less than 1 unit, we don't want to squash the texture to fit, so
    // scaling updates the texture co-ordinates to crop the texture in that case
    SCNMaterial *material = self.planeGeometry.materials[4];
    material.diffuse.contentsTransform = SCNMatrix4MakeScale(width, height, 1);
    material.diffuse.wrapS = SCNWrapModeRepeat;
    material.diffuse.wrapT = SCNWrapModeRepeat;
}

- (void)hide {
    SCNMaterial *transparentMaterial = [SCNMaterial new];
    transparentMaterial.diffuse.contents = [UIColor colorWithWhite:1.0 alpha:0.0];
    self.planeGeometry.materials = @[transparentMaterial, transparentMaterial, transparentMaterial, transparentMaterial, transparentMaterial, transparentMaterial];
}
@end
