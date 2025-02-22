/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */
#import "RNSVGMask.h"
#import "RNSVGBrushType.h"
#import "RNSVGNode.h"
#import "RNSVGPainter.h"

#ifdef RN_FABRIC_ENABLED
#import <react/renderer/components/rnsvg/ComponentDescriptors.h>
#import <react/renderer/components/view/conversions.h>
#import "RCTConversions.h"
#import "RCTFabricComponentsPlugins.h"
#import "RNSVGFabricConversions.h"
#endif // RN_FABRIC_ENABLED

@implementation RNSVGMask

#ifdef RN_FABRIC_ENABLED
using namespace facebook::react;

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    static const auto defaultProps = std::make_shared<const RNSVGMaskProps>();
    _props = defaultProps;
  }
  return self;
}

#pragma mark - RCTComponentViewProtocol

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
  return concreteComponentDescriptorProvider<RNSVGMaskComponentDescriptor>();
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
  const auto &newProps = *std::static_pointer_cast<const RNSVGMaskProps>(props);

  self.x = [RNSVGLength lengthWithString:RCTNSStringFromString(newProps.x)];
  self.y = [RNSVGLength lengthWithString:RCTNSStringFromString(newProps.y)];
  if (RCTNSStringFromStringNilIfEmpty(newProps.maskheight)) {
    self.maskheight = [RNSVGLength lengthWithString:RCTNSStringFromString(newProps.maskheight)];
  }
  if (RCTNSStringFromStringNilIfEmpty(newProps.maskwidth)) {
    self.maskwidth = [RNSVGLength lengthWithString:RCTNSStringFromString(newProps.maskwidth)];
  }
  if (RCTNSStringFromStringNilIfEmpty(newProps.height)) {
    self.maskheight = [RNSVGLength lengthWithString:RCTNSStringFromString(newProps.height)];
  }
  if (RCTNSStringFromStringNilIfEmpty(newProps.width)) {
    self.maskwidth = [RNSVGLength lengthWithString:RCTNSStringFromString(newProps.width)];
  }
  self.maskUnits = newProps.maskUnits == 0 ? kRNSVGUnitsObjectBoundingBox : kRNSVGUnitsUserSpaceOnUse;
  self.maskContentUnits = newProps.maskUnits == 0 ? kRNSVGUnitsObjectBoundingBox : kRNSVGUnitsUserSpaceOnUse;
  if (newProps.maskTransform.size() == 6) {
    self.maskTransform = CGAffineTransformMake(
        newProps.maskTransform.at(0),
        newProps.maskTransform.at(1),
        newProps.maskTransform.at(2),
        newProps.maskTransform.at(3),
        newProps.maskTransform.at(4),
        newProps.maskTransform.at(5));
  }

  setCommonGroupProps(newProps, self);
}

- (void)prepareForRecycle
{
  [super prepareForRecycle];
  _x = nil;
  _y = nil;
  _maskheight = nil;
  _maskwidth = nil;
  _maskUnits = kRNSVGUnitsObjectBoundingBox;
  _maskContentUnits = kRNSVGUnitsObjectBoundingBox;
  _maskTransform = CGAffineTransformIdentity;
}
#endif // RN_FABRIC_ENABLED

- (RNSVGPlatformView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
  return nil;
}

- (void)parseReference
{
  self.dirty = false;
  [self.svgView defineMask:self maskName:self.name];
}

- (void)setX:(RNSVGLength *)x
{
  if ([x isEqualTo:_x]) {
    return;
  }

  _x = x;
  [self invalidate];
}

- (void)setY:(RNSVGLength *)y
{
  if ([y isEqualTo:_y]) {
    return;
  }

  _y = y;
  [self invalidate];
}

- (void)setMaskwidth:(RNSVGLength *)maskwidth
{
  if ([maskwidth isEqualTo:_maskwidth]) {
    return;
  }

  _maskwidth = maskwidth;
  [self invalidate];
}

- (void)setMaskheight:(RNSVGLength *)maskheight
{
  if ([maskheight isEqualTo:_maskheight]) {
    return;
  }

  _maskheight = maskheight;
  [self invalidate];
}

- (void)setMaskUnits:(RNSVGUnits)maskUnits
{
  if (maskUnits == _maskUnits) {
    return;
  }

  _maskUnits = maskUnits;
  [self invalidate];
}

- (void)setMaskContentUnits:(RNSVGUnits)maskContentUnits
{
  if (maskContentUnits == _maskContentUnits) {
    return;
  }

  _maskContentUnits = maskContentUnits;
  [self invalidate];
}

- (void)setMaskTransform:(CGAffineTransform)maskTransform
{
  _maskTransform = maskTransform;
  [self invalidate];
}

@end

#ifdef RN_FABRIC_ENABLED
Class<RCTComponentViewProtocol> RNSVGMaskCls(void)
{
  return RNSVGMask.class;
}
#endif // RN_FABRIC_ENABLED
