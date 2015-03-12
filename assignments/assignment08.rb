# ========================================================================================
# Assignment 8
# ========================================================================================

# ========================================================================================
#  Problem 1 - Roman Numerals

# implement conversion between integers and roman numerals
# validate using MiniTest unit tests

module Assignment08
  class RomanNumeral
    def initialize(number)
      @numeral = number
      @rn = ""
    end

    def to_s
      if @numeral > 3999
        return "Number is too large to convert!"
      elsif @numeral < 1
        return "Number cannot be converted!"
      else while @numeral > 999
         @numeral = @numeral - 1000
         @rn << "M"
        end
        while @numeral > 899
          @numeral = @numeral - 900
          @rn << "CM"
        end
        while @numeral > 499
          @numeral = @numeral - 500
          @rn << "D"
        end
        while @numeral > 399
          @numeral = @numeral - 400
          @rn << "CD"
        end
        while @numeral > 99
          @numeral = @numeral - 100
          @rn << "C"
        end
        while @numeral > 89
          @numeral = @numeral - 90
          @rn << "XC"
        end
        while @numeral > 49
          @numeral = @numeral - 50
          @rn << "L"
        end
        while @numeral > 39
          @numeral = @numeral - 40
          @rn << "XL"
        end
        while @numeral > 9
          @numeral = @numeral - 10
          @rn << "X"
        end
        while @numeral > 8
          @numeral = @numeral - 9
          @rn << "IX"
        end
        while @numeral > 4
          @numeral = @numeral - 5
          @rn << "V"
        end
        while @numeral > 3
          @numeral = @numeral - 4
          @rn << "IV"
        end
        while @numeral > 0
          @numeral = @numeral - 1
          @rn << "I"
        end
      end
      @rn
    end
 
    def to_i
      @rn = @numeral
      if @rn == ""
        return "No conversion is possible!"
      elsif (@rn.delete "CDILMVX") != ""
        return "That is not a valid roman numeral!"
      else
        rn = @rn.reverse
        @numeral = 0
        return "That is not a valid roman numeral!" if rn.end_with?("MMMM")
        while rn.end_with?("M")
          @numeral += 1000
          rn.chop!
          return @numeral if rn.empty?
        end
        if rn.end_with?("MC")
          @numeral += 900
          rn.chop!.chop!
          return "That is not a valid roman numeral!" if rn.end_with?("M")
          return "That is not a valid roman numeral!" if rn.end_with?("D")
          return "That is not a valid roman numeral!" if rn.end_with?("C")
          return @numeral if rn.empty?
        end
        if rn.end_with?("D")
          @numeral += 500
          rn.chop!
          return "That is not a valid roman numeral!" if rn.end_with?("M")
          return "That is not a valid roman numeral!" if rn.end_with?("D")
          return @numeral if rn.empty?
        end
        if rn.end_with?("DC")
          @numeral += 400
          rn.chop!.chop!
          return "That is not a valid roman numeral!" if rn.end_with?("M")
          return "That is not a valid roman numeral!" if rn.end_with?("D")
          return "That is not a valid roman numeral!" if rn.end_with?("C")
          return @numeral if rn.empty?
        end
        return "That is not a valid roman numeral!" if rn.end_with?("CCCC")
        while rn.end_with?("C")
          @numeral += 100
          rn.chop!
          return "That is not a valid roman numeral!" if rn.end_with?("M")
          return "That is not a valid roman numeral!" if rn.end_with?("D")
          return @numeral if rn.empty?
        end
        if rn.end_with?("CX")
          @numeral += 90
          rn.chop!.chop!
          return "That is not a valid roman numeral!" if rn.end_with?("M")
          return "That is not a valid roman numeral!" if rn.end_with?("D")
          return "That is not a valid roman numeral!" if rn.end_with?("C")
          return "That is not a valid roman numeral!" if rn.end_with?("L")
          return "That is not a valid roman numeral!" if rn.end_with?("X")
          return @numeral if rn.empty?
        end
        if rn.end_with?("L")
          @numeral += 50
          rn.chop!
          return "That is not a valid roman numeral!" if rn.end_with?("M")
          return "That is not a valid roman numeral!" if rn.end_with?("D")
          return "That is not a valid roman numeral!" if rn.end_with?("C")
          return "That is not a valid roman numeral!" if rn.end_with?("L")
          return @numeral if rn.empty?
        end
        if rn.end_with?("LX")
          @numeral += 40
          rn.chop!.chop!
          return "That is not a valid roman numeral!" if rn.end_with?("M")
          return "That is not a valid roman numeral!" if rn.end_with?("D")
          return "That is not a valid roman numeral!" if rn.end_with?("C")
          return "That is not a valid roman numeral!" if rn.end_with?("L")
          return "That is not a valid roman numeral!" if rn.end_with?("X")
          return @numeral if rn.empty?
        end
        return "That is not a valid roman numeral!" if rn.end_with?("XXXX")
        while rn.end_with?("X")
          @numeral += 10
          rn.chop!
          return "That is not a valid roman numeral!" if rn.end_with?("M")
          return "That is not a valid roman numeral!" if rn.end_with?("D")
          return "That is not a valid roman numeral!" if rn.end_with?("C")
          return "That is not a valid roman numeral!" if rn.end_with?("L")
          return @numeral if rn.empty?
        end
        if rn.end_with?("XI")
          @numeral += 9
          rn.chop!.chop!
          return @numeral if rn.empty?
          return "That is not a valid roman numeral!"
        end
        if rn.end_with?("V")
          @numeral += 5
          rn.chop!
          return "That is not a valid roman numeral!" if rn.end_with?("M")
          return "That is not a valid roman numeral!" if rn.end_with?("D")
          return "That is not a valid roman numeral!" if rn.end_with?("C")
          return "That is not a valid roman numeral!" if rn.end_with?("L")
          return "That is not a valid roman numeral!" if rn.end_with?("X")
          return "That is not a valid roman numeral!" if rn.end_with?("V")
          return @numeral if rn.empty?
        end
        if rn.end_with?("VI")
          @numeral += 4
          rn.chop!.chop!
          return @numeral if rn.empty?
          return "That is not a valid roman numeral!"
        end
        return "That is not a valid roman numeral!" if rn.end_with?("IIII")
        while rn.end_with?("I")
          @numeral += 1
          rn.chop!
          return "That is not a valid roman numeral!" if rn.end_with?("M")
          return "That is not a valid roman numeral!" if rn.end_with?("D")
          return "That is not a valid roman numeral!" if rn.end_with?("C")
          return "That is not a valid roman numeral!" if rn.end_with?("L")
          return "That is not a valid roman numeral!" if rn.end_with?("X")
          return "That is not a valid roman numeral!" if rn.end_with?("V")
          return @numeral if rn.empty?
        end
        @numeral
      end
    end
    
    # bonus: create from Roman Numeral
    def self.from_string(roman_numeral)
      RomanNumeral.new(roman_numeral)
    end
  end


