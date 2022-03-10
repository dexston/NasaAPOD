//
// Created by Admin on 20.02.2022.
//

import Foundation

struct Photo: Decodable {
    var copyright: String?
    var date: Date?
    var explanation: String?
    var title: String?
    var mediaType: MediaType?
    var url: URL?
    var hdurl: URL?
    var msg: String?
}

enum MediaType: String, Decodable {
    case image
    case video
}
