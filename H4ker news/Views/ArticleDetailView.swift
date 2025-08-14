import SwiftUI

struct ArticleDetailView: View {
    let story: HNStory

    var body: some View {
        Group {
            if let urlString = story.url, let url = URL(string: urlString) {
                WebView(url: url)
                    .ignoresSafeArea(edges: .bottom)
            } else {
                VStack(spacing: 12) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 44))
                        .foregroundColor(.secondary)
                    Text("Link unavailable")
                        .font(.headline)
                    Text("This story does not have a valid URL. You can open it in Hacker News instead.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemBackground))
            }
        }
        .navigationTitle(story.displayTitle)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemBackground))
    }
} 
