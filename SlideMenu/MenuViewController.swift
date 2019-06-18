//
//  MenuViewController.swift
//  SlideMenu
//
//  Created by ouyou on 2019/06/18.
//  Copyright © 2019 ouyou. All rights reserved.
//

import UIKit

enum MenuType : Int{
    case home
    case camera
    case profile
}

class MenuViewController: UITableViewController {

    var didTapMenuType: ((MenuType) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else{return}
        dismiss(animated: true) {[weak self] in
            self?.didTapMenuType!(menuType)
        }

    }
   

}
