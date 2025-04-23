Return-Path: <linux-arch+bounces-11514-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB97A98824
	for <lists+linux-arch@lfdr.de>; Wed, 23 Apr 2025 13:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315E97A489D
	for <lists+linux-arch@lfdr.de>; Wed, 23 Apr 2025 11:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C1C25C83E;
	Wed, 23 Apr 2025 11:08:51 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8E9215F48;
	Wed, 23 Apr 2025 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745406531; cv=none; b=Hu/t9djbEjSG+BeyhoA8p2eqGzNaMIS+y+s/IrdnffI0eOau1cT/15jEhpI7zZ2kF+GsdiI1vbojctGhYkq3mBff467Jm5pfy2GWDJXd1pN1QsokS2hgdQc/hxtqe3yVHhRCOfmho03+eFmj7sWYYrRfX1R8QA0pt1426V4PGtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745406531; c=relaxed/simple;
	bh=RnnG84anotKGAVOmE/Y2MzxczrfxkF2+Ipgfx+N2wL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KlImcGZawzrsVnNHY86G+ESfGWcXTp4FGz4reqPM1wF9+iDIA+i3z3n4YQM3k2TUQuzpMTmMqum41ng/rJudItvyHEd/NHwXwIcZB8fQiFtnRp7prjmYYDT/YOv46CtTN+90aXs4yaqL65o9mjLDBHlUGoSdnhom0foGDRBtCEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7B00943892;
	Wed, 23 Apr 2025 11:08:43 +0000 (UTC)
Message-ID: <66a5aba9-2a32-4ef9-a839-a389b975757d@ghiti.fr>
Date: Wed, 23 Apr 2025 13:08:42 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] riscv: introduce asm/swab.h
Content-Language: en-US
To: Ignacio Encinas <ignacio@iencinas.com>, Arnd Bergmann <arnd@arndb.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>,
 Zhihang Shao <zhihang.shao.iscas@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
References: <20250403-riscv-swab-v3-0-3bf705d80e33@iencinas.com>
 <20250403-riscv-swab-v3-2-3bf705d80e33@iencinas.com>
 <c6efcdca-5739-42b6-8cb4-f4d8cc85b6af@app.fastmail.com>
 <b3f8e641-9690-4792-974c-c895d2e4531a@iencinas.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <b3f8e641-9690-4792-974c-c895d2e4531a@iencinas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeigeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeejkeeugfdthefhveelffdvgeetgeelteeijeekheehfeevtdduvdfgteevgfehffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhinhhfrhgruggvrggurdhorhhgnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemtgeludgrmegtkeehvgemtgduuddtmeekuggvvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemtgeludgrmegtkeehvgemtgduuddtmeekuggvvddphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemtgeludgrmegtkeehvgemtgduuddtmeekuggvvdgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohepihhgnhgrtghiohesihgvnhgtihhnrghsrdgtohhmpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgtp
 hhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegvsghighhgvghrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhdqmhgvnhhtvggvsheslhhishhtshdrlhhinhhugidruggvvh
X-GND-Sasl: alex@ghiti.fr

Hi Ignacio,

On 04/04/2025 19:35, Ignacio Encinas wrote:
>
> On 4/4/25 7:58, Arnd Bergmann wrote:
>> On Thu, Apr 3, 2025, at 22:34, Ignacio Encinas wrote:
>>> +#define ARCH_SWAB(size) \
>>> +static __always_inline unsigned long __arch_swab##size(__u##size value) \
>>> +{									\
>>> +	unsigned long x = value;					\
>>> +									\
>>> +	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZBB)) {            \
>>> +		asm volatile (".option push\n"				\
>>> +			      ".option arch,+zbb\n"			\
>>> +			      "rev8 %0, %1\n"				\
>>> +			      ".option pop\n"				\
>>> +			      : "=r" (x) : "r" (x));			\
>>> +		return x >> (BITS_PER_LONG - size);			\
>>> +	}                                                               \
>>> +	return  ___constant_swab##size(value);				\
>>> +}
> Hello Arnd!
>
>> I think the fallback should really just use the __builtin_bswap
>> helpers instead of the ___constant_swab variants. The output
>> would be the same, but you can skip patch 1/2.
> I tried, but that change causes build errors:
>
> ```
> undefined reference to `__bswapsi2'
>
> [...]
>
> undefined reference to `__bswapdi2
> ```
>
> I tried working around those, but couldn't find a good solution. I'm a
> bit out of my depth here, but I "summarized" everything here [1]. Let me
> know if I'm missing something.
>
> [1] https://lore.kernel.org/linux-riscv/b3b59747-0484-4042-bdc4-c067688e3bfe@iencinas.com/

Note that I only encountered those issues in the purgatory.

So to me we have 3 solutions:

- either implementing both __bswapsi2 and __bswapdi2

- or linking against libgcc

- or merging patch 1.

Given the explanation in commit d67703a8a69e ("arm64: kill off the 
libgcc dependency"), I would not use libgcc.

The less intrusive solution (for us riscv) is merging patch 1.

But please let me know if I missed another solution or if I'm wrong.

Thanks,

Alex


>
>> I would also suggest dumbing down the macro a bit so you can
>> still find the definition with 'git grep __arch_swab64'. Ideally
>> just put the function body into a macro but leave the three
>> separate inline function definitions.
> Good point, thanks for bringing it up. Just to be sure, is this what you
> had in mind? (Give or take formatting + naming of variables)
>
> #define arch_swab(size, value) 						\
> ({                      						\
> 	unsigned long x = value;					\
> 									\
> 	if (riscv_has_extension_likely(RISCV_ISA_EXT_ZBB)) {            \
> 		asm volatile (".option push\n"				\
> 			      ".option arch,+zbb\n"			\
> 			      "rev8 %0, %1\n"				\
> 			      ".option pop\n"				\
> 			      : "=r" (x) : "r" (x));			\
> 		x = x >> (BITS_PER_LONG - size);			\
> 	} else {                                                        \
> 		x = ___constant_swab##size(value);                      \
> 	}								\
> 	x;								\
> })
>
> static __always_inline unsigned long __arch_swab64(__u64 value) {
> 	return arch_swab(64, value);
> }
>
> Thanks!
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

