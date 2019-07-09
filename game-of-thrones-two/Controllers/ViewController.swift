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
  @IBOutlet weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    //tableView.register(EpisodeViewCell.self, forCellReuseIdentifier: Show.episodeViewCellName)
    
     tableView.register(UINib(nibName: "EpisodeViewCell" , bundle: nil), forCellReuseIdentifier: "EpisodeViewCell")
     getData {
      tableView.reloadData()
    }
    
  }
  
  func getData(closure: ()-> Void){
      let myNetworkManager = NetworkManager()
      networkRequests.append(myNetworkManager)
      myNetworkManager.delegate = self
      myNetworkManager.downloadAPIPost()
      closure()
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

    
    if let title = episodes[indexPath.row].name {
      cell.titleLabel.text = title
    }
    
    if let season = episodes[indexPath.row].name,
       let episode = episodes[indexPath.row].name {
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
    if let show = postArray["_embedded"] as? [String : Any] {
      if let showEpisodes = show["episodes"] as? [[String: Any]] {
        for i in 1...showEpisodes.count {
          var episode = Episode()
          episode.name = showEpisodes[i-1][EpisodeKeys.name] as? String
          episode.airdate = showEpisodes[i-1][EpisodeKeys.airdate] as? String
          episode.airtime = showEpisodes[i-1][EpisodeKeys.airtime] as? String
          episode.id = showEpisodes[i-1][EpisodeKeys.id] as? Int
          episode.number = showEpisodes[i-1][EpisodeKeys.number] as? String
          episode.summary = showEpisodes[i-1][EpisodeKeys.summary] as? String
          episodes.append(episode)
        }
      }
    }
    tableView.reloadData()
  }
}

