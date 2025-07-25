module EgyptianFrac where

import Data.Sequence (Seq, ViewL(..), viewl, empty, (|>))
import Test.QuickCheck

reduceF b a = (b `div` d, a `div` d) where d = gcd b a

-- b/a + d/c
add (b, a) (d, c) = reduceF (c*b + a*d) (a*c)
diff (b, a) (d, c) = (b, a) `add` (-d, c)

-- sum of 1/a_1 + 1/a_2 + ... + 1/a_n
sumR as = foldr add (0, 1) [(1, a) | a <- as]

-- Choose the 'better' decomposition of Egyptian fractions
cmp [] ys = ys
cmp xs [] = xs
cmp xs ys | length xs < length ys = xs
          | length ys < length xs = ys
          | head xs < head ys = xs
          | otherwise = ys

-- Fibonacci (greedy) decomposition
-- decompose b/a = 1/q + decompose (b/a - 1/q), where q = 1 + floor(a/b)
decomposeF (1, a) = [a]
decomposeF (b, a) = q : decomposeF ((b, a) `diff` (1, q)) where q = 1 + a `div` b

decompose (1, a) = [a]
decompose (b, a) = bfs (b, a, 1 + a `div` b, [], b) [] empty where
  bfs (b, a, q, qs, n) best queue
    | best /= [] && 1 + length qs >= length best = best
    | a * n < b * q = case viewl queue of
        EmptyL -> best
        c :< cs -> bfs (from c) best cs
    | otherwise = if b' == 1 && a' > q
        then bfs (b, a, q + 1, qs, n) (cmp (a':q:qs) best) queue
        else bfs (b, a, q + 1, qs, n) best (queue |> (b', a', q:qs, n - 1))
    where
      (b', a') = (b, a) `diff` (1, q)
  from (b, a, []  , n) = (b, a, 1 + a `div` b,         []  , n)
  from (b, a, q:qs, n) = (b, a, 1 + max q (a `div` b), q:qs, n)

-- some hard cases:
-- (5, 121) (27, 29), (65, 87)

-- bound the nominator and denominator in range [1, 125]
fracOf (x, y) = reduceF (min x' y') (max x' y') where
  x' = 1 + (abs x) `mod` 125
  y' = 1 + (abs y) `mod` 125

verifySum x f = x == sumR (f x)

prop_sumF :: (Int, Int) -> Bool
prop_sumF x = verifySum (fracOf x) decomposeF

prop_sum :: (Int, Int) -> Bool
prop_sum x = verifySum (fracOf x) decompose

prop_best :: (Int, Int) -> Bool
prop_best x = qs1 == cmp qs1 qs2 where
  qs1 = decompose y
  qs2 = reverse (decomposeF y)
  y = fracOf x
