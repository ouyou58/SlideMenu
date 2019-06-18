//
//  ViewController.swift
//  SlideMenu
//
//  Created by ouyou on 2019/06/18.
//  Copyright © 2019 ouyou. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let transition = SlideInTransition()
    var topView : UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else{
            return
        }
        menuViewController.didTapMenuType = { menuType in
            self.transtionToNew(menuType)
            
        }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController,animated: true)
    }
    
    func transtionToNew(_ menuType: MenuType){
        let title = String(describing: menuType).capitalized
        self.title = title
        topView?.removeFromSuperview()
        
        switch menuType {
        case .profile:
            let view = UIView()
            view.backgroundColor = .yellow
            view.frame = self.view.bounds
            self.view.addSubview(view)
        case .camera:
            let view = UIView()
            view.backgroundColor = .red
            view.frame = self.view.bounds
            self.view.addSubview(view)
        case .home:
            let view = UIView()
            view.backgroundColor = .blue
            view.frame = self.view.bounds
            self.view.addSubview(view)
        default:
            break
        }
        
    }
    
}

extension HomeViewController : UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}
