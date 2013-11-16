class Version < ActiveRecord::Base
  attr_accessible :keywords, :mediators, :outcomes, :determinants, :inclusions, :foundations
end