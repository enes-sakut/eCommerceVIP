//
//  InteractiveZoomView.swift
//  eCommerceVIP
//
//  Created by enes.sakut on 18.04.2023.
//

import UIKit

public class InteractiveZoomView<T: UIView>: UIView, UIGestureRecognizerDelegate {
  
  var isZooming: Bool {
    return driver.isZooming
  }
  
  private var driver: InteractiveZoomDriver<T>!
  
  public init(
    sourceView: T,
    targetViewFactory: @escaping (T) throws -> UIView,
    shouldZoomTransform: @escaping (T) -> Bool
  ) {
    
    super.init(frame: .zero)
    
    self.driver = InteractiveZoomDriver(
      gestureTargetView: self,
      sourceView: sourceView,
      targetViewFactory: targetViewFactory,
      shouldZoomTransform: shouldZoomTransform
    )
  }
  
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension InteractiveZoomView {
  
  public static func clone(from fromImageView: UIImageView) -> UIImageView {
    
    let view = UIImageView()
    view.image = fromImageView.image
    view.clipsToBounds = fromImageView.clipsToBounds
    view.contentMode = fromImageView.contentMode
    return view
  }
  
}

extension InteractiveZoomView where T: UIImageView {
  
  public static func shouldZoomTransform(sourceView: T) -> Bool {
    
    if sourceView.image == nil {
      return false
    }
    return true
  }
  
  public convenience init(sourceView: T) {
    self.init(
      sourceView: sourceView,
      targetViewFactory: InteractiveZoomView.clone,
      shouldZoomTransform: InteractiveZoomView.shouldZoomTransform
    )
  }
}

