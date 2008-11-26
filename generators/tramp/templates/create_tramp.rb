
class TrampMigration < ActiveRecord::Migration

  def self.up

    create_table "accounts", :force => true do |t|
      t.string   "code"
      t.string   "label"
      t.string   "orientation"
      t.boolean  "agregator"
      t.integer  "parent_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "entries", :force => true do |t|
      t.date     "date"
      t.string   "account"
      t.string   "sublabel"
      t.integer  "debit",       :default => 0
      t.integer  "credit",      :default => 0
      t.integer  "amount",      :default => 0
      t.string   "orientation"
      t.integer  "movement_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "event_types", :force => true do |t|
      t.string   "code"
      t.string   "label"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "events", :force => true do |t|
      t.string   "code"
      t.string   "label"
      t.integer  "amount"
      t.integer  "piece"
      t.date     "when_occured"
      t.date     "when_noticed"
      t.integer  "event_type_id"
      t.integer  "party_id"
      t.string   "type"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "movements", :force => true do |t|
      t.integer  "event_id"
      t.boolean  "was_posted"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "parties", :force => true do |t|
      t.string   "name"
      t.string   "account"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "parties_service_agreements", :id => false, :force => true do |t|
      t.integer "party_id"
      t.integer "service_agreement_id"
    end

    create_table "posting_rules", :force => true do |t|
      t.string   "code"
      t.string   "label"
      t.date     "date_begin"
      t.date     "date_end"
      t.string   "amount"
      t.string   "parameter"
      t.string   "entry"
      t.integer  "event_type_id"
      t.string   "type"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "service_agreements", :force => true do |t|
      t.string   "code"
      t.string   "label"
      t.float    "multiplier"
      t.integer  "fixed_fee"
      t.string   "account"
      t.date     "date_begin"
      t.date     "date_end"
      t.integer  "event_type_id"
      t.integer  "posting_rule_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  
  end
  
  def self.down
    drop_table :accounts
    drop_table :entries
    drop_table :events
    drop_table :event_types
    drop_table :movements
    drop_table :parties
    drop_table :parties_service_agreements
    drop_table :posting_rules
    drop_table :service_agreements
  end
end