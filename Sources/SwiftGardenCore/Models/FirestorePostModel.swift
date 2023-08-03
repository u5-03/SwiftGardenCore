//
//  FirestorePostModel.swift
//  
//
//  Created by Yugo Sugiyama on 2023/08/02.
//

import Foundation

public struct FirestorePostModel: Identifiable {
    public let id = UUID().uuidString
    public let imageName: String
    public let imageURL: URL
    public let date: Date
    public let temperature: Double
    public let humidity: Int
    
    public init(imageName: String, imageURL: URL, date: Date, temperature: Double, humidity: Int) {
        self.imageName = imageName
        self.imageURL = imageURL
        self.date = date
        self.temperature = temperature
        self.humidity = humidity
    }
    
    enum CodingKeys: String, CodingKey {
        case fields
    }
    
    enum FieldsKeys: String, CodingKey {
        case imageName
        case imageURL
        case timestamp
        case temperature
        case humidity
    }
}

// Used in linux CLI app using RestAPI
extension FirestorePostModel: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var fieldsContainer = container.nestedContainer(keyedBy: FieldsKeys.self, forKey: .fields)
        try fieldsContainer.encode(["stringValue": imageName], forKey: .imageName)
        try fieldsContainer.encode(["stringValue": imageURL], forKey: .imageURL)
        let formatter = DateFormatter()
        // change format to be treated as Timestamp type of Firebase
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let timestamp = formatter.string(from: date)
        try fieldsContainer.encode(["timestampValue": timestamp], forKey: .timestamp)
        try fieldsContainer.encode(["doubleValue": temperature], forKey: .temperature)
        try fieldsContainer.encode(["integerValue": humidity], forKey: .humidity)
    }
}

// Used in iOS app using Firebase SDK
extension FirestorePostModel: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: FieldsKeys.self)
        imageName = try container.decode(String.self, forKey: .imageName)
        imageURL = try container.decode(URL.self, forKey: .imageURL)
        date = try container.decode(Date.self, forKey: .timestamp)
        temperature = try container.decode(Double.self, forKey: .temperature)
        humidity = try container.decode(Int.self, forKey: .humidity)
    }
}

public extension FirestorePostModel {
    static var mock: FirestorePostModel {
        .init(
            imageName: .random,
            imageURL: URL(string: "https://picsum.photos/200/300")!,
            date: Date(),
            temperature: .random(in: 0...30),
            humidity: .random(in: 0...100)
        )
    }
    
    static var mocks: [FirestorePostModel] {
        Array(1...24)
            .map({ index in FirestorePostModel.mock(hour: index) })
    }
    
    private static func mock(hour: Int) -> FirestorePostModel {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .hour, value: hour, to: Date())!
        
        return .init(
            imageName: .random,
            imageURL: URL(string: "https://picsum.photos/200/300")!,
            date: date,
            temperature: .random(in: 0...30),
            humidity: .random(in: 0...100)
        )
    }
}
