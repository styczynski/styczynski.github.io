@ECHO OFF
IF [%1] == [install] (
  npm install .
  npm prune
) ELSE (
  IF [%1] == [] (
    npm run help -s
  ) ELSE (
    npm run %* -s
  )
)
@ECHO ON
