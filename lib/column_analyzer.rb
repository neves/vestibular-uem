class ColumnAnalyzer
  # retorna todos os indices dos espacos na linha
	def self.accept
		/ |\t/
	end

  def self.spaces(line)
    line.chars.each_with_index.select {|char, i| char =~ self.accept}.map{|char_index| char_index.last}
  end

  def self.not_spaces(line)
    line.chars.each_with_index.select {|char, i| ! (char =~ self.accept)}.map{|char_index| char_index.last}
  end

  def self.analyze_lines(lines)
    first = true
    indexes = []
    lines.each do |line|
      if first
        first = false
        indexes = self.spaces(line)
        next
      end
      indexes.reject!{|i| ! (line[i..i] =~ self.accept) }
    end
    indexes
  end

  def self.line_mask(spaces, length = 0, char = "-")
    length = [length, spaces.max + 1].max
    a = char * length
    spaces.each {|i| a[i] = " "}
    a
  end
end
=begin
  # mapeia os dados extraidos da linha para um Hash com as chaves informadas
  def self.map(mask, line, names)
    unpack = self.mask2unpack(mask)
    dados = line.unpack(unpack).map &:strip
    Hash[*names.zip(dados).flatten]
  end
end

  def self.analyze_lines2(lines)
    not_spaces = []
    lines.each do |line|
      not_spaces |= self.not_spaces(line)
    end
    tudo = (not_spaces.min..not_spaces.max).to_a
    (tudo - not_spaces).sort
  end

  def count2percent
    max = @count.max
    min = @count.min
    diff = (max - min).to_f
    @count.map {|i| ((i-min)/diff*100).to_i }
  end

  def filter(p = 95)
    maiores = []
    count2percent.each_with_index do |v, i|
      maiores << i if v >= p
    end
    return maiores
  end

  def filter_max
    maiores = []
    max = @count.max
    @count.each_with_index do |v, i|
      maiores << i if v == max
    end
    return maiores
  end

  def mask
    m = ""
    max = @count.max
    @count.each do |v|
      m << (v == max ? " " : "-")
    end
    m
  end
=end