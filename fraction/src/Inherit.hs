module Inherit where

s = [(a, b, c, n) | a <- [2..10], b <- [a+1..11], c <- [b+1..12],
     let d = a*b*c - a*b - b*c - a*c, d > 0,
     let n = a*b*c `div` d, n > 1,
         n `mod` a == 0, n `mod` b == 0, n `mod` c == 0]
