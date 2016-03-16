//
//  YCFlipView.h
//  YCFlipView
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@class YCFlipView;

@protocol YCFlipViewDelegate<NSObject>

- (void)viewDidFlipped:(YCFlipView *)view;

@end

typedef NS_ENUM(NSInteger, YCFlipDirection){
    YCFlipDirectionUpdown,
    YCFlipDirectionLeftRight
};

@interface YCFlipView : UIView

@property (nonatomic, assign) YCFlipDirection direction;
@property (nonatomic, assign) id<YCFlipViewDelegate> delegate;
@property (nonatomic, assign) BOOL enableFlip;
@property (nonatomic, assign) UIEdgeInsets insets;
@property (nonatomic, retain) UIImage *frontImage;
@property (nonatomic, retain) UIImage *backImage;

-(instancetype)initWithFrame:(CGRect)frame frontImage:(UIImage *)frontImage backImage:(UIImage *)backImage;
- (void)flipStartAnimation;

@end





