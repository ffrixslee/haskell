data BinaryTree a = 
    Leaf
  | Node (BinaryTree a) a (BinaryTree a)
  deriving (Eq, Ord, Show)

insert' :: Ord a
        => a
        -> BinaryTree a
        -> BinaryTree a

insert' b Leaf = Node Leaf b Leaf
insert' b (Node left a right)
  | b == a = Node left a right
  | b < a = Node (insert' b left) a right
  | b > a = Node left a (insert' b right)

mapTree :: (a -> b)
        -> BinaryTree a
        -> BinaryTree b
mapTree _ Leaf = Leaf
mapTree f (Node left a right) = 
    Node undefined undefined undefined

testTree' :: BinaryTree Integer
testTree' =
    Node (Node Leaf 3 Leaf)
         1
         (Node Leaf 4 Leaf)

mapExpected = 
    Node (Node Leaf 4 Leaf)
         2
         (Node Leaf 5 Leaf)

mapOkay = 
    if mapTree (+1) testTree' == mapExpected
        then print "yup OK!"
        else error "test failed!"

mapTree' :: (a -> b) -> BinaryTree a -> BinaryTree b
mapTree' _ Leaf = Leaf
mapTree' f (Node left x right) = 
    Node (mapTree f left) (f x) (mapTree f right) 

testTree :: BinaryTree Integer
testTree = 
    Node (Node Leaf 1 Leaf)
         2
         (Node Leaf 3 Leaf)

preorder :: BinaryTree a -> [a]
preorder Leaf = []
preorder (Node left x right) = 
    [x] ++ preorder left ++ preorder right
testPreorder :: IO()
testPreorder =
    if preorder testTree == [2,1,3]
        then putStrLn "Preorder fine!"
        else putStrLn "Bad news bears"

inorder :: BinaryTree a -> [a]
inorder Leaf = []
inorder (Node left y right) = 
    inorder left ++ [y] ++ inorder right
testInorder :: IO()
testInorder = 
    if inorder testTree == [1, 2, 3]
        then putStrLn "Inorder fine!"
        else putStrLn "Bad news bears."

postorder :: BinaryTree a -> [a]
postorder Leaf = []
postorder (Node left z right) = 
    postorder left ++ postorder right ++ [z]

testPostorder :: IO()
testPostorder = 
    if postorder testTree == [1, 3, 2]
    then putStrLn "Postorder fine!"
    else putStrLn "Bad news bears"

main :: IO()
main = do
    testPreorder
    testInorder
    testPostorder

--Write foldr for BinaryTree

--any traversal order is fine
foldTree :: (a -> b-> b)
          -> b
          -> BinaryTree a
          -> b
foldTree Leaf = Node (BinaryTree a) a (BinaryTree a)