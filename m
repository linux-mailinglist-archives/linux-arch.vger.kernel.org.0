Return-Path: <linux-arch+bounces-1214-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1CA8209ED
	for <lists+linux-arch@lfdr.de>; Sun, 31 Dec 2023 07:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D041C2179A
	for <lists+linux-arch@lfdr.de>; Sun, 31 Dec 2023 06:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FFC33CF;
	Sun, 31 Dec 2023 06:37:39 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A98F33CE;
	Sun, 31 Dec 2023 06:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id CBA7F1C0003;
	Sun, 31 Dec 2023 06:37:33 +0000 (UTC)
Message-ID: <3d36ca3c-9a91-41a7-9e68-288982c2c8a8@ghiti.fr>
Date: Sun, 31 Dec 2023 07:37:33 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] riscv: enable HAVE_FAST_GUP if MMU
Content-Language: en-US
To: Jisheng Zhang <jszhang@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Will Deacon <will@kernel.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <20231219175046.2496-1-jszhang@kernel.org>
 <20231219175046.2496-5-jszhang@kernel.org>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20231219175046.2496-5-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

On 19/12/2023 18:50, Jisheng Zhang wrote:
> Activate the fast gup for riscv mmu platforms. Here are some
> GUP_FAST_BENCHMARK performance numbers:
>
> Before the patch:
> GUP_FAST_BENCHMARK: Time: get:53203 put:5085 us
>
> After the patch:
> GUP_FAST_BENCHMARK: Time: get:17711 put:5060 us


On which platform did you run this benchmark?


>
> The get time is reduced by 66.7%! IOW, 3x get speed!


Well done!

Thanks,

Alex


>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   arch/riscv/Kconfig               | 1 +
>   arch/riscv/include/asm/pgtable.h | 6 ++++++
>   2 files changed, 7 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d3555173d9f4..04df9920282d 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -119,6 +119,7 @@ config RISCV
>   	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
>   	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
>   	select HAVE_EBPF_JIT if MMU
> +	select HAVE_FAST_GUP if MMU
>   	select HAVE_FUNCTION_ARG_ACCESS_API
>   	select HAVE_FUNCTION_ERROR_INJECTION
>   	select HAVE_GCC_PLUGINS
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index ab00235b018f..c6eb214139e6 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -673,6 +673,12 @@ static inline int pmd_write(pmd_t pmd)
>   	return pte_write(pmd_pte(pmd));
>   }
>   
> +#define pud_write pud_write
> +static inline int pud_write(pud_t pud)
> +{
> +	return pte_write(pud_pte(pud));
> +}
> +
>   static inline int pmd_dirty(pmd_t pmd)
>   {
>   	return pte_dirty(pmd_pte(pmd));

