# frozen_string_literal: true

class TitleBracketsValidator < ActiveModel::Validator
  def validate(movie)
    @title = movie.title
    @opening_brackets = ["(", "{", "["]
    @closing_brackets = [")", "}", "]"]
    @movie = movie
    @chars = @title.split("")

    return movie.errors.add(:title, "All brackets have to be closed") unless proper_number_of_brackets?
    @chars.each_with_index do |char, index|
      if @opening_brackets.include?(char)
        check_presence_of_closing_brackets(char, index)
        check_if_brackets_have_content(index, @closing_bracket_index)
      end
    end
  end

  private

  def proper_number_of_brackets?
    counted_opening_brackets = @opening_brackets.map { |bracket| @title.count(bracket) }
    counted_closing_brackets = @closing_brackets.map { |bracket| @title.count(bracket) }
    counted_opening_brackets == counted_closing_brackets
  end

  def check_presence_of_closing_brackets(char, index)
    closing_bracket_type = @closing_brackets[@opening_brackets.index(char)]
    missing_bracket = @chars[index + 1..-1].find_index(closing_bracket_type)
    if missing_bracket.present?
      @closing_bracket_index = missing_bracket + index + 1
    else
      return @movie.errors.add(:title, "Title must have #{char} bracket closed")
    end
  end

  def check_if_brackets_have_content(opening_bracket, closing_bracket)
    if @chars[opening_bracket + 1...closing_bracket].join.blank?
      @movie.errors.add(:title, "brackets musn't be empty")
    end
  end
end
