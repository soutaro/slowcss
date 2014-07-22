SlowCSS = {}

durationPattern = /\b\d+(.\d*)?(m?s)\b/g

scale = (rule, property, factor) ->
  text = rule.style[property]
  return unless text

  console.log property, text

  result = text.replace durationPattern, (string, x, unit) ->
    time = parseFloat(string, 10)
    "#{time*factor}#{unit}"

  rule.style[property] = result

SlowCSS.scale = (factor) ->
  for styleSheet in document.styleSheets
    if styleSheet.cssRules?
      for rule in styleSheet.cssRules
        if rule.cssText.match(durationPattern)
          scale(rule, "transition", factor)
          scale(rule, "-webkit-animation", factor)
          scale(rule, "-moz-animation", factor)
    else
      console.warn "Empty cssRule (maybe loaded from different origin)", "href=#{styleSheet.href}"

window.SlowCSS = SlowCSS
