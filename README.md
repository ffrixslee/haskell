# haskell
Cataloging Haskell exercises that I've attempted

# Notes & Thoughts:
## Chapter 20:
- folding requires a monoidal instance ↔️ related to the fact that folding implies a binary associative operation
- minimal req: foldMap OR foldr

**Resources:**
- https://blog.jakuba.net/2014-07-30-foldable-and-traversable/
> "We can describe a fold as taking a structure and reducing it to a single result."
> fold and foldMap require the elements of the Foldable to be Monoids.  
> foldr uses a function to give us the final result

>  Important: it is the fold function itslef that requires the elements of Foldable to have a Monoid instance, while Foldable itself does not have that restriction.

> Can bypass this restriction by wrapping the elements in a Monoid such as Sum or Product and fold them then.