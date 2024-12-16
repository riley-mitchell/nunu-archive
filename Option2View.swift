//
//  Option2View.swift
//  NU
//
//  Created by Riley Mitchell on 8/21/24.
//

import SwiftUI

struct Option2View: View {
    @StateObject private var newsFetcher = NewsFetcher()

    // Filter only negative sentiment news items
    private var negativeNewsItems: [NewsItem] {
        newsFetcher.newsItems.filter { $0.sentiment == "Negative" }
    }

    var body: some View {
        VStack {
            if negativeNewsItems.isEmpty {
                Text("Fetching negative stories...")
                    .font(.title2)
                    .padding()
            } else {
                List(negativeNewsItems) { item in
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.headline)
                            .lineLimit(2)

                        if let description = item.description {
                            Text(description)
                                .font(.subheadline)
                                .lineLimit(3)
                                .foregroundColor(.secondary)
                        }

                        if let url = item.url, let validURL = URL(string: url) {
                            NavigationLink(destination: WebView(url: validURL)) {
                                Text("Read more")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .padding()
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
            }
        }
        .onAppear {
            print("Option2View appears, starting news fetch.")
            newsFetcher.fetchNews()
        }
        .navigationTitle("Negative News")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct Option2View_Previews: PreviewProvider {
    static var previews: some View {
        Option2View()
    }
}




