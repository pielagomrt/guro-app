# require 'rails_helper'

# RSpec.describe Teacher, type: :model do
#     let(:teacher) { Teacher.new }
#     it "1. should not save without firstname" do 
         
        
#         teacher.firstname = nil
#         teacher.lastname = "Pielago" 
#         teacher.email = "pielago@gmail.com"
#         teacher.password = "12345"
#         teacher.sections = 4
#         teacher.grading_system = 90 

#         expect(teacher).to_not be_valid
#         expect(teacher.errors).to be_present
#         expect(teacher.errors.to_hash.keys).to include(:firstname)
#     end 
# end

require 'rails_helper'

RSpec.describe Teacher, type: :model do
  let(:teacher) { Teacher.new }

  context 'Validations' do
    it '1. should not save without firstname' do
      teacher.firstname = nil
      teacher.lastname = 'Doe'
      teacher.email = 'doe@example.com'
      teacher.password = '12345'

      expect(teacher).to_not be_valid
      expect(teacher.errors).to be_present
      expect(teacher.errors.to_h.keys).to include(:firstname)
    end

    it '2. should not save without lastname' do
        teacher.firstname = "Jane"
        teacher.lastname = nil
        teacher.email = 'doe@example.com'
        teacher.password = '12345'
  
        expect(teacher).to_not be_valid
        expect(teacher.errors).to be_present
        expect(teacher.errors.to_h.keys).to include(:lastname)
      end

     it '3. should not save without email' do
        teacher.firstname = "Jane"
        teacher.lastname = "Doe"
        teacher.email = nil
        teacher.password = '12345'
  
        expect(teacher).to_not be_valid
        expect(teacher.errors).to be_present
        expect(teacher.errors.to_h.keys).to include(:email)
      end
     
    it '4. should not save without password' do
        teacher.firstname = "Jane"
        teacher.lastname = "Doe"
        teacher.email = 'doe@example.com'
        teacher.password = nil
  
        expect(teacher).to_not be_valid
        expect(teacher.errors).to be_present
        expect(teacher.errors.to_h.keys).to include(:password)
    end  
      
  end
end

