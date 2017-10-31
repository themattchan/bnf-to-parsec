module BNFToParser where
import qualified Data.ByteString.Lazy as BL
import qualified Text.Megaparsec as P
import qualified Text.Megaparsec.Char as PC
import qualified Text.Megaparsec.Char.Lexer as PL
import qualified Language.Haskell.Exts as H


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
nontermIdent = undefined

alts = undefined
--tokens :: P.Parser


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
