//
//  NetworkManager.swift
//  game-of-thrones-two
//
//  Created by MCS Devices on 7/5/19.
//  Copyright © 2019 Cristian Aaron Perez. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
  
  var delegate: NetworkManagerDelegate?
  
  func downloadAPIPost(){
    let urlString = URL(string: "\(Show.endPoint)")
    if let url = urlString {
      let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
        if error != nil {
          print(error as Any)
        } else {
          do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
              DispatchQueue.main.async {
                self?.delegate?.didDownloadPost(postArray: jsonArray)
              }
            }
          } catch {
            print(error.localizedDescription)
          }
        }
      }
      task.resume()
    }
  }
  
  func getImage(imgUrl: String){
    
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


