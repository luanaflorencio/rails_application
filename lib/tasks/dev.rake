namespace :dev do
  desc "Configuração do ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      msg_spinner("Apagando BD..") { %x(rails db:drop) }
      msg_spinner("Criando BD..") { %x(rails db:create) }
      msg_spinner("Migrando BD..") { %x(rails db:migrate) }
      msg_spinner("Populando BD..") { %x(rails db:seed) }
    else
      puts "Você não está no ambiente de desenvolvimento"
    end
  end

  def msg_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}", format: :dots)
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
