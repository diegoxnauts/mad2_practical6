//
//  QRGeneratorViewController.swift
//  mad2_practical6
//
//  Created by Jm San Diego on 27/11/19.
//  Copyright © 2019 Jm San Diego. All rights reserved.
//

import Foundation
import QRCoder

class QRGeneratorViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var urlTxtField: UITextField!
    
    @IBOutlet weak var qrImage: UIImageView!
    
    let generator = QRCodeGenerator(correctionLevel: .Q)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        urlTxtField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        urlTxtField.resignFirstResponder()
        let url = urlTxtField.text
        qrImage.image = generator.createImage(value: url!, size: CGSize(width: 200,height: 200))
        return true;
    }
}
