//
//  ViewController.swift
//  DCToastView
//
//  Created by vberihuete on 11/25/2018.
//  Copyright (c) 2018 vberihuete. All rights reserved.
//

import UIKit
import DCToastView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func showToastUpAction(_ sender: Any) {
        ToastPresenter.shared.show(in: self.view, message: "This is a toast", place: .up)
    }
    
    @IBAction func showToastDownAction(_ sender: Any) {
        ToastPresenter.shared.show(in: self.view, message: "This is a toast", place: .down)
    }

}

