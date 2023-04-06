namespace :dev do
  desc "Configuração do ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      msg_spinner("Apagando BD..") { %x(rails db:drop) }
      msg_spinner("Criando BD..") { %x(rails db:create) }
      msg_spinner("Migrando BD..") { %x(rails db:migrate) }
      %x(rails dev:add_mining_type)
      %x(rails dev:add_coins)
    else
      puts "Você não está no ambiente de desenvolvimento"
    end
  end

  desc "Cadastra moedas para popular BD"
  task add_coins: :environment do
    msg_spinner("Cadastrando moedas...")do
      coins = [
                  {
                      description: "Bitcoin",
                      acronym: "BTC",
                      url_image: "https://w7.pngwing.com/pngs/450/133/png-transparent-bitcoin-cryptocurrency-virtual-currency-decal-blockchain-info-bitcoin-text-trademark-logo.png",
                      mining_type: MiningType.find_by(acronym: "PoW")
                  },

                  {
                      description: "Dash",
                      acronym: "DASH",
                      url_image: "https://seeklogo.com/images/D/dash-logo-4A14989CF5-seeklogo.com.png",
                      mining_type: MiningType.all.sample
                  },

                  {
                      description: "Ethereum",
                      acronym: "ETH",
                      url_image: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Ethereum_logo_2014.svg/1257px-Ethereum_logo_2014.svg.png",
                      mining_type: MiningType.all.sample
                  }
              ]

      coins.each do |coin|
          Coin.find_or_create_by!(coin)
      end
    end
end

desc "Cadastrando tipos demineração"
task add_mining_type: :environment do
  msg_spinner ("Cadastrando Tipos de Mineação") do
  mining_types = [
    { description: "Proof of Work", acronym: "PoW"  },
    { description: "Proof of Sate", acronym: "PoS" },
    { description: "Proof of Capacity", acronym:"PoC" }
  ]

  mining_types.each do |mining_type|
    MiningType.find_or_create_by!(mining_type)
  end
end
end


  def msg_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}", format: :dots)
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
