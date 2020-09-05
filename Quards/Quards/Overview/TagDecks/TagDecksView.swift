//
//  TagDecksView.swift
//  Quards
//
//  Created by Max Fest on 30.08.20.
//

import SwiftUI

struct TagDecksView: View {
	@EnvironmentObject var quardsModel: QuardsModel
	@EnvironmentObject var tabController: TabBarController
	
	@ObservedObject var tagDeck: TagDeck
	
	@Binding var isSelected: Bool
	@State var selectedChild: Int?
	
	@State var showingCards = false
	
	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 30)
				.foregroundColor(Color(tagDeck.wrappedColor))
				.padding(isSelected ? 5 : 0)
				.edgesIgnoringSafeArea(.bottom)
				.frame(maxWidth: .infinity, maxHeight: isSelected ? .infinity : 80)
			
			VStack(spacing: -10) {
				TagDeckHeader(tagDeck: tagDeck, isSelected: $isSelected, selectedChild: $selectedChild, showingCards: $showingCards)
					.padding([.leading, .trailing], isSelected ? 10 : 0)

								
				if isSelected {
					if !showingCards {
						ChildrenView(tagDeck: tagDeck, selectedChild: $selectedChild, createDeck: {
							let newDeck = quardsModel.createTagDeck(parent: tagDeck)
							withAnimation {
								selectedChild = tagDeck.wrappedChildren.firstIndex(of: newDeck)
							}
						})
						.transition(AnyTransition.opacity.animation(.linear(duration: 0.3)))
						.frame(maxHeight: .infinity)
					} else {
						SingleDeckView(tagDeck: tagDeck)
							.transition(.move(edge: .bottom))
							.animation(.easeInOut)
					}
				}
			}
		}
		.onDisappear {
			self.selectedChild = nil
			self.showingCards = false
		}
	}
}
