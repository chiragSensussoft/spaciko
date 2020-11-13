import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class SliverStickyFooter extends SingleChildRenderObjectWidget {
  const SliverStickyFooter({
    Key key,
    Widget child,
  }) : super(key: key, child: child);

  @override
  RenderSliverStickyFooter createRenderObject(BuildContext context) =>
      RenderSliverStickyFooter();
}

class RenderSliverStickyFooter extends RenderSliverSingleBoxAdapter {
  RenderSliverStickyFooter({
    RenderBox child,
  }) : super(child: child);

  @override
  void performLayout() {
    child?.layout(
      constraints.asBoxConstraints(),
      parentUsesSize: true,
    );

    final paintedChildSize =
    calculatePaintOffset(constraints, from: 0.0, to: child.size.height);
    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);
    geometry = SliverGeometry(
      scrollExtent: child.size.height,
      paintExtent: paintedChildSize,
      maxPaintExtent: paintedChildSize,
      hasVisualOverflow: true,
      paintOrigin: -child.size.height + paintedChildSize,
      visible: true,
    );

    if (child != null) {
      setChildParentData(child, constraints, geometry);
    }
  }
}