require 'minitest/autorun'

  class TestRomanNumeral < MiniTest::Test
    def test_romannumeraltostring
      a = RomanNumeral.new(1).to_s
      assert_equal a, "I"
      b = RomanNumeral.new(2).to_s
      assert_equal b, "II"
      c = RomanNumeral.new(3).to_s
      assert_equal c, "III"
      d = RomanNumeral.new(4).to_s
      assert_equal d, "IV"
      e = RomanNumeral.new(5).to_s
      assert_equal e, "V"
      f = RomanNumeral.new(6).to_s
      assert_equal f, "VI"
      g = RomanNumeral.new(9).to_s
      assert_equal g, "IX"
      h = RomanNumeral.new(10).to_s
      assert_equal h, "X"
      i = RomanNumeral.new(19).to_s
      assert_equal i, "XIX"
      j = RomanNumeral.new(32).to_s
      assert_equal j, "XXXII"
      k = RomanNumeral.new(40).to_s
      assert_equal k, "XL"
      l = RomanNumeral.new(49).to_s
      assert_equal l, "XLIX"
      m = RomanNumeral.new(50).to_s
      assert_equal m, "L"
      n = RomanNumeral.new(89).to_s
      assert_equal n, "LXXXIX"
      o = RomanNumeral.new(90).to_s
      assert_equal o, "XC"
      p = RomanNumeral.new(100).to_s
      assert_equal p, "C"
      q = RomanNumeral.new(399).to_s
      assert_equal q, "CCCXCIX"
      r = RomanNumeral.new(400).to_s
      assert_equal r, "CD"
      s = RomanNumeral.new(499).to_s
      assert_equal s, "CDXCIX"
      t = RomanNumeral.new(500).to_s
      assert_equal t, "D"
      u = RomanNumeral.new(899).to_s
      assert_equal u, "DCCCXCIX"
      v = RomanNumeral.new(900).to_s
      assert_equal v, "CM"
      w = RomanNumeral.new(999).to_s
      assert_equal w, "CMXCIX"
      x = RomanNumeral.new(1000).to_s
      assert_equal x, "M"
      y = RomanNumeral.new(1399).to_s
      assert_equal y, "MCCCXCIX"
      z = RomanNumeral.new(1400).to_s
      assert_equal z, "MCD"
      aa = RomanNumeral.new(1899).to_s
      assert_equal aa, "MDCCCXCIX"
      ab = RomanNumeral.new(1900).to_s
      assert_equal ab, "MCM"
      ac = RomanNumeral.new(1999).to_s
      assert_equal ac, "MCMXCIX"
      ad = RomanNumeral.new(2000).to_s
      assert_equal ad, "MM"
      ae = RomanNumeral.new(2999).to_s
      assert_equal ae, "MMCMXCIX"
      af = RomanNumeral.new(3999).to_s
      assert_equal af, "MMMCMXCIX"
      ag = RomanNumeral.new(4000).to_s
      assert_equal ag, "Number is too large to convert!"
      bo = RomanNumeral.new(0).to_s
      assert_equal bo, "Number cannot be converted!"
    end

    def test_romannumeraltointeger
      ah = RomanNumeral.from_string("I").to_i
      assert_equal ah, 1
      ai = RomanNumeral.from_string("II").to_i
      assert_equal ai, 2
      aj = RomanNumeral.from_string("III").to_i
      assert_equal aj, 3
      ak = RomanNumeral.from_string("IV").to_i
      assert_equal ak, 4
      al = RomanNumeral.from_string("V").to_i
      assert_equal al, 5
      am = RomanNumeral.from_string("VI").to_i
      assert_equal am, 6
      an = RomanNumeral.from_string("IX").to_i
      assert_equal an, 9
      ao = RomanNumeral.from_string("X").to_i
      assert_equal ao, 10
      ap = RomanNumeral.from_string("XIX").to_i
      assert_equal ap, 19
      aq = RomanNumeral.from_string("XXXII").to_i
      assert_equal aq, 32
      ar = RomanNumeral.from_string("XL").to_i
      assert_equal ar, 40
      as = RomanNumeral.from_string("XLIX").to_i
      assert_equal as, 49
      at = RomanNumeral.from_string("L").to_i
      assert_equal at, 50
      au = RomanNumeral.from_string("LXXXIX").to_i
      assert_equal au, 89
      av = RomanNumeral.from_string("XC").to_i
      assert_equal av, 90
      aw = RomanNumeral.from_string("C").to_i
      assert_equal aw, 100
      ax = RomanNumeral.from_string("CCCXCIX").to_i
      assert_equal ax, 399
      ay = RomanNumeral.from_string("CD").to_i
      assert_equal ay, 400
      az = RomanNumeral.from_string("CDXCIX").to_i
      assert_equal az, 499
      ba = RomanNumeral.from_string("D").to_i
      assert_equal ba, 500
      bb = RomanNumeral.from_string("DCCCXCIX").to_i
      assert_equal bb, 899
      bc = RomanNumeral.from_string("CM").to_i
      assert_equal bc, 900
      bd = RomanNumeral.from_string("CMXCIX").to_i
      assert_equal bd, 999
      be = RomanNumeral.from_string("M").to_i
      assert_equal be, 1000
      bf = RomanNumeral.from_string("MCCCXCIX").to_i
      assert_equal bf, 1399
      bg = RomanNumeral.from_string("MCD").to_i
      assert_equal bg, 1400
      bh = RomanNumeral.from_string("MDCCCXCIX").to_i
      assert_equal bh, 1899
      bi = RomanNumeral.from_string("MCM").to_i
      assert_equal bi, 1900
      bj = RomanNumeral.from_string("MCMXCIX").to_i
      assert_equal bj, 1999
      bk = RomanNumeral.from_string("MM").to_i
      assert_equal bk, 2000
      bl = RomanNumeral.from_string("MMCMXCIX").to_i
      assert_equal bl, 2999
      bm = RomanNumeral.from_string("MMMCMXCIX").to_i
      assert_equal bm, 3999
      bn = RomanNumeral.from_string("MMMM").to_i
      assert_equal bn, "That is not a valid roman numeral!"
      bq = RomanNumeral.from_string("MCMM").to_i
      assert_equal bq, "That is not a valid roman numeral!"
      br = RomanNumeral.from_string("MCMD").to_i
      assert_equal br, "That is not a valid roman numeral!"
      bs = RomanNumeral.from_string("MCMC").to_i
      assert_equal bs, "That is not a valid roman numeral!"
      bt = RomanNumeral.from_string("DM").to_i
      assert_equal bt, "That is not a valid roman numeral!"
      bu = RomanNumeral.from_string("DD").to_i
      assert_equal bu, "That is not a valid roman numeral!"
      bv = RomanNumeral.from_string("CDM").to_i
      assert_equal bv, "That is not a valid roman numeral!"
      bw = RomanNumeral.from_string("CDD").to_i
      assert_equal bw, "That is not a valid roman numeral!"
      bx = RomanNumeral.from_string("CDC").to_i
      assert_equal bx, "That is not a valid roman numeral!"
      by = RomanNumeral.from_string("CCCC").to_i
      assert_equal by, "That is not a valid roman numeral!"
      bz = RomanNumeral.from_string("CMCM").to_i
      assert_equal bz, "That is not a valid roman numeral!"
      ca = RomanNumeral.from_string("CMCD").to_i
      assert_equal ca, "That is not a valid roman numeral!"
      cb = RomanNumeral.from_string("XCM").to_i
      assert_equal cb, "That is not a valid roman numeral!"
      cc = RomanNumeral.from_string("XCD").to_i
      assert_equal cc, "That is not a valid roman numeral!"
      cd = RomanNumeral.from_string("XCC").to_i
      assert_equal cd, "That is not a valid roman numeral!"
      ce = RomanNumeral.from_string("XCL").to_i
      assert_equal ce, "That is not a valid roman numeral!"
      cf = RomanNumeral.from_string("XCX").to_i
      assert_equal cf, "That is not a valid roman numeral!"
      cg = RomanNumeral.from_string("LM").to_i
      assert_equal cg, "That is not a valid roman numeral!"
      ch = RomanNumeral.from_string("LD").to_i
      assert_equal ch, "That is not a valid roman numeral!"
      ci = RomanNumeral.from_string("LC").to_i
      assert_equal ci, "That is not a valid roman numeral!"
      cj = RomanNumeral.from_string("LL").to_i
      assert_equal cj, "That is not a valid roman numeral!"
      ck = RomanNumeral.from_string("XLM").to_i
      assert_equal ck, "That is not a valid roman numeral!"
      cl = RomanNumeral.from_string("XLD").to_i
      assert_equal cl, "That is not a valid roman numeral!"
      cm = RomanNumeral.from_string("XLC").to_i
      assert_equal cm, "That is not a valid roman numeral!"
      cn = RomanNumeral.from_string("XLL").to_i
      assert_equal cn, "That is not a valid roman numeral!"
      co = RomanNumeral.from_string("XLX").to_i
      assert_equal co, "That is not a valid roman numeral!"
      cp = RomanNumeral.from_string("XXXX").to_i
      assert_equal cp, "That is not a valid roman numeral!"
      cq = RomanNumeral.from_string("XM").to_i
      assert_equal cq, "That is not a valid roman numeral!"
      cr = RomanNumeral.from_string("XD").to_i
      assert_equal cr, "That is not a valid roman numeral!"
      cs = RomanNumeral.from_string("XLXC").to_i
      assert_equal cs, "That is not a valid roman numeral!"
      ct = RomanNumeral.from_string("XLXL").to_i
      assert_equal ct, "That is not a valid roman numeral!"
      cu = RomanNumeral.from_string("IXM").to_i
      assert_equal cu, "That is not a valid roman numeral!"
      cv = RomanNumeral.from_string("IXD").to_i
      assert_equal cv, "That is not a valid roman numeral!"
      cw = RomanNumeral.from_string("IXC").to_i
      assert_equal cw, "That is not a valid roman numeral!"
      cx = RomanNumeral.from_string("IXL").to_i
      assert_equal cx, "That is not a valid roman numeral!"
      cy = RomanNumeral.from_string("IXX").to_i
      assert_equal cy, "That is not a valid roman numeral!"
      cz = RomanNumeral.from_string("IXV").to_i
      assert_equal cz, "That is not a valid roman numeral!"
      da = RomanNumeral.from_string("IVI").to_i
      assert_equal da, "That is not a valid roman numeral!"
      db = RomanNumeral.from_string("IIII").to_i
      assert_equal db, "That is not a valid roman numeral!"
      dc = RomanNumeral.from_string("IM").to_i
      assert_equal dc, "That is not a valid roman numeral!"
      dd = RomanNumeral.from_string("ID").to_i
      assert_equal dd, "That is not a valid roman numeral!"
      de = RomanNumeral.from_string("ID").to_i
      assert_equal de, "That is not a valid roman numeral!"
      df = RomanNumeral.from_string("IC").to_i
      assert_equal df, "That is not a valid roman numeral!"
      dg = RomanNumeral.from_string("IL").to_i
      assert_equal dg, "That is not a valid roman numeral!"
      dh = RomanNumeral.from_string("IXI").to_i
      assert_equal dh, "That is not a valid roman numeral!"
      di = RomanNumeral.from_string("IVIV").to_i
      assert_equal di, "That is not a valid roman numeral!"
    end

    def test_romannumeralfromstring
      bp = RomanNumeral.from_string("IX")
      assert_instance_of RomanNumeral, bp
    end
  end
