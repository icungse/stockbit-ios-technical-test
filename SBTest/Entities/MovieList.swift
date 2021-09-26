
import Foundation

struct MovieList: Codable {
    var result: [Movie]
    var page: String
}

struct Movie: Codable {
    var title: String
    var thumbnailPotrait: String
    var rating: String
    var detail: Detail
}

struct Detail: Codable {
    var release: String
    var description: String
    var country: String
    var thumbnailLandscape: String
    var genre: String
}
