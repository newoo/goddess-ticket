//
//  YeoshinTv.swift
//  goddess
//
//  Created by Taeheon Woo on 2021/06/17.
//

import Foundation

struct YeoshinTv: Decodable {
  let tvId: String
  let tvNameMain: String
  let tvVideoId: String
  
  var thumbnailUrl: String {
    "https://img.youtube.com/vi/\(tvVideoId)/0.jpg"
  }
  
  enum CodingKeys: String, CodingKey {
    case tvId, tvNameMain, tvVideoId
  }
}
