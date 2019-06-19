//
//  SlideInTransition.swift
//  SlideMenu
//
//  Created by ouyou on 2019/06/18.
//  Copyright © 2019 ouyou. All rights reserved.
//

import UIKit

class SlideInTransition: NSObject,UIViewControllerAnimatedTransitioning {  //UIViewControllerAnimatedTransitioning自定义转场动画
    
    var isPresenting = false
    let dimmingView = UIView()
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
/*动画转场师不能直接获取到视图控制器，所以用下面这两种方法获取到视图控制器，从而再去获取视图
  转场师m目前只定义了两个key来获取视图控制器，from和to，从from控制器出来to控制器，42行代码，想转场视图容器中添加了to的view
  to和from的生成：from是执行转场动画时，自动识别出来的控制器，to是谁遵守转场协议，谁就是to，HomeViewController中
  menuViewController.transitioningDelegate = self,所以menuViewController就是toViewController，42行中加载了他的view
 */
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let fromViewController = transitionContext.viewController(forKey: .from) else {return}
        print(type(of: fromViewController))
        print(toViewController)
        
        
        let containerView = transitionContext.containerView
        let finalWidth = toViewController.view.bounds.width * 0.8
        let finalHeigh = toViewController.view.bounds.height
        
        if isPresenting {
            dimmingView.backgroundColor = .black
            dimmingView.alpha = 0.0
            containerView.addSubview(dimmingView)
            dimmingView.frame = containerView.bounds
            containerView.addSubview(toViewController.view)
            toViewController.view.frame = CGRect(x:-finalWidth,y: 0,width: finalWidth,height: finalHeigh)
        }
        
        let transform = {
            self.dimmingView.alpha = 0.5
            toViewController.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
        }
        
        let identity = {
            self.dimmingView.alpha = 0.0
            fromViewController.view.transform = .identity
        }
        
        let duration = transitionDuration(using: transitionContext)
        let isCancelled = transitionContext.transitionWasCancelled
        UIView.animate(withDuration: duration, animations: {
            self.isPresenting ? transform() : identity()
        }) {(_) in
            transitionContext.completeTransition(!isCancelled)
        }
    }
    

}
