
import Foundation

struct CertificationResponse: Decodable {
    let certifications: [String: [Certification]]
}

struct Certification: Decodable {
    let certification: String
    let meaning: String
    let order: Int
}
