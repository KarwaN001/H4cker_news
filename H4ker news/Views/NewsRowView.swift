import SwiftUI

struct NewsRowView: View {
    let story: HNStory

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(story.displayTitle)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
                .lineLimit(3)

            HStack(spacing: 8) {
                Text("by \(story.displayAuthor)")
                Text("•")
                Text(story.displayPoints)
                if !story.timeAgo.isEmpty {
                    Text("•")
                    Text(story.timeAgo)
                }
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color.black.opacity(0.06), lineWidth: 0.5)
                .blendMode(.overlay)
        )
        .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 4)
        .contentShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}

struct NewsRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NewsRowView(story: .init(objectID: "1", title: "Swift 6 Released with Major Concurrency Improvements and Backward Compatibility", url: "https://swift.org", author: "apple", points: 123, created_at_i: Int(Date().timeIntervalSince1970) - 3600))
                .previewLayout(.sizeThatFits)
                .padding()
                .preferredColorScheme(.light)
            NewsRowView(story: .init(objectID: "1", title: "Swift 6 Released with Major Concurrency Improvements and Backward Compatibility", url: "https://swift.org", author: "apple", points: 123, created_at_i: Int(Date().timeIntervalSince1970) - 3600))
                .previewLayout(.sizeThatFits)
                .padding()
                .preferredColorScheme(.dark)
        }
    }
} 
