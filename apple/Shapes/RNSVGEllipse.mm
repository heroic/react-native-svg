/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RNSVGEllipse.h"
#import <React/RCTLog.h>

#ifdef RN_FABRIC_ENABLED
#import <react/renderer/components/rnsvg/ComponentDescriptors.h>
#import <react/renderer/components/view/conversions.h>
#import "RCTConversions.h"
#import "RCTFabricComponentsPlugins.h"
#import "RNSVGFabricConversions.h"
#endif // RN_FABRIC_ENABLED

@implementation RNSVGEllipse

#ifdef RN_FABRIC_ENABLED
using namespace facebook::react;

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    static const auto defaultProps = std::make_shared<const RNSVGEllipseProps>();
    _props = defaultProps;
  }
  return self;
}

#pragma mark - RCTComponentViewProtocol

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
  return concreteComponentDescriptorProvider<RNSVGEllipseComponentDescriptor>();
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
  const auto &newProps = *std::static_pointer_cast<const RNSVGEllipseProps>(props);

  self.cx = [RNSVGLength lengthWithString:RCTNSStringFromString(newProps.cx)];
  self.cy = [RNSVGLength lengthWithString:RCTNSStringFromString(newProps.cy)];
  self.rx = [RNSVGLength lengthWithString:RCTNSStringFromString(newProps.rx)];
  self.ry = [RNSVGLength lengthWithString:RCTNSStringFromString(newProps.ry)];

  setCommonRenderableProps(newProps, self);
}

- (void)prepareForRecycle
{
  [super prepareForRecycle];
  _cx = nil;
  _cy = nil;
  _rx = nil;
  _ry = nil;
}
#endif // RN_FABRIC_ENABLED

- (void)setCx:(RNSVGLength *)cx
{
  if ([cx isEqualTo:_cx]) {
    return;
  }
  [self invalidate];
  _cx = cx;
}

- (void)setCy:(RNSVGLength *)cy
{
  if ([cy isEqualTo:_cy]) {
    return;
  }
  [self invalidate];
  _cy = cy;
}

- (void)setRx:(RNSVGLength *)rx
{
  if ([rx isEqualTo:_rx]) {
    return;
  }
  [self invalidate];
  _rx = rx;
}

- (void)setRy:(RNSVGLength *)ry
{
  if ([ry isEqualTo:_ry]) {
    return;
  }
  [self invalidate];
  _ry = ry;
}

- (CGPathRef)getPath:(CGContextRef)context
{
  CGMutablePathRef path = CGPathCreateMutable();
  CGFloat cx = [self relativeOnWidth:self.cx];
  CGFloat cy = [self relativeOnHeight:self.cy];
  CGFloat rx = [self relativeOnWidth:self.rx];
  CGFloat ry = [self relativeOnHeight:self.ry];
  CGPathAddEllipseInRect(path, nil, CGRectMake(cx - rx, cy - ry, rx * 2, ry * 2));
  return (CGPathRef)CFAutorelease(path);
}

@end

#ifdef RN_FABRIC_ENABLED
Class<RCTComponentViewProtocol> RNSVGEllipseCls(void)
{
  return RNSVGEllipse.class;
}
#endif // RN_FABRIC_ENABLED
