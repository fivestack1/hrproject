//
//  PaywallView.swift
//  MyHoroscope2
//
//  Created by admin on 23.06.2026.
//


import SwiftUI
import StoreKit
import SwiftData

struct PaywallView: View {

    @Environment(\.dismiss)
    private var dismiss

    @State
    private var subscriptions =
    SubscriptionManager.shared

    @State
    private var animateHero = false

    var onSuccess: (() -> Void)?
    
    @State
    private var showBdata = false
    
    @Query
    private var users: [UserProfile]

    var body: some View {

        ZStack {

            CosmicBackground()

            ScrollView(showsIndicators: false) {

                VStack(spacing: 28) {

                    hero

                    titleSection

                    features

                    subscriptionsSection

                    purchaseButton

                    bottomButtons

                }
                .padding(.horizontal, 24)
                

            }

            if subscriptions.purchaseInProgress {

                loadingOverlay

            }

        }
        .task {

            await subscriptions.loadProducts()

            await subscriptions.updatePurchasedProducts()

        }
        .onChange(
            of: subscriptions.isSubscribed
        ) { _, subscribed in

            if subscribed {

                dismiss()

                onSuccess?()

            }
        }
        .alert(
            "Purchase Error",
            isPresented: .constant(
                subscriptions.errorMessage != nil
            )
        ) {

            Button("OK") {

                subscriptions.errorMessage = nil

            }

        } message: {

            Text(
                subscriptions.errorMessage ?? ""
            )

        }

    }

    // MARK: Hero

    var hero: some View {

        VStack(spacing: 20) {
            
            ZStack {
                
                Circle()
                    .fill(
                        Color.purple.opacity(0.15)
                    )
                    .frame(
                        width: 70,
                        height: 70
                    )
                
                Image(systemName: "sparkles")
                    .font(.system(size: 40))
                    .foregroundStyle(.white)
                
                if !users.isEmpty {
                    HStack {
                        Spacer()
                        VStack{
                            dismissButton
                            Spacer()
                        }
                    }
                }
                
            }
            /*.scaleEffect(
                animateHero ? 1.05 : 0.95
            )
            .animation(
                .easeInOut(duration: 2)
                .repeatForever(),
                value: animateHero
            )
            .onAppear {
                animateHero = true
                
            }*/
            
        }.padding(.top, 0)

    }

    // MARK: Title

    var titleSection: some View {

        VStack(spacing: 12) {

            Text("Unlock Premium")
                .font(.system(size: 34, weight: .bold))
                .multilineTextAlignment(.center)

            Text(
                "Unlimited astrology, birth charts and personal astrologer"
            )
            .font(.body)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)

        }
        .foregroundStyle(.white)

    }

    // MARK: Features

    var features: some View {

        GlowCard {

            VStack(spacing: 18) {

                PremiumFeatureRow(
                    icon: "sparkles",
                    title: "Unlimited AI Horoscope"
                )

                PremiumFeatureRow(
                    icon: "moon.stars.fill",
                    title: "Personal Birth Chart"
                )

                PremiumFeatureRow(
                    icon: "heart.fill",
                    title: "Compatibility Reports"
                )

                PremiumFeatureRow(
                    icon: "message.fill",
                    title: "Unlimited AI Chat"
                )

                PremiumFeatureRow(
                    icon: "star.fill",
                    title: "Premium Features Forever"
                )

            }

        }

    }

    // MARK: Plans

    var subscriptionsSection: some View {

        VStack(spacing: 15) {

            if let yearly = subscriptions.yearlyProduct {

                SubscriptionCard(

                    product: yearly,

                    selected:
                    subscriptions.yearlySelected,

                    badge: "BEST VALUE"

                ) {

                    subscriptions.selectYearly()

                }

            }

            if let weekly = subscriptions.weeklyProduct {

                SubscriptionCard(

                    product: weekly,

                    selected:
                    subscriptions.weeklySelected

                ) {

                    subscriptions.selectWeekly()

                }

            }

        }

    }

    // MARK: Purchase
    var purchaseButton: some View {
        /*Button {
            Task {
                await subscriptions.purchaseSelected()
            }
        } label: {
            Text(
                subscriptions.selectedProduct?.hasTrial == true ? "Start Free Trial" : "Continue"
            )
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding()
        }
        .buttonStyle(CosmicButtonStyle())*/
        GradientButton(title: subscriptions.selectedProduct?.hasTrial == true ? "Start Free Trial" : "Continue", action: {
            Task {
                await subscriptions.purchaseSelected()
            }
        })
    }

    // MARK: Footer

    var bottomButtons: some View {
        
        VStack {
            
            HStack {
                Button("Restore") {
                    Task {
                        await subscriptions.restorePurchases()
                    }
                }
                                
                Link("Terms", destination: URL(string: "https://sites.google.com/view/iterms/")!)
                Link("Policy", destination: URL(string: "https://sites.google.com/view/ipprivacy-policy/")!)

                if users.isEmpty {
                    Button("Start with limits") {
                        showBdata = true
                    }
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.65))
                }
            }
            .font(.caption)
            .foregroundStyle(.white.opacity(0.65))
            .padding(.top, 0)
            Text("Subscriptions auto-renew. Cancel anytime in App Store Settings.")
                                .font(.system(size: 10))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .opacity(0.65)
                                .padding(.top, 10)
        }
        .fullScreenCover(isPresented: $showBdata) {
            BirthDataSetupView()
        }
    }

    // MARK: Loading

    var loadingOverlay: some View {

        ZStack {

            Color.black.opacity(0.5)
                .ignoresSafeArea()

            VStack(spacing: 20) {

                ProgressView()

                Text("Processing Purchase...")

            }
            .padding(30)
            .background(.ultraThinMaterial)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 24
                )
            )

        }
        .foregroundStyle(.white)

    }

    private var dismissButton: some View {

        Button {

            dismiss()

        } label: {

            Image(systemName: "xmark")
                .font(.headline)
                .foregroundStyle(.white).opacity(0.7)
                
        }
    }
}


