Return-Path: <linux-arch+bounces-1210-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63218820830
	for <lists+linux-arch@lfdr.de>; Sat, 30 Dec 2023 19:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DCB41C20965
	for <lists+linux-arch@lfdr.de>; Sat, 30 Dec 2023 18:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004AABA37;
	Sat, 30 Dec 2023 18:26:30 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1A4BA33;
	Sat, 30 Dec 2023 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56F6B240003;
	Sat, 30 Dec 2023 18:26:12 +0000 (UTC)
Message-ID: <e227f095-0c3d-43c4-8ba3-8ec1b925b929@ghiti.fr>
Date: Sat, 30 Dec 2023 19:26:11 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] riscv: tlb: avoid tlb flushing if fullmm == 1
To: Jisheng Zhang <jszhang@kernel.org>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20231228084642.1765-1-jszhang@kernel.org>
 <20231228084642.1765-3-jszhang@kernel.org>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20231228084642.1765-3-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Jisheng,

On 28/12/2023 09:46, Jisheng Zhang wrote:
> The mmu_gather code sets fullmm=1 when tearing down the entire address
> space for an mm_struct on exit or execve. So if the underlying platform
> supports ASID, the tlb flushing can be avoided because the ASID
> allocator will never re-allocate a dirty ASID.
>
> Use the performance of Process creation in unixbench on T-HEAD TH1520
> platform is improved by about 4%.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   arch/riscv/include/asm/tlb.h | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
> index 1eb5682b2af6..35f3c214332e 100644
> --- a/arch/riscv/include/asm/tlb.h
> +++ b/arch/riscv/include/asm/tlb.h
> @@ -12,10 +12,19 @@ static void tlb_flush(struct mmu_gather *tlb);
>   
>   #define tlb_flush tlb_flush
>   #include <asm-generic/tlb.h>
> +#include <asm/mmu_context.h>
>   
>   static inline void tlb_flush(struct mmu_gather *tlb)
>   {
>   #ifdef CONFIG_MMU
> +	/*
> +	 * If ASID is supported, the ASID allocator will either invalidate the
> +	 * ASID or mark it as used. So we can avoid TLB invalidation when
> +	 * pulling down a full mm.
> +	 */


Given the number of bits are limited for the ASID, at some point we'll 
reuse previously allocated ASID so the ASID allocator must make sure to 
invalidate the entries when reusing an ASID: can you point where this is 
done?

Thanks,

Alex


> +	if (static_branch_likely(&use_asid_allocator) && tlb->fullmm)
> +		return;
> +
>   	if (tlb->fullmm || tlb->need_flush_all)
>   		flush_tlb_mm(tlb->mm);
>   	else

