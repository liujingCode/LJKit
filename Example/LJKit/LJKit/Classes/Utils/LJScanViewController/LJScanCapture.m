//
//  LJScanCapture.m
//  LJKit_Example
//
//  Created by developer on 2019/10/30.
//  Copyright © 2019 liujing. All rights reserved.
//

#import "LJScanCapture.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@interface LJScanCapture ()<AVCaptureMetadataOutputObjectsDelegate>
@property (assign,nonatomic)AVCaptureDevice *device;
@property (strong,nonatomic)AVCaptureDeviceInput *input;
@property (strong,nonatomic)AVCaptureMetadataOutput *output;
@property (strong,nonatomic)AVCaptureSession *session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer *previewLayer;

/// 扫描区域
@property (nonatomic, assign) CGRect scanRect;
/// 预览视图
@property (nonatomic, assign) UIView *preView;
/// 扫描类型
@property (nonatomic, copy) NSArray *objTypes;
@end
@implementation LJScanCapture
+(instancetype)scanWithPreView:(UIView*)preView andObjectType:(NSArray*)objTypes andScanRect:(CGRect)scanRect {
    LJScanCapture *scanCapture = [[LJScanCapture alloc] initWithPreView:preView andObjectType:objTypes andScanRect:scanRect];
    return scanCapture;
}

-(instancetype)initWithPreView:(UIView*)preView andObjectType:(NSArray*)objTypes andScanRect:(CGRect)scanRect {
    if (self = [super init]) {
        self.scanRect = scanRect;
        self.preView = preView;
        self.objTypes = objTypes;
        [self setupScan];
    }
    return self;
}

#pragma mark - 扫描
- (void)startScan {
    if (!self.session.isRunning) {
        [self.session startRunning];
    }
}

- (void)stopScan {
    if (self.session.isRunning) {
        [self.session stopRunning];
    }
    
}

- (void)setFlashEnable:(BOOL)flashEnable {
    _flashEnable = flashEnable;
    [self.input.device lockForConfiguration:nil];
    self.input.device.torchMode = flashEnable ? AVCaptureTorchModeOn : AVCaptureTorchModeOff;
    [self.input.device unlockForConfiguration];
}

- (void)setFocalScale:(float)focalScale {
    _focalScale = focalScale;
    
    AVCaptureConnection *connect=[self.output connectionWithMediaType:AVMediaTypeVideo];

    [CATransaction begin];

    [CATransaction setAnimationDuration:0.2];
    
    [self.previewLayer setAffineTransform:CGAffineTransformMakeScale(focalScale, focalScale)];

    connect.videoScaleAndCropFactor= focalScale;

    [CATransaction commit];
}

- (UIView *)stillImageOutput {
    return [UIImageView new];
}


//- (void)setFocalScale:(CGFloat)scale {
//    [_input.device lockForConfiguration:nil];
//       
//       AVCaptureConnection *videoConnection = [self connectionWithMediaType:AVMediaTypeVideo fromConnections:[[self stillImageOutput] connections]];
//       
//       CGFloat zoom = scale / videoConnection.videoScaleAndCropFactor;
//       
//       videoConnection.videoScaleAndCropFactor = scale;
//       
//       [_input.device unlockForConfiguration];
//       
//       CGAffineTransform transform = _videoPreView.transform;
//       
//       _videoPreView.transform = CGAffineTransformScale(transform, zoom, zoom);
//}

#pragma mark - 初始化
- (void)setupScan{
    if (!self.device) {
        return;
    }
    if (!self.input){
        return ;
    }
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    if (!CGRectEqualToRect(self.scanRect,CGRectZero) ){
        CGFloat x = self.scanRect.origin.y / self.preView.frame.size.height;
        CGFloat y = self.scanRect.origin.x / self.preView.frame.size.width;
        CGFloat width = self.scanRect.size.height / self.preView.frame.size.height;
        CGFloat height = self.scanRect.size.width / self.preView.frame.size.width;
        self.output.rectOfInterest = CGRectMake(x, y, width, height);
    }
    if ([self.session canAddInput:self.input]){
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.output]){
        [self.session addOutput:self.output];
    }
    NSArray *metadataObjectTypes = (self.objTypes.count > 0)?self.objTypes:[self defaultMetaDataObjectTypes];
    self.output.metadataObjectTypes = metadataObjectTypes;
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.frame = self.preView.bounds;
    [self.preView.layer insertSublayer:self.previewLayer atIndex:0];
    
    
//    //先进行判断是否支持控制对焦,不开启自动对焦功能，很难识别二维码。
//    if (_device.isFocusPointOfInterestSupported &&[_device isFocusModeSupported:AVCaptureFocusModeAutoFocus]){
//        [_input.device lockForConfiguration:nil];
//        [_input.device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
//        [_input.device unlockForConfiguration];
//    }
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate
-(void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count <= 0) {
        return;
    }
    
    AVMetadataMachineReadableCodeObject *object = [metadataObjects lastObject];
    //  没有扫描到数据,或者数据不是指定实例
    if (!object || ![object isMemberOfClass:[AVMetadataMachineReadableCodeObject class]]) {
        return;
    }
    // 扫描的结果回调
    if (self.resultHandle) {
       self.resultHandle(object.stringValue);
    }
    NSLog(@"扫描结果:%@",object.stringValue);
}


#pragma mark - 默认扫描类型
- (NSArray *)defaultMetaDataObjectTypes{
    NSMutableArray *types = [@[AVMetadataObjectTypeQRCode,
                               AVMetadataObjectTypeUPCECode,
                               AVMetadataObjectTypeCode39Code,
                               AVMetadataObjectTypeCode39Mod43Code,
                               AVMetadataObjectTypeEAN13Code,
                               AVMetadataObjectTypeEAN8Code,
                               AVMetadataObjectTypeCode93Code,
                               AVMetadataObjectTypeCode128Code,
                               AVMetadataObjectTypePDF417Code,
                               AVMetadataObjectTypeAztecCode] mutableCopy];
    return types;
}


#pragma mark - 懒加载
-(AVCaptureSession *)session {
    if (!_session) {
        _session = [[AVCaptureSession alloc]init];
    }
    return _session;
}

-(AVCaptureVideoPreviewLayer *)previewLayer {
    if (!_previewLayer) {
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    }
    return _previewLayer;
}
-(AVCaptureMetadataOutput *)output{
    if (!_output) {
        _output = [[AVCaptureMetadataOutput alloc] init];
    }
    return _output;
}
-(AVCaptureDevice *)device{
    if (!_device) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}
-(AVCaptureDeviceInput *)input{
    if (!_input) {
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    }
    return _input;
}

@end
