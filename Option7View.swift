//
//  Option7View.swift
//  NU
//
//  Created by Riley Mitchell on 8/21/24.
//

import SwiftUI

struct Option7View: View {
    @StateObject private var newsFetcher = NewsFetcher()

    var body: some View {
        VStack {
            if newsFetcher.newsItems.isEmpty {
                Text("Fetching unusual news...")
                    .font(.title2)
                    .padding()
            } else {
                List(newsFetcher.newsItems) { item in
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
            print("Option1View appears, starting news fetch.")
            newsFetcher.fetchNews()
        }
        .navigationTitle("Unusual News")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct Option7View_Previews: PreviewProvider {
    static var previews: some View {
        Option7View()
    }
}
