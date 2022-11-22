//
//  CameraView.swift
//  
//
//  Created by Timothy Obeisun on 11/16/22.
//

import AVFoundation
import UIKit
import Vision
import Foundation



class CameraView: UIView {
    
    var didUploadData: (
        (
            _ base64: String,
            _ fileExtension: String
        ) -> Void)?
    
    lazy var baseView: UIView = {
        let baseView = UIView()
        baseView.backgroundColor = .clear
        return baseView
    }()
    
    lazy var imageBackground: UIImageView = {
        let imageBackground = UIImageView()
        imageBackground.contentMode = .scaleAspectFill
        imageBackground.image = UIImage().loadImage(named: "camera_1")?.blurImage()
        return imageBackground
    }()
    
    lazy var cameraBaseView: UIView = {
        let cameraBaseView = UIView()
        cameraBaseView.backgroundColor = .clear
        cameraBaseView.layer.cornerRadius = 10
        cameraBaseView.layer.borderColor = UIColor().loadColor(named: "SnappayPrimary")?.cgColor
        cameraBaseView.layer.borderWidth = 5
        cameraBaseView.clipsToBounds = true
        return cameraBaseView
    }()
    
    private let captureSession = AVCaptureSession()
    private lazy var previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
    private let videoDataOutput = AVCaptureVideoDataOutput()
    private var faceLayers: [CAShapeLayer] = []
    private let output = AVCapturePhotoOutput()
    var isCaptured: Bool = false
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareViews()
        prepareConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        prepareViews()
        prepareConstraints()
        setupCamera()
        
        startRunning()
    }
    
    func startRunning() {
        DispatchQueue.global(qos: .default).async {
            self.captureSession.startRunning()
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCamera() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(
            deviceTypes: [.builtInWideAngleCamera],
            mediaType: .video,
            position: .front
        )
        if let device = deviceDiscoverySession.devices.first {
            if let deviceInput = try? AVCaptureDeviceInput(device: device) {
                if captureSession.canAddInput(deviceInput) {
                    captureSession.addInput(deviceInput)
                    setupPreview()
                }
                
                if captureSession.canAddOutput(output) {
                    captureSession.addOutput(output)
                }
            }
        }
    }
    
    private func setupPreview() {
        self.previewLayer.videoGravity = .resizeAspectFill
        self.cameraBaseView.layer.addSublayer(self.previewLayer)
        self.previewLayer.frame = self.cameraBaseView.frame
        
        self.videoDataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(value: kCVPixelFormatType_32BGRA)] as [String : Any]
        
        self.videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera queue"))
        self.captureSession.addOutput(self.videoDataOutput)
        
        let videoConnection = self.videoDataOutput.connection(with: .video)
        videoConnection?.videoOrientation = .portrait
    }
}

extension CameraView {
    private func prepareViews() {
        addSubview(baseView)
        
        baseView.addSubview(
            [
                imageBackground,
                cameraBaseView
            ]
        )
        
        self.previewLayer.frame = self.frame
    }
    
    private func prepareConstraints() {
        baseView.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0
        )
        
        imageBackground.anchor(
            top: baseView.topAnchor,
            left: baseView.leftAnchor,
            bottom: baseView.bottomAnchor,
            right: baseView.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0
        )
        
        cameraBaseView.anchor(
            top: baseView.topAnchor,
            left: baseView.leftAnchor,
            bottom: baseView.bottomAnchor,
            right: baseView.rightAnchor,
            paddingTop: 80,
            paddingLeft: 0,
            paddingBottom: 80,
            paddingRight: 0
        )
        cameraBaseView.centerY(inView: baseView)
    }
    
}


