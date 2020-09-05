//
//  GradesView.swift
//  Quards
//
//  Created by Max Fest on 29.08.20.
//

import SwiftUI

struct GradesView: View {
	var gradeCard: (SRGrade) -> Void
	
	var body: some View {
		HStack {
			ForEach(SRGrade.allCases, id: \.self) { grade in
				Button(action: {
					self.gradeCard(grade)
				}) {
					Circle()
						.foregroundColor(grade.color)
						.frame(width: 60, height: 60)
				}
				.buttonStyle(GradeButtonStyle())
			}
		}
	}
}

struct GradeButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.scaleEffect(configuration.isPressed ? 0.9 : 1)
	}
}

struct GradesView_Previews: PreviewProvider {
	static var previews: some View {
		GradesView() {_ in}
	}
}
