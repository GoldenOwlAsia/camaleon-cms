=begin
  Camaleon CMS is a content management system
  Copyright (C) 2015 by Owen Peredo Diaz
  Email: owenperedo@gmail.com
  This program is free software: you can redistribute it and/or modify   it under the terms of the GNU Affero General Public License as  published by the Free Software Foundation, either version 3 of the  License, or (at your option) any later version.
  This program is distributed in the hope that it will be useful,  but WITHOUT ANY WARRANTY; without even the implied warranty of  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  See the  GNU Affero General Public License (GPLv3) for more details.
=end
class CamaleonCms::Apps::ThemesFrontController < CamaleonCms::FrontendController
  before_action :init_theme

  private

  def init_theme
    theme_name = params[:controller].split("/")[1]
    @theme = current_theme
    return render_error(404) unless current_theme.slug == theme_name
    lookup_context.prefixes = []
    lookup_context.prefixes.prepend(params[:controller].sub("themes/#{theme_name}", "themes/#{theme_name}/views"))  unless current_theme.settings["gem_mode"]
    lookup_context.prefixes.append("themes/#{current_theme.slug}") if current_theme.settings["gem_mode"]
    lookup_context.prefixes.append("themes/#{current_theme.slug}/views") unless current_theme.settings["gem_mode"]
  end
end
