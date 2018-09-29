#!/usr/bin/env stack
-- stack --resolver=lts-12.10 script
import Control.Monad
import Development.Shake
import Development.Shake.Command
import Development.Shake.FilePath
import Development.Shake.Util

execPandoc =
  [ "stack", "exec"
  , "--resolver=lts-12.10"
  , "--package", "pandoc"
  , "--"
  , "pandoc"
  ]
index  = "index.html"
template = "default.revealjs"
slides = "slides.md"

main :: IO ()
main = shakeArgs shakeOptions $ do
  want [index]

  index %> \out -> do
    need [template, slides]
    cmd_ execPandoc $
      [ "--mathjax"
      , "-t", "revealjs"
      , "--from=markdown+definition_lists"
      , "--template", template
      , "-o", out
      , slides
      ]
