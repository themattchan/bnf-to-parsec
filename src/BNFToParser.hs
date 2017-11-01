module BNFToParser where
import Control.Applicative
import Control.Monad
import qualified Data.ByteString.Lazy as BL
import qualified Text.Megaparsec as P
import qualified Text.Megaparsec.Char as PC
import qualified Text.Megaparsec.Char.Lexer as PL
import qualified Language.Haskell.Exts as H


data BNF
  =


grammar :: Parser [H.Decl ()]
grammar = P.some production

production :: Parser (H.Decl ())
production = do
  name <- nontermIdent
  PC.char ':'
  PC.space
  cases <- alts
  return $ H.FunBind () [] -- TODO

nontermIdent :: Parser String
nontermIdent = do
  c <- PC.lowerChar
  r <- P.sepBy1 (P.many alphaNumChar) (PC.char '_')
  return $ c : intersperse '_' r

stringLit :: Parser String
stringLit = lexeme $ q *> P.manyTill PC.anyChar q
  where q = char '\''

alts :: Parser (H.Exp ())
alts = undefined  -- use (App "<|>") here

tokens :: Parser (H.Exp ())
tokens = undefined --

token :: P.Parser (H.Exp ())
token = undefined


--------------------------------------------------------------------------------
-- Megaparsec boilerplate

type Parser a = P.Parsec () String a

spaceConsumer :: Parser ()
spaceConsumer = PL.space PC.space lineComment blockComment
  where
    lineComment  = PL.skipLineComment "#"
    blockComment = PL.skipBlockComment "/*" "*/"

symbol :: String -> Parser String
symbol = PL.symbol spaceConsumer


lexeme :: Parser String -> Parser String
lexeme = PL.lexeme spaceConsumer