struct PremiumFeatureRow: View {

    let icon: String

    let title: String

    var body: some View {

        HStack(spacing: 16) {

            Image(systemName: icon)
                .font(.title3)

                .foregroundStyle(.purple)

                .frame(width: 30)

            Text(title)

            Spacer()

        }
        .foregroundStyle(.white)

    }

}


struct SubscriptionCard: View {

    let product: Product

    let selected: Bool

    var badge: String? = nil

    let action: () -> Void

    @State private var pulse = false

    var body: some View {

        Button(action: action) {

            ZStack(alignment: .topTrailing) {

                RoundedRectangle(cornerRadius: 26)
                    .fill(.ultraThinMaterial)

                RoundedRectangle(cornerRadius: 26)
                    .strokeBorder(
                        selected
                        ? Color.purple
                        : Color.white.opacity(0.12),
                        lineWidth: selected ? 2.5 : 1
                    )

                VStack(alignment: .leading, spacing: 18) {

                    HStack(alignment: .top) {

                        VStack(alignment: .leading, spacing: 6) {

                            HStack{
                                Text(title)
                                    .font(.title3.bold())
                                    .padding(.trailing, 10)
                                
                                /*if let badge {
                                    Text(badge)
                                        .font(.caption2.bold())
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(
                                            Capsule()
                                                .fill(
                                                    LinearGradient(
                                                        colors: [
                                                            .pink,
                                                            .pink
                                                        ],
                                                        startPoint: .leading,
                                                        endPoint: .trailing
                                                    )
                                                )
                                        )
                                        .foregroundStyle(.white)
                                        //.offset(x: -16, y: 14)
                                        .scaleEffect(
                                            pulse ? 1.05 : 0.95
                                        )
                                        .animation(
                                            .easeInOut(duration: 1.6)
                                            .repeatForever(),
                                            value: pulse
                                        )
                                        .onAppear {
                                            pulse = true

                                        }
                                }*/
                            }

                            /*Text(subtitle)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)*/
                            
                            Text("\(product.displayPrice) / \(priceDescription)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        /*Image(systemName:
                                selected
                                ? "checkmark.circle.fill"
                                : "circle")
                        .font(.title2)
                        .foregroundStyle(
                            selected
                            ? Color.purple
                            : Color.gray
                        )*/
                        
                        Text(product.displayPrice)
                            .font(.title3.bold())
                    }

                    //Divider().overlay(Color.white.opacity(0.08))

                    /*HStack(alignment: .bottom) {

                        VStack(alignment: .leading, spacing: 4) {

                            Text(product.displayPrice)
                                .font(.system(size: 28, weight: .bold))

                            Text(priceDescription)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        Spacer()

                        if let weekly = product.weeklyEquivalent {

                            VStack(alignment: .trailing, spacing: 4) {

                                Text("\(weekly)/week")
                                    .font(.headline)

                                Text("Equivalent")
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        
                        if let badge {

                            Text(badge)
                                .font(.caption2.bold())
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(
                                    Capsule()
                                        .fill(
                                            LinearGradient(
                                                colors: [
                                                    .purple,
                                                    .blue
                                                ],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                )
                                .foregroundStyle(.white)
                                .offset(x: -16, y: 14)
                                .scaleEffect(
                                    pulse ? 1.05 : 0.95
                                )
                                .animation(
                                    .easeInOut(duration: 1.6)
                                    .repeatForever(),
                                    value: pulse
                                )
                                .onAppear {

                                    pulse = true

                                }
                        }
                    }*/
                }
                .padding(22)

                

            }
            //.frame(height: 170)
            .shadow(
                color: selected
                ? .purple.opacity(0.35)
                : .clear,
                radius: 20
            )
            .scaleEffect(selected ? 1.02 : 1)
            .animation(
                .spring(
                    response: 0.35,
                    dampingFraction: 0.8
                ),
                value: selected
            )

        }
        .buttonStyle(.plain)
    }

    private var selectedGradient: LinearGradient {

        LinearGradient(
            colors: [
                .purple,
                .blue
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    private var title: String {

        if product.id == SubscriptionManager.yearlyID {
            return "Monthly"
        }

        return "Weekly"
    }

    private var subtitle: String {

        if product.id == SubscriptionManager.yearlyID {

            if product.hasTrial {
                return "Includes Free Trial"
            }

            return "Best value"
        }

        return "Cancel anytime"
    }

    private var priceDescription: String {

        if product.id == SubscriptionManager.yearlyID {
            return "per month"
        }

        return "per week"
    }
}


