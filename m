Return-Path: <linux-arch+bounces-5739-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EFE94252E
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 05:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E671F2382C
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jul 2024 03:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089B11B969;
	Wed, 31 Jul 2024 03:45:04 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0534118049;
	Wed, 31 Jul 2024 03:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722397503; cv=none; b=Lbrfrz6HFlcCCV6Cae1zX443GqWTxVKBO3/umg1yp0Q1nQm4MJD7K5lrF9uj3V9+HM8KKu+0lZjN2pGwRFPK3qpFf08zIQ7I8wkFwm6QMx3+iwbIigu+rFPoHUMXMFrUVMsDGpQTaGir7S5iQo9Lb3wDIH9lSstsB/hPkh5ybSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722397503; c=relaxed/simple;
	bh=R3SnnIddhK4TM5HoC+drXmaK4feI1RvTi2Q2m/Vx+P4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XGzNAt8h5pcnHEcwqC5nVrKCnunlLgNnC3RhlGfkCNEf5U5zIDFo+MPunjOxaruqT+k73shwiPn7DPuK75Lkfa4N3GW8jXdcLXEPmULKWwqIOpLM/6K8WjuQkLtXS4E1s45pbSaaD1WykNL0UUpQxxUM++RLOcuK6Pua3QwonXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 622D71007;
	Tue, 30 Jul 2024 20:45:25 -0700 (PDT)
Received: from [10.162.41.10] (a077893.blr.arm.com [10.162.41.10])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3B183F64C;
	Tue, 30 Jul 2024 20:44:57 -0700 (PDT)
Message-ID: <b1dd907d-d45b-4602-964e-70654094a315@arm.com>
Date: Wed, 31 Jul 2024 09:14:54 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] uapi: Define GENMASK_U128
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
References: <20240725054808.286708-1-anshuman.khandual@arm.com>
 <20240725054808.286708-2-anshuman.khandual@arm.com>
 <Zqkt3byHNZQvCZiB@yury-ThinkPad>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Zqkt3byHNZQvCZiB@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/24 23:45, Yury Norov wrote:
> On Thu, Jul 25, 2024 at 11:18:07AM +0530, Anshuman Khandual wrote:
>> This adds GENMASK_U128() and __GENMASK_U128() macros using __BITS_PER_U128
>> and __int128 data types. These macros will be used in providing support for
>> generating 128 bit masks.
>>
>> Cc: Yury Norov <yury.norov@gmail.com>
>> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> Cc: Arnd Bergmann <arnd@arndb.de>>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-arch@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  include/linux/bits.h                   | 2 ++
>>  include/uapi/asm-generic/bitsperlong.h | 2 ++
>>  include/uapi/linux/bits.h              | 3 +++
>>  include/uapi/linux/const.h             | 1 +
>>  4 files changed, 8 insertions(+)
>>
>> diff --git a/include/linux/bits.h b/include/linux/bits.h
>> index 0eb24d21aac2..0a174cce09d2 100644
>> --- a/include/linux/bits.h
>> +++ b/include/linux/bits.h
>> @@ -35,5 +35,7 @@
>>  	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
>>  #define GENMASK_ULL(h, l) \
>>  	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
>> +#define GENMASK_U128(h, l) \
>> +	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
>>  
>>  #endif	/* __LINUX_BITS_H */
>> diff --git a/include/uapi/asm-generic/bitsperlong.h b/include/uapi/asm-generic/bitsperlong.h
>> index fadb3f857f28..6275367b17bb 100644
>> --- a/include/uapi/asm-generic/bitsperlong.h
>> +++ b/include/uapi/asm-generic/bitsperlong.h
>> @@ -28,4 +28,6 @@
>>  #define __BITS_PER_LONG_LONG 64
>>  #endif
>>  
>> +#define __BITS_PER_U128 128
> 
> Do we need such a macro for a fixed-width type? Even if we do, I'm not
> sure that a header named bitsperlong.h is a good place to host it.

__BITS_PER_U128 is being used anymore, will drop it.

> 
>> +
>>  #endif /* _UAPI__ASM_GENERIC_BITS_PER_LONG */
>> diff --git a/include/uapi/linux/bits.h b/include/uapi/linux/bits.h
>> index 3c2a101986a3..4d4b7b08003c 100644
>> --- a/include/uapi/linux/bits.h
>> +++ b/include/uapi/linux/bits.h
>> @@ -12,4 +12,7 @@
>>          (((~_ULL(0)) - (_ULL(1) << (l)) + 1) & \
>>           (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
>>  
>> +#define __GENMASK_U128(h, l) \
>> +	((_BIT128((h) + 1)) - (_BIT128(l)))
>> +
>>  #endif /* _UAPI_LINUX_BITS_H */
>> diff --git a/include/uapi/linux/const.h b/include/uapi/linux/const.h
>> index a429381e7ca5..a0211136dfd8 100644
>> --- a/include/uapi/linux/const.h
>> +++ b/include/uapi/linux/const.h
>> @@ -27,6 +27,7 @@
>>  
>>  #define _BITUL(x)	(_UL(1) << (x))
>>  #define _BITULL(x)	(_ULL(1) << (x))
>> +#define _BIT128(x)	((unsigned __int128)(1) << (x))
> 
> GENMASK() macros may be used in assembly code. This is not the case
> for GENMASK_128 at this time, of course, but I think we'd introduce 
> assembly glue at this point to simplify things in future. Can you
> check the include/uapi/linux/const.h and add something like _U128()
> in there?


https://lore.kernel.org/lkml/20240724103142.165693-1-anshuman.khandual@arm.com/

We had _U128() in the previous version V1 but as Arnd explained earlier
gcc silently truncates the constant passed into that helper. So _U128()
cannot take a real large 128 bit constant as the input.

--- a/include/uapi/linux/const.h
+++ b/include/uapi/linux/const.h
@@ -16,14 +16,17 @@
 #ifdef __ASSEMBLY__
 #define _AC(X,Y)	X
 #define _AT(T,X)	X
+#define _AC128(X)	X
 #else
 #define __AC(X,Y)	(X##Y)
 #define _AC(X,Y)	__AC(X,Y)
 #define _AT(T,X)	((T)(X))
+#define _AC128(X)	((unsigned __int128)(X))
 #endif
 
 #define _UL(x)		(_AC(x, UL))
 #define _ULL(x)		(_AC(x, ULL))
+#define _U128(x)	(_AC128(x))
 
 #define _BITUL(x)	(_UL(1) << (x))
 #define _BITULL(x)	(_ULL(1) << (x))

AFAICS unsigned __int128 based constants can only be formed via shifting
and merging operations involving two distinct user provided 64 bit parts.
Probably something like the following

#define _AC128(h, l)	(((unsigned __int128)h << 64) | (unsigned __int128)l)
#define _U128(h, l)	(_AC128(h, l))

But then carving out h and l components for the required 128 bit constant
needs to be done manually and for assembly the shifting operations has to
be platform specific. Hence just wondering if it is worth adding the macro
_U128().

> 
>>  
>>  #define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
>>  #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
>> -- 
>> 2.30.2

