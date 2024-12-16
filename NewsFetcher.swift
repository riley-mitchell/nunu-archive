//
//  NewsFetcher.swift
//  NU
//
//  Created by Riley Mitchell on 8/21/24.
//

import Foundation

// Define NewsItem struct
struct NewsItem: Identifiable, Codable {
    let id: String
    let title: String
    let description: String?
    let url: String?
    var sentiment: String
    var sentimentScore: Double // Added sentiment score for more detail

    init(title: String, description: String?, url: String?, sentiment: String = "Neutral", sentimentScore: Double = 0.0) {
        self.id = UUID().uuidString
        self.title = title
        self.description = description
        self.url = url
        self.sentiment = sentiment
        self.sentimentScore = sentimentScore
    }
}

// Define NewsAPIResponse struct
struct NewsAPIResponse: Codable {
    let articles: [Article]
}

// Define Article struct
struct Article: Codable {
    let title: String
    let description: String?
    let url: String?
}

// Define NewsFetcher class
class NewsFetcher: ObservableObject {
    @Published var newsItems: [NewsItem] = []

    private let apiKey = "eb3d136e26bb4aa7962bed471a839677"
    private let urlString = "https://newsapi.org/v2/everything?q=feel-good&apiKey="

    // Expanded list of positive and negative keywords
    private let positiveKeywords = [
        ("happy", 0.5), ("joy", 0.8), ("love", 0.7), ("win", 0.6), ("success", 0.9),
        ("amazing", 1.0), ("blessed", 0.8), ("victory", 0.7), ("hope", 0.6)
    ]
    private let negativeKeywords = [
        ("sad", 0.5), ("tragedy", 1.0), ("loss", 0.8), ("fail", 0.7), ("hurt", 0.6),
        ("disaster", 1.0), ("grief", 0.8), ("regret", 0.7), ("pain", 0.9)
    ]
    private let neutralKeywords = [
        ("news", 0.3), ("update", 0.3), ("report", 0.3), ("article", 0.3), ("story", 0.3)
    ]

    func fetchNews() {
        guard let url = URL(string: "\(urlString)\(apiKey)") else {
            print("Invalid URL")
            return
        }

        print("Fetching news from: \(url)") // Debug statement

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching news: \(error)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("Error: HTTP status code \(httpResponse.statusCode)")
                return
            }

            guard let data = data else {
                print("No data returned")
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(NewsAPIResponse.self, from: data)
                DispatchQueue.main.async {
                    self.newsItems = response.articles.map {
                        let sentiment = self.analyzeSentiment(title: $0.title, description: $0.description)
                        return NewsItem(title: $0.title, description: $0.description, url: $0.url, sentiment: sentiment.sentiment, sentimentScore: sentiment.score)
                    }
                    print("News items fetched: \(self.newsItems)") // Debug statement
                }
            } catch {
                print("Error decoding news: \(error)")
            }
        }
        task.resume()
    }

    // Advanced sentiment analysis
    private func analyzeSentiment(title: String, description: String?) -> (sentiment: String, score: Double) {
        let content = "\(title) \(description ?? "")".lowercased()

        var positiveScore = 0.0
        var negativeScore = 0.0

        // Calculate positive score
        for (word, weight) in positiveKeywords {
            if content.contains(word) {
                positiveScore += weight
            }
        }

        // Calculate negative score
        for (word, weight) in negativeKeywords {
            if content.contains(word) {
                negativeScore += weight
            }
        }

        // Calculate neutral score based on neutral keywords
        var neutralScore = 0.0
        for (word, weight) in neutralKeywords {
            if content.contains(word) {
                neutralScore += weight
            }
        }

        // Determine sentiment and overall score
        let totalScore = positiveScore - negativeScore
        let finalSentiment: String
        if totalScore > 0.5 {
            finalSentiment = "Positive"
        } else if totalScore < -0.5 {
            finalSentiment = "Negative"
        } else {
            finalSentiment = "Neutral"
        }

        return (finalSentiment, totalScore)
    }
}














