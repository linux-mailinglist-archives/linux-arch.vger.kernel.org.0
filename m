Return-Path: <linux-arch+bounces-6302-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C30F956167
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2024 05:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D2C1C2141C
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2024 03:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE49E288B1;
	Mon, 19 Aug 2024 03:18:56 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9781804E;
	Mon, 19 Aug 2024 03:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724037536; cv=none; b=GMeMA1F4QW8xlsPo/815g6kxLCiO5YloW15Id6FXSDp0H/g4JLXEPI+EAW9kuDvXvUumMSpU1TWhCUnLuXeL4RLoBKQLLcR4zDWv9794ZzZ3X4kTfEb5HYGVycA9M77qtSO9cbBE02tyko0JvCLfpudJ0C706ca4uEM/WFm6xm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724037536; c=relaxed/simple;
	bh=Ux6+XrBc6ayouZzLRcIzjbfTqqQMFU5pOj7UuwROAas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OxuKJkFbv8r7qrA5UTjquMUIqqkyFh037fr3qJlwyrJ30qu6mW+m3pTucYaFE8vNWpPFirQBWfUV1RNde+PjiUMOAWQNvvvoDPJWYM7F3VxgUqZmtfKCIGlLjE7kfK28irlMLa8OwYqY9J8hubmdjnXjsUf8eolHBV00+hVx6Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FA491042;
	Sun, 18 Aug 2024 20:19:13 -0700 (PDT)
