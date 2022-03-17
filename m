Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23554DD13B
	for <lists+linux-arch@lfdr.de>; Fri, 18 Mar 2022 00:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiCQXld (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Mar 2022 19:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiCQXlc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Mar 2022 19:41:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC022C74B5;
        Thu, 17 Mar 2022 16:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78465B8204A;
        Thu, 17 Mar 2022 23:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA497C340E9;
        Thu, 17 Mar 2022 23:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1647560412;
        bh=w797oqO942yv+U+WAjx8vxn2UXSyujCK+6XAulOhpmM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mta7xvARtzsI9Z8MUCe/BOrdIaoo8KclzMP0367SKo/tFMoE8dJqa3WRcs6um6BLG
         amIDUoecdLPF0KKITo285fkxgActdutDIMpmwg7Kz751NPeOQXypsTqf+lN8LHlypn
         qSIarGlFtWMRQvLcivq5epIfLbAAw1Th8aXwAvW4=
Date:   Thu, 17 Mar 2022 16:40:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jianxing Wang <wangjianxing@loongson.cn>
Cc:     peterz@infradead.org, will@kernel.org, aneesh.kumar@linux.ibm.com,
        npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm/mmu_gather: limit free batch count and add
 schedule point in tlb_batch_pages_flush
Message-Id: <20220317164011.27d7341715de12d890ca244a@linux-foundation.org>
In-Reply-To: <20220317072857.2635262-1-wangjianxing@loongson.cn>
References: <20220317072857.2635262-1-wangjianxing@loongson.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 17 Mar 2022 03:28:57 -0400 Jianxing Wang <wangjianxing@loongson.cn> wrote:

> free a large list of pages maybe cause rcu_sched starved on
> non-preemptible kernels. howerver free_unref_page_list maybe can't
> cond_resched as it maybe called in interrupt or atomic context,
> especially can't detect atomic context in CONFIG_PREEMPTION=n.
> 
> tlb flush batch count depends on PAGE_SIZE, it's too large if
> PAGE_SIZE > 4K, here limit free batch count with 512.
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

tlb_batch_pages_flush() doesn't appear in this trace.  I assume the call
sequence is

zap_pte_range
->tlb_flush_mmu
  ->tlb_flush_mmu_free

correct?

> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -47,8 +47,20 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
>  	struct mmu_gather_batch *batch;
>  
>  	for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
> -		free_pages_and_swap_cache(batch->pages, batch->nr);
> -		batch->nr = 0;
> +		struct page **pages = batch->pages;
> +
> +		do {
> +			/*
> +			 * limit free batch count when PAGE_SIZE > 4K
> +			 */
> +			unsigned int nr = min(512U, batch->nr);
> +
> +			free_pages_and_swap_cache(pages, nr);
> +			pages += nr;
> +			batch->nr -= nr;
> +
> +			cond_resched();
> +		} while (batch->nr);
>  	}

The patch looks safe enough.  But again, it's unlikely to work if the
calling task has realtime policy.  The same can be said of the
cond_resched() in zap_pte_range(), and presumably many others.

I'll save this away for now and will revisit after 5.18-rc1.

How serious is this problem?  Under precisely what circumstances were
you able to trigger this?  In other words, do you believe that a
backport into -stable kernels is needed and if so, why?

Thanks.
