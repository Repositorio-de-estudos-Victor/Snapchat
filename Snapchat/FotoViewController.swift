//
//  FotoViewController.swift
//  Snapchat
//
//  Created by Victor Rodrigues Novais on 14/05/20.
//  Copyright © 2020 Victoriano. All rights reserved.
//

import UIKit

class FotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
}
