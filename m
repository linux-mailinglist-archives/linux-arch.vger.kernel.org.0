Return-Path: <linux-arch+bounces-11974-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E40AB9F99
	for <lists+linux-arch@lfdr.de>; Fri, 16 May 2025 17:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E71E9E4D13
	for <lists+linux-arch@lfdr.de>; Fri, 16 May 2025 15:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8821A3178;
	Fri, 16 May 2025 15:09:54 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17E21B042E;
	Fri, 16 May 2025 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747408194; cv=none; b=l99aVr6vU1WeTdCmXxEBEBGpm54hVgEX7Azfx7EwF8mebwDw15G34Htc355s0uzD3k7r1zTHi96AEOlUyfSv5KfZcrqWMxrMCy9ahtnnvasbCsww9f72KPt+eM8hfGXzRjka/bD1TMl+w5VnLiZXbUm0sGs2EYQ85hQBa0KZ0h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747408194; c=relaxed/simple;
	bh=TPg/XiOw3gdSUlzUnbmxtHDybOQJj2VRxVK1TxJR0Zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/I4H6m+EmAlveyJU+Mba2iTY/E+6o+1fuOBYP21yKgKNL3ic/OxUmfZyaX4NqdBxwuAmRfxMxUBuo4EDfEXIqzDEX58MvuZ9nc4x1K4KEsDE+gypyQqsIzeKC0XoPSLYVZGk1AzBF2QjrGJvIXSNjTctMQac/UZT4c9TEuYIyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 366ED43AE3;
	Fri, 16 May 2025 15:09:47 +0000 (UTC)
Message-ID: <6886cf50-1a05-4ebd-bf8c-1afa652e8c89@ghiti.fr>
Date: Fri, 16 May 2025 17:09:46 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] bugs/riscv: Concatenate 'cond_str' with '__FILE__'
 in __BUG_FLAGS(), to extend WARN_ON/BUG_ON output
Content-Language: en-US
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org
References: <20250515124644.2958810-1-mingo@kernel.org>
 <20250515124644.2958810-13-mingo@kernel.org>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250515124644.2958810-13-mingo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudeftdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedthfelfeejgeehveegleejleelgfevhfekieffkeeujeetfedvvefhledvgeegieenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmegsieguheemgehfudelmeeirgeludemjeekfhdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmegsieguheemgehfudelmeeirgeludemjeekfhdtpdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmegsieguheemgehfudelmeeirgeludemjeekfhdtngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepmhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhun
 hgurghtihhonhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughu
X-GND-Sasl: alex@ghiti.fr

Hi Ingo,

On 15/05/2025 14:46, Ingo Molnar wrote:
> Extend WARN_ON and BUG_ON style output from:
>
>    WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:8511 sched_init+0x20/0x410
>
> to:
>
>    WARNING: CPU: 0 PID: 0 at [idx < 0 && ptr] kernel/sched/core.c:8511 sched_init+0x20/0x410
>
> Note that the output will be further reorganized later in this series.
>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Alexandre Ghiti <alex@ghiti.fr>
> Cc: linux-riscv@lists.infradead.org
> Cc: <linux-arch@vger.kernel.org>
> ---
>   arch/riscv/include/asm/bug.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
> index feaf456d465b..da9b8e83934d 100644
> --- a/arch/riscv/include/asm/bug.h
> +++ b/arch/riscv/include/asm/bug.h
> @@ -61,7 +61,7 @@ do {								\
>   			".org 2b + %3\n\t"                      \
>   			".popsection"				\
>   		:						\
> -		: "i" (__FILE__), "i" (__LINE__),		\
> +		: "i" (WARN_CONDITION_STR(cond_str) __FILE__), "i" (__LINE__),	\
>   		  "i" (flags),					\
>   		  "i" (sizeof(struct bug_entry)));              \
>   } while (0)

I have added a dummy WARN_ON_ONCE(pgtable_l5_enabled == true) and I get 
the following output:

WARNING: [pgtable_l5_enabled == true] arch/riscv/kernel/setup.c:364 at 
setup_arch+0x6c4/0x704, CPU#0: swapper/0

So you can add for riscv:

Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com> # riscv

Thanks,

Alex




