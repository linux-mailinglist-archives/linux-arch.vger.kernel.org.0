Return-Path: <linux-arch+bounces-5269-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 967EC927B4F
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 18:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D8A283A77
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 16:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3E71B373A;
	Thu,  4 Jul 2024 16:40:25 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3493F1AE87A;
	Thu,  4 Jul 2024 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720111225; cv=none; b=mh+5z0fl5X/XASGMnwuahHl85aCTOiN4ZkeIWj3l16IBjN55XoL1hROgfsbZqTEs1picMnpyLjZCRQhJ2BbMxPTq59etCfWx1orCiAiwee01z9n61rTR1GFUfHjoNE7jU4+zDOO0zJ5O2Zhko4AXtnRHO/1pYUDHf15zZ7QUf0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720111225; c=relaxed/simple;
	bh=lJCVDztbx8OJeDVXvVpMxH2Zike52t6CiBZFoi5gEfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7GajLpgloXulH67OoGDcLTweMwJxaYcRc5Eqqj9wI1HxGhMMaa2333Q0glH6RsW32caZNDe4lPSKexyoPVhVA1ZVbvXVsbHr1H8TAPBs6jD6C2K/8dsPplNBRCyI9jhRuOFXHiOMifdkY6Cqhiq4zQdfL9vzNidrkZHpoBnXmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 895FE20002;
	Thu,  4 Jul 2024 16:40:19 +0000 (UTC)
Message-ID: <956d345e-9451-490f-93e7-32ccd5f07c2e@ghiti.fr>
Date: Thu, 4 Jul 2024 18:40:19 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] riscv: Improve amocas.X use in cmpxchg()
Content-Language: en-US
To: Andrea Parri <parri.andrea@gmail.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Nathan Chancellor <nathan@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 Andrea Parri <andrea@rivosinc.com>
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
 <20240626130347.520750-5-alexghiti@rivosinc.com> <Zn1pqD7Aruo4XwN8@andrea>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <Zn1pqD7Aruo4XwN8@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

