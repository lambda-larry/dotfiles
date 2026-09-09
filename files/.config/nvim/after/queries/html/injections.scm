;; extends
;; inherits: html_tags

; <script type="x-shader/x-vertex">
; <script type="x-shader/x-fragment">
(script_element
  (start_tag
    (attribute
      (attribute_name) @_attr
      (#eq? @_attr "type")
      (quoted_attribute_value
        (attribute_value) @_type)))
  (#any-of? @_type "x-shader/x-vertex" "x-shader/x-fragment")
  (raw_text) @injection.content
  (#set! injection.language "glsl"))
