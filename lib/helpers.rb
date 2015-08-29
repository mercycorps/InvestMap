module MC
  def markdown(text)
    text
  end

  def tour
    sitemap.find_resource_by_path('/tour/index.html')
  end

  def get_page(slug = false)
    if slug
      # Find the page in our pages folder
      sitemap.find_resource_by_path "/pages/#{slug}/index.html"
    else
      # Return pages root
      sitemap.find_resource_by_path "/pages/index.html"
    end
  end
end
