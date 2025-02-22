/**
 * Copyright (c) 2015-present, Horcrux.
 * All rights reserved.
 *
 * This source code is licensed under the MIT-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RNSVGClipPath.h"

#ifdef RN_FABRIC_ENABLED
#import <react/renderer/components/rnsvg/ComponentDescriptors.h>
#import <react/renderer/components/view/conversions.h>
#import "RCTConversions.h"
#import "RCTFabricComponentsPlugins.h"
#import "RNSVGFabricConversions.h"
#endif // RN_FABRIC_ENABLED

@implementation RNSVGClipPath

#ifdef RN_FABRIC_ENABLED
using namespace facebook::react;

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    static const auto defaultProps = std::make_shared<const RNSVGClipPathProps>();
    _props = defaultProps;
  }
  return self;
}

#pragma mark - RCTComponentViewProtocol

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
  return concreteComponentDescriptorProvider<RNSVGClipPathComponentDescriptor>();
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
  const auto &newProps = *std::static_pointer_cast<const RNSVGClipPathProps>(props);
  setCommonNodeProps(newProps, self);
}

- (void)prepareForRecycle
{
  [super prepareForRecycle];
}
#endif // RN_FABRIC_ENABLED

- (void)parseReference
{
  self.dirty = false;
  [self.svgView defineClipPath:self clipPathName:self.name];
}

- (BOOL)isSimpleClipPath
{
  NSArray<RNSVGView *> *children = self.subviews;
  if (children.count == 1) {
    RNSVGView *child = children[0];
    if ([child class] != [RNSVGGroup class]) {
      return true;
    }
  }
  return false;
}

@end

#ifdef RN_FABRIC_ENABLED
Class<RCTComponentViewProtocol> RNSVGClipPathCls(void)
{
  return RNSVGClipPath.class;
}
#endif // RN_FABRIC_ENABLED