Received: from [10.162.42.12] (a077893.blr.arm.com [10.162.42.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEB513F58B;
	Sun, 18 Aug 2024 20:18:44 -0700 (PDT)
Message-ID: <1dd33784-e9f8-46ca-bf6c-861ba9600e76@arm.com>
Date: Mon, 19 Aug 2024 08:48:41 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/2] uapi: Define GENMASK_U128
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, ardb@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
References: <20240801071646.682731-1-anshuman.khandual@arm.com>
 <20240801071646.682731-2-anshuman.khandual@arm.com>
 <090eb237-10f4-4358-be07-1eb8d30c3ec1@arm.com>
 <ZsCsVkkK-ElBf_dZ@yury-ThinkPad>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZsCsVkkK-ElBf_dZ@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/17/24 19:27, Yury Norov wrote:
> On Fri, Aug 16, 2024 at 11:58:04AM +0530, Anshuman Khandual wrote:
>>
>>
>> On 8/1/24 12:46, Anshuman Khandual wrote:
>>> This adds GENMASK_U128() and __GENMASK_U128() macros using __BITS_PER_U128
>>> and __int128 data types. These macros will be used in providing support for
>>> generating 128 bit masks.
>>>
>>> Cc: Yury Norov <yury.norov@gmail.com>
>>> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>>> Cc: Arnd Bergmann <arnd@arndb.de>>
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: linux-arch@vger.kernel.org
>>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>>  include/linux/bits.h       | 13 +++++++++++++
>>>  include/uapi/linux/bits.h  |  3 +++
>>>  include/uapi/linux/const.h | 15 +++++++++++++++
>>>  3 files changed, 31 insertions(+)
>>>
>>> diff --git a/include/linux/bits.h b/include/linux/bits.h
>>> index 0eb24d21aac2..bf99feb5570e 100644
>>> --- a/include/linux/bits.h
>>> +++ b/include/linux/bits.h
>>> @@ -36,4 +36,17 @@
>>>  #define GENMASK_ULL(h, l) \
>>>  	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
>>>  
>>> +/*
>>> + * Missing asm support
>>> + *
>>> + * __GENMASK_U128() depends on _BIT128() which would not work
>>> + * in the asm code, as it shifts an 'unsigned __init128' data
>>> + * type instead of direct representation of 128 bit constants
>>> + * such as long and unsigned long. The fundamental problem is
>>> + * that a 128 bit constant will get silently truncated by the
>>> + * gcc compiler.
>>> + */
>>> +#define GENMASK_U128(h, l) \
>>> +	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
>>> +
>>>  #endif	/* __LINUX_BITS_H */
>>> diff --git a/include/uapi/linux/bits.h b/include/uapi/linux/bits.h
>>> index 3c2a101986a3..4d4b7b08003c 100644
>>> --- a/include/uapi/linux/bits.h
>>> +++ b/include/uapi/linux/bits.h
>>> @@ -12,4 +12,7 @@
>>>          (((~_ULL(0)) - (_ULL(1) << (l)) + 1) & \
>>>           (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
>>>  
>>> +#define __GENMASK_U128(h, l) \
>>> +	((_BIT128((h) + 1)) - (_BIT128(l)))
>>> +
>>>  #endif /* _UAPI_LINUX_BITS_H */
>>> diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
>>> index a429381e7ca5..5be12e8f8f9c 100644
>>> --- a/include/uapi/linux/const.h
>>> +++ b/include/uapi/linux/const.h
>>> @@ -28,6 +28,21 @@
>>>  #define _BITUL(x)	(_UL(1) << (x))
>>>  #define _BITULL(x)	(_ULL(1) << (x))
>>>  
>>> +/*
>>> + * Missing asm support
>>> + *
>>> + * __BIT128() would not work in the asm code, as it shifts an
>>> + * 'unsigned __init128' data type as direct representation of
>>> + * 128 bit constants is not supported in the gcc compiler, as
>>> + * they get silently truncated.
>>> + *
>>> + * TODO: Please revisit this implementation when gcc compiler
>>> + * starts representing 128 bit constants directly like long
>>> + * and unsigned long etc. Subsequently drop the comment for
>>> + * GENMASK_U128() which would then start supporting asm code.
>>> + */
>>> +#define _BIT128(x)	((unsigned __int128)(1) << (x))
>>> +
>>>  #define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
>>>  #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
>>>  
>>
>> Hello Yuri/Arnd,
>>
>> This proposed GENMASK_U128(h, l) warns during build when the higher end
>> bit is 127 (which in itself is a valid input).
>>
>> ./include/uapi/linux/const.h:45:44: warning: left shift count >= width of type [-Wshift-count-overflow]
>>    45 | #define _BIT128(x) ((unsigned __int128)(1) << (x))
>>       |                                            ^~
>> ./include/asm-generic/bug.h:123:25: note: in definition of macro ‘WARN_ON’
>>   123 |  int __ret_warn_on = !!(condition);    \
>>       |                         ^~~~~~~~~
>> ./include/uapi/linux/bits.h:16:4: note: in expansion of macro ‘_BIT128’
>>    16 |  ((_BIT128((h) + 1)) - (_BIT128(l)))
>>       |    ^~~~~~~
>> ./include/linux/bits.h:51:31: note: in expansion of macro ‘__GENMASK_U128’
>>    51 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
>>       |                               ^~~~~~~~~~~~~~
>>
>> This is caused by ((unsigned __int128)(1) << (128)) which is generated
>> via (h + 1) element in __GENMASK_U128().
>>
>> #define _BIT128(x)	((unsigned __int128)(1) << (x))
>> #define __GENMASK_U128(h, l) \
>> 	((_BIT128((h) + 1)) - (_BIT128(l)))
>>
>> Adding some extra tests in lib/test_bits.c exposes this build problem,
>> although it does not fail these new tests.
>>
>> [    1.719221]     # Subtest: bits-test
>> [    1.719291]     # module: test_bits
>> [    1.720522]     ok 1 genmask_test
>> [    1.721570]     ok 2 genmask_ull_test
>> [    1.722668]     ok 3 genmask_u128_test
>> [    1.723760]     ok 4 genmask_input_check_test
>> [    1.723909] # bits-test: pass:4 fail:0 skip:0 total:4
>> [    1.724101] ok 1 bits-test
>>
>> diff --git a/lib/test_bits.c b/lib/test_bits.c
>> index d3d858b24e02..7a972edc7122 100644
>> --- a/lib/test_bits.c
>> +++ b/lib/test_bits.c
>> @@ -49,6 +49,8 @@ static void genmask_u128_test(struct kunit *test)
>>         KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(63, 0));
>>         KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(64, 0) >> 1);
>>         KUNIT_EXPECT_EQ(test, 0x00000000ffffffffULL, GENMASK_U128(81, 50) >> 50);
>> +       KUNIT_EXPECT_EQ(test, 0x0000000000000003ULL, GENMASK_U128(127, 126) >> 126);
>> +       KUNIT_EXPECT_EQ(test, 0x0000000000000001ULL, GENMASK_U128(127, 127) >> 127);
>>
>> The most significant bit in the generate mask can be added separately
>> , thus voiding that extra shift. The following patch solves the build
>> problem.
>>
>> diff --git a/include/uapi/linux/bits.h b/include/uapi/linux/bits.h
>> index 4d4b7b08003c..4e50f635c6d9 100644
>> --- a/include/uapi/linux/bits.h
>> +++ b/include/uapi/linux/bits.h
>> @@ -13,6 +13,6 @@
>>           (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
>>  
>>  #define __GENMASK_U128(h, l) \
>> -       ((_BIT128((h) + 1)) - (_BIT128(l)))
>> +       (((_BIT128(h)) - (_BIT128(l))) | (_BIT128(h)))
> 
> Can you send v3 with the fix? I will drop this series from bitmap-for-next
> meanwhile.

Sure, will send out V4 (current series being V3).

> 
> Can you also extend the test for more? I'd like to check for example
> the (127, 0) range. Also, can you please check both HI and LO parts 
> the mask?

Following tests form the complete set on GENMASK_U128(). The last four tests
here will be added in V4. Please also note that only 64 bit mask portion can
be tested at once.

        KUNIT_EXPECT_EQ(test, 0x0000000000ff0000ULL, GENMASK_U128(87, 80) >> 64);
        KUNIT_EXPECT_EQ(test, 0x0000000000ffffffULL, GENMASK_U128(87, 64) >> 64);
        KUNIT_EXPECT_EQ(test, 0x0000000000000001ULL, GENMASK_U128(0, 0));
        KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(63, 0));
        KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(64, 0) >> 1);
        KUNIT_EXPECT_EQ(test, 0x00000000ffffffffULL, GENMASK_U128(81, 50) >> 50);
        KUNIT_EXPECT_EQ(test, 0x0000000000000003ULL, GENMASK_U128(127, 126) >> 126);
        KUNIT_EXPECT_EQ(test, 0x0000000000000001ULL, GENMASK_U128(127, 127) >> 127);
        KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(127, 0) >> 64);
        KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(127, 0) & ~GENMASK_U128(127, 64));

Although, please do let me know if you would like to add some more tests.

> 
> For the v3, please share the link to the following series that
> actually uses new API.

Sure, will add the following link pointing to the work in progress on arm64.

https://lore.kernel.org/all/20240801054436.612024-1-anshuman.khandual@arm.com/

