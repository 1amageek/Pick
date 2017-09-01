//
//  ViewController.swift
//  Sample
//
//  Created by 1amageek on 2017/09/01.
//  Copyright © 2017年 Stamp Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var pick: UINavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewController: AssetsViewController = AssetsViewController()
        let navigationController: UINavigationController = UINavigationController(rootViewController: viewController)
        self.pick = navigationController
    }

    @IBAction func pick(_ sender: Any) {
        self.present(self.pick!, animated: true, completion: nil)
    }
}

