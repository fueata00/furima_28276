class SearchPrice < ActiveHash::Base
  self.data = [
    { id: 1, name: '選択する' },
    { id: 2, name: '300 ~ 1,000' },
    { id: 3, name: '1,000 ~ 5,000' },
    { id: 4, name: '5,000 ~ 10,000' },
    { id: 5, name: '10,000 ~ 30,000' },
    { id: 6, name: '30,000 ~ 50,000' },
    { id: 7, name: '50,000 ~' }
  ]
end
