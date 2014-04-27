((factory) ->
  if typeof define is "function" and define.amd?
    define ["twitter/bootstrap"], factory
).call(@, (Bootstrap) ->
  Bootstrap
)
