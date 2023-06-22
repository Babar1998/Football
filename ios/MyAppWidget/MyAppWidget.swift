//
//  MyAppWidget.swift
//  MyAppWidget
//
//  Created by Alvaro Armijos on 19/6/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

@main
struct Widgets: WidgetBundle {
  var body: some Widget {
    if #available(iOS 16.1, *) {
      FootballMatchApp()
    }
  }
}

// We need to redefined live activities pipe
struct LiveActivitiesAppAttributes: ActivityAttributes, Identifiable {
  public typealias LiveDeliveryData = ContentState
  
  public struct ContentState: Codable, Hashable { }
  
  var id = UUID()
}

// Create shared default with custom group
let sharedDefault = UserDefaults(suiteName: "group.lalo.liveactivities")!

@available(iOSApplicationExtension 16.1, *)
struct FootballMatchApp: Widget {
  var body: some WidgetConfiguration {
    ActivityConfiguration(for: LiveActivitiesAppAttributes.self) { context in
      let matchName = sharedDefault.string(forKey: "matchName")!
      
      let teamAName = sharedDefault.string(forKey: "teamAName")!
      let teamAState = sharedDefault.string(forKey: "teamAState")!
      let teamAScore = sharedDefault.integer(forKey: "teamAScore")
      let teamALogo = sharedDefault.string(forKey: "teamALogo")!
      
      let teamBName = sharedDefault.string(forKey: "teamBName")!
      let teamBState = sharedDefault.string(forKey: "teamBState")!
      let teamBScore = sharedDefault.integer(forKey: "teamBScore")
      let teamBLogo = sharedDefault.string(forKey: "teamBLogo")!
      
      let matchStartDate = Date(timeIntervalSince1970: sharedDefault.double(forKey: "matchStartDate") / 1000)
      let matchEndDate = Date(timeIntervalSince1970: sharedDefault.double(forKey: "matchEndDate") / 1000)
      let matchRemainingTime = matchStartDate...matchEndDate
      
      ZStack {
          Color(UIColor(white: 1, alpha: 0.5))
        HStack {
          ZStack {
            VStack(alignment: .center, spacing: 2.0) {
              
              Spacer()
              
              Text(teamAName)
                .lineLimit(1)
                .font(.subheadline)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
              
              Text(teamAState)
                .lineLimit(1)
                .font(.footnote)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            }
            .frame(width: 70, height: 120)
            .padding(.bottom, 8)
            .padding(.top, 8)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
            
            ZStack {
              if let uiImageTeamA = UIImage(named: teamALogo)
              {
                Image(uiImage: uiImageTeamA)
                  .resizable()
                  .frame(width: 80, height: 80)
                  .offset(y:-20)
              }
            }
          }
          
          VStack(alignment: .center, spacing: 6.0) {
            HStack {
              Text("\(teamAScore)")
                .font(.title)
                .fontWeight(.bold)

              Text(":")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.primary)

              Text("\(teamBScore)")
                .font(.title)
                .fontWeight(.bold)
            }
            .padding(.horizontal, 5.0)
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))

            HStack(alignment: .center, spacing: 2.0) {
              Text(timerInterval: matchRemainingTime, countsDown: true)
                .multilineTextAlignment(.center)
                .frame(width: 50)
                .monospacedDigit()
                .font(.footnote)
            }

            VStack(alignment: .center, spacing: 1.0) {
              Text(matchName)
                .font(.footnote)
            }
          }
          .padding(.vertical, 6.0)
          
          ZStack {
            VStack(alignment: .center, spacing: 2.0) {

              Spacer()

              Text(teamBName)
                .lineLimit(1)
                .font(.subheadline)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

              Text(teamBState)
                .lineLimit(1)
                .font(.footnote)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            }
            .frame(width: 70, height: 120)
            .padding(.bottom, 8)
            .padding(.top, 8)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))

