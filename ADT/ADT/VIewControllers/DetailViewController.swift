//
//  DetailViewController.swift
//  ADT
//
//  Created by Xavier De Leon on 7/28/21.
//

import UIKit


final class DetailViewController: UIViewController {
    @IBOutlet weak var showNameLabel: UILabel!
    
    var showViewModel: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showNameLabel.text = showViewModel?.name
    }
}
