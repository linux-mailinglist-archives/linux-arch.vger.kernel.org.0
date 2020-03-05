Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA39917AA65
	for <lists+linux-arch@lfdr.de>; Thu,  5 Mar 2020 17:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgCEQVi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Mar 2020 11:21:38 -0500
Received: from foss.arm.com ([217.140.110.172]:50794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgCEQVi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Mar 2020 11:21:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2002530E;
        Thu,  5 Mar 2020 08:21:37 -0800 (PST)
Received: from [10.1.195.32] (e112269-lin.cambridge.arm.com [10.1.195.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C34233F534;
        Thu,  5 Mar 2020 08:21:35 -0800 (PST)
Subject: Re: [PATCH v2 04/19] arm64: mte: Use Normal Tagged attributes for the
 linear map
To:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
References: <20200226180526.3272848-1-catalin.marinas@arm.com>
 <20200226180526.3272848-5-catalin.marinas@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <946fcd05-ba8f-90ec-d30b-458b327df59c@arm.com>
Date:   Thu, 5 Mar 2020 16:21:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200226180526.3272848-5-catalin.marinas@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 26/02/2020 18:05, Catalin Marinas wrote:
> Once user space is given access to tagged memory, the kernel must be
> able to clear/save/restore tags visible to the user. This is done via
> the linear mapping, therefore map it as such. The new MT_NORMAL_TAGGED
> index for MAIR_EL1 is initially mapped as Normal memory and later
> changed to Normal Tagged via the cpufeature infrastructure. From a
> mismatched attribute aliases perspective, the Tagged memory is
> considered a permission and it won't lead to undefined behaviour.
> 
> The empty_zero_page is cleared to ensure that the tags it contains are
> already zeroed. The actual tags-aware clear_page() implementation is
> part of a subsequent patch.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/include/asm/memory.h       |  1 +
>  arch/arm64/include/asm/pgtable-prot.h |  2 ++
>  arch/arm64/kernel/cpufeature.c        | 30 +++++++++++++++++++++++++++
>  arch/arm64/mm/dump.c                  |  4 ++++
>  arch/arm64/mm/mmu.c                   | 22 ++++++++++++++++++--
>  arch/arm64/mm/proc.S                  |  8 +++++--
>  6 files changed, 63 insertions(+), 4 deletions(-)
> 
[...]
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 128f70852bf3..a2c206444e47 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -120,7 +120,7 @@ static bool pgattr_change_is_safe(u64 old, u64 new)
>  	 * The following mapping attributes may be updated in live
>  	 * kernel mappings without the need for break-before-make.
>  	 */
> -	static const pteval_t mask = PTE_PXN | PTE_RDONLY | PTE_WRITE | PTE_NG;
> +	pteval_t mask = PTE_PXN | PTE_RDONLY | PTE_WRITE | PTE_NG;
>  
>  	/* creating or taking down mappings is always safe */
>  	if (old == 0 || new == 0)
> @@ -134,6 +134,19 @@ static bool pgattr_change_is_safe(u64 old, u64 new)
>  	if (old & ~new & PTE_NG)
>  		return false;
>  
> +	if (system_supports_mte()) {
> +		/*
> +		 * Changing the memory type between Normal and Normal-Tagged
> +		 * is safe since Tagged is considered a permission attribute
> +		 * from the mismatched attribute aliases perspective.
> +		 */
> +		if ((old & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL) ||
> +		    (old & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL_TAGGED) ||
> +		    (new & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL) ||
> +		    (new & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL_TAGGED))
> +			mask |= PTE_ATTRINDX_MASK;
> +	}
> +
>  	return ((old ^ new) & ~mask) == 0;
>  }

This is much more permissive than I would expect. If either the old or
new memory type is NORMAL (or NORMAL_TAGGED) then the memory type is
ignored altogether.

Should this check be:

if (((old & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL) ||
     (old & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL_TAGGED)) &&
    ((new & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL) ||
     (new & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL_TAGGED)))

Steve
