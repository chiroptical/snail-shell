module Snail.Shell.ToText (toText) where

import Data.Text
import Snail.Shell.Lexer

toText :: SExpression -> Text
toText = \case
    TextLiteral (_, txt) -> "\"" <> txt <> "\""
    Lexeme (_, lexeme) -> lexeme
    SExpression Nothing exprs ->
        let txt = Data.Text.unwords $ toText <$> exprs
         in "(" <> txt <> ")"
    SExpression (Just c) exprs ->
        let txt = Data.Text.unwords $ toText <$> exprs
         in singleton c <> "(" <> txt <> ")"
