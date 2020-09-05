//
//  TagDeckHeader.swift
//  Quards
//
//  Created by Max Fest on 31.08.20.
//

import SwiftUI

struct TagDeckHeader: View {
	@EnvironmentObject var quardsModel: QuardsModel
	@EnvironmentObject var tabController: TabBarController
	
	@ObservedObject var tagDeck: TagDeck
	@Binding var isSelected: Bool
	@Binding var selectedChild: Int?
	@Binding var showingCards: Bool
	
	@State var showingOptions = false
	@State var renaming = false // need it to make sure that the view doesn"t disappear when you edit the name...
	@State var title = ""
	
	var body: some View {
		let colorBinding = Binding<Color>(
			get: {
				Color(tagDeck.wrappedColor)
			}, set: {
				tagDeck.wrappedColor = UIColor($0)
				quardsModel.coreDataStack.saveContext()
			})
		
		return HStack {

			TextField("new title", text: $title, onCommit: {
				tagDeck.name = title.isEmpty ? "Untitled" : title
				quardsModel.coreDataStack.saveContext()
				renaming = false
			})
			.font(Font.system(size: 20, weight: .bold))
			.foregroundColor(Color(tagDeck.secondaryColor))
			.frame(idealWidth: 100, maxWidth: 200)
			.padding()
			.disabled(!isSelected || selectedChild != nil)
			.onTapGesture {
				renaming = true
			}
			
			Spacer()
			
			if isSelected && selectedChild == nil {
				Group {
					Toggle("", isOn: $showingCards)
						.toggleStyle(DeckToggleStyle())
						.foregroundColor(Color(tagDeck.complementaryColor))
					
					OptionsButton(showingOptions: $showingOptions)
						.foregroundColor(Color(tagDeck.complementaryColor))
						.frame(width: 30, height: 30)
						.padding(.trailing, 30)
						.popover(isPresented: $showingOptions, arrowEdge: .bottom, content: {
							TagDeckOptions(showPopover: $showingOptions, color: colorBinding, included: $tagDeck.includeInDailyReview, delete: {
								withAnimation {
									isSelected = false
									quardsModel.deleteDeck(deck: tagDeck)
								}
							})
							.padding([.leading, .trailing], 7)
							.padding([.top, .bottom], 15)
							.onDisappear {
								quardsModel.coreDataStack.saveContext()
							}
						})
				}
				.disabled(renaming)
				.transition(.asymmetric(insertion: .move(edge: .bottom), removal: .identity))
				.onDisappear {
					showingOptions = false
				}
			}
		}
		.contentShape(Rectangle())
		.onTapGesture {
			withAnimation {
				if isSelected && !(showingOptions || renaming) {
					isSelected = false
				} else {
					isSelected = true
				}
				selectedChild = nil
			}
		}
		.onAppear {
			title = tagDeck.name
		}
	}
}
