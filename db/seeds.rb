# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

spinner = TTY::Spinner.new("[:spinner] Cadastrando Moedas...")
spinner.auto_spin

coins = [
            {
                description: "Dash",
                acronym: "DASH",
                url_image: "https://seeklogo.com/images/D/dash-logo-4A14989CF5-seeklogo.com.png"
            },

            {
                description: "Ethereum",
                acronym: "ETH",
                url_image: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Ethereum_logo_2014.svg/1257px-Ethereum_logo_2014.svg.png"
            }
        ]

coins.each do |coin|
    Coin.find_or_create_by!(coin)
end

spinner.succes("(Concluído)")