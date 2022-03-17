Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABFC4DBCEF
	for <lists+linux-arch@lfdr.de>; Thu, 17 Mar 2022 03:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245639AbiCQCX0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Mar 2022 22:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbiCQCX0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Mar 2022 22:23:26 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD1A31BE92;
        Wed, 16 Mar 2022 19:22:09 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.20.42.95])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxKsxCmzJiVZAKAA--.8083S3;
        Thu, 17 Mar 2022 10:21:55 +0800 (CST)
Subject: Re: [PATCH 1/1] mm/mmu_gather: limit tlb batch count and add schedule
 point in tlb_batch_pages_flush
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will@kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220315125536.1036303-1-wangjianxing@loongson.cn>
 <YjGmkOKfmj71bfMA@hirez.programming.kicks-ass.net>
From:   wangjianxing <wangjianxing@loongson.cn>
Message-ID: <1c2b999d-4924-25c5-cb8a-2be951c8c2a9@loongson.cn>
Date:   Thu, 17 Mar 2022 10:21:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YjGmkOKfmj71bfMA@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: AQAAf9AxKsxCmzJiVZAKAA--.8083S3
X-Coremail-Antispam: 1UD129KBjvdXoWrKry5GFyrCr17Wr4UXryxKrg_yoWfJFX_ur
        4rKF1xX3ykZF48JFnFkw4IqFya9r95uFy3Jrsaq39rtF4jqas3Ars2gFnxXry7JrWfuF98
        Cr13Jr43JF4agjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxAYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        c2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
        ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07
        j8GYLUUUUU=
X-CM-SenderInfo: pzdqwyxldq5xtqj6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 03/16/2022 04:57 PM, Peter Zijlstra wrote:
> This seems like a really complicated way of writing something like the
> below...
>
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index afb7185ffdc4..b382e86c1b47 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -47,8 +47,17 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
>   	struct mmu_gather_batch *batch;
>   
>   	for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
> -		free_pages_and_swap_cache(batch->pages, batch->nr);
> -		batch->nr = 0;
> +		struct page_struct *pages = batch->pages;
> +
> +		do {
> +			int nr = min(512, batch->nr);
> +
> +			free_pages_and_swap_cache(pages, nr);
> +			pages += nr;
> +			batch->nr -= nr;
> +
> +			cond_resched();
> +		} while (batch->nr);
>   	}
>   	tlb->active = &tlb->local;
>   }
Yeah, it looks nicer.

I will resubmit the patch.

