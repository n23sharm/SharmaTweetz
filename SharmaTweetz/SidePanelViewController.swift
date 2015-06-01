    //
//  SidePanelViewController.swift
//  SharmaTweetz
//
//  Created by Neha Sharma on 5/31/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

@objc
protocol SidePanelViewControllerDelegate {
    func itemSelected(item: String!)
}

class SidePanelViewController: UIViewController {
    
    var delegate: SidePanelViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func profileClicked(sender: AnyObject) {
        delegate?.itemSelected("Profile")
    }

    @IBAction func homeClicked(sender: AnyObject) {
        delegate?.itemSelected("Home")
    }
    
    @IBAction func mentionsClicked(sender: AnyObject) {
    }


}
