defmodule HelloWeb.HelloHTML do
  # HelloWeb.html
  use HelloWeb, :html

  # grab, match, and embed templates in hello_html/
  embed_templates "hello_html/*"
end
