Return-Path: <linux-arch+bounces-5268-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0D6927B34
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 18:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 800F0B2293B
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 16:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049E01B29C2;
	Thu,  4 Jul 2024 16:36:41 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3761B29C7;
	Thu,  4 Jul 2024 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720111000; cv=none; b=HV9pR+pixoSMMKglMp075l1DYaUGNeBy56uHYoag/8GaxUGA+vXlkiRpzU+Q4gartbtIaWS5zs2W9cjLUqDBGwiJjsPBO0WeevJNtOvOX053M1GBxm3kmoR/BPsHAd1p+g/Ph/u8w1fpz4pdQEIItaclfL22DxpPWF7WaNEUyYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720111000; c=relaxed/simple;
	bh=Sq5sZlWOJ5cxOL6fNrvlElfWwOopQZLPbYTsSYU7u/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+glnZxDWl9B2Ivq5juoTxhoqUHs+cETI2v2gr/+roF0FxwfPt9qz9MpqgiWkRDdFT1plFGs97wBaXuyWzRXcqDYqgNmtVz7+yr9sDYWzfDEvMgDjbuR7w0dIyQMeCkWzWc5n3aF80oEkaW2vhqufXU7+9T6YmTcpA2uerqfbWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id E251A1C0003;
	Thu,  4 Jul 2024 16:36:26 +0000 (UTC)
Message-ID: <1cd452af-58cd-468c-9bb6-90f67711d0b0@ghiti.fr>
Date: Thu, 4 Jul 2024 18:36:26 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] riscv: Implement cmpxchg8/16() using Zabha
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
 <20240626130347.520750-4-alexghiti@rivosinc.com> <Zn1StcN3H0r/eHjh@andrea>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <Zn1StcN3H0r/eHjh@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr


On 27/06/2024 13:53, Andrea Parri wrote:
>> -#define __arch_cmpxchg_masked(sc_sfx, prepend, append, r, p, o, n)	\
>> +#define __arch_cmpxchg_masked(sc_sfx, cas_sfx, prepend, append, r, p, o, n)	\
>>   ({									\
>> +	__label__ no_zacas, zabha, end;					\
>> +									\
>> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {			\
>> +		asm goto(ALTERNATIVE("j %[no_zacas]", "nop", 0,		\
>> +				     RISCV_ISA_EXT_ZACAS, 1)		\
>> +			 : : : : no_zacas);				\
>> +		asm goto(ALTERNATIVE("nop", "j %[zabha]", 0,		\
>> +				     RISCV_ISA_EXT_ZABHA, 1)		\
>> +			 : : : : zabha);				\
>> +	}								\
>> +									\
>> +no_zacas:;								\
>>   	u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
>>   	ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
>>   	ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
>> @@ -133,6 +145,19 @@
>>   		: "memory");						\
>>   									\
>>   	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
>> +	goto end;							\
>> +									\
>> +zabha:									\
>> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {			\
>> +		__asm__ __volatile__ (					\
>> +			prepend						\
>> +			"	amocas" cas_sfx " %0, %z2, %1\n"	\
>> +			append						\
>> +			: "+&r" (r), "+A" (*(p))			\
>> +			: "rJ" (n)					\
>> +			: "memory");					\
>> +	}								\
>> +end:;									\
>>   })
> I admit that I found this all quite difficult to read; IIUC, this is
> missing an IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) check.


I'm not sure we need the zacas check here, since we could use a 
toolchain that supports zabha but not zacas, run this on a zabha/zacas 
platform and it would work.


>    How about adding
> such a check under the zabha: label (replacing/in place of the second
> IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) check) and moving the corresponding
> asm goto statement there, perhaps as follows? (on top of this patch)


If that makes things clearer for you, sure, I can do that.


>
> Also, the patch presents the first occurrence of RISCV_ISA_EXT_ZABHA;
> perhaps worth moving the hwcap/cpufeature changes from patch #6 here?
>
>    Andrea
>
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index b9a3fdcec919..3c913afec150 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -110,15 +110,12 @@
>   	__label__ no_zacas, zabha, end;					\
>   									\
>   	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {			\
> -		asm goto(ALTERNATIVE("j %[no_zacas]", "nop", 0,		\
> -				     RISCV_ISA_EXT_ZACAS, 1)		\
> -			 : : : : no_zacas);				\
>   		asm goto(ALTERNATIVE("nop", "j %[zabha]", 0,		\
>   				     RISCV_ISA_EXT_ZABHA, 1)		\
>   			 : : : : zabha);				\
>   	}								\
>   									\
> -no_zacas:;								\
> +no_zacas:								\
>   	u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
>   	ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
>   	ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
> @@ -148,16 +145,20 @@ no_zacas:;								\
>   	goto end;							\
>   									\
>   zabha:									\
> -	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {			\


But we need to keep this check, otherwise it would fail to compile on 
toolchains without Zabha support.


> -		__asm__ __volatile__ (					\
> -			prepend						\
> -			"	amocas" cas_sfx " %0, %z2, %1\n"	\
> -			append						\
> -			: "+&r" (r), "+A" (*(p))			\
> -			: "rJ" (n)					\
> -			: "memory");					\
> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZAZAS)) {			\
> +		asm goto(ALTERNATIVE("j %[no_zacas]", "nop", 0,		\
> +				     RISCV_ISA_EXT_ZACAS, 1)		\
> +			 : : : : no_zacas);				\
>   	}								\
> -end:;									\
> +									\
> +	__asm__ __volatile__ (						\
> +		prepend							\
> +		"	amocas" cas_sfx " %0, %z2, %1\n"		\
> +		append							\
> +		: "+&r" (r), "+A" (*(p))				\
> +		: "rJ" (n)						\
> +		: "memory");						\
> +end:									\
>   })
>   
>   #define __arch_cmpxchg(lr_sfx, sc_cas_sfx, prepend, append, r, p, co, o, n)	\
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

