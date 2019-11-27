//
//  QRScannerViewController.swift
//  mad2_practical6
//
//  Created by Jm San Diego on 27/11/19.
//  Copyright © 2019 Jm San Diego. All rights reserved.
//

import Foundation
import AVFoundation
import QRCodeReader

class QRScannerViewController: UIViewController, QRCodeReaderViewControllerDelegate {
    
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            
            // Configure the view controller (optional)
            $0.showTorchButton        = false
            $0.showSwitchCameraButton = false
            $0.showCancelButton       = false
            $0.showOverlayView        = true
            $0.rectOfInterest         = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    @IBAction func scanAction(_ sender: AnyObject) {
      // Retrieve the QRCode content
      // By using the delegate pattern
      readerVC.delegate = self

      // Or by using the closure pattern
      readerVC.completionBlock = { (result: QRCodeReaderResult?) in
        print("result: \(result!)")
      }

      // Presents the readerVC as modal form sheet
      readerVC.modalPresentationStyle = .formSheet
        
      present(readerVC, animated: true, completion: nil)
    }
    
    // MARK: - QRCodeReaderViewController Delegate Methods

    func reader(_ reader: QRCodeReaderViewController, didScanResult result:  QRCodeReaderResult) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
        let alertView = UIAlertController(title: "QR Result", message: result.value, preferredStyle: UIAlertController.Style.alert)
        
        alertView.addAction(UIAlertAction(title: "OK",
                                          style: UIAlertAction.Style.default,
                                          handler: { _ in self.dismiss(animated: true, completion: nil) }))
        
        self.present(alertView, animated: true)
        reader.stopScanning()
    }

    //This is an optional delegate method, that allows you to be notified when the user switches the cameraName
    //By pressing on the switch camera button
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        let cameraName = newCaptureDevice.device.localizedName
        print("Switching capture to: \(cameraName)")
    }

    func readerDidCancel(_ reader: QRCodeReaderViewController) {
      reader.stopScanning()

      dismiss(animated: true, completion: nil)
    }

//    override func processQRCodeContent(qrCodeContent: String) -> Bool {
//        print(qrCodeContent)
//        dismiss(animated: true, completion: nil)
//        return true
//    }
//
//    override func didFailWithError(error: NSError) {
//        let alert = UIAlertController(title: error.localizedDescription, message: error.localizedFailureReason, preferredStyle: UIAlertController.Style.alert)
//
//        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in self.dismiss(animated: true, completion: nil)
//        })
//
//        alert.addAction(okAction)
//
//        self.present(alert, animated: true, completion: nil)
//
//    }
}
