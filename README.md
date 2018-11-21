# AnimationSequence
Easily sequence animations together in swift.

Strongly inspired by this article - https://medium.com/@ernesto.torres/ios-uiview-chained-animations-f8fadcc16be5


```
let sequence = AnimationSequence()
sequence.addAnimation(duration: 0.3, animationCurve: .curveEaseOut) {
            //this block just runs in a UIView.animate call
            self.viewA.alpha = 0
            self.viewB.alpha = 1
            }
            .addAnimation(duration: 0.2, animationCurve: .curveEaseOut) {
                self.viewBHeightConstraint.constant = 10
                self.view.layoutIfNeeded()
            }
            .addAnimation(duration: 0.4) {
                self.viewA.alpha = 1
            }
            .addAnimation() {
                self.viewB.alpha = 0
            }
            .execute
```      
      
