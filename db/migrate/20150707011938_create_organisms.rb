class CreateOrganisms < ActiveRecord::Migration
  def change
    create_table :organisms do |t|
      t.string :content_type
      t.binary :data, limit: 5.megabytes                            # 画像データ
      t.string :content_type                                        # MINEタイプ
      t.text :description
      t.integer :micromotion_degree, null: false, default: 90
      t.integer :step_length, null: false, default: 50              # 単位はpx
      t.integer :multiplication_speed, null: false, default: 5      #　増殖速度単位は秒 (s)

      t.timestamps null: false
    end
  end
end
