Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57C5A1242BE
	for <lists+linux-arch@lfdr.de>; Wed, 18 Dec 2019 10:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfLRJRo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Dec 2019 04:17:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39224 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLRJRn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Dec 2019 04:17:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AX3VdH7EqYVEvpigBaq6scqvol8UFlytVvrQaxwhRTM=; b=srjXb+CxYdYqaxGRqX3nMXE1M
        C2geSj7fwM5u2GA7fxI8FP+v4268VeXJPYvxhOKrvoC+VQ5QGooB9BQOFVFxLuX071vWav1PtDVzO
        fb5ZlSZyDtar5TL2grgkuSySdQ7Vp1cuMjjznT76n3MgUxQpH8HrZXAK1u9YEpV3HTRTzCuOuvFpK
        Y9eOUQYo5HRQ+0VX1ZjCZa1O0E4z/+Yx+y6VENLuQr3iXjesZ7aRm+/aNfnIBONymnuLEt8NWzxlW
        E7pR6nPKjZxW3QEyuUVbciHYYmpEjW4J2bKvHFh4lp84cz6Kgd/gGtAVoqvXPfiBn0HMxU9MXVngI
        5dNo8hNvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihVSa-0004jh-5F; Wed, 18 Dec 2019 09:17:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 830B4306062;
        Wed, 18 Dec 2019 10:16:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DE2FC2B3E30F6; Wed, 18 Dec 2019 10:17:33 +0100 (CET)
Date:   Wed, 18 Dec 2019 10:17:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     akpm@linux-foundation.org, npiggin@gmail.com, mpe@ellerman.id.au,
        will@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mm/mmu_gather: Invalidate TLB correctly on batch
 allocation failure and flush
Message-ID: <20191218091733.GO2844@hirez.programming.kicks-ass.net>
References: <20191218053530.73053-1-aneesh.kumar@linux.ibm.com>
 <20191218053530.73053-2-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218053530.73053-2-aneesh.kumar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 18, 2019 at 11:05:29AM +0530, Aneesh Kumar K.V wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Architectures for which we have hardware walkers of Linux page table should
> flush TLB on mmu gather batch allocation failures and batch flush. Some
> architectures like POWER supports multiple translation modes (hash and radix)

nohash, hash and radix in fact :-)

> and in the case of POWER only radix translation mode needs the above TLBI.

> This is because for hash translation mode kernel wants to avoid this extra
> flush since there are no hardware walkers of linux page table. With radix
> translation, the hardware also walks linux page table and with that, kernel
> needs to make sure to TLB invalidate page walk cache before page table pages are
> freed.
> 
> More details in
> commit: d86564a2f085 ("mm/tlb, x86/mm: Support invalidating TLB caches for RCU_TABLE_FREE")
> 
> Fixes: a46cc7a90fd8 ("powerpc/mm/radix: Improve TLB/PWC flushes")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---

> diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
> index b2c0be93929d..7f3a8b902325 100644
> --- a/arch/powerpc/include/asm/tlb.h
> +++ b/arch/powerpc/include/asm/tlb.h
> @@ -26,6 +26,17 @@
>  
>  #define tlb_flush tlb_flush
>  extern void tlb_flush(struct mmu_gather *tlb);
> +/*
> + * book3s:
> + * Hash does not use the linux page-tables, so we can avoid
> + * the TLB invalidate for page-table freeing, Radix otoh does use the
> + * page-tables and needs the TLBI.
> + *
> + * nohash:
> + * We still do TLB invalidate in the __pte_free_tlb routine before we
> + * add the page table pages to mmu gather table batch.

I'm a little confused though; if nohash is a software TLB fill, why do
you need a TLBI for tables?

> + */
> +#define tlb_needs_table_invalidate()	radix_enabled()
>  
>  /* Get the generic bits... */
>  #include <asm-generic/tlb.h>
