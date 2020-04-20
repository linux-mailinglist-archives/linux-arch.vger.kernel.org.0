Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDB81B07FF
	for <lists+linux-arch@lfdr.de>; Mon, 20 Apr 2020 13:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgDTLrx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Apr 2020 07:47:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45466 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgDTLrx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Apr 2020 07:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uHONsJr4KTEbnxxWPAu0Ew27QiCD45QjANeqi0Gi8dc=; b=vTp2gHceK5xxpBGqQ42nYZb4gH
        mnA9XPuy7DRtkA60Df0jiiy97/SlJOp04WyRhiU2mpwpDKgFglWyL1et7pobaqGcOc2KccsuF2tq9
        r5lih7DbF8DvviZnMY/w5D0UBLT+IiaxgUTqMMpPkt9AjH9jrTkixQFC0wACrJMjGEk6Ypq5kXWAY
        Enrz0NYVa7bS0ZJ9fmx5Ey2JFVZ92VN3WLWH6S77jP9kly7KVGeeU0JOr2oZ6Fqbe9MjBwf988D8x
        qQdAEkIR9vO3f6xiZFwx27vF2CccaawMTkPYXmpoMSIcPYUCUC33+3xeKPy23pnPnYuuhuFETPpJ/
        j5F/QxdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQUt4-0004FH-Oq; Mon, 20 Apr 2020 11:46:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 25CFD3024EA;
        Mon, 20 Apr 2020 13:46:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15FA32B8DAF8C; Mon, 20 Apr 2020 13:46:51 +0200 (CEST)
Date:   Mon, 20 Apr 2020 13:46:51 +0200
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
Subject: Re: [PATCH v1 4/6] tlb: mmu_gather: add tlb_set_*_range APIs
Message-ID: <20200420114651.GD20696@hirez.programming.kicks-ass.net>
References: <20200403090048.938-1-yezhenyu2@huawei.com>
 <20200403090048.938-5-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403090048.938-5-yezhenyu2@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 03, 2020 at 05:00:46PM +0800, Zhenyu Ye wrote:
> From: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> 
> tlb_set_{pte|pmd|pud|p4d}_range() adjust the tlb->start and
> tlb->end, then set corresponding cleared_*.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
> ---
>  include/asm-generic/tlb.h | 55 ++++++++++++++++++++++++++++-----------
>  1 file changed, 40 insertions(+), 15 deletions(-)
> 
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index f391f6b500b4..ee91310a65c6 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -511,6 +511,38 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
>  }
>  #endif
>  
> +/*
> + * tlb_set_{pte|pmd|pud|p4d}_range() adjust the tlb->start and tlb->end,
> + * and set corresponding cleared_*.
> + */
> +static inline void tlb_set_pte_range(struct mmu_gather *tlb,
> +				     unsigned long address, unsigned long size)
> +{
> +	__tlb_adjust_range(tlb, address, size);
> +	tlb->cleared_ptes = 1;
> +}
> +
> +static inline void tlb_set_pmd_range(struct mmu_gather *tlb,
> +				     unsigned long address, unsigned long size)
> +{
> +	__tlb_adjust_range(tlb, address, size);
> +	tlb->cleared_pmds = 1;
> +}
> +
> +static inline void tlb_set_pud_range(struct mmu_gather *tlb,
> +				     unsigned long address, unsigned long size)
> +{
> +	__tlb_adjust_range(tlb, address, size);
> +	tlb->cleared_puds = 1;
> +}
> +
> +static inline void tlb_set_p4d_range(struct mmu_gather *tlb,
> +				     unsigned long address, unsigned long size)
> +{
> +	__tlb_adjust_range(tlb, address, size);
> +	tlb->cleared_p4ds = 1;
> +}

Uhm.. when I wrote that patch they were called tlb_flush_p*_range():

  https://lkml.kernel.org/r/20200401122004.GE20713@hirez.programming.kicks-ass.net

Your current naming makes no sense what so ever, we do not "set" the
range.
