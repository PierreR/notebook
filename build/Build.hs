import Data.Monoid
import Development.Shake
import Development.Shake.Command
import Development.Shake.FilePath
import Development.Shake.Util

buildDir = "out"
srcDir = "src"

main :: IO ()
main = shakeArgs shakeOptions{shakeFiles="build/_shake"} $ do

  buildDir <> "/**/*.html" %> \out -> do
    let  doc = srcDir </> dropDirectory1 (out -<.> "adoc")
    need [doc]
    cmd "asciidoctor" doc "-o" out

  buildDir <> "/**/*.pdf" %> \out -> do
    let  doc = srcDir </> dropDirectory1 (out -<.> "adoc")
    need [doc]
    cmd "asciidoctor-pdf" doc "-o" out

  "clean" ~> do
    putNormal ("Cleaning files in " <> buildDir)
    removeFilesAfter buildDir ["/**/*.html"]
    removeFilesAfter buildDir ["/**/*.pdf"]

  "html" ~> do
    is <- getDirectoryFiles srcDir ["/**/*.adoc"]
    need [ buildDir </> i -<.> "html" | i <- is ]

  "pdf" ~> do
    is <- getDirectoryFiles srcDir ["/**/*.adoc"]
    need [ buildDir </> i -<.> "pdf" | i <- is ]
