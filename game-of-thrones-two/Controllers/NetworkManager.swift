//
//  NetworkManager.swift
//  game-of-thrones-two
//
//  Created by MCS Devices on 7/5/19.
//  Copyright © 2019 Cristian Aaron Perez. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
  
  var delegate: NetworkManagerDelegate?

  func downloadAPIPost(completion: @escaping ([String: Any]?) -> Void) {
    guard let url = URL(string: "\(Show.endPoint)") else {
      completion(nil)
      return
    }
    
    Alamofire.request(url).responseJSON { response in
      guard response.result.isSuccess, let value = response.result.value as? [String: Any] else {
        completion(nil)
        return
      }
      
      completion(value)
    }
  }
  
  func getImage(imgUrl: String, completion: @escaping ([String: Any]?) -> Data) {
    
    let imgURL = URL(string: imgUrl)
    let task = URLSession.shared.dataTask(with: imgURL!) { [weak self] (data, response, error) in
      if error != nil {
        print(error as Any)
      } else {
        do  {
          if let imgData =  data{  // conditional casting.
            DispatchQueue.main.async { // calling the serial main queue to handle the display of information faster.
              //self?.image?.didDownloadImage(image: UIImage(data: imgData)!)
            }
            
          }
        }
      }
    }
    task.resume()
  }
  
}


