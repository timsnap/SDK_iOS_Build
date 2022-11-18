//
//  File.swift
//  
//
//  Created by Timothy Obeisun on 11/11/22.
//

import UIKit

extension UIImage {
    public func loadImage(named name: String) -> UIImage? {
        UIImage(named: name, in: Bundle.module, compatibleWith: nil)
    }
    
    
    public func blurImage() -> UIImage? {
        let context = CIContext(options: nil)
        let inputImage = CIImage(image: self)
        let originalOrientation = self.imageOrientation
        let originalScale = self.scale
        
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(inputImage, forKey: kCIInputImageKey)
        filter?.setValue(10.0, forKey: kCIInputRadiusKey)
        let outputImage = filter?.outputImage
        
        var imageContext:CGImage?
        
        if let asd = outputImage
        {
            imageContext = context.createCGImage(asd, from: (inputImage?.extent)!)
        }
        
        if let cgImageA = imageContext
        {
            return UIImage(cgImage: cgImageA, scale: originalScale, orientation: originalOrientation)
        }
        
        return nil
    }
}
