import Foundation

struct HNResponse: Decodable {
    let hits: [HNStory]
}

struct HNStory: Identifiable, Decodable, Hashable {
    let objectID: String
    let title: String?
    let url: String?
    let author: String?
    let points: Int?
    let created_at_i: Int?

    var id: String { objectID }

    var displayTitle: String { title?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false ? (title ?? "") : "Untitled" }
    var displayAuthor: String { author?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false ? (author ?? "") : "Unknown" }
    var displayPoints: String {
        let pts = points ?? 0
        return "\(pts) point\(pts == 1 ? "" : "s")"
    }
    var timeAgo: String {
        guard let epoch = created_at_i else { return "" }
        let date = Date(timeIntervalSince1970: TimeInterval(epoch))
        return date.timeAgoString()
    }
}

extension Date {
    func timeAgoString() -> String {
        let seconds = Int(Date().timeIntervalSince(self))
        if seconds < 60 { return "just now" }
        let minutes = seconds / 60
        if minutes < 60 { return "\(minutes)m ago" }
        let hours = minutes / 60
        if hours < 24 { return "\(hours)h ago" }
        let days = hours / 24
        if days < 7 { return "\(days)d ago" }
        let weeks = days / 7
        if weeks < 5 { return "\(weeks)w ago" }
        let months = days / 30
        if months < 12 { return "\(months)mo ago" }
        let years = days / 365
        return "\(years)y ago"
    }
} 
