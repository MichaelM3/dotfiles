; extends
  (
    (comment) @_sql_comment
    .
    (template_string) @injection.content
    (#lua-match? @_sql_comment "/%*%s*sql%s*%*/")
    (#offset! @injection.content 0 1 0 -1)
    (#set! injection.include-children)
    (#set! injection.language "sql")
  )
