//
// Created by Admin on 20.02.2022.
//

import Foundation

struct Photo: Decodable {
    var copyright: String? = nil
    var date: Date = Date()
    var explanation: String = ""
    var hdurl: String? = nil
    var title: String = "No photo for that date"
    var url: String = ""
    var mediaType: String = ""
}