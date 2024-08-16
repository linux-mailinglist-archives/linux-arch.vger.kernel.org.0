Return-Path: <linux-arch+bounces-6241-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B36919541B3
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 08:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 353AD287043
	for <lists+linux-arch@lfdr.de>; Fri, 16 Aug 2024 06:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1A17E76F;
	Fri, 16 Aug 2024 06:28:13 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF99D34CD8;
	Fri, 16 Aug 2024 06:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723789693; cv=none; b=nmPMQoxnmSo/WcVL2YbDK4z/PEJmiF7HTd1nJUpLxZiW4C9LCTJ2R0Pbl+dLq9LQC0YY56CzlLon8+RboP5aW2aas/fjg/MoQ5HR1OOKc8YLXRHHS4QNN0nQTr3D3XZpsGhbE4d4cYHcStwTABd8K+pSVv9nP7Jymp/b9LIrgfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723789693; c=relaxed/simple;
	bh=YWQI/nyT5QdlLevRRr/GwMqaTttd/nH11Y3stUGbZrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQVhX5AAj3v8CtuuFBAqgKoX6cK7mscR12xqkrR3vnDZVrRTvC02hf6HW/N+nrx9n33eIlnFsAo1/MGG+w5j8cKVSgNqct6VlslxykdCliS0rlBovyxjYOhvBr45FzkJ4zkE7ZfaV1IRyBK3g3y+LiqCR/qMGPUVA9AIKcgifvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0D9E143D;
	Thu, 15 Aug 2024 23:28:35 -0700 (PDT)
Received: from [10.163.57.106] (unknown [10.163.57.106])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 315173F73B;
	Thu, 15 Aug 2024 23:28:06 -0700 (PDT)
Message-ID: <090eb237-10f4-4358-be07-1eb8d30c3ec1@arm.com>
Date: Fri, 16 Aug 2024 11:58:04 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/2] uapi: Define GENMASK_U128
To: linux-kernel@vger.kernel.org
Cc: ardb@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
References: <20240801071646.682731-1-anshuman.khandual@arm.com>
 <20240801071646.682731-2-anshuman.khandual@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240801071646.682731-2-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/1/24 12:46, Anshuman Khandual wrote:
