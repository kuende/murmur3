require "./spec_helper"

describe Murmur3 do
  it "generates correct murmur3 hash for increasing sequence" do
    # these examples are based on adding a index number to a sample string in
    # a loop. The expected values were generated by the java datastax murmur3
    # implementation. The number of examples here of increasing lengths ensure
    # test coverage of all tail-length branches in the murmur3 algorithm
    series_expected = [
  		0x0000000000000000_u64, # ""
  		0x2ac9debed546a380_u64, # "0"
  		0x649e4eaa7fc1708e_u64, # "01"
  		0xce68f60d7c353bdb_u64, # "012"
  		0x0f95757ce7f38254_u64, # "0123"
  		0x0f04e459497f3fc1_u64, # "01234"
  		0x88c0a92586be0a27_u64, # "012345"
  		0x13eb9fb82606f7a6_u64, # "0123456"
  		0x8236039b7387354d_u64, # "01234567"
  		0x4c1e87519fe738ba_u64, # "012345678"
  		0x3f9652ac3effeb24_u64, # "0123456789"
  		0x3f33760ded9006c6_u64, # "01234567890"
  		0xaed70a6631854cb1_u64, # "012345678901"
  		0x8a299a8f8e0e2da7_u64, # "0123456789012"
  		0x624b675c779249a6_u64, # "01234567890123"
  		0xa4b203bb1d90b9a3_u64, # "012345678901234"
  		0xa3293ad698ecb99a_u64, # "0123456789012345"
  		0xbc740023dbd50048_u64, # "01234567890123456"
  		0x3fe5ab9837d25cdd_u64, # "012345678901234567"
  		0x2d0338c1ca87d132_u64, # "0123456789012345678"
  	]

    sample = ""

    series_expected.each_with_index do |expected, i|
      Murmur3.h1(sample.bytes).should eq(expected)

      sample += (i % 10).to_s
    end
  end

  it "generates correct murmur3 hash for 'hello'" do
    Murmur3.h1("hello".bytes).should eq(0xcbd8a7b341bd9b02_u64)
  end

  it "generates correct murmur3 hash for 'hello, world'" do
    Murmur3.h1("hello, world".bytes).should eq(0x342fac623a5ebc8e_u64)
  end

  it "generates correct murmur3 hash for '19 Jan 2038 at 3:14:07 AM'" do
    Murmur3.h1("19 Jan 2038 at 3:14:07 AM".bytes).should eq(0xb89e5988b737affc_u64)
  end

  it "generates correct murmur3 hash for 'The quick brown fox jumps over the lazy dog.'" do
    Murmur3.h1("The quick brown fox jumps over the lazy dog.".bytes).should eq(0xcd99481f9ee902c9_u64)
  end

  it "generates correct murmu3 hash for string" do
    Murmur3.h1("The quick brown fox jumps over the lazy dog.").should eq(0xcd99481f9ee902c9_u64)
  end
end