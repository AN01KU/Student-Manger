//
//  SecondViewController.swift
//  notificationCenterDemo
//
//  Created by Ankush Ganesh on 16/01/23.
//

import UIKit

protocol SecondViewControllerDelegate: NSObject {
    func animeButtonPressed()
    func gameButtonPressed()
}


class SecondViewController: UIViewController {

    weak var delegate: SecondViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func animePressed(_ sender: UIButton) {
        //NotificationCenter.default.post(name: .anime, object: Bike())
        delegate?.animeButtonPressed()
    }
    
    @IBAction func GamePressed(_ sender: Any) {
        //NotificationCenter.default.post(name: .game, object: nil)
        delegate?.gameButtonPressed()
    }
  

}
