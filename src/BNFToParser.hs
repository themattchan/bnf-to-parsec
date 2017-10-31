module BNFToParser where
import qualified Text.Megaparsec as P
import qualified Language.Haskell.Exts as H

grammar :: P.Parser [H.Decl ()]
grammar = P.many1 production

production :: P.Parser (H.Decl ())
production = do
  name <- nonterm
  P.char ':'
  P.space
  cases <- alts
  return $ H.FunBind () [] -- TODO
