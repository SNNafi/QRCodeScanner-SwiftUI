//
//  QRCodeScannerViewController.swift
//  QRCodeScannerSwiftUI
//
//  Created by Shahriar Nasim Nafi on 9/12/21.
//  Copyright © 2021 Shahriar Nasim Nafi. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeScannerViewController: UIViewController {
    
    let captureSession = AVCaptureSession()
    let captureMetadataOutput = AVCaptureMetadataOutput()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the back-facing camera for capturing videos
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("Failed to get the camera device")
            return
        }
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice) // Set the input device on the capture session.
            captureSession.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            
            captureSession.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.metadataObjectTypes = [.qr]
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            // Start video capture.
            captureSession.startRunning()
            
            
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubviewToFront(qrCodeFrameView)
            
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more. print(error)
            return
        }
    }
    
    func qrCodeFrameBorder(color: UIColor) {
        qrCodeFrameView.layer.borderColor = color.cgColor
    }
}
