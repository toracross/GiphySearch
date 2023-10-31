import Foundation

public struct GifData: Codable {
    let data: [Gif]
    let pagination: Pagination
    
    enum CodingKeys: String, CodingKey {
        case data, pagination
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.data = try container.decodeIfPresent([Gif].self, forKey: .data) ?? []
        self.pagination = try container.decode(Pagination.self, forKey: .pagination)
    }
}

public struct Gif: Codable {
    let id: String?
    let title: String?
    let images: GifImage?
    
    enum CodingKeys: String, CodingKey {
        case id, title, images
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.images = try container.decodeIfPresent(GifImage.self, forKey: .images)
    }
}

public struct Pagination: Codable {
    let totalCount: Int?
    let count: Int?
    let offset: Int?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case count, offset
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.totalCount = try container.decodeIfPresent(Int.self, forKey: .totalCount)
        self.count = try container.decodeIfPresent(Int.self, forKey: .count)
        self.offset = try container.decodeIfPresent(Int.self, forKey: .offset)
    }
}
