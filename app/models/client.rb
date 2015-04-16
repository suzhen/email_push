class Client < Base

  validates :name, presence: true

  # validates :email, presence: true

  has_and_belongs_to_many :groups, join_table: :client_groups

  default_scope { order("updated_at DESC") }

  def group_names
    self.groups.map(&:name).join(",")
  end

  def self.add_search_scope(name, &block)
      self.singleton_class.send(:define_method, name.to_sym, &block)
  end

  add_search_scope :in_name_or_email_or_company_or_mobile do |words|
    like_any([:name, :email, :company, :mobile], prepare_words(words))
  end

  def self.like_any(fields, values)
      where fields.map { |field|
        values.map { |value|
          arel_table[field].matches("%#{value}%")
        }.inject(:or)
      }.inject(:or)
  end

  private

    def self.prepare_words(words)
        return [''] if words.blank?
        a = words.split(/[,\s]/).map(&:strip)
        a.any? ? a : ['']
    end


end
