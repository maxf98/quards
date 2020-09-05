//
//  QuardView.swift
//  Quards
//
//  Created by Max Fest on 24.08.20.
//

import SwiftUI
import PencilKit

struct QuardView: View {	
	@ObservedObject var session: Session
			
	var exit: () -> Void
		
	var body: some View {
		if let card = session.currentCard {
			let dragGesture = DragGesture(coordinateSpace: .global)
				.onEnded { value in
					if value.translation.height < 0 {
						withAnimation {
							session.frontHidden = true
						}
					} else {
						withAnimation {
							session.frontHidden = false
						}
					}
				}
			
			VStack {
				Group {
					if !session.frontHidden {
						ZStack() {
							Image(uiImage: card.frontImg)
							
							VStack(alignment: .leading) {
								Spacer()
								CardTags(tagDeck: card.tagDeck)
									.padding(.leading, 50)
							}
							.frame(maxWidth: .infinity, alignment: .leading)
						}
						.transition(.move(edge:.top))
						.animation(.easeInOut)
						
					} else {
						LinearGradient(gradient: Gradient(colors: [Color(card.tagDeck?.wrappedColor ?? .blue), .white]), startPoint: .top, endPoint: .bottom)
							.edgesIgnoringSafeArea(.all)
							.frame(maxWidth: .infinity)
							.frame(height: 35)
					}
				}
				.gesture(dragGesture)
				.highPriorityGesture(TapGesture()
															.onEnded { _ in
																 withAnimation {
																	session.frontHidden.toggle()
																 }
														 })
				
				HorizontalLine()
				
				ResponseView(session: session)
					.frame(maxHeight: .infinity)
				
			}
			.background(
				Color.white
					.edgesIgnoringSafeArea(.all)
					.frame(maxWidth: .infinity, maxHeight: .infinity))
		} else {
			EmptyView()
		}
	}
}
