//
//  APIConstants.swift
//  game-of-thrones-two
//
//  Created by MCS Devices on 7/5/19.
//  Copyright © 2019 Cristian Aaron Perez. All rights reserved.
//

import Foundation

struct Show {
  static let endPoint = "https://api.tvmaze.com/shows/82?embed=seasons&embed=episodes"
  static let tableViewCellHeight = 80.0
  static let episodeViewCellName = "EpisodeViewCell"
}

struct Episode {
  var id: Int?
  var name: String?
  var season: String?
  var number: Int?
  var summary: String?
  var airdate: String?
  var airtime: String?
  var imageUrl: String?
}

struct EpisodeKeys {
  static let id = "id"
  static let name = "name"
  static let season = "season"
  static let number = "number"
  static let summary = "summary"
  static let airdate = "airdate"
  static let airtime = "airtime"
  static let imageUrl = "medium"
  static let image = "image"
}
