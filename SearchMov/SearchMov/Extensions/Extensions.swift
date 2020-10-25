//
//  Extensions.swift
//  SearchMov
//
//  Created by Mathew Thomas on 25/10/2020.
//

import UIKit

// MARK: - UIImageView Extension
extension UIImageView {
    
    public func downloadImage(from url: URL, imageView: UIImageView) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                var image: UIImage = UIImage(data: data)!
                image = image.withRoundedCorners(radius: 20)!
                imageView.image = image
            }
        }
    }
    
    fileprivate func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

// MARK: - UIImage Extension
extension UIImage {
    
    public func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
        let maxRadius = min(size.width, size.height) / 2
        let cornerRadius: CGFloat
        if let radius = radius, radius > 0 && radius <= maxRadius {
            cornerRadius = radius
        } else {
            cornerRadius = maxRadius
        }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

// MARK: - UIViewController
extension UIViewController {
    
    func showAlert() {
        let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

