Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C262478AB0
	for <lists+linux-arch@lfdr.de>; Fri, 17 Dec 2021 12:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhLQL7W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Dec 2021 06:59:22 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53704 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhLQL7W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Dec 2021 06:59:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 070BC62153;
        Fri, 17 Dec 2021 11:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FE9C36AE5;
        Fri, 17 Dec 2021 11:59:19 +0000 (UTC)
Date:   Fri, 17 Dec 2021 11:59:16 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        moyufeng@huawei.com, linux-arch@vger.kernel.org
Subject: Re: [PATCH] asm-generic: introduce io_stop_wc() and add
 implementation for ARM64
Message-ID: <Ybx7lEF4srH4vBmh@arm.com>
References: <20211217085611.111999-1-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217085611.111999-1-wangxiongfeng2@huawei.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 17, 2021 at 04:56:11PM +0800, Xiongfeng Wang wrote:
> For memory accesses with Normal-Non Cacheable attributes, the CPU may do

You may want to mention "arm64 Normal Non-Cacheable" as other
architectures have a different meaning of NC.

> write combining. But in some situation, this is bad for the performance
> because the prior access may wait too long just to be merged.
> 
> We introduce io_stop_wc() to prevent the Normal-NC memory accesses before
> this instruction to be merged with memory accesses after this
> instruction.
> 
> We add implementation for ARM64 using DGH instruction and provide NOP
> implementation for other architectures.
> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  Documentation/memory-barriers.txt |  9 +++++++++
>  arch/arm64/include/asm/barrier.h  |  9 +++++++++
>  include/asm-generic/barrier.h     | 11 +++++++++++
>  3 files changed, 29 insertions(+)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 7367ada13208..b868b51b1801 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1950,6 +1950,15 @@ There are some more advanced barrier functions:
>       For load from persistent memory, existing read memory barriers are sufficient
>       to ensure read ordering.
>  
> + (*) io_stop_wc();
> +
> +     For memory accesses with Normal-Non Cacheable attributes (e.g. those
> +     returned by ioremap_wc()), the CPU may do write combining. But in some
> +     situation, this is bad for the performance because the prior access may
> +     wait too long just to be merged. io_stop_wc() can be used to prevent
> +     merging memory accesses with Normal-Non Cacheable attributes before this
> +     instruction with any memory accesses appearing after this instruction.

I'm fine with the patch in general but the comment here and in
asm-generic/barrier.h should avoid Normal Non-Cacheable as that's an
arm-specific term. Looking at Documentation/driver-api/device-io.rst, we
could simply say "write-combining". Something like:

     For memory accesses with write-combining attributes (e.g. those
     returned by ioremap_wc()), the CPU may wait for prior accesses to
     be merged with subsequent ones. io_stop_wc() can be used to prevent
     the merging of write-combining memory accesses before this macro
     with those after it when such wait has performance implications.

(feel free to rephrase it but avoid Normal NC here)

> +
>  ===============================
>  IMPLICIT KERNEL MEMORY BARRIERS
>  ===============================
> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index 1c5a00598458..62217be36217 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -26,6 +26,14 @@
>  #define __tsb_csync()	asm volatile("hint #18" : : : "memory")
>  #define csdb()		asm volatile("hint #20" : : : "memory")
>  
> +/*
> + * Data Gathering Hint:
> + * This instruction prevents merging memory accesses with Normal-NC or
> + * Device-GRE attributes before the hint instruction with any memory accesses
> + * appearing after the hint instruction.
> + */
> +#define dgh()		asm volatile("hint #6" : : : "memory")

This is fine, arm-specific code.

> +
>  #ifdef CONFIG_ARM64_PSEUDO_NMI
>  #define pmr_sync()						\
>  	do {							\
> @@ -46,6 +54,7 @@
>  #define dma_rmb()	dmb(oshld)
>  #define dma_wmb()	dmb(oshst)
>  
> +#define io_stop_wc()	dgh()
>  
>  #define tsb_csync()								\
>  	do {									\
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index 640f09479bdf..083be6d34cb9 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -251,5 +251,16 @@ do {									\
>  #define pmem_wmb()	wmb()
>  #endif
>  
> +/*
> + * ioremap_wc() maps I/O memory as memory with Normal-Non Cacheable attributes.
> + * The CPU may do write combining for this kind of memory access. io_stop_wc()
> + * prevents merging memory accesses with Normal-Non Cacheable attributes
> + * before this instruction with any memory accesses appearing after this
> + * instruction.

Please change this as well along the lines of my comment above.

> + */
> +#ifndef io_stop_wc
> +#define io_stop_wc do { } while (0)
> +#endif
> +
>  #endif /* !__ASSEMBLY__ */
>  #endif /* __ASM_GENERIC_BARRIER_H */

Thanks.

-- 
Catalin
