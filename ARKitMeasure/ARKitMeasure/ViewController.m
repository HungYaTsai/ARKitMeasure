//
//  ViewController.m
//  ARKitMeasure
//
//  Created by 蔡弘亞 on 26/07/2017.
//  Copyright © 2017 蔡弘亞. All rights reserved.
//

#import "ViewController.h"
#include <math.h>

@interface ViewController () <ARSCNViewDelegate, ARSessionDelegate>

@property (weak, nonatomic) IBOutlet ARSCNView *arsnView;
@property (weak, nonatomic) IBOutlet UITextView *distView;
@property (weak, nonatomic) IBOutlet UITextView *readyView;

@end

    
@implementation ViewController

bool measuring = false;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setMultipleTouchEnabled:YES];
    
    // Set the view's delegate
    self.arsnView.delegate = self;
    
    // Show statistics such as fps and timing information
    self.arsnView.showsStatistics = YES;
    
    // Create a new scene
    SCNScene *scene = [SCNScene new];
    
    // Set the scene to the view
    self.arsnView.scene = scene;
    [self.arsnView.session setDelegate:self];
    
    [self resetValue];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Create a session configuration
    ARWorldTrackingSessionConfiguration *configuration = [ARWorldTrackingSessionConfiguration new];
    
    // Run the view's session
    [self.arsnView.session runWithConfiguration:configuration];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Pause the view's session
    [self.arsnView.session pause];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
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
-(void) resetValue{
    measuring = false;
    startValue = SCNVector3Make(0.0, 0.0, 0.0);
    endValue =  SCNVector3Make(0.0, 0.0, 0.0);
    
    _distView.text = @"0.0 m";
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self resetValue];
    measuring = true;
}

-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    measuring = false;
}

- (void) updateDistanceView{
    float distance = sqrt((startValue.x - endValue.x) * (startValue.x - endValue.x) +
                               (startValue.y - endValue.y) * (startValue.y - endValue.y) +
                               (startValue.z - endValue.z) * (startValue.z - endValue.z));
    _distView.text = [NSString stringWithFormat:@"%f m", distance];
}

- (void)session:(ARSession *)session didUpdateFrame:(ARFrame *)frame{
    
    NSArray<ARHitTestResult *> *result = [frame hitTest:CGPointMake(0.5, 0.5) types:ARHitTestResultTypeFeaturePoint];
    
    if(result.count > 0)
        self.readyView.hidden = YES;
    if(measuring && result.count > 0 ){
        
        if(startValue.x == 0 && startValue.y == 0 && startValue.z == 0)
            startValue = SCNVector3Make(result[0].worldTransform.columns[3].x, result[0].worldTransform.columns[3].y, result[0].worldTransform.columns[3].z);
        endValue = SCNVector3Make(result[0].worldTransform.columns[3].x, result[0].worldTransform.columns[3].y, result[0].worldTransform.columns[3].z);
        
        [self updateDistanceView];
    }
}

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
