//
//  CardView.swift
//  Quards
//
//  Created by Max Fest on 05.08.20.
//

import SwiftUI
import PencilKit

struct CardView: View {
	@Environment(\.presentationMode) var presentationMode
	@ObservedObject var card: Card
	
	@Binding var showingCard: Bool
	
	@State var drawingFront = false
	@State var drawingBack = false

	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 10)
				.foregroundColor(.white)
				.frame(maxWidth: .infinity, maxHeight: .infinity)
			
			VStack(spacing: 0) {
				if !(drawingFront || drawingBack) {
					HStack {
						CardTags(tagDeck: card.tagDeck)
							.padding(.leading, 50)
						
						Spacer()
						
						Button(action: {
							withAnimation {
								showingCard = false
							}
						}) {
							Image(systemName: "xmark.circle")
								.resizable()
								.scaledToFit()
								.frame(width: 35, height: 35)
								.padding()
						}
					}
				}
			
				ScrollView {
						CardSide(showingDrawingView: $drawingFront, card: card, front: true)
							.opacity(drawingBack ? 0.6 : 1)
							.disabled(drawingBack)
							.padding(.bottom, 20)
						
						Divider()
						
						CardSide(showingDrawingView: $drawingBack, card: card, front: false)
							.opacity(drawingFront ? 0.6 : 1)
							.disabled(drawingFront)
							.padding(.top, 20)
					}
				//.frame(height: UIScreen.main.bounds.height + card.frontImg.size.height, alignment: .top)
			}
		}
	}
}

