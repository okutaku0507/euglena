class CreateOrganisms < ActiveRecord::Migration
  def change
    create_table :organisms do |t|
      t.string :content_type
      t.binary :data, limit: 5.megabytes                            # 画像データ
      t.string :content_type                                        # MINEタイプ
      t.text :description
      t.integer :micromotion_degree, null: false, default: 10
      t.integer :step_length, null: false, default: 10              # 単位はpx

      t.timestamps null: false
    end
  end
end
