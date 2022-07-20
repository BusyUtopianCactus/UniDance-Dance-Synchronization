//
//  scanBarcodeViewController.swift
//  Unidance
//
//  Created by Daniel Basman on 3/8/22.
//

import Foundation
import UIKit

class scanBarcodeViewController:UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var codeInput: UITextField!
    
    @IBAction func unwindToRoom( _ seg: UIStoryboardSegue) {
    }
    static var sessionNumber:String = "0"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        codeInput.delegate = self
        print("SCAN BARCODE")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        performSegue(withIdentifier: "userInfo", sender: textField.returnKeyType)
        scanBarcodeViewController.sessionNumber = codeInput.text!
        return true
    }
    
    
}
