class Task < ApplicationRecord
  belongs_to :project
  belongs_to :member, optional: true
end
