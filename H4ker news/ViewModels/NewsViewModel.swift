import Foundation
import SwiftUI

@MainActor
final class NewsViewModel: ObservableObject {
    @Published var stories: [HNStory] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let endpoint = URL(string: "https://hn.algolia.com/api/v1/search?tags=front_page")!

    func fetchFrontPage() async {
        if isLoading { return }
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            var request = URLRequest(url: endpoint)
            request.timeoutInterval = 20
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let http = response as? HTTPURLResponse, 200..<300 ~= http.statusCode else {
                throw URLError(.badServerResponse)
            }
            let decoder = JSONDecoder()
            let result = try decoder.decode(HNResponse.self, from: data)
            withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
                self.stories = result.hits
            }
        } catch {
            self.errorMessage = "Failed to load stories. Please try again."
        }
    }
} 
