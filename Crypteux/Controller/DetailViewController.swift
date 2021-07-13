//
//  DetailViewController.swift
//  Crypteux
//
//  Created by Aiman on 2021/07/12.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var coinPrice: UILabel!
    
    var coinType: String = ""
    var coinCurrentPrice: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        coinLabel.text = coinType
        coinPrice.text = coinCurrentPrice
    }
    

}
