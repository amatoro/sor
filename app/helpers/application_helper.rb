module ApplicationHelper
  def markdown(text)
    options = {
      filter_html: true,
      hard_wrap: true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      no_intra_emphasis: true
    }

    extensions = {
      autolink: true,
      disable_indented_code_blocks: false,
      strikethrough: true,
      underline: true,
      highlight: true,
      quote: true,
      superscript: true,
      fenced_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end
end
