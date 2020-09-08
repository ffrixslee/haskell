Exercises: Eq instances
Write the Eq instances for the datatypes provided.
1. It’s not a typo, we’re just being cute with the name:
data TisAnInteger =
TisAn Integer
CHAPTER 6. LESS AD-HOC POLYMORPHISM 274
2. data TwoIntegers =
Two Integer Integer
3. data StringOrInt =
TisAnInt Int
| TisAString String
4. data Pair a =
Pair a a
5. data Tuple a b =
Tuple a b
6. data Which a =
ThisOne a
| ThatOne a
7. data EitherOr a b =
Hello a
| Goodbye b