On 27/06/2024 15:31, Andrea Parri wrote:
> On Wed, Jun 26, 2024 at 03:03:41PM +0200, Alexandre Ghiti wrote:
>> cmpxchg() uses amocas.X instructions from Zacas and Zabha but still uses
>> the LR/SC acquire/release semantics which require barriers.
>>
>> Let's improve that by using proper amocas acquire/release semantics in
>> order to avoid any of those barriers.
> I can't really parse this changelog...
>
>
>> Suggested-by: Andrea Parri <andrea@rivosinc.com>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
>>   arch/riscv/include/asm/cmpxchg.h | 60 ++++++++++++++++++--------------
>>   1 file changed, 33 insertions(+), 27 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
>> index b9a3fdcec919..3c65b00a0d36 100644
>> --- a/arch/riscv/include/asm/cmpxchg.h
>> +++ b/arch/riscv/include/asm/cmpxchg.h
>> @@ -105,7 +105,9 @@
>>    * indicated by comparing RETURN with OLD.
>>    */
>>   
>> -#define __arch_cmpxchg_masked(sc_sfx, cas_sfx, prepend, append, r, p, o, n)	\
>> +#define __arch_cmpxchg_masked(sc_sfx, cas_sfx,				\
>> +			      sc_prepend, sc_append,			\
>> +			      r, p, o, n)				\
>>   ({									\
>>   	__label__ no_zacas, zabha, end;					\
>>   									\
>> @@ -129,7 +131,7 @@ no_zacas:;								\
>>   	ulong __rc;							\
>>   									\
>>   	__asm__ __volatile__ (						\
>> -		prepend							\
>> +		sc_prepend							\
>>   		"0:	lr.w %0, %2\n"					\
>>   		"	and  %1, %0, %z5\n"				\
>>   		"	bne  %1, %z3, 1f\n"				\
>> @@ -137,7 +139,7 @@ no_zacas:;								\
>>   		"	or   %1, %1, %z4\n"				\
>>   		"	sc.w" sc_sfx " %1, %1, %2\n"			\
>>   		"	bnez %1, 0b\n"					\
>> -		append							\
>> +		sc_append							\
>>   		"1:\n"							\
>>   		: "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
>>   		: "rJ" ((long)__oldx), "rJ" (__newx),			\
>> @@ -150,9 +152,7 @@ no_zacas:;								\
>>   zabha:									\
>>   	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {			\
>>   		__asm__ __volatile__ (					\
>> -			prepend						\
>>   			"	amocas" cas_sfx " %0, %z2, %1\n"	\
>> -			append						\
>>   			: "+&r" (r), "+A" (*(p))			\
>>   			: "rJ" (n)					\
>>   			: "memory");					\
>> @@ -160,7 +160,9 @@ zabha:									\
>>   end:;									\
>>   })
>>   
>> -#define __arch_cmpxchg(lr_sfx, sc_cas_sfx, prepend, append, r, p, co, o, n)	\
>> +#define __arch_cmpxchg(lr_sfx, sc_sfx, cas_sfx,				\
>> +		       sc_prepend, sc_append,				\
>> +		       r, p, co, o, n)					\
>>   ({									\
>>   	__label__ zacas, end;						\
>>   	register unsigned int __rc;					\
>> @@ -172,12 +174,12 @@ end:;									\
>>   	}								\
>>   									\
>>   	__asm__ __volatile__ (						\
>> -		prepend							\
>> +		sc_prepend							\
>>   		"0:	lr" lr_sfx " %0, %2\n"				\
>>   		"	bne  %0, %z3, 1f\n"				\
>> -		"	sc" sc_cas_sfx " %1, %z4, %2\n"			\
>> +		"	sc" sc_sfx " %1, %z4, %2\n"			\
>>   		"	bnez %1, 0b\n"					\
>> -		append							\
>> +		sc_append							\
>>   		"1:\n"							\
>>   		: "=&r" (r), "=&r" (__rc), "+A" (*(p))			\
>>   		: "rJ" (co o), "rJ" (n)					\
>> @@ -187,9 +189,7 @@ end:;									\
>>   zacas:									\
>>   	if (IS_ENABLED(CONFIG_RISCV_ISA_ZACAS)) {			\
>>   		__asm__ __volatile__ (					\
>> -			prepend						\
>> -			"	amocas" sc_cas_sfx " %0, %z2, %1\n"	\
>> -			append						\
>> +			"	amocas" cas_sfx " %0, %z2, %1\n"	\
>>   			: "+&r" (r), "+A" (*(p))			\
>>   			: "rJ" (n)					\
>>   			: "memory");					\
>> @@ -197,7 +197,8 @@ zacas:									\
>>   end:;									\
>>   })
>>   
>> -#define _arch_cmpxchg(ptr, old, new, sc_sfx, prepend, append)		\
>> +#define _arch_cmpxchg(ptr, old, new, sc_sfx, cas_sfx,			\
>> +		      sc_prepend, sc_append)				\
>>   ({									\
>>   	__typeof__(ptr) __ptr = (ptr);					\
>>   	__typeof__(*(__ptr)) __old = (old);				\
>> @@ -206,22 +207,24 @@ end:;									\
>>   									\
>>   	switch (sizeof(*__ptr)) {					\
>>   	case 1:								\
>> -		__arch_cmpxchg_masked(sc_sfx, ".b" sc_sfx,		\
>> -					prepend, append,		\
>> -					__ret, __ptr, __old, __new);    \
>> +		__arch_cmpxchg_masked(sc_sfx, ".b" cas_sfx,		\
>> +				      sc_prepend, sc_append,		\
>> +				      __ret, __ptr, __old, __new);	\
>>   		break;							\
>>   	case 2:								\
>> -		__arch_cmpxchg_masked(sc_sfx, ".h" sc_sfx,		\
>> -					prepend, append,		\
>> -					__ret, __ptr, __old, __new);	\
>> +		__arch_cmpxchg_masked(sc_sfx, ".h" cas_sfx,		\
>> +				      sc_prepend, sc_append,		\
>> +				      __ret, __ptr, __old, __new);	\
>>   		break;							\
>>   	case 4:								\
>> -		__arch_cmpxchg(".w", ".w" sc_sfx, prepend, append,	\
>> -				__ret, __ptr, (long), __old, __new);	\
>> +		__arch_cmpxchg(".w", ".w" sc_sfx, ".w" cas_sfx,		\
>> +			       sc_prepend, sc_append,			\
>> +			       __ret, __ptr, (long), __old, __new);	\
>>   		break;							\
>>   	case 8:								\
>> -		__arch_cmpxchg(".d", ".d" sc_sfx, prepend, append,	\
>> -				__ret, __ptr, /**/, __old, __new);	\
>> +		__arch_cmpxchg(".d", ".d" sc_sfx, ".d" cas_sfx,		\
>> +			       sc_prepend, sc_append,			\
>> +			       __ret, __ptr, /**/, __old, __new);	\
>>   		break;							\
>>   	default:							\
>>   		BUILD_BUG();						\
>> @@ -230,16 +233,19 @@ end:;									\
>>   })
>>   
>>   #define arch_cmpxchg_relaxed(ptr, o, n)					\
>> -	_arch_cmpxchg((ptr), (o), (n), "", "", "")
>> +	_arch_cmpxchg((ptr), (o), (n), "", "", "", "")
>>   
>>   #define arch_cmpxchg_acquire(ptr, o, n)					\
>> -	_arch_cmpxchg((ptr), (o), (n), "", "", RISCV_ACQUIRE_BARRIER)
>> +	_arch_cmpxchg((ptr), (o), (n), "", ".aq",			\
>> +		      "", RISCV_ACQUIRE_BARRIER)
>>   
>>   #define arch_cmpxchg_release(ptr, o, n)					\
>> -	_arch_cmpxchg((ptr), (o), (n), "", RISCV_RELEASE_BARRIER, "")
>> +	_arch_cmpxchg((ptr), (o), (n), "", ".rl",			\
>> +		      RISCV_RELEASE_BARRIER, "")
>>   
>>   #define arch_cmpxchg(ptr, o, n)						\
>> -	_arch_cmpxchg((ptr), (o), (n), ".rl", "", "	fence rw, rw\n")
>> +	_arch_cmpxchg((ptr), (o), (n), ".rl", ".aqrl",			\
>> +		      "", RISCV_FULL_BARRIER)
> ... but this is not what I suggested: my suggestion [1] was about (limited
> to) the fully-ordered macro arch_cmpxchg().  In fact, I've recently raised
> some concern about similar changes to the acquire/release macros, cf. [2].
>
> Any particular reasons for doing this?


Not at all, I overinterpreted your suggestion, I'll restrict this to the 
fully-ordered macro then.

Thanks,


>
>    Andrea
>
> [1] https://lore.kernel.org/lkml/ZlYff9x12FICHoP0@andrea/
> [2] https://lore.kernel.org/lkml/20240505123340.38495-1-puranjay@kernel.org/
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

