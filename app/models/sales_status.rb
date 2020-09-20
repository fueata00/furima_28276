class SalesStatus < ActiveHash::Base
  self.data = [
    { id: 1, name: 'すべて' },
    { id: 2, name: '販売中' },
    { id: 3, name: '売り切れ' }
  ]
end
