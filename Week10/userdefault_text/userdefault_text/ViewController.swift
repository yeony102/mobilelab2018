//
//  ViewController.swift
//  userdefault_text
//
//  Created by Yeonhee Lee on 4/13/18.
//  Copyright © 2018 yeonheelee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var lblName: UILabel!
    
    override func viewDidLoad() {
        
        // the key is the name that given in the through the UserDefaults.standard.set method
        if let name = UserDefaults.standard.value(forKey: "name") as? String {
            lblName.text = name
        }
        
        // reference the text field
        txtName.delegate = self
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // it is called when 'return' key pressed. return NO to ignore.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if txtName.tag == 1 {
            lblName.text = textField.text!  // As soon as the return key on the keyboard is pressed, the text in the text field will be shown on the lable.
            UserDefaults.standard.set(textField.text!, forKey: "name")
        }
        
        return true
    }


}

