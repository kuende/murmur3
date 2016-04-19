require "./murmur3/*"

module Murmur3
  def self.h1(data : String) : UInt64
    h1(data.bytes)
  end

  def self.h1(data : Array(UInt8)) : UInt64
    length = data.size

    c1 = 0x87c37b91114253d5_u64
    c2 = 0x4cf5ad432745937f_u64

    h1 = 0_u64
    h2 = 0_u64
    h3 = 0_u64
    h4 = 0_u64

    # body
  	n_blocks = length / 16

    n_blocks.times.each do |i|
      # Start positions for getting 8 bytes
      st1 = i * 16
      st2 = (i * 16) + 8

      # Define 2 tuples for first 8 bytes from index st1 and st2
      block1 = {data[st1 + 0], data[st1 + 1], data[st1 + 2], data[st1 + 3], data[st1 + 4], data[st1 + 5], data[st1 + 6], data[st1 + 7]}
      block2 = {data[st2 + 0], data[st2 + 1], data[st2 + 2], data[st2 + 3], data[st2 + 4], data[st2 + 5], data[st2 + 6], data[st2 + 7]}
      k1 = (pointerof(block1) as UInt64*).value
      k2 = (pointerof(block2) as UInt64*).value

  		k1 *= c1
  		k1 = (k1 << 31) | (k1 >> 33) # ROTL64(k1, 31)
  		k1 *= c2
  		h1 ^= k1

  		h1 = (h1 << 27) | (h1 >> 37) # ROTL64(h1, 27)
  		h1 += h2
  		h1 = h1*5 + 0x52dce729_u64

  		k2 *= c2
  		k2 = (k2 << 33) | (k2 >> 31) # ROTL64(k2, 33)
  		k2 *= c1
  		h2 ^= k2

  		h2 = (h2 << 31) | (h2 >> 33) # ROTL64(h2, 31)
  		h2 += h1
  		h2 = h2*5 + 0x38495ab5
  	end

    # tail
    tail = data[n_blocks*16, 16]
    tail_length = tail.size
    k1 = 0_u64
    k2 = 0_u64

    if tail_length >= 15
      k2 ^= (tail[14].to_u64) << 48
    end

    if tail_length >= 14
      k2 ^= (tail[13].to_u64) << 40
    end

    if tail_length >= 13
      k2 ^= (tail[12].to_u64) << 32
    end

    if tail_length >= 12
      k2 ^= (tail[11].to_u64) << 24
    end

    if tail_length >= 11
      k2 ^= (tail[10].to_u64) << 16
    end

    if tail_length >= 10
      k2 ^= (tail[9].to_u64) << 8
    end

    if tail_length >= 9
      k2 ^= tail[8].to_u64

      k2 *= c2
      k2 = (k2 << 33) | (k2 >> 31) # ROTL64(k2, 33)
      k2 *= c1
      h2 ^= k2
    end

    if tail_length >= 8
      k1 ^= (tail[7].to_u64) << 56
    end

    if tail_length >= 7
      k1 ^= (tail[6].to_u64) << 48
    end

    if tail_length >= 6
      k1 ^= (tail[5].to_u64) << 40
    end

    if tail_length >= 5
      k1 ^= (tail[4].to_u64) << 32
    end

    if tail_length >= 4
      k1 ^= (tail[3].to_u64) << 24
    end

    if tail_length >= 3
      k1 ^= (tail[2].to_u64) << 16
    end

    if tail_length >= 2
      k1 ^= (tail[1].to_u64) << 8
    end

    if tail_length >= 1
      k1 ^= tail[0].to_u64

      k1 *= c1
      k1 = (k1 << 31) | (k1 >> 33) # ROTL64(k1, 31)
      k1 *= c2
      h1 ^= k1
    end


    h1 ^= length.to_u64
  	h2 ^= length.to_u64

  	h1 += h2
  	h2 += h1

  	# finalizer

		fmix1 = 0xff51afd7ed558ccd_u64
		fmix2 = 0xc4ceb9fe1a85ec53_u64

  	# fmix64(h1)
  	h1 ^= h1 >> 33
  	h1 *= fmix1
  	h1 ^= h1 >> 33
  	h1 *= fmix2
  	h1 ^= h1 >> 33

  	# fmix64(h2)
  	h2 ^= h2 >> 33
  	h2 *= fmix1
  	h2 ^= h2 >> 33
  	h2 *= fmix2
  	h2 ^= h2 >> 33

  	h1 += h2
  	# the following is extraneous since h2 is discarded
  	# h2 += h1

  	h1
  end
end
