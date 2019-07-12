//
//  ViewController.swift
//  game-of-thrones-two
//
//  Created by MCS Devices on 7/5/19.
//  Copyright © 2019 Cristian Aaron Perez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var show: [String : [Episode]] = [:]
  var networkRequests: [Any?] = []
  var delegate:NetworkManagerDelegateSerie?
  @IBOutlet weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UINib(nibName: Show.episodeViewCellName , bundle: nil), forCellReuseIdentifier: Show.episodeViewCellName)
    self.getData { response in
      if let safeResponse = response {
        self.didDownloadPost(postArray: safeResponse)
        self.tableView.reloadData()
      }
    }
    
  }
  
  func getData(completion: @escaping ([String: Any]?) -> Void){
    let myNetworkManager = NetworkManager()
    networkRequests.append(myNetworkManager)
    myNetworkManager.downloadAPIPost(){ response in
      completion(response)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return show["\(section+1)"]?.count ?? 0
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return show.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Season: \(section+1)"
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Show.episodeViewCellName, for: indexPath) as! EpisodeViewCell
    
    if let title = show["\(indexPath.section+1)"]![indexPath.row].name {
      cell.titleLabel.text = title
    }
    
    if let episode = show["\(indexPath.section+1)"]![indexPath.row].number {
      cell.subtitleLabel.text = "Episode: \(episode)"
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return CGFloat(Show.tableViewCellHeight)
  }
  
}

extension ViewController: UITableViewDelegate {
  
}

extension ViewController {
  func didDownloadPost(postArray: [String : Any]) {
    if let show = postArray["_embedded"] as? [String : Any] {
      if let showEpisodes = show["episodes"] as? [[String: Any]] {
        for i in 1...showEpisodes.count {
          var episode = Episode()
          episode.season = "\(showEpisodes[i-1][EpisodeKeys.season] as! Int)"
          episode.name = showEpisodes[i-1][EpisodeKeys.name] as? String
          episode.airdate = showEpisodes[i-1][EpisodeKeys.airdate] as? String
          episode.airtime = showEpisodes[i-1][EpisodeKeys.airtime] as? String
          episode.id = showEpisodes[i-1][EpisodeKeys.id] as? Int
          episode.number = showEpisodes[i-1][EpisodeKeys.number] as? Int
          episode.summary = showEpisodes[i-1][EpisodeKeys.summary] as? String
          if let imageDictionary = showEpisodes[i-1][EpisodeKeys.image] as? [String: String] {
            episode.imageUrl = imageDictionary[EpisodeKeys.imageUrl]
          }
          
          if let season = episode.season {
            if self.show[season] != nil {
              self.show[season]!.append(episode)
            } else {
              self.show[season] = []
              self.show[season]!.append(episode)
            }
          }
        }
      }
    }
  }
}

