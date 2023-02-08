module ApplicationHelper
    def date_br(date_us)
        date_us.strftime("%d/%m/%Y")
    end

    def environment_rails
        if Rails.env.production?
            "Produção"
        elsif Rails.env.development?
            "Desenvolvimento"
        else
            "Teste"
        end 
    end
end
