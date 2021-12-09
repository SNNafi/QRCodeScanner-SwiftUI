//
//  QRCodeScanner.swift
//  QRCodeScannerSwiftUI
//
//  Created by Shahriar Nasim Nafi on 9/12/21.
//  Copyright © 2021 Shahriar Nasim Nafi. All rights reserved.
//

import SwiftUI
import AVFoundation

struct QRCodeScanner: UIViewControllerRepresentable {
    
    var qrCodeFrameColor: UIColor
    @Binding var qrCodeText: String
    
    
    let qrCodeScannerViewController = QRCodeScannerViewController()
    func makeUIViewController(context: Context) -> QRCodeScannerViewController {
        qrCodeScannerViewController.qrCodeFrameBorder(color: qrCodeFrameColor)
        qrCodeScannerViewController.captureMetadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: .main)
        return qrCodeScannerViewController
    }
    
    func updateUIViewController(_ uiViewController: QRCodeScannerViewController, context: Context) {
        
    }
    
    
    func makeCoordinator() -> QRCodeScannerCoordinator {
        QRCodeScannerCoordinator(self)
    }
    
    class QRCodeScannerCoordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        let qrCodeScanner: QRCodeScanner
        let qrCodeScannerViewController: QRCodeScannerViewController
        init(_ qrCodeScanner: QRCodeScanner) {
            self.qrCodeScanner = qrCodeScanner
            qrCodeScannerViewController = qrCodeScanner.qrCodeScannerViewController
        }
        
        
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            // Check if the metadataObjects array is not nil and it contains at least one object.
            if metadataObjects.count == 0 {
                qrCodeScannerViewController.qrCodeFrameView.frame = CGRect.zero
                qrCodeScanner.qrCodeText = "No QR code is detected"
                return
            }
            
            // Get the metadata object.
            let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            if metadataObj.type == AVMetadataObject.ObjectType.qr {
                // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
                let barCodeObject = qrCodeScannerViewController.videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
                qrCodeScannerViewController.qrCodeFrameView.frame = barCodeObject!.bounds
                guard let qrCodeText = metadataObj.stringValue else { return }
                qrCodeScanner.qrCodeText = qrCodeText
            }
        }
    }
}