> This adds GENMASK_U128() and __GENMASK_U128() macros using __BITS_PER_U128
> and __int128 data types. These macros will be used in providing support for
> generating 128 bit masks.
> 
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Arnd Bergmann <arnd@arndb.de>>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  include/linux/bits.h       | 13 +++++++++++++
>  include/uapi/linux/bits.h  |  3 +++
>  include/uapi/linux/const.h | 15 +++++++++++++++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index 0eb24d21aac2..bf99feb5570e 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -36,4 +36,17 @@
>  #define GENMASK_ULL(h, l) \
>  	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
>  
> +/*
> + * Missing asm support
> + *
> + * __GENMASK_U128() depends on _BIT128() which would not work
> + * in the asm code, as it shifts an 'unsigned __init128' data
> + * type instead of direct representation of 128 bit constants
> + * such as long and unsigned long. The fundamental problem is
> + * that a 128 bit constant will get silently truncated by the
> + * gcc compiler.
> + */
> +#define GENMASK_U128(h, l) \
> +	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
> +
>  #endif	/* __LINUX_BITS_H */
> diff --git a/include/uapi/linux/bits.h b/include/uapi/linux/bits.h
> index 3c2a101986a3..4d4b7b08003c 100644
> --- a/include/uapi/linux/bits.h
> +++ b/include/uapi/linux/bits.h
> @@ -12,4 +12,7 @@
>          (((~_ULL(0)) - (_ULL(1) << (l)) + 1) & \
>           (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
>  
> +#define __GENMASK_U128(h, l) \
> +	((_BIT128((h) + 1)) - (_BIT128(l)))
> +
>  #endif /* _UAPI_LINUX_BITS_H */
> diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
> index a429381e7ca5..5be12e8f8f9c 100644
> --- a/include/uapi/linux/const.h
> +++ b/include/uapi/linux/const.h
> @@ -28,6 +28,21 @@
>  #define _BITUL(x)	(_UL(1) << (x))
>  #define _BITULL(x)	(_ULL(1) << (x))
>  
> +/*
> + * Missing asm support
> + *
> + * __BIT128() would not work in the asm code, as it shifts an
> + * 'unsigned __init128' data type as direct representation of
> + * 128 bit constants is not supported in the gcc compiler, as
> + * they get silently truncated.
> + *
> + * TODO: Please revisit this implementation when gcc compiler
> + * starts representing 128 bit constants directly like long
> + * and unsigned long etc. Subsequently drop the comment for
> + * GENMASK_U128() which would then start supporting asm code.
> + */
> +#define _BIT128(x)	((unsigned __int128)(1) << (x))
> +
>  #define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
>  #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
>  

Hello Yuri/Arnd,

This proposed GENMASK_U128(h, l) warns during build when the higher end
bit is 127 (which in itself is a valid input).

./include/uapi/linux/const.h:45:44: warning: left shift count >= width of type [-Wshift-count-overflow]
   45 | #define _BIT128(x) ((unsigned __int128)(1) << (x))
      |                                            ^~
./include/asm-generic/bug.h:123:25: note: in definition of macro ‘WARN_ON’
  123 |  int __ret_warn_on = !!(condition);    \
      |                         ^~~~~~~~~
./include/uapi/linux/bits.h:16:4: note: in expansion of macro ‘_BIT128’
   16 |  ((_BIT128((h) + 1)) - (_BIT128(l)))
      |    ^~~~~~~
./include/linux/bits.h:51:31: note: in expansion of macro ‘__GENMASK_U128’
   51 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
      |                               ^~~~~~~~~~~~~~

This is caused by ((unsigned __int128)(1) << (128)) which is generated
via (h + 1) element in __GENMASK_U128().

#define _BIT128(x)	((unsigned __int128)(1) << (x))
#define __GENMASK_U128(h, l) \
	((_BIT128((h) + 1)) - (_BIT128(l)))

Adding some extra tests in lib/test_bits.c exposes this build problem,
although it does not fail these new tests.

[    1.719221]     # Subtest: bits-test
[    1.719291]     # module: test_bits
[    1.720522]     ok 1 genmask_test
[    1.721570]     ok 2 genmask_ull_test
[    1.722668]     ok 3 genmask_u128_test
[    1.723760]     ok 4 genmask_input_check_test
[    1.723909] # bits-test: pass:4 fail:0 skip:0 total:4
[    1.724101] ok 1 bits-test

diff --git a/lib/test_bits.c b/lib/test_bits.c
index d3d858b24e02..7a972edc7122 100644
--- a/lib/test_bits.c
+++ b/lib/test_bits.c
@@ -49,6 +49,8 @@ static void genmask_u128_test(struct kunit *test)
        KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(63, 0));
        KUNIT_EXPECT_EQ(test, 0xffffffffffffffffULL, GENMASK_U128(64, 0) >> 1);
        KUNIT_EXPECT_EQ(test, 0x00000000ffffffffULL, GENMASK_U128(81, 50) >> 50);
+       KUNIT_EXPECT_EQ(test, 0x0000000000000003ULL, GENMASK_U128(127, 126) >> 126);
+       KUNIT_EXPECT_EQ(test, 0x0000000000000001ULL, GENMASK_U128(127, 127) >> 127);

The most significant bit in the generate mask can be added separately
, thus voiding that extra shift. The following patch solves the build
problem.

diff --git a/include/uapi/linux/bits.h b/include/uapi/linux/bits.h
index 4d4b7b08003c..4e50f635c6d9 100644
--- a/include/uapi/linux/bits.h
+++ b/include/uapi/linux/bits.h
@@ -13,6 +13,6 @@
          (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
 
 #define __GENMASK_U128(h, l) \
-       ((_BIT128((h) + 1)) - (_BIT128(l)))
+       (((_BIT128(h)) - (_BIT128(l))) | (_BIT128(h)))

