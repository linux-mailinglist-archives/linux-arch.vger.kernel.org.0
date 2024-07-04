Return-Path: <linux-arch+bounces-5270-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DD5927C31
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 19:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E6C283C78
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 17:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11C83B782;
	Thu,  4 Jul 2024 17:26:03 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7328573463;
	Thu,  4 Jul 2024 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720113963; cv=none; b=M2YASt1uCTsp8d2ZAA9zzibKtqtZquDZb94wQx4xLu/iCKq7SE2sQ6HUfmNOdBttq/bI4XMorUqC12kg8Z4/p97z9xAup4FvpoQ6J30ibo6PXu7LwuNN8RmilAz9V+tGv5r3Mn5lR6PYy/yiKMnqYu6zhZ7IFH9KaKsTs+pcM3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720113963; c=relaxed/simple;
	bh=eXkylD9MmWSdmwsYCaZddSS6ayoRI6OIyX16FP+hcvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kA++vr1IJnjAXbYZdlF4fKk26e+W10xBkw0j73aY26SmSKG2EVMhsW9vys8zMz9cbdINxLlD/V3W36TNLLMZKP1dK8S64E7YwTKFCPiyTCh9TvIUIYo8kpXGpq6blHomdARRzIuYpeTMbEze3J1psNFgcZvFqr58+0BN0+9aty8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 17AB3240004;
	Thu,  4 Jul 2024 17:25:47 +0000 (UTC)
Message-ID: <b221b813-51dc-4d34-be27-7dacb8866560@ghiti.fr>
Date: Thu, 4 Jul 2024 19:25:47 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] riscv: Implement xchg8/16() using Zabha
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
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
 <20240626130347.520750-7-alexghiti@rivosinc.com> <Zn1tC1G6eiyIW/yJ@andrea>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <Zn1tC1G6eiyIW/yJ@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr


On 27/06/2024 15:45, Andrea Parri wrote:
>> -#define __arch_xchg_masked(sc_sfx, prepend, append, r, p, n)		\
>> +#define __arch_xchg_masked(sc_sfx, swap_sfx, prepend, sc_append,	\
>> +			   swap_append, r, p, n)			\
>>   ({									\
>> +	__label__ zabha, end;						\
>> +									\
>> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {			\
>> +		asm goto(ALTERNATIVE("nop", "j %[zabha]", 0,		\
>> +				     RISCV_ISA_EXT_ZABHA, 1)		\
>> +			 : : : : zabha);				\
>> +	}								\
>> +									\
>>   	u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
>>   	ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
>>   	ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
>> @@ -28,12 +37,25 @@
>>   	       "	or   %1, %1, %z3\n"				\
>>   	       "	sc.w" sc_sfx " %1, %1, %2\n"			\
>>   	       "	bnez %1, 0b\n"					\
>> -	       append							\
>> +	       sc_append							\
>>   	       : "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
>>   	       : "rJ" (__newx), "rJ" (~__mask)				\
>>   	       : "memory");						\
>>   									\
>>   	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
>> +	goto end;							\
>> +									\
>> +zabha:									\
>> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {			\
>> +		__asm__ __volatile__ (					\
>> +			prepend						\
>> +			"	amoswap" swap_sfx " %0, %z2, %1\n"	\
>> +			swap_append						\
>> +			: "=&r" (r), "+A" (*(p))			\
>> +			: "rJ" (n)					\
>> +			: "memory");					\
>> +	}								\
>> +end:;									\
>>   })
> As for patch #1: why the semicolon? and should the second IS_ENABLED()
> be kept?
>
>
>> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
>> index e17d0078a651..f71ddd2ca163 100644
>> --- a/arch/riscv/include/asm/hwcap.h
>> +++ b/arch/riscv/include/asm/hwcap.h
>> @@ -81,6 +81,7 @@
>>   #define RISCV_ISA_EXT_ZTSO		72
>>   #define RISCV_ISA_EXT_ZACAS		73
>>   #define RISCV_ISA_EXT_XANDESPMU		74
>> +#define RISCV_ISA_EXT_ZABHA		75
>>   
>>   #define RISCV_ISA_EXT_XLINUXENVCFG	127
>>   
>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> index 5ef48cb20ee1..c125d82c894b 100644
>> --- a/arch/riscv/kernel/cpufeature.c
>> +++ b/arch/riscv/kernel/cpufeature.c
>> @@ -257,6 +257,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>>   	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
>>   	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
>>   	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
>> +	__RISCV_ISA_EXT_DATA(zabha, RISCV_ISA_EXT_ZABHA),
>>   	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
>>   	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
>>   	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
> To be squashed into patch #3?


Yep, done, thanks.


>
>    Andrea
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

