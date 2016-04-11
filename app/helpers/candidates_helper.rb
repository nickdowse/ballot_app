module CandidatesHelper
  def options_for_multiple_select(titles, ids)
    results = []
    titles.each_with_index do |title, index|
      results << [title, ids[index]]
    end
    return results
  end
end
