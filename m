Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9179E4DAD10
	for <lists+linux-arch@lfdr.de>; Wed, 16 Mar 2022 09:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351618AbiCPI72 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Mar 2022 04:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239096AbiCPI71 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Mar 2022 04:59:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2381A81E;
        Wed, 16 Mar 2022 01:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZO6T+T6VdhnXFg3DFC0hePFp/Gp9l+EG3ROcsdfHimI=; b=hIrSRoOagI53lLjOGSK/k278vN
        cZ7iCZuRhzmJwK+3urA//1N7SwFBNCIOi02dhCx2BWCpLMthq39xx5jC8iFVske1nqKga+BbrrYW6
        qUKurJK5maBQOLWzOG6xJpfO1aZXi8BxCQw6P47wuXm8Hw8M4c+/nfkx1oCpL8BivgVeCA5OFiWjL
        9mPLxqy04S3or4aPorHIMNLcqJOcFqyYC6+SrMDTdfrl85X3quKgDSbGaNpYL3Kc/sMq7bRvAwfUf
        rwZdIeORDm3+0+b08gtqSeLnTGTtlGCkKs4qKNm5sUgmBLZgSmvzRFYMv4c5AlS34tlqTRII0PTXi
        P425ehcg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUPTf-001UlC-3O; Wed, 16 Mar 2022 08:57:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6FFF630021B;
        Wed, 16 Mar 2022 09:57:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5441821BE7625; Wed, 16 Mar 2022 09:57:52 +0100 (CET)
Date:   Wed, 16 Mar 2022 09:57:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jianxing Wang <wangjianxing@loongson.cn>
Cc:     will@kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mm/mmu_gather: limit tlb batch count and add
 schedule point in tlb_batch_pages_flush
Message-ID: <YjGmkOKfmj71bfMA@hirez.programming.kicks-ass.net>
References: <20220315125536.1036303-1-wangjianxing@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315125536.1036303-1-wangjianxing@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 15, 2022 at 08:55:36AM -0400, Jianxing Wang wrote:
> free a large list of pages maybe cause rcu_sched starved on
> non-preemptible kernels. howerver free_unref_page_list maybe can't
> cond_resched as it maybe called in interrupt or atomic context,
> especially can't detect atomic context in CONFIG_PREEMPTION=n.
> 
> tlb flush batch count depends on PAGE_SIZE, it's too large if
> PAGE_SIZE > 4K, here limit max batch size with 4K.
> And add schedule point in tlb_batch_pages_flush.
> 
> rcu: rcu_sched kthread starved for 5359 jiffies! g454793 f0x0
> RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=19
> [...]
> Call Trace:
>    free_unref_page_list+0x19c/0x270
>    release_pages+0x3cc/0x498
>    tlb_flush_mmu_free+0x44/0x70
>    zap_pte_range+0x450/0x738
>    unmap_page_range+0x108/0x240
>    unmap_vmas+0x74/0xf0
>    unmap_region+0xb0/0x120
>    do_munmap+0x264/0x438
>    vm_munmap+0x58/0xa0
>    sys_munmap+0x10/0x20
>    syscall_common+0x24/0x38
> 
> Signed-off-by: Jianxing Wang <wangjianxing@loongson.cn>
> ---
>  include/asm-generic/tlb.h | 7 ++++++-
>  mm/mmu_gather.c           | 7 +++++--
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 2c68a545ffa7..47c7f93ca695 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -230,8 +230,13 @@ struct mmu_gather_batch {
>  	struct page		*pages[0];
>  };
>  
> +#if PAGE_SIZE > 4096UL
> +#define MAX_GATHER_BATCH_SZ	4096
> +#else
> +#define MAX_GATHER_BATCH_SZ	PAGE_SIZE
> +#endif
>  #define MAX_GATHER_BATCH	\
> -	((PAGE_SIZE - sizeof(struct mmu_gather_batch)) / sizeof(void *))
> +	((MAX_GATHER_BATCH_SZ - sizeof(struct mmu_gather_batch)) / sizeof(void *))
>  
>  /*
>   * Limit the maximum number of mmu_gather batches to reduce a risk of soft
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index afb7185ffdc4..f2c105810b3f 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -8,6 +8,7 @@
>  #include <linux/rcupdate.h>
>  #include <linux/smp.h>
>  #include <linux/swap.h>
> +#include <linux/slab.h>
>  
>  #include <asm/pgalloc.h>
>  #include <asm/tlb.h>
> @@ -27,7 +28,7 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
>  	if (tlb->batch_count == MAX_GATHER_BATCH_COUNT)
>  		return false;
>  
> -	batch = (void *)__get_free_pages(GFP_NOWAIT | __GFP_NOWARN, 0);
> +	batch = kmalloc(MAX_GATHER_BATCH_SZ, GFP_NOWAIT | __GFP_NOWARN);
>  	if (!batch)
>  		return false;
>  
> @@ -49,6 +50,8 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
>  	for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
>  		free_pages_and_swap_cache(batch->pages, batch->nr);
>  		batch->nr = 0;
> +
> +		cond_resched();
>  	}
>  	tlb->active = &tlb->local;
>  }
> @@ -59,7 +62,7 @@ static void tlb_batch_list_free(struct mmu_gather *tlb)
>  
>  	for (batch = tlb->local.next; batch; batch = next) {
>  		next = batch->next;
> -		free_pages((unsigned long)batch, 0);
> +		kfree(batch);
>  	}
>  	tlb->local.next = NULL;
>  }

This seems like a really complicated way of writing something like the
below...

diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index afb7185ffdc4..b382e86c1b47 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -47,8 +47,17 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
 	struct mmu_gather_batch *batch;
 
 	for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
-		free_pages_and_swap_cache(batch->pages, batch->nr);
-		batch->nr = 0;
+		struct page_struct *pages = batch->pages;
+
+		do {
+			int nr = min(512, batch->nr);
+
+			free_pages_and_swap_cache(pages, nr);
+			pages += nr;
+			batch->nr -= nr;
+
+			cond_resched();
+		} while (batch->nr);
 	}
 	tlb->active = &tlb->local;
 }
