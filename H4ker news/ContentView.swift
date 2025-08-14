//
//  ContentView.swift
//  H4ker news
//
//  Created by karwan Syborg on 14/08/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NewsViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.stories) { story in
                            NavigationLink(value: story) {
                                NewsRowView(story: story)
                                    .transition(.move(edge: .bottom).combined(with: .opacity))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                }
                .background(Color(.systemGroupedBackground))
                .refreshable { await viewModel.fetchFrontPage() }

                if viewModel.isLoading && viewModel.stories.isEmpty {
                    ProgressView("Loading")
                        .padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .fill(Color(.secondarySystemBackground))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(Color.black.opacity(0.06), lineWidth: 0.5)
                                .blendMode(.overlay)
                        )
                }
            }
            .navigationTitle("H4cker News")
            .navigationDestination(for: HNStory.self) { story in
                ArticleDetailView(story: story)
            }
            .task { await viewModel.fetchFrontPage() }
            .alert("Error", isPresented: Binding(get: { viewModel.errorMessage != nil }, set: { _ in viewModel.errorMessage = nil })) {
                Button("OK", role: .cancel) { viewModel.errorMessage = nil }
                Button("Retry") { Task { await viewModel.fetchFrontPage() } }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