            ZStack {
              if let uiImageTeamB = UIImage(contentsOfFile: teamBLogo)
              {
                Image(uiImage: uiImageTeamB)
                  .resizable()
                  .frame(width: 80, height: 80)
                  .offset(y:-20)
              }
            }
          }
        }
        .padding(.horizontal, 2.0)
      }.frame(height: 160)
    } dynamicIsland: { context in
      let matchName = sharedDefault.string(forKey: "matchName")!
      
      let teamAName = sharedDefault.string(forKey: "teamAName")!
      let teamAState = sharedDefault.string(forKey: "teamAState")!
      let teamAScore = sharedDefault.integer(forKey: "teamAScore")
      let teamALogo = sharedDefault.string(forKey: "teamALogo")!
      
      let teamBName = sharedDefault.string(forKey: "teamBName")!
      let teamBState = sharedDefault.string(forKey: "teamBState")!
      let teamBScore = sharedDefault.integer(forKey: "teamBScore")
      let teamBLogo = sharedDefault.string(forKey: "teamBLogo")!
      
      let matchStartDate = Date(timeIntervalSince1970: sharedDefault.double(forKey: "matchStartDate") / 1000)
      let matchEndDate = Date(timeIntervalSince1970: sharedDefault.double(forKey: "matchEndDate") / 1000)
      let matchRemainingTime = matchStartDate...matchEndDate
      
      return DynamicIsland {
        DynamicIslandExpandedRegion(.leading) {
          VStack(alignment: .center, spacing: 2.0) {
            
            if let uiImageTeamA = UIImage(contentsOfFile: teamALogo)
            {
              Image(uiImage: uiImageTeamA)
                .resizable()
                .frame(width: 80, height: 80)
                .offset(y:0)
            }
            
            Spacer()
            
            Text(teamAName)
              .lineLimit(1)
              .font(.subheadline)
              .fontWeight(.bold)
              .multilineTextAlignment(.center)
            
            Text(teamAState)
              .lineLimit(1)
              .font(.footnote)
              .fontWeight(.bold)
              .multilineTextAlignment(.center)
          }
          .frame(width: 70, height: 120)
          .padding(.bottom, 8)
          .padding(.top, 8)
          
          
        }
        DynamicIslandExpandedRegion(.trailing) {
          VStack(alignment: .center, spacing: 2.0) {
            
            if let uiImageTeamB = UIImage(contentsOfFile: teamBLogo)
            {
              Image(uiImage: uiImageTeamB)
                .resizable()
                .frame(width: 80, height: 80)
                .offset(y:0)
            }
            
            Spacer()
            
            Text(teamBName)
              .lineLimit(1)
              .font(.subheadline)
              .fontWeight(.bold)
              .multilineTextAlignment(.center)
            
            Text(teamBState)
              .lineLimit(1)
              .font(.footnote)
              .fontWeight(.bold)
              .multilineTextAlignment(.center)
          }
          .frame(width: 70, height: 120)
          .padding(.bottom, 8)
          .padding(.top, 8)
          
          
        }
        DynamicIslandExpandedRegion(.center) {
          VStack(alignment: .center, spacing: 6.0) {
            HStack {
              Text("\(teamAScore)")
                .font(.title)
                .fontWeight(.bold)
              
              Text(":")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
              
              Text("\(teamBScore)")
                .font(.title)
                .fontWeight(.bold)
            }
            .padding(.horizontal, 5.0)
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
            
            HStack(alignment: .center, spacing: 2.0) {
              Text(timerInterval: matchRemainingTime, countsDown: true)
                .multilineTextAlignment(.center)
                .frame(width: 50)
                .monospacedDigit()
                .font(.footnote)
                .foregroundStyle(.white)
            }
            
            VStack(alignment: .center, spacing: 1.0) {
              Text(matchName)
                .font(.footnote)
                .foregroundStyle(.white)
            }
            
          }
          .padding(.vertical, 6.0)
        }
      } compactLeading: {
        HStack {
          if let uiImageTeamA = UIImage(contentsOfFile: teamALogo)
          {
            Image(uiImage: uiImageTeamA)
              .resizable()
              .frame(width: 36, height: 36)
          }
          
          Text("\(teamAScore)")
            .font(.title)
            .fontWeight(.bold)
        }
      } compactTrailing: {
        HStack {
          Text("\(teamBScore)")
            .font(.title)
            .fontWeight(.bold)
          if let uiImageTeamB = UIImage(contentsOfFile: teamBLogo)
          {
            Image(uiImage: uiImageTeamB)
              .resizable()
              .frame(width: 36, height: 36)
          }
        }
      } minimal: {
        ZStack {
          if let uiImageTeamA = UIImage(contentsOfFile: teamALogo)
          {
            Image(uiImage: uiImageTeamA)
              .resizable()
              .frame(width: 37, height: 37)
              .offset(x:-6)
          }
          
          if let uiImageTeamB = UIImage(contentsOfFile: teamBLogo)
          {
            Image(uiImage: uiImageTeamB)
              .resizable()
              .frame(width: 37, height: 37)
              .offset(x:6)
          }
        }
      }
    }
  }
}