//
//  ViewController.swift
//  ImageTransfer
//
//  Created by Masaki Horimoto on 2015/04/15.
//  Copyright (c) 2015年 Masaki Horimoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageBeHereNow: UIImageView!
    @IBOutlet var imageDestinationArea: UIImageView!
    @IBOutlet var imageSourceArea: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageDestinationArea.backgroundColor = UIColor.yellowColor()
        imageSourceArea.backgroundColor = UIColor.orangeColor()
        imageBeHereNow.image = UIImage(named: "BeHereNow.jpg")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

