//
//  DrawingView.swift
//  Quards
//
//  Created by Max Fest on 09.08.20.
//

import SwiftUI
import PencilKit

struct DrawingView: View {
	
	@State var drawing: PKDrawing
	@Binding var showDrawingView: Bool
	@Binding var offset: CGFloat
	
	var save: (PKDrawing) -> Void
	
	var toolPicker: PKToolPicker
	
	@State var viewZoom: CGFloat = 1
	
	var body: some View {
		ZStack {
			Color.white.edgesIgnoringSafeArea(.all)
				.frame(maxWidth: .infinity, maxHeight: .infinity)
			
			VStack(spacing: 0) {

				Button(action: {
					self.save(drawing)
					withAnimation {
						self.showDrawingView = false
					}
				}) {
					Image(systemName: "pencil.slash")
						.resizable()
						.scaledToFit()
						.frame(width: 30)
						.padding()
				}
				.frame(maxWidth: .infinity, alignment: .trailing)
				
				DrawingViewRepresentation(drawing: $drawing, scaleFactor: $viewZoom, toolPicker: toolPicker)
				.overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black))
				
				DraggableView(offset: $offset) {
					VStack(spacing: 0) {
						Divider()
						RoundedRectangle(cornerRadius: 4)
							.foregroundColor(.gray)
							.frame(width: 60, height: 25)
					}
				}
			}
		}
	}
}
