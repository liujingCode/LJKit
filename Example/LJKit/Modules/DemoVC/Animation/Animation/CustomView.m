//
//  CustomView.m
//
//  Code generated using QuartzCode 1.66.4 on 2019/9/29.
//  www.quartzcodeapp.com
//

#import "CustomView.h"
#import "QCMethod.h"

@interface CustomView ()

@property (nonatomic, strong) NSMutableDictionary * layers;
@property (nonatomic, strong) NSMapTable * completionBlocks;
@property (nonatomic, assign) BOOL  updateLayerValueForCompletedAnimation;


@end

@implementation CustomView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self setupProperties];
		[self setupLayers];
	}
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self) {
		[self setupProperties];
		[self setupLayers];
	}
	return self;
}



- (void)setupProperties{
	self.completionBlocks = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsOpaqueMemory valueOptions:NSPointerFunctionsStrongMemory];;
	self.layers = [NSMutableDictionary dictionary];
	self.updateLayerValueForCompletedAnimation = YES;
	self.color = [UIColor colorWithRed:0.989 green: 0.86 blue:0.0142 alpha:1];
}

- (void)setupLayers{
	self.backgroundColor = [UIColor colorWithRed:1 green: 1 blue:1 alpha:1];
	
	CAShapeLayer * formValue = [CAShapeLayer layer];
	formValue.frame = CGRectMake(27.48, 28.99, 30, 15);
	formValue.path = [self formValuePath].CGPath;
	[self.layer addSublayer:formValue];
	self.layers[@"formValue"] = formValue;
	
	CAShapeLayer * toValue = [CAShapeLayer layer];
	toValue.frame = CGRectMake(27.48, 44, 30, 15);
	toValue.path = [self toValuePath].CGPath;
	[self.layer addSublayer:toValue];
	self.layers[@"toValue"] = toValue;
	
	[self resetLayerPropertiesForLayerIdentifiers:nil];
}

- (void)resetLayerPropertiesForLayerIdentifiers:(NSArray *)layerIds{
	[CATransaction begin];
	[CATransaction setDisableActions:YES];
	
	if(!layerIds || [layerIds containsObject:@"formValue"]){
		CAShapeLayer * formValue = self.layers[@"formValue"];
		formValue.anchorPoint = CGPointMake(0.5, 1);
		formValue.frame       = CGRectMake(27.48, 28.99, 30, 15);
		formValue.fillColor   = [UIColor colorWithRed:0.914 green: 0.539 blue:0.0451 alpha:1].CGColor;
		formValue.strokeColor = [UIColor colorWithRed:0.404 green: 0.404 blue:0.404 alpha:1].CGColor;
		formValue.lineWidth   = 0;
	}
	if(!layerIds || [layerIds containsObject:@"toValue"]){
		CAShapeLayer * toValue = self.layers[@"toValue"];
		toValue.anchorPoint = CGPointMake(0.5, 0);
		toValue.frame       = CGRectMake(27.48, 44, 30, 15);
		toValue.fillColor   = [UIColor colorWithRed:0.914 green: 0.539 blue:0.0451 alpha:1].CGColor;
		toValue.strokeColor = [UIColor colorWithRed:0.404 green: 0.404 blue:0.404 alpha:1].CGColor;
		toValue.lineWidth   = 0;
	}
	
	[CATransaction commit];
}

#pragma mark - Animation Setup

