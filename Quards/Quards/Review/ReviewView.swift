//
//  ReviewView.swift
//  Quards
//
//  Created by Max Fest on 24.08.20.
//

import SwiftUI

struct ReviewView: View {
	@EnvironmentObject var tabController: TabBarController
	@StateObject var reviewData: ReviewData
	
	@State var reviewing = false
	
	func exitSession() {
		reviewData.selectedDecks = Set<TagDeck>()
		reviewData.refreshSR()
		reviewing = false
		tabController.hideTabBar = false
	}
	
	var body: some View {
		ZStack {
			ScrollView {
				VStack {
					
					NextReviewView(expectedTime: reviewData.srData.drTime, numCards: reviewData.srData.drCount, startDailyReview: {
						tabController.hideTabBar = true
						reviewing = true
						reviewData.newDailyReviewSession()
					})
					.padding(50)
					.frame(maxWidth: .infinity)
					
					ReviewSelectionView(selectedDecks: $reviewData.selectedDecks, startReview: {
						tabController.hideTabBar = true
						reviewing = true
						reviewData.newSessionFromSelectedDecks()
					})
						.padding(50)
						.frame(maxWidth: .infinity)
				}
				.frame(maxHeight: .infinity)
			}
			.onTapGesture {
				withAnimation {
					tabController.hideTabBar.toggle()
				}
			}
			
			if reviewing {
				SessionView(session: reviewData.currentSession ?? Session(), exitSession: exitSession)
					.frame(maxHeight: .infinity)
			}
		}
	}
}

