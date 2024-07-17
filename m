Return-Path: <linux-arch+bounces-5471-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 371C6933FBD
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 17:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7D7EB20F14
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 15:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55D3181B94;
	Wed, 17 Jul 2024 15:34:27 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A19D181319;
	Wed, 17 Jul 2024 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721230467; cv=none; b=F5027tTJ+f+qGNuki1XK7k6nG64lr02XHTrsN0Yy6j2+Dwb/4+/hKCQJuaH4ltIZMvRdUqeCio3JdNFUOGcdTxuAVX5AF8Zzwu5m7+U36fyxFka9Nmckm/qDWj83N6cWxizJ9EJYmHPwoSIQt84nAdCS3LICsXq10TBPjv6XpVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721230467; c=relaxed/simple;
	bh=XjqeyxTlTDWQmVBkcZD1JavWHf7v9WcY8L09nw+Tyt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jSJ3VEUgILVNNLIl9usBS5ceKFTjsFiMYe/LspAhgjT4ZcJ13n7xqB+1ypfVR1Me8MWDb2Esl1Ec+seEis6NicsQy9guoLLoU44MFkeLwNrWm3iSJ0g1Wph7IfwV3jjp6rzhklC2MleG7QyW0/SHkxJGdFGPVj+RdDgrgntCA7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 470AD20009;
	Wed, 17 Jul 2024 15:34:20 +0000 (UTC)
Message-ID: <f31da52a-55c4-472d-8056-b3e82feba4f8@ghiti.fr>
Date: Wed, 17 Jul 2024 17:34:19 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] riscv: Implement cmpxchg8/16() using Zabha
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, Andrew Jones <ajones@ventanamicro.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>, Jonathan Corbet
 <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Andrea Parri <parri.andrea@gmail.com>, Nathan Chancellor
 <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
 Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org
References: <20240717061957.140712-1-alexghiti@rivosinc.com>
 <20240717061957.140712-4-alexghiti@rivosinc.com>
 <20240717-e7104dac172d9f2cbc25d9c6@orel>
 <20240717-enroll-snowless-e722e367789b@spud>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240717-enroll-snowless-e722e367789b@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: alex@ghiti.fr

On 17/07/2024 17:29, Conor Dooley wrote:
> On Wed, Jul 17, 2024 at 10:26:34AM -0500, Andrew Jones wrote:
>> On Wed, Jul 17, 2024 at 08:19:49AM GMT, Alexandre Ghiti wrote:
>>> -#define __arch_cmpxchg_masked(sc_sfx, prepend, append, r, p, o, n)	\
>>> +#define __arch_cmpxchg_masked(sc_sfx, cas_sfx, prepend, append, r, p, o, n)	\
>>>   ({									\
>>> +	__label__ no_zabha_zacas, end;					\
>>> +									\
>>> +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&			\
>>> +	    IS_ENABLED(CONFIG_RISCV_ISA_ZACAS)) {			\
>>> +		asm goto(ALTERNATIVE("j %[no_zabha_zacas]", "nop", 0,	\
>>> +				     RISCV_ISA_EXT_ZABHA, 1)		\
>>> +			 : : : : no_zabha_zacas);			\
>>> +		asm goto(ALTERNATIVE("j %[no_zabha_zacas]", "nop", 0,	\
>>> +				     RISCV_ISA_EXT_ZACAS, 1)		\
>>> +			 : : : : no_zabha_zacas);			\
>> I came late to the call, but I guess trying to get rid of these asm gotos
>> was the topic of the discussion. The proposal was to try and use static
>> branches, but keep in mind that we've had trouble with static branches
>> inside macros in the past when those macros are used in many places[1]
>>
>> [1] commit 0b1d60d6dd9e ("riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=y")
> The other half of the suggestion was not using an asm goto, but instead
> trying to patch the whole thing in the alternative, for the problematic
> section with llvm < 17.


And I'm not a big fan of this solution since it would imply patching the 
5-7 instructions for LR/SC into nops which would probably slow (a bit) 
the amocas/amoswap sequence. I agree it should not be that big, but that 
it is just to fix an llvm issue, so not worth it to me!


>>> +									\
>>> +		__asm__ __volatile__ (					\
>>> +			prepend						\
>>> +			"	amocas" cas_sfx " %0, %z2, %1\n"	\
>>> +			append						\
>>> +			: "+&r" (r), "+A" (*(p))			\
>>> +			: "rJ" (n)					\
>>> +			: "memory");					\
>>> +		goto end;						\
>>> +	}								\
>>> +									\
>>> +no_zabha_zacas:;							\
>> unnecessary ;
>>
>>>   	u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
>>>   	ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
>>>   	ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
>>> @@ -133,6 +155,8 @@
>>>   		: "memory");						\
>>>   									\
>>>   	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
>>> +									\
>>> +end:;									\
>>>   })
>>>   
>>>   #define __arch_cmpxchg(lr_sfx, sc_cas_sfx, prepend, append, r, p, co, o, n)	\

