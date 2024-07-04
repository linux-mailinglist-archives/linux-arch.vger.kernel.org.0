Return-Path: <linux-arch+bounces-5267-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF50B927B16
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 18:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B06D284D91
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 16:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E701B372D;
	Thu,  4 Jul 2024 16:25:50 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585624C70;
	Thu,  4 Jul 2024 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720110350; cv=none; b=JHb5rBPzDbpTfwZ0IrtDg9Ifc9styiGfLQjq+Rtnl5fwJi+JAQ85bMoic8wsXTt0+0Fn9elMlzcN3V1342hUqLefxVbMDHXAjbK2zoor2Hf23le0vFoi19qZXPwhmI8THVO9ffk7YYVMtyRQPBjfm3cRIa9vCIu3CA8wCjIQ0bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720110350; c=relaxed/simple;
	bh=urYl2qAAR3+WhRDpnGu1Hivo8REdcNHMRzQA897vT9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qp3Av14b90T2oOgf3AJ4DaVJdPlySEsZomv7SCrS/8MFz180wE0EQ4GBU857zcXS51F+p51MG6mJu273nQhgHD0TS7chFXL85pW7IcBx+fl+LMqaScgDaFibRm4Qkc/Fp0i9oDhLRotJ+gZgIqc+HMDaPpHnLP8iVJGP/j7hvm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 076E52000A;
	Thu,  4 Jul 2024 16:25:41 +0000 (UTC)
Message-ID: <4008aeca-352f-489e-ba07-7a11f5ab7ccb@ghiti.fr>
Date: Thu, 4 Jul 2024 18:25:41 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] riscv: Implement cmpxchg32/64() using Zacas
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
 <20240626130347.520750-2-alexghiti@rivosinc.com> <Zn1Hwpcamaz1YaEM@andrea>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <Zn1Hwpcamaz1YaEM@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Andrea,

On 27/06/2024 13:06, Andrea Parri wrote:
>> -#define __arch_cmpxchg(lr_sfx, sc_sfx, prepend, append, r, p, co, o, n)	\
>> +#define __arch_cmpxchg(lr_sfx, sc_cas_sfx, prepend, append, r, p, co, o, n)	\
>>   ({									\
>> +	__label__ zacas, end;						\
>>   	register unsigned int __rc;					\
>>   									\
>> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZACAS)) {			\
>> +		asm goto(ALTERNATIVE("nop", "j %[zacas]", 0,		\
>> +				     RISCV_ISA_EXT_ZACAS, 1)		\
>> +			 : : : : zacas);				\
>> +	}								\
>> +									\
>>   	__asm__ __volatile__ (						\
>>   		prepend							\
>>   		"0:	lr" lr_sfx " %0, %2\n"				\
>>   		"	bne  %0, %z3, 1f\n"				\
>> -		"	sc" sc_sfx " %1, %z4, %2\n"			\
>> +		"	sc" sc_cas_sfx " %1, %z4, %2\n"			\
>>   		"	bnez %1, 0b\n"					\
>>   		append							\
>>   		"1:\n"							\
>>   		: "=&r" (r), "=&r" (__rc), "+A" (*(p))			\
>>   		: "rJ" (co o), "rJ" (n)					\
>>   		: "memory");						\
>> +	goto end;							\
>> +									\
>> +zacas:									\
>> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZACAS)) {			\
>> +		__asm__ __volatile__ (					\
>> +			prepend						\
>> +			"	amocas" sc_cas_sfx " %0, %z2, %1\n"	\
>> +			append						\
>> +			: "+&r" (r), "+A" (*(p))			\
>> +			: "rJ" (n)					\
>> +			: "memory");					\
>> +	}								\
> Is this second IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) check actually needed?
> (just wondering - no real objection)


To me yes, otherwise a toolchain without zacas support would fail to 
assemble the amocas instruction.


>
>
>> +end:;									\
> Why the semicolon?


That fixes a clang warning reported by Nathan here: 
https://lore.kernel.org/linux-riscv/20240528193110.GA2196855@thelio-3990X/


>
>
>>   })
>>   
>>   #define _arch_cmpxchg(ptr, old, new, sc_sfx, prepend, append)		\
>> @@ -156,7 +177,7 @@
>>   	__typeof__(ptr) __ptr = (ptr);					\
>>   	__typeof__(*(__ptr)) __old = (old);				\
>>   	__typeof__(*(__ptr)) __new = (new);				\
>> -	__typeof__(*(__ptr)) __ret;					\
>> +	__typeof__(*(__ptr)) __ret = (old);				\
> This is because the compiler doesn't realize __ret is actually
> initialized, right?  IAC, seems a bit unexpected to initialize
> with (old) (which indicates SUCCESS of the CMPXCHG operation);
> how about using (new) for the initialization of __ret instead?
> would (new) still work for you?


But amocas rd register must contain the expected old value in order to 
actually work right?


>
>    Andrea
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

