module CalPi where

-- sum $ take n $ map (4.0/) $ zipWith (*) [1,3..] (cycle [1, -1])
leibniz n = 4 * (gregory 1.0 n)

-- \frac{\pi}{4} = 4\tan^{-1} \frac{1}{5} - \tan^{-1} \frac{1}{239}
-- \tan^{-1} x = x - \frac{x^3}{3} + \frac{x^5}{5} - \frac{x^7}{7} + \dotsb

gregory x n = fst $ foldl (\(s, x') k -> let y = x'*x*x in (s + y / k, y)) (x, x) (take n $ zipWith (*) [3,5..] (cycle [-1, 1]))

machin n = 4 * (4 * (gregory 0.2 n) - (gregory (1/239) n))
