namespace :levels do
  desc "Migrate all levels"
  task add_data: :environment do
    %w(chien_con1 chien_con2 chien_con3 au_nhi1 au_nhi2 au_nhi3 thieu_nhi1 thieu_nhi2 thieu_nhi3 nghia_si1 nghia_si2 nghia_si3 nghia_si4 du_truong huynh_truong1 huynh_truong2 huynh_truong3 tro_uy tro_ta hlv1 hlv2 hlv3 tuyen_uy).each do |name|
      Level.create!(name: name)
    end
    du_truong = Level.find_by(name: 'du_truong')
    huynh_truong = Level.find_by(name: 'huynh_truong1')
    Person.joins(:level).where(levels: { name: 'senior' }).update_all(level_id: huynh_truong.id)
    Person.joins(:level).where(levels: { name: 'junior' }).update_all(level_id: du_truong.id)
  end
end
