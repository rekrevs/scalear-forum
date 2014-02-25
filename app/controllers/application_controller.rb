class ApplicationController < ActionController::Base
    #protect_from_forgery
    #don't need this since api
    before_filter :set_locale
    
    def set_locale
        I18n.locale = params[:locale] || I18n.default_locale
    end
    
    def self.default_url_options
        { locale: I18n.locale }
    end

end
