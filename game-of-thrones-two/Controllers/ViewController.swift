//
//  ViewController.swift
//  game-of-thrones-two
//
//  Created by MCS Devices on 7/5/19.
//  Copyright © 2019 Cristian Aaron Perez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var episodes: [Episode] = []
  var networkRequests: [Any?] = []
  var delegate:NetworkManagerDelegateSerie?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  func getData(closure: ()-> Void){
      let myNetworkManager = NetworkManager()
      networkRequests.append(myNetworkManager)
      myNetworkManager.delegate = self
      myNetworkManager.downloadAPIPost()
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return episodes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Show.episodeViewCellName, for: indexPath) as! EpisodeViewCell
    
    if let title = episodes[indexPath.row].name as String? {
      cell.titleLabel.text = title
    }
    
    if let season = episodes[indexPath.row].name as String?,
       let episode = episodes[indexPath.row].name as String? {
      cell.subtitleLabel.text = "Season: \(season), Episode: \(episode)"
    }
    
    cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.init(red: 0.9, green: 0.2, blue: 0.5, alpha: 0.2) :  UIColor.white
    return cell
    
    
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return CGFloat(Show.tableViewCellHeight)
  }
  
}

extension ViewController: UITableViewDelegate {
  
}

extension ViewController: NetworkManagerDelegate {
  func didDownloadPost(postArray: [String : Any]) {
    if let n = postArray{
      for i in 1...n{
        let season = Season(imdbID: self.imdbID, season: "\(i)")
        season.delegate = self
      }
    }
  }
}