#end


# ========================================================================================
#  Problem 2: Golden Ratio

# Golden Ratio is ratio between consecutive Fibonacci numbers
# calculate the golden ratio up to specified precision
# validate using MiniTest unit tests

#module Assignment08
  def golden_ratio(precision)
    x = fib(99)/fib(98).to_f
    x.round(precision)
  end
  def fib(n)
    def calc_fib(n, cache)
      if cache.length > n
        cache[n]
      else
        cache[n] = calc_fib(n-1, cache) + calc_fib(n-2, cache)
      end
    end
    calc_fib(n, [1,1])
  end

require 'minitest/autorun'

  class TestGoldenRatio < MiniTest::Test
    def test_goldenratio
      a = golden_ratio(0)
      assert_equal a, 2
      b = golden_ratio(1)
      assert_equal b, 1.6
      c = golden_ratio(2)
      assert_equal c, 1.62
      d = golden_ratio(3)
      assert_equal d, 1.618
      e = golden_ratio(4)
      assert_equal e, 1.618
      f = golden_ratio(5)
      assert_equal f, 1.61803
      g = golden_ratio(6)
      assert_equal g, 1.618034
      h = golden_ratio(7)
      assert_equal h, 1.618034
      i = golden_ratio(8)
      assert_equal i, 1.61803399
      j = golden_ratio(9)
      assert_equal j, 1.618033989
      k = golden_ratio(10)
      assert_equal k, 1.6180339887
      l = golden_ratio(11)
      assert_equal l, 1.61803398875
      m = golden_ratio(12)
      assert_equal m, 1.61803398875
      n = golden_ratio(13)
      assert_equal n, 1.6180339887499
      o = golden_ratio(14)
      assert_equal o, 1.6180339887499
      p = golden_ratio(15)
      assert_equal p, 1.618033988749895
      q = golden_ratio(15)
      assert_equal q, 1.618033988749895

    end
  end
end
