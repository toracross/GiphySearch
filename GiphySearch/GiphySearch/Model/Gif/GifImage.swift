import Foundation

public struct GifImage: Codable {
    let original: OriginalImageData?
    let fixedWidth: FixedWidthImageData?
    
    enum CodingKeys: String, CodingKey {
        case original
        case fixedWidth = "fixed_width"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.original = try container.decodeIfPresent(OriginalImageData.self, forKey: .original)
        self.fixedWidth = try container.decodeIfPresent(FixedWidthImageData.self, forKey: .fixedWidth)
    }
}

public struct OriginalImageData: Codable {
    let height: Int?
    let width: Int?
    let url: String?
    let frames: Int?
    
    enum CodingKeys: String, CodingKey {
        case height, width, url, frames
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let height = try container.decodeIfPresent(String.self, forKey: .height) ?? ""
        let width = try container.decodeIfPresent(String.self, forKey: .width) ?? ""
        let frames = try container.decodeIfPresent(String.self, forKey: .frames) ?? ""
        
        self.height = Int(height)
        self.width = Int(width)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.frames = Int(frames)
    }
}

public struct FixedWidthImageData: Codable {
    let height: Int?
    let width: Int?
    let url: String?
    let frames: Int?
    
    enum CodingKeys: String, CodingKey {
        case height, width, url, frames
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let height = try container.decodeIfPresent(String.self, forKey: .height) ?? ""
        let width = try container.decodeIfPresent(String.self, forKey: .width) ?? ""
        let frames = try container.decodeIfPresent(String.self, forKey: .frames) ?? ""
        
        self.height = Int(height)
        self.width = Int(width)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.frames = Int(frames)
    }
}
