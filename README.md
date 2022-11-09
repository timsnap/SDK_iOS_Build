# Snappay_SDK_iOS_Build

A description of this package.

# Project Architecture Guide

**Snappay_SDK_iOS_Demo project implements MVVM architecture approach.**

ViewModel is not a new concept. It’s the main part of the MVVM design pattern that was first introduced in 2005 by Josh Gossman in [this post](Introduction to Model/View/ViewModel pattern for building WPF apps ) at Microsoft’s blog. MVVM brings all the testability and decoupling we need and in it's core has only 3 layers. And the name of these layers explain themselves. Additional coordinator part of the MVVM-C pattern was added to handle communication between MVVM-C modules.

## Navigation Patterns

### Coordinator Pattern

## Implementation details

### There is no single canonical implementation of the Coordinator pattern, but the one that is used in Snappay_SDK_iOS_Demo project has several benefits

 

## WHY

### Makes it easy to handle the "biggest pain" of the coordinator pattern - handling of the back button (or swipe back) in the horizontal flow in order to be able to deallocate the child coordinator when it finishes its flow. [**More on this problem**](Coordinators, Routers, and Back Buttons | HackerNoon )

 

- Avoids polluting navigation (router) with flow logic (coordinators)

- Delegates what to do when the back button is pressed (deallocation of child coordinator) back to the parent coordinator

- Provides a common interface for presenting and pushing coordinators and view controllers [**Presentable** protocol]

- Allows us to push to subsequent horizontal flows with ease.

## Screens

- Home Screen.

- Image Capture Screen.

- Success Payment Screen.

## UI Frameworks

##UIKIT (Programmatic UI)

- Building UI programmatically means creating the user interface in code (Swift, to be exact), rather than using the Interface Builder.

- Easy code refactoring for experienced developers since the developer is in control of the UI elements.

- Easier to resolve merge conflicts 

- Easy to see the properties of UI elements 

- Supports adding animations

- External Librarires.

- None For now.

## programming Language

### Swift.

## Network Data Layer.

### URLSession.
