Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B641711C92A
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2019 10:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfLLJbU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Dec 2019 04:31:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38404 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbfLLJbU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Dec 2019 04:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KvrwbQennYY8QnMZ8aYWegrb07xu+PIkjz3Z8wg/eK4=; b=NW2MeACWD7pQvnuQ878OqOex5
        8Bl0zzFsRZzFAJXTKTkJ923v7X2eJEFzq8qA/FcdHnVm1fFjP625ix7THJU7C+ucJgFfYOHFRvD1L
        Q/gAkZILIxrfAhp09zHvb40mkvjb3Cir5fN8qTVqXOfg1pQIGu2arcO4eJ7CgcrdRx+cVshg+IPgM
        kgICX46GZXqN8SlxiHJSXc4k7ME0bto3wI6/OgBfFjjPtC/aFO3QWi0foIji9c7KsOhdTFH9UfoyF
        5PhvHdRtW2unb456JPxJy0rrG2pAdMaPaxCMt3P7xXSCju64OuadJiOlqXHTXxohD5F88MpxkJ4/C
        73mG9EV7w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifKoF-0005N7-JP; Thu, 12 Dec 2019 09:30:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0A600305FEE;
        Thu, 12 Dec 2019 10:29:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0517F2B18D290; Thu, 12 Dec 2019 10:30:55 +0100 (CET)
Date:   Thu, 12 Dec 2019 10:30:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Burton <paulburton@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Nick Hu <nickhu@andestech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 08/17] asm-generic/tlb: Provide MMU_GATHER_TABLE_FREE
Message-ID: <20191212093055.GT2827@hirez.programming.kicks-ass.net>
References: <20191211120713.360281197@infradead.org>
 <20191211122956.112607298@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211122956.112607298@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Dec 11, 2019 at 01:07:21PM +0100, Peter Zijlstra wrote:
> @@ -56,6 +56,15 @@
>   *    Defaults to flushing at tlb_end_vma() to reset the range; helps when
>   *    there's large holes between the VMAs.
>   *
> + *  - tlb_remove_table()
> + *
> + *    tlb_remove_table() is the basic primitive to free page-table directories
> + *    (__p*_free_tlb()).  In it's most primitive form it is an alias for
> + *    tlb_remove_page() below, for when page directories are pages and have no
> + *    additional constraints.
> + *
> + *    See also MMU_GATHER_TABLE_FREE and MMU_GATHER_RCU_TABLE_FREE.
> + *
>   *  - tlb_remove_page() / __tlb_remove_page()
>   *  - tlb_remove_page_size() / __tlb_remove_page_size()
>   *

> @@ -202,7 +193,16 @@ struct mmu_table_batch {
>  
>  extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
>  
> -#endif
> +#else /* !CONFIG_MMU_GATHER_HAVE_TABLE_FREE */
> +
> +/*
> + * Without either HAVE_TABLE_FREE || CONFIG_HAVE_RCU_TABLE_FREE the
> + * architecture is assumed to have page based page directories and
> + * we can use the normal page batching to free them.
> + */
> +#define tlb_remove_table(tlb, page) tlb_remove_page((tlb), (page))
> +
> +#endif /* CONFIG_MMU_GATHER_TABLE_FREE */

The build robot kindly notified me that this breaks ARM because it does
the exact same #define for the same reason.

(and I noticed the comment is stale)

I'll post a new version of this patch with the below delta.

---
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -37,10 +37,6 @@ static inline void __tlb_remove_table(vo
 
 #include <asm-generic/tlb.h>
 
-#ifndef CONFIG_MMU_GATHER_RCU_TABLE_FREE
-#define tlb_remove_table(tlb, entry) tlb_remove_page(tlb, entry)
-#endif
-
 static inline void
 __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 {
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -196,9 +196,8 @@ extern void tlb_remove_table(struct mmu_
 #else /* !CONFIG_MMU_GATHER_HAVE_TABLE_FREE */
 
 /*
- * Without either HAVE_TABLE_FREE || CONFIG_HAVE_RCU_TABLE_FREE the
- * architecture is assumed to have page based page directories and
- * we can use the normal page batching to free them.
+ * Without MMU_GATHER_TABLE_FREE the architecture is assumed to have page based
+ * page directories and we can use the normal page batching to free them.
  */
 #define tlb_remove_table(tlb, page) tlb_remove_page((tlb), (page))
 
