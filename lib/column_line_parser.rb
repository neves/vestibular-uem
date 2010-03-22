class ColumnLineParser
  def initialize(mask, names)
    @names = names
    @unpack = self.class.mask2unpack(mask)
  end

  # converte uma mascara " -  --+ " em um string de unpack "x1A1x2A2A1x1"
  def self.mask2unpack(mask)
    last = nil
    count = 0
    m = nil
    unpack = ""
    mask.chars.each do |c|
      if c != last
        unpack << m << count.to_s if last != nil
        last = c
        count = 0
        m = c == " " ? "x" : "A"
      end
      count += 1
    end
    unpack << m << count.to_s if last != nil
    unpack
  end

  # mapeia os dados extraidos da linha para um Hash com as chaves informadas
  def parse(line)
    dados = line.unpack(@unpack).map &:strip
    Hash[*@names.zip(dados).flatten]
  end
end