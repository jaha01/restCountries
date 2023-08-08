//
//  UIImage+Async.swift
//  restCountries
//
//  Created by Jahongir Anvarov on 02.08.2023.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadImage(imageUrl: String) {
        guard let url = URL(string: imageUrl) else { return }
        
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            
            guard let self = self else { return }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else if let error = error {
                self.image = UIImage(systemName: "person")
                print ("error download image = \(error)")
            }
            
        }
        
        task.resume()
     }
}
