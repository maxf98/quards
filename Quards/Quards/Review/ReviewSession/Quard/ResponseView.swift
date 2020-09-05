//
//  ResponseView.swift
//  Quards
//
//  Created by Max Fest on 24.08.20.
//

import SwiftUI
import PencilKit

struct ResponseView: View {
	@ObservedObject var session: Session
	@State var drawing = PKDrawing()
	
	func gradeCard(grade: SRGrade) {
		self.drawing = PKDrawing()
		session.gradeCard(grade: grade)
		session.nextCard()
	}
		
	var body: some View {
		ZStack {
			Color.white
			
			if session.drawing {
				DrawingViewRepresentation(drawing: $drawing, scaleFactor: .constant(1), toolPicker: session.toolPicker)
				
				VStack {
					HStack {
						Spacer()
						Button(action: {
							session.drawing = false
						}) {
							Text("Done")
								.padding(.top, 15)
								.padding(.trailing, 30)
						}
					}
					Spacer()
				}
			} else {
				VStack {
					ComparisonView(attempt: drawing.image(from: drawing.bounds, scale: UIScreen.main.scale), answer: session.currentCard!.backImg)
					
					Spacer()
					
					GradesView(gradeCard: gradeCard)
				}
			}
		}
	}
}