- (void)addUntitled1Animation{
	NSString * fillMode = kCAFillModeForwards;
	
	////An infinity animation
	
	////FormValue animation
	CABasicAnimation * formValueTransformAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
	formValueTransformAnim.fromValue    = @(0);
	formValueTransformAnim.toValue      = @(-30 * M_PI/180);
	formValueTransformAnim.duration     = 1;
	formValueTransformAnim.repeatCount  = INFINITY;
	formValueTransformAnim.autoreverses = YES;
	
	CAAnimationGroup * formValueUntitled1Anim = [QCMethod groupAnimations:@[formValueTransformAnim] fillMode:fillMode];
	[self.layers[@"formValue"] addAnimation:formValueUntitled1Anim forKey:@"formValueUntitled1Anim"];
	
	////ToValue animation
	CAKeyframeAnimation * toValueTransformAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
	toValueTransformAnim.values       = @[@(0), 
		 @(30 * M_PI/180)];
	toValueTransformAnim.keyTimes     = @[@0, @1];
	toValueTransformAnim.duration     = 1;
	toValueTransformAnim.repeatCount  = INFINITY;
	toValueTransformAnim.autoreverses = YES;
	
	CAAnimationGroup * toValueUntitled1Anim = [QCMethod groupAnimations:@[toValueTransformAnim] fillMode:fillMode];
	[self.layers[@"toValue"] addAnimation:toValueUntitled1Anim forKey:@"toValueUntitled1Anim"];
}

#pragma mark - Animation Cleanup

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
	void (^completionBlock)(BOOL) = [self.completionBlocks objectForKey:anim];;
	if (completionBlock){
		[self.completionBlocks removeObjectForKey:anim];
		if ((flag && self.updateLayerValueForCompletedAnimation) || [[anim valueForKey:@"needEndAnim"] boolValue]){
			[self updateLayerValuesForAnimationId:[anim valueForKey:@"animId"]];
			[self removeAnimationsForAnimationId:[anim valueForKey:@"animId"]];
		}
		completionBlock(flag);
	}
}

- (void)updateLayerValuesForAnimationId:(NSString *)identifier{
	if([identifier isEqualToString:@"Untitled1"]){
		[QCMethod updateValueFromPresentationLayerForAnimation:[self.layers[@"formValue"] animationForKey:@"formValueUntitled1Anim"] theLayer:self.layers[@"formValue"]];
		[QCMethod updateValueFromPresentationLayerForAnimation:[self.layers[@"toValue"] animationForKey:@"toValueUntitled1Anim"] theLayer:self.layers[@"toValue"]];
	}
}

- (void)removeAnimationsForAnimationId:(NSString *)identifier{
	if([identifier isEqualToString:@"Untitled1"]){
		[self.layers[@"formValue"] removeAnimationForKey:@"formValueUntitled1Anim"];
		[self.layers[@"toValue"] removeAnimationForKey:@"toValueUntitled1Anim"];
	}
}

- (void)removeAllAnimations{
	[self.layers enumerateKeysAndObjectsUsingBlock:^(id key, CALayer *layer, BOOL *stop) {
		[layer removeAllAnimations];
	}];
}

#pragma mark - Bezier Path

- (UIBezierPath*)formValuePath{
	CGRect bound = CGRectMake(0, 0, 30, 15);
	UIBezierPath*  formValuePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0) radius:CGRectGetWidth(bound)/2 startAngle:-180 * M_PI/180 endAngle:0 clockwise:YES];
	[formValuePath addLineToPoint:CGPointMake(0, 0)];
	[formValuePath closePath];
	
	CGAffineTransform pathTransform = CGAffineTransformMakeTranslation(CGRectGetMidX(bound), CGRectGetMidY(bound));;
	pathTransform = CGAffineTransformScale(pathTransform, 1, CGRectGetHeight(bound)/CGRectGetWidth(bound));;
	[formValuePath applyTransform:pathTransform];
	return formValuePath;
}

- (UIBezierPath*)toValuePath{
	CGRect bound = CGRectMake(0, 0, 30, 15);
	UIBezierPath*  toValuePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0) radius:CGRectGetWidth(bound)/2 startAngle:0 endAngle:-180 * M_PI/180 clockwise:YES];
	[toValuePath addLineToPoint:CGPointMake(0, 0)];
	[toValuePath closePath];
	
	CGAffineTransform pathTransform = CGAffineTransformMakeTranslation(CGRectGetMidX(bound), CGRectGetMidY(bound));;
	pathTransform = CGAffineTransformScale(pathTransform, 1, CGRectGetHeight(bound)/CGRectGetWidth(bound));;
	[toValuePath applyTransform:pathTransform];
	return toValuePath;
}


@end
