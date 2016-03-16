//
//  YCFlipView.m
//  YCFlipView
//
//

#import "YCFlipView.h"
#import <QuartzCore/QuartzCore.h>

#define kAnimationDuration 2.0
#define kDistance 1000.0

@interface YCFlipView()

@property (nonatomic, retain) CATransformLayer *doubleSidedLayer;
@property (nonatomic, retain) CALayer *topLayer;
@property (nonatomic, retain) CALayer *bottomLayer;
@property (nonatomic, retain) UITapGestureRecognizer *tapGesture;


@end

@implementation YCFlipView

- (instancetype)initWithFrame:(CGRect)frame frontImage:(UIImage *)frontImage backImage:(UIImage *)backImage {
    
    if (self = [super initWithFrame:frame]) {
        
        self.frontImage = frontImage;
        self.backImage = backImage;
        
        self.backgroundColor = [UIColor clearColor];
        
        //Configuring doubleSidedLayer
        self.doubleSidedLayer  = [CATransformLayer layer];
        [self.doubleSidedLayer setFrame:self.bounds];
        
        //Set the anchor point to the left side of the layer
        [self.doubleSidedLayer setAnchorPoint:CGPointMake(0.5, 0.5)];
        
        //Configuring top layer
        self.topLayer = [[CALayer alloc] init];

        [self.topLayer setFrame:self.doubleSidedLayer.bounds];
        [self.topLayer setContents:(id)frontImage.CGImage];
        [self.topLayer setZPosition:2];
        [self.topLayer setDoubleSided:NO];

        
        //Configuring bottom layer
        self.bottomLayer = [[CALayer alloc]init];

        [self.bottomLayer setFrame:self.doubleSidedLayer.bounds];
        [self.bottomLayer setContents:(id)backImage.CGImage];
        [self.bottomLayer setZPosition:1];
        [self.bottomLayer setDoubleSided:NO];
        

    
        [self.doubleSidedLayer addSublayer:self.topLayer];
        [self.doubleSidedLayer addSublayer:self.bottomLayer];
        [self.layer addSublayer:self.doubleSidedLayer];
        
        self.tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doFlip:)];
        [self addGestureRecognizer:self.tapGesture];
        
        self.enableFlip = YES;
        self.direction = YCFlipDirectionLeftRight;
    }
    
    return self;
}

- (void)setInsets:(UIEdgeInsets)insets
{
    _insets = insets;
    self.topLayer.frame = UIEdgeInsetsInsetRect(self.bounds, insets);
    self.bottomLayer.frame = UIEdgeInsetsInsetRect(self.bounds, insets);
}

- (void)dealloc{

}

- (void)doFlip:(UIGestureRecognizer*) gestureRecognizer {
    
    if (!self.enableFlip) {
        return;
    }
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self];
    
    //Flipping the transform layer
    if([self.topLayer containsPoint:[self.topLayer convertPoint:touchPoint fromLayer:self.layer]]) {
        [self flipStartAnimation];
    }
}

- (void)flipStartAnimation
{
    [CATransaction setCompletionBlock:^ {
        if ([self.delegate respondsToSelector:@selector(viewDidFlipped:)]) {
            [self.delegate viewDidFlipped:self];
        }
    }];
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:kAnimationDuration];
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = 1.0 / -kDistance;
    
    self.doubleSidedLayer.transform = perspective;
    
    if (self.direction == YCFlipDirectionLeftRight) {
        [self.doubleSidedLayer setSublayerTransform :CATransform3DRotate(self.doubleSidedLayer.sublayerTransform, M_PI, 0, 1, 0)];
    }
    else{
        [self.doubleSidedLayer setSublayerTransform :CATransform3DRotate(self.doubleSidedLayer.sublayerTransform, M_PI, 1, 0, 0)];
    }
    
    [CATransaction commit];
}

- (void)setDirection:(YCFlipDirection)direction
{
    _direction = direction;
    if (direction == YCFlipDirectionUpdown) {
        self.bottomLayer.transform = CATransform3DMakeRotation( M_PI, 1, 0, 0);
    }
    else{
        self.bottomLayer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    }
}

- (void)reset
{
    self.doubleSidedLayer.transform = CATransform3DIdentity;
}

@end

