//
//  TOPButtonView.swift
//  Time of Possession
//
//  Created by Jim Dabrowski on 11/10/21.
//

import SwiftUI

struct TOPButtonView: View, TOPTimerListener {
    @EnvironmentObject var timer: TOPTimer
    @EnvironmentObject var configuration: Configuration
        
    @State var isListener: Bool = false
    @State var elapsedTime: Double = 0.0

    var forHome: Bool
    
    var body: some View {
        ZStack {
            if isListener {
                Rectangle()
                    .foregroundColor(forHome ? configuration.homeColor : configuration.visitingColor)
                    .padding()
                    .shadow(color: Color("darkShadow"), radius: 2.0, x: 3.0, y: 3.0)
            } else {
                Rectangle()
                    .foregroundColor(forHome ? configuration.homeColor : configuration.visitingColor)
                    .padding()
                    .shadow(color: Color("darkShadow"), radius: 10.0, x: 5.0, y: 5.0)
                    .opacity(0.5)
            }
            VStack {
                TeamTextView(team: forHome ? $configuration.homeTeam : $configuration.visitingTeam)
                TimerTextView(elapsedTime: $elapsedTime)
            }
        }.onTapGesture {
            if isListener {
                timer.stop()
            } else {
                if timer.isRunning {
                    timer.becomeListener(newListener: self)
                } else {
                    timer.start()
                    timer.becomeListener(newListener: self)
                }
            }
        }
    }    
}


struct TimerTextView: View {
    @Binding var elapsedTime: Double
    
    var body: some View {
        Text(elapsedTimeString(elapsedTime: elapsedTime))
            .font(.system(size: 48, weight: .regular, design: .monospaced))
            .foregroundColor(Color("instructionText"))
    }
    
    func elapsedTimeString(elapsedTime: Double) -> String {
        // Display elapsed time in hh:mm:ss padded with 0s
        let timeFormatter = DateComponentsFormatter()
        timeFormatter.allowedUnits = [.hour, .minute, .second]
        timeFormatter.zeroFormattingBehavior = .pad
        return timeFormatter.string(from: elapsedTime) ?? "00:00:00"
    }
}

struct TeamTextView: View {
    @Binding var team: String
    
    var body: some View {
        Text(team)
            .font(.system(size: 36))
            .fontWeight(.bold)
            .foregroundColor(Color("instructionText"))
    }
}

