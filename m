Return-Path: <linux-arch+bounces-10903-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E69A64F56
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 13:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E69188F814
	for <lists+linux-arch@lfdr.de>; Mon, 17 Mar 2025 12:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292F6238D32;
	Mon, 17 Mar 2025 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7Ar7yyZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2DF18BC3D;
	Mon, 17 Mar 2025 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215226; cv=none; b=J3E9sKDuBUf4wzyXx272Izo7ldHZ5D6rxLBG4sEc3xoZU+bEy1yUBBxDUWVQqoHbfHUKe3hauj9XCNEtvu0E5z4LNuTh+wTyXNStQvjWj97pPu7/mao0bt03pmwv/ET48+yF58GERfkbPDHtpg7UWNnn1maXp4gL4mVY0D96yX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215226; c=relaxed/simple;
	bh=Qm34pbxAa6RjHCc2A1aXJ4qBOugE70Km6ONzqhDGMKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbXfT+CrxcTqYHciP/HJrGLlKbDsA3OTDjozsfD7Ji2ELgjvAKzTnsJeMnz5Y4+bMi596LHbuef/j0E1RoTNTyEHDan+1tyTfxC8twSQ/IBmsD97aOu3y+BnGpXGuEtHplNIs0iXOaLzF4sbe2aS/eVzPrppEFWVoCpwPOLWSs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7Ar7yyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A338C4CEE9;
	Mon, 17 Mar 2025 12:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742215225;
	bh=Qm34pbxAa6RjHCc2A1aXJ4qBOugE70Km6ONzqhDGMKA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E7Ar7yyZci/sFoCidNgE8WXrHkJCdBUtC5+SBI7ElJU6LgZqLiSvRPlv1xqMCdR+2
	 JdSknt+r47jh4J64JDHOV3bC2f8CCEHU9CwoE9ISsT1r2OFEQaCkooFpGyY2cq0AUS
	 8BJqKWvVNVKmYaiENoybfTCks4OV2Hujobg04vepdZYEAJYEHgTYSVQtuBbCiU49Wg
	 w4Y7etNdGOWGUdqy5s7jSxyR/7rnszsVQfJoCdbVmwcu/WQyL4uucGKWINrXNoVXHO
	 5i4vQUYMXA8gu7KzsUBsrs+oDW3h+voixjT+nCGjato5WHQworTVVXnwjAQoo5sK7c
	 ZdFal0K6UlYKw==
Message-ID: <e3dfe753-fb5f-4f2f-9d24-da8a4f01be19@kernel.org>
Date: Mon, 17 Mar 2025 07:40:20 -0500
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] nios2: move pr_debug() about memory start and
 end to setup_arch()
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Guo Ren
 <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Zijlstra <peterz@infradead.org>,
 Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>,
 Stafford Horne <shorne@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org
References: <20250313135003.836600-1-rppt@kernel.org>
 <20250313135003.836600-7-rppt@kernel.org>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20250313135003.836600-7-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/25 08:49, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> This will help with pulling out memblock_free_all() to the generic
> code and reducing code duplication in arch::mem_init().
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>   arch/nios2/kernel/setup.c | 2 ++
>   arch/nios2/mm/init.c      | 2 --
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
> index da122a5fa43b..a4cffbfc1399 100644
> --- a/arch/nios2/kernel/setup.c
> +++ b/arch/nios2/kernel/setup.c
> @@ -149,6 +149,8 @@ void __init setup_arch(char **cmdline_p)
>   	memory_start = memblock_start_of_DRAM();
>   	memory_end = memblock_end_of_DRAM();
>   
> +	pr_debug("%s: start=%lx, end=%lx\n", __func__, memory_start, memory_end);
> +
>   	setup_initial_init_mm(_stext, _etext, _edata, _end);
>   	init_task.thread.kregs = &fake_regs;
>   
> diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
> index a2278485de19..aa692ad30044 100644
> --- a/arch/nios2/mm/init.c
> +++ b/arch/nios2/mm/init.c
> @@ -65,8 +65,6 @@ void __init mem_init(void)
>   	unsigned long end_mem   = memory_end; /* this must not include
>   						kernel stack at top */
>   
> -	pr_debug("mem_init: start=%lx, end=%lx\n", memory_start, memory_end);
> -
>   	end_mem &= PAGE_MASK;
>   	high_memory = __va(end_mem);
>   

Acked-By: Dinh Nguyen <dinguyen@kernel.org>

