Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146D61B08F7
	for <lists+linux-arch@lfdr.de>; Mon, 20 Apr 2020 14:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgDTMMD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Apr 2020 08:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726262AbgDTMMD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Apr 2020 08:12:03 -0400
X-Greylist: delayed 1450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Apr 2020 05:12:02 PDT
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B118BC061A0C;
        Mon, 20 Apr 2020 05:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hyyhVGnvFilfrdqHNEg1EViEFDU1g/FpAPCa//Vm+Ms=; b=Ro0x8c1X2BeWf7TvQCOYH/vp3B
        u8UbmQW+uedKRoJDHljAHvWQiYcHgwyhXDsYpGMGpRc80vsD3ENgjZpqt4uTgcirKDrKKeGgWYAyY
        ZdLOtoEXXnkEIIYIgtOd2v44QGGlsqtBytg1uHI4aUjAP+tySOzwCO0pMaNI4vnP8sO/U4uyY/AYw
        d38ygCc2ptooChKwRxRBjX+o9uNLnCDhAgfbMRqM/V6UxIBMCZfakSu78Qm33nl6LrUeHJ2hefPO1
        vEJIvFQvXjsgirK1UOM25FkhTaoPeJvqbvqpKGNGES42UZvmNSpym3h0VhGh8VlZkE+EvNJc7cHTL
        DqHfGkfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQVGL-0004t8-1H; Mon, 20 Apr 2020 12:10:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D050B3024EA;
        Mon, 20 Apr 2020 14:10:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C09EF2B8DAF8C; Mon, 20 Apr 2020 14:10:55 +0200 (CEST)
Date:   Mon, 20 Apr 2020 14:10:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org,
        maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de,
        yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com,
        broonie@kernel.org, guohanjun@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org,
        xiexiangyou@huawei.com, prime.zeng@hisilicon.com,
        zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
Subject: Re: [PATCH v1 6/6] arm64: tlb: Set the TTL field in flush_tlb_range
Message-ID: <20200420121055.GF20696@hirez.programming.kicks-ass.net>
References: <20200403090048.938-1-yezhenyu2@huawei.com>
 <20200403090048.938-7-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403090048.938-7-yezhenyu2@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 03, 2020 at 05:00:48PM +0800, Zhenyu Ye wrote:
> This patch uses the cleared_* in struct mmu_gather to set the
> TTL field in flush_tlb_range().
> 
> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
> ---
>  arch/arm64/include/asm/tlb.h      | 26 +++++++++++++++++++++++++-
>  arch/arm64/include/asm/tlbflush.h | 14 ++++++++------
>  2 files changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
> index b76df828e6b7..d5ab72eccff4 100644
> --- a/arch/arm64/include/asm/tlb.h
> +++ b/arch/arm64/include/asm/tlb.h
> @@ -21,11 +21,34 @@ static void tlb_flush(struct mmu_gather *tlb);
>  
>  #include <asm-generic/tlb.h>
>  
> +/*
> + * get the tlbi levels in arm64.  Default value is 0 if more than one
> + * of cleared_* is set or neither is set.
> + * Arm64 doesn't support p4ds now.
> + */
> +static inline int tlb_get_level(struct mmu_gather *tlb)
> +{
> +	int sum = tlb->cleared_ptes + tlb->cleared_pmds +
> +		  tlb->cleared_puds + tlb->cleared_p4ds;
> +
> +	if (sum != 1)
> +		return 0;
> +	else if (tlb->cleared_ptes)
> +		return 3;
> +	else if (tlb->cleared_pmds)
> +		return 2;
> +	else if (tlb->cleared_puds)
> +		return 1;
> +
> +	return 0;
> +}

That's some mighty wonky code. Please look at the generated asm.
