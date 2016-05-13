require 'rails_helper'

RSpec.describe ShopHelper, type: :helper do 

  describe '#set_gender' do 
    it "subs out Male and returns Men's" do
      @item = FactoryGirl.create(:item, gender: FactoryGirl.create(:gender))

      expect(set_gender).to eq("Men's")
    end
  
    it "set's gender if nil and returns Men's" do 
      @item = FactoryGirl.create(:item, gender: FactoryGirl.create(:gender, name: nil))

      expect(set_gender).to eq("Men's")
    end

    it "set's gender if blank and returns Men's" do 
      @item = FactoryGirl.create(:item, gender: FactoryGirl.create(:gender, name: ""))
    
      expect(set_gender).to eq("Men's")
    end
  end

  describe '#set_pattern' do 
    it "displays item pattern if it is set" do
      @item = FactoryGirl.create(:item, :with_pattern_family)
      
      expect(set_pattern).to eq("MyString")
    end
  
    it "does nothing if the pattern is nil and returns nil" do
      @item = FactoryGirl.create(:item)
      
      expect(set_pattern).to eq("")
    end
  
    it "does nothing if pattern is an empty and returns an empty string" do 
      @item = FactoryGirl.create(:item, :without_pattern_family)

      expect(set_pattern).to eq("")
    end
  end

  describe '#set_display_name' do 
    it "displays item display name if it is set" do 
      @item = FactoryGirl.create(:item, brand: FactoryGirl.create(:brand))

      expect(set_display_name).to eq("Awesome Brand")
    end

    it "does nothing if display name is nil" do 
      @item = FactoryGirl.create(:item, brand: FactoryGirl.create(:brand, display_name: nil))

      expect(set_display_name).to eq("")
    end

    it "does nothing if display name is empty" do 
      @item = FactoryGirl.create(:item, brand: FactoryGirl.create(:brand, display_name: ""))
      
      expect(set_display_name).to eq("")
    end
  end

  describe '#set_item_name' do
    it 'displays item_name if it set' do
      @item = FactoryGirl.create(:item)
    
      expect(set_item_name).to eq("MyString")
    end

    it 'does nothing if item_name is nil and returns nl' do
      @item = FactoryGirl.create(:item, item_name: nil)

      expect(set_item_name).to eq("")
    end

    it 'does nothing if item_name is empty and returns an empty string' do
      @item = FactoryGirl.create(:item, item_name: "")

      expect(set_item_name).to eq("")
    end
  end

  describe '#set_color' do 
    it 'displays the item color if it set' do
      @item = FactoryGirl.create(:item)

      expect(set_color).to eq("MyString")
    end

    it 'does nothing if item color is nil and returns nil' do
      @item = FactoryGirl.create(:item, color: nil)

      expect(set_color).to eq("")
    end

    it 'does nothing if item color is empty or nil and returns an  empty string' do
      @item = FactoryGirl.create(:item, color: "")

      expect(set_color).to eq("")
    end
  end

  describe '#description_item_string' do
    it 'displays the description item string correctly if' do 
      @item = FactoryGirl.create(:item, :with_pattern_family, gender: FactoryGirl.create(:gender), brand: FactoryGirl.create(:brand), )

      expect(description_item_string).to eq("Men's Awesome Brand MyString in MyString MyString")
    end
  end

  describe '#brand_selected' do
    it 'checks if filters hash is an empty array for brands and returns empty string' do 
      @filters = {brands: [], colors: [], patterns: []}

      expect(brand_selected).to eq("")
    end

    it 'checks if filters hash does have a brand selected and returns the brand name' do 
      @filters = {brands: [[337, "Express"]], colors: [], patterns: []}

      expect(brand_selected).to eq("Express")
    end

    it 'checks the filters hash for more than one brand selected' do 
      @filters = {brands: [[337, "Express"], [100, "Twillory"]], colors: [], patterns: []}

      expect(brand_selected).to eq("")
    end
  end

  describe '#color_selected' do
    it 'checks if filters hash is an empty array for colors and returns empty string' do 
      @filters = {brands: [], colors: [], patterns: []}

      expect(color_selected).to eq("")
    end

    it 'checks if filters hash does have a color selected and returns the color name' do 
      @filters = {brands: [], colors: [[1, :Blue]], patterns: []}

      expect(color_selected).to eq("Blue")
    end

    it 'checks the filters hash for more than one color selected' do 
      @filters = {brands: [], colors: [[1, "Blue"], [2, "Black"]], patterns: []}

      expect(color_selected).to eq("")
    end
  end

  describe '#patern_selected' do
    it 'checks if filters hash is an empty array for patterns and returns empty string' do 
      @filters = {brands: [], colors: [], patterns: []}

      expect(pattern_selected).to eq("")
    end

    it 'checks if filters hash does have a pattern selected and returns the pattern name' do 
      @filters = {brands: [], colors: [], patterns: [[1, "Plaid"]]}

      expect(pattern_selected).to eq("Plaid")
    end

    it 'checks the filters hash for more than one pattern selected and returns empty string' do 
      @filters = {brands: [], colors: [], patterns: [[1, "Plaid"], [2, "Gingham"]]}

      expect(pattern_selected).to eq("")
    end
  end