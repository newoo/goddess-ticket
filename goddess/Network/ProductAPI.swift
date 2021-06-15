//
//  ProductAPI.swift
//  goddess
//
//  Created by Taeheon Woo on 2021/06/15.
//

import Moya

enum ProductAPI {
  case fetchList
}

extension ProductAPI: TargetType {
  var baseURL: URL {
    URL(string: "https://fe8eb658-e817-42b3-9c2b-8750cc0b33c4.mock.pstmn.io/latest/ios")!
  }
  
  var path: String {
    switch self {
    case .fetchList:
      return "/products"
    }
  }
  
  var method: Moya.Method {
    .get
  }
  
  var task: Task {
    .requestPlain
  }
  
  var validationType: ValidationType {
    return .successCodes
  }
  
  var headers: [String: String]? {
    ["Accept": "application/json"]
  }
  
  public var sampleData: Data {
    Data()
  }
}

