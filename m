Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99CAD1A218F
	for <lists+linux-arch@lfdr.de>; Wed,  8 Apr 2020 14:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgDHMSP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Apr 2020 08:18:15 -0400
Received: from foss.arm.com ([217.140.110.172]:38012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbgDHMSP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Apr 2020 08:18:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94ADC31B;
        Wed,  8 Apr 2020 05:18:12 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3217A3F73D;
        Wed,  8 Apr 2020 05:18:09 -0700 (PDT)
Date:   Wed, 8 Apr 2020 13:18:02 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, x86@kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com
Subject: Re: [PATCH 26/28] arm64: use __vmalloc_node in arch_alloc_vmap_stack
Message-ID: <20200408121802.GA36478@lakrids.cambridge.arm.com>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-27-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408115926.1467567-27-hch@lst.de>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 08, 2020 at 01:59:24PM +0200, Christoph Hellwig wrote:
> arch_alloc_vmap_stack can use a slightly higher level vmalloc function.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/vmap_stack.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/vmap_stack.h b/arch/arm64/include/asm/vmap_stack.h
> index 0a12115d9638..0cc6636e3f15 100644
> --- a/arch/arm64/include/asm/vmap_stack.h
> +++ b/arch/arm64/include/asm/vmap_stack.h
> @@ -19,10 +19,8 @@ static inline unsigned long *arch_alloc_vmap_stack(size_t stack_size, int node)
>  {
>  	BUILD_BUG_ON(!IS_ENABLED(CONFIG_VMAP_STACK));
>  
> -	return __vmalloc_node_range(stack_size, THREAD_ALIGN,
> -				    VMALLOC_START, VMALLOC_END,
> -				    THREADINFO_GFP, PAGE_KERNEL, 0, node,
> -				    __builtin_return_address(0));
> +	return __vmalloc_node(stack_size, THREAD_ALIGN, THREADINFO_GFP, node,
> +			__builtin_return_address(0));
>  }
>  
>  #endif /* __ASM_VMAP_STACK_H */
> -- 
> 2.25.1
> 
