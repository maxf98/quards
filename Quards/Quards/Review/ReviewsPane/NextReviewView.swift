//
//  NextReviewView.swift
//  Quards
//
//  Created by Max Fest on 29.08.20.
//

import SwiftUI

struct NextReviewView: View {
	var expectedTime: Double
	var numCards: Int
	
	var startDailyReview: () -> Void
	
	var formattedTime: String {
		let hrs = Int(expectedTime) / (3600)
		let hrStr = hrs > 0 ? "\(hrs) hrs : " : ""
		let mins = (Int(expectedTime) % 3600) / 60 + 1
		let minStr = "\(mins) mins"
		return hrStr + minStr
	}
	
	var body: some View {
		VStack {
			Text("Your daily review")
				.foregroundColor(.gray)
				.fontWeight(.bold)
				.frame(maxWidth: .infinity, alignment: .trailing)
			
			Group {
				if numCards > 0 {
					VStack {
						Text("\(numCards) \(numCards == 1 ? "card" : "cards") ~ \(formattedTime)")
						
						Button(action: startDailyReview) {
							Image(systemName: "play.circle.fill")
								.resizable()
								.scaledToFit()
								.frame(width: 50, height: 50)
						}
					}
				} else {
					Text("No cards for review today!")
				}
			}
			.frame(maxWidth: .infinity)
			.padding()
			.overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 0.5))
		}
	}
}

struct NextReviewView_Previews: PreviewProvider {
	static var previews: some View {
		NextReviewView(expectedTime: 135, numCards: 10, startDailyReview: {})
	}
}
