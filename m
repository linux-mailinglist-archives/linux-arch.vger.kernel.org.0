Return-Path: <linux-arch+bounces-13090-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A480B1DA24
	for <lists+linux-arch@lfdr.de>; Thu,  7 Aug 2025 16:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C67561DEC
	for <lists+linux-arch@lfdr.de>; Thu,  7 Aug 2025 14:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC93264A9D;
	Thu,  7 Aug 2025 14:43:23 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE8262FF8;
	Thu,  7 Aug 2025 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754577803; cv=none; b=dEED8LkZu/EpkzJXBhwRQ8b99IAGOmNEfhBW5EY7xE8EO6oxmaS62Dwu7UdMjSvtHW00HVRRjWRVV81REiNj9KzpzLx4JdPV5uXIsPl54a0Lk4/VV38uk9b9mopdXJqb3j2bet5qeU1x5WbmigJTdaqrUxnySV60J3AwB6tKAKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754577803; c=relaxed/simple;
	bh=y//IMsBANN67YjgRvFs1TqJNvAqanY/RR7wYOqvwarQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j072cA7J2Xq6pyO2GSQS4o81rGlMfPRyEpUD/o+fZ6v5th8youJk50D4N1/pqeXoYf2GRFgN6dyqDKS8k5gGp2ioh2Mp1N7PBMFwkTpZ9l1wP37Cn1gt7Q1Wo7I33uBjniH3qTRT63NDXNymUAvGo3QqPjH5D/tIrUgmxkph27k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id D90BA4432A;
	Thu,  7 Aug 2025 14:43:12 +0000 (UTC)
Message-ID: <53b98e1e-4f7e-4320-8d04-d84dd2c4092d@ghiti.fr>
Date: Thu, 7 Aug 2025 16:43:09 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/17] riscv: Add __attribute_const__ to ffs()-family
 implementations
To: Kees Cook <kees@kernel.org>, linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org
References: <20250804163910.work.929-kees@kernel.org>
 <20250804164417.1612371-9-kees@kernel.org>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250804164417.1612371-9-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeehiefhuddtuddukeetkeehhedtffduhfevfeeftdefveffgfeuffejjeejfeekueenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemlehftghfmeeksghfleemleeludgumeekrggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemlehftghfmeeksghfleemleeludgumeekrggrfhdphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemlehftghfmeeksghfleemleeludgumeekrggrfhgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepudekpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehli
 hhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrlhhphhgrsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghskhihsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqhhgvgigrghhonhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmieekkheslhhishhtshdrlhhinhhugidqmheikehkrdhorhhg
X-GND-Sasl: alex@ghiti.fr

Hi Kees,

On 8/4/25 18:44, Kees Cook wrote:
> While tracking down a problem where constant expressions used by
> BUILD_BUG_ON() suddenly stopped working[1], we found that an added static
> initializer was convincing the compiler that it couldn't track the state
> of the prior statically initialized value. Tracing this down found that
> ffs() was used in the initializer macro, but since it wasn't marked with
> __attribute__const__, the compiler had to assume the function might
> change variable states as a side-effect (which is not true for ffs(),
> which provides deterministic math results).
>
> Add missing __attribute_const__ annotations to RISC-V's implementations of
> variable__ffs(), variable__fls(), and variable_ffs() functions. These are pure
> mathematical functions that always return the same result for the same
> input with no side effects, making them eligible for compiler optimization.
>
> Build tested ARCH=riscv defconfig with GCC riscv64-linux-gnu 14.2.0.
>
> Link: https://github.com/KSPP/linux/issues/364 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>   arch/riscv/include/asm/bitops.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
> index d59310f74c2b..77880677b06e 100644
> --- a/arch/riscv/include/asm/bitops.h
> +++ b/arch/riscv/include/asm/bitops.h
> @@ -45,7 +45,7 @@
>   #error "Unexpected BITS_PER_LONG"
>   #endif
>   
> -static __always_inline unsigned long variable__ffs(unsigned long word)
> +static __always_inline __attribute_const__ unsigned long variable__ffs(unsigned long word)
>   {
>   	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
>   				      RISCV_ISA_EXT_ZBB, 1)
> @@ -74,7 +74,7 @@ static __always_inline unsigned long variable__ffs(unsigned long word)
>   	 (unsigned long)__builtin_ctzl(word) :	\
>   	 variable__ffs(word))
>   
> -static __always_inline unsigned long variable__fls(unsigned long word)
> +static __always_inline __attribute_const__ unsigned long variable__fls(unsigned long word)
>   {
>   	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
>   				      RISCV_ISA_EXT_ZBB, 1)
> @@ -103,7 +103,7 @@ static __always_inline unsigned long variable__fls(unsigned long word)
>   	 (unsigned long)(BITS_PER_LONG - 1 - __builtin_clzl(word)) :	\
>   	 variable__fls(word))
>   
> -static __always_inline int variable_ffs(int x)
> +static __always_inline __attribute_const__ int variable_ffs(int x)
>   {
>   	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
>   				      RISCV_ISA_EXT_ZBB, 1)


Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Acked-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex



