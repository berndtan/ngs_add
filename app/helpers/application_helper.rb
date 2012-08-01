module ApplicationHelper
	
	# Return the full title on a per-page status.
	def full_title(page_title)
		base_title = 'NGS App'
		if page_title.empty?
			base_title
		else
				"#{base_title} | #{page_title}"
		end
	end
end