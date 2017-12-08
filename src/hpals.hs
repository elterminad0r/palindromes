import System.Environment
import Control.Monad
import Data.Char

is_pal :: (Eq a) => [a] -> Bool
is_pal [] = True
is_pal [_] = True
is_pal (x:xs) = (x == last xs) && (is_pal $ init xs)

letters :: [Char] -> [Char]
letters = (map toLower) . (filter isAlpha)

main :: IO ()
main = do
    tests <- getArgs
    forM_ tests (\w -> do
                    (putStr . show) w
                    putStr " "
                    (print . is_pal . letters) w
                )
