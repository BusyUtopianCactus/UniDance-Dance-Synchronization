//
//  createBarcodeViewController.swift
//  Unidance
//
//  Created by Daniel Basman on 3/8/22.
//

import Foundation
import UIKit

class createBarcodeViewController:UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var codeLabel: UILabel!
    static var code = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        createBarcodeViewController.code  = Int.random(in: 1...9999)
        codeLabel.text = String(createBarcodeViewController.code)
        print("CREATE BARCODE")
        //apiCall(urlVal: "https://unidance-f4c44-default-rtdb.firebaseio.com/users.json")
       
        
        
        // image.image = generateQRCode(from: "https://httpbin.org/get?sessionNumber=" + String(createBarcodeViewController.code))
    }
    
//    func generateQRCode(from string: String) -> UIImage? {
//        let info = string.data(using: String.Encoding.ascii)
//
//        if let filter = CIFilter(name: "CIQRCodeGenerator") {
//            filter.setValue(info, forKey: "inputMessage")
//            let change = CGAffineTransform(scaleX: 5, y: 5)
//
//            if let output = filter.outputImage?.transformed(by: change) {
//                apiCall(urlVal: string)
//                return UIImage(ciImage: output)
//            }
//        }
//
//        return nil
//    }
//
//
//    func apiCall(urlVal: String) {
////string: "https://httpbin.org/get"
//        let url = URL(string: urlVal)!
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if data != nil {
//                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
//                print("API SUCCESS")
//                print(json)
//            } else if let error = error {
//                print("HTTP Request Failed \(error)")
//            }
//        }
//
//        task.resume()
//    }
    

   
}
