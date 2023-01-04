// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let university = try? JSONDecoder().decode(University.self, from: jsonData)


import Foundation

// MARK: - University
struct University: Codable {
    let webPages: [String]?
    let stateProvince: String?
    let alphaTwoCode, name, country: String?
    let domains: [String]?

    enum CodingKeys: String, CodingKey {
        case webPages = "web_pages"
        case stateProvince = "state-province"
        case alphaTwoCode = "alpha_two_code"
        case name, country, domains
    }
}

//typealias University = [University]