extension CameraView: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        let faceDetectionRequest = VNDetectFaceLandmarksRequest(completionHandler: { (request: VNRequest, error: Error?) in
            DispatchQueue.main.async {
                self.faceLayers.forEach({ drawing in drawing.removeFromSuperlayer() })
                
                if let observations = request.results as? [VNFaceObservation] {
                    self.handleFaceDetectionObservations(observations: observations)
                }
            }
        })
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: imageBuffer, orientation: .leftMirrored, options: [:])
        
        do {
            try imageRequestHandler.perform([faceDetectionRequest])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func handleFaceDetectionObservations(observations: [VNFaceObservation]) {
        for observation in observations {
            let faceRectConverted = self.previewLayer.layerRectConverted(fromMetadataOutputRect: observation.boundingBox)
            let faceRectanglePath = CGPath(rect: faceRectConverted, transform: nil)
            
            let faceLayer = CAShapeLayer()
            faceLayer.path = faceRectanglePath
            faceLayer.fillColor = UIColor.clear.cgColor
            faceLayer.strokeColor = UIColor().loadColor(named: "SnappayPrimary")?.cgColor
            let halfFaceLayerCurrentPointX = (faceLayer.path?.currentPoint.x ?? 0.0) / 2
            let halfFaceLayerCurrentPointY = (faceLayer.path?.currentPoint.y ?? 0.0) / 2
            let cameraBaseViewCenterX = self.cameraBaseView.center.x
            let cameraBaseViewCenterY = self.cameraBaseView.center.y
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                if halfFaceLayerCurrentPointX < cameraBaseViewCenterX
                    && halfFaceLayerCurrentPointY < cameraBaseViewCenterY {
                    if !self.isCaptured {
                        self.output.capturePhoto(
                            with: AVCapturePhotoSettings(),
                            delegate: self
                        )
                        self.isCaptured = true
                    }
                }
            }
            
            self.faceLayers.append(faceLayer)
            self.cameraBaseView.layer.addSublayer(faceLayer)
            
            //FACE LANDMARKS
            if let landmarks = observation.landmarks {
                if let leftEye = landmarks.leftEye {
                    self.handleLandmark(leftEye, faceBoundingBox: faceRectConverted)
                }
                if let leftEyebrow = landmarks.leftEyebrow {
                    self.handleLandmark(leftEyebrow, faceBoundingBox: faceRectConverted)
                }
                if let rightEye = landmarks.rightEye {
                    self.handleLandmark(rightEye, faceBoundingBox: faceRectConverted)
                }
                if let rightEyebrow = landmarks.rightEyebrow {
                    self.handleLandmark(rightEyebrow, faceBoundingBox: faceRectConverted)
                }
                
                if let nose = landmarks.nose {
                    self.handleLandmark(nose, faceBoundingBox: faceRectConverted)
                }
                
                if let outerLips = landmarks.outerLips {
                    self.handleLandmark(outerLips, faceBoundingBox: faceRectConverted)
                }
                if let innerLips = landmarks.innerLips {
                    self.handleLandmark(innerLips, faceBoundingBox: faceRectConverted)
                }
            }
        }
    }
    
    private func handleLandmark(_ eye: VNFaceLandmarkRegion2D, faceBoundingBox: CGRect) {
        let landmarkPath = CGMutablePath()
        let landmarkPathPoints = eye.normalizedPoints
            .map({ eyePoint in
                CGPoint(
                    x: eyePoint.y * faceBoundingBox.height + faceBoundingBox.origin.x,
                    y: eyePoint.x * faceBoundingBox.width + faceBoundingBox.origin.y)
            })
        landmarkPath.addLines(between: landmarkPathPoints)
        landmarkPath.closeSubpath()
        let landmarkLayer = CAShapeLayer()
        landmarkLayer.path = landmarkPath
        landmarkLayer.fillColor = UIColor.clear.cgColor
        landmarkLayer.strokeColor = UIColor.green.cgColor
        
        self.faceLayers.append(landmarkLayer)
        //        self.cameraBaseView.layer.addSublayer(landmarkLayer)
    }
}


extension CameraView : AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        
        
        guard let data = photo.fileDataRepresentation() else { return }
        let image = UIImage(data: data)
        let base64String = convertImageToBase64String(img: image)
        guard let didUploadData = didUploadData else { return }
        didUploadData(base64String, data.format)
        captureSession.stopRunning()
    }
    
    func convertImageToBase64String (img: UIImage?) -> String {
        return img?.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
}
