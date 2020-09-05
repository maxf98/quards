//
//  CardSide.swift
//  Quards
//
//  Created by Max Fest on 24.08.20.
//

import SwiftUI
import PencilKit

struct CardSide: View {
	@EnvironmentObject var quardsModel: QuardsModel
		
	@Binding var showingDrawingView: Bool
	@ObservedObject var card: Card
	
	@State var offset: CGFloat = 0
	
	var toolPicker = PKToolPicker() // need to initialize this here because the drawing view is reloaded,
	// so I can't create the reference there, maybe include in the model somehow, e.g. in an environmentObject

	var drawing: PKDrawing {
		front ? card.frontDrawing : card.backDrawing
	}
	
	var img: UIImage {
		front ? card.frontImg : card.backImg
	}
	
	var front: Bool
	
	func saveDrawing(drawing: PKDrawing) {
		card.updateDrawing(isFront: front, drawing: drawing)
		offset = 0
		quardsModel.coreDataStack.saveContext()
	}
		
	var body: some View {
		ZStack {
			Image(uiImage: img)
			
			Button(action: {
				withAnimation {
					self.showingDrawingView = true
				}
			}){
				Image(systemName: "pencil")
					.resizable()
					.scaledToFit()
					.frame(width: 30, height: 30)
					.padding(.trailing, 15)
			}
			.frame(maxWidth: .infinity, alignment: .trailing)
			
			if showingDrawingView {
				DrawingView(drawing: drawing, showDrawingView: $showingDrawingView, offset: $offset, save: saveDrawing, toolPicker: toolPicker)
			}
		}
		.frame(height: showingDrawingView ? img.size.height + 150 + offset : img.size.height + 20)
	}
}

