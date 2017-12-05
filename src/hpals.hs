import System.Environment
import Data.Char

is_pal :: (Eq a) => [a] -> Bool
is_pal [] = True
is_pal [_] = True
is_pal (x:xs) = (x == last xs) && (is_pal $ init xs)

letters :: [Char] -> [Char]
letters = (map toLower) . (filter isAlpha)

main = do
    [word] <- getArgs
    putStrLn $ if (is_pal $ letters word) then "is a palindrome" else "is not a palindrome"
