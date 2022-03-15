Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CA64D9BA8
	for <lists+linux-arch@lfdr.de>; Tue, 15 Mar 2022 13:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348504AbiCOM5o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Mar 2022 08:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiCOM5o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Mar 2022 08:57:44 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3213B4E394;
        Tue, 15 Mar 2022 05:56:30 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.20.42.95])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxwM73jDBinMQJAA--.30157S3;
        Tue, 15 Mar 2022 20:56:24 +0800 (CST)
Subject: Re: [PATCH 1/1] mm/mmu_gather: limit tlb batch count and add schedule
 point in tlb_batch_pages_flush
To:     will@kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com, peterz@infradead.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220315125536.1036303-1-wangjianxing@loongson.cn>
From:   wangjianxing <wangjianxing@loongson.cn>
Message-ID: <d9b06aeb-3408-75c6-f55d-9143d831ae6c@loongson.cn>
Date:   Tue, 15 Mar 2022 20:56:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20220315125536.1036303-1-wangjianxing@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: AQAAf9BxwM73jDBinMQJAA--.30157S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4xJr4xJF1kZF48uFW3Jrb_yoW5KF15pF
        Z5Ca1xZrZ5Gw48Jw4Iy3Z29Fy3ZanIgryxCrW0q3sxAr13t34q9FyvvFWUZr18CrWrurWS
        qFZFqF4rZrs2vFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvjb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkI
        ecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUqE
        oXUUUUU
X-CM-SenderInfo: pzdqwyxldq5xtqj6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

1. I try to increase the overcommit ratio of cpu to 1:2~1:3 in KVM
hypervisor, per-vm has the same number of vcpu with host cpu, then setup
2 or 3 vm.

2. Run ltpstress(20180926) test in per vm, both host and guest is 
non-preemptiable
kernel, vm dmesg will throw some rcu_sched warning.

3. PAGE_SIZE in my kernel config is 16K, tlb batch max count is 2015, 
it's too long in non-preemptible state.

The issue's orignal 
link:https://patchwork.kernel.org/project/linux-mm/patch/20220302013825.2290315-1-wangjianxing@loongson.cn/


On 03/15/2022 08:55 PM, Jianxing Wang wrote:
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
>     free_unref_page_list+0x19c/0x270
>     release_pages+0x3cc/0x498
>     tlb_flush_mmu_free+0x44/0x70
>     zap_pte_range+0x450/0x738
>     unmap_page_range+0x108/0x240
>     unmap_vmas+0x74/0xf0
>     unmap_region+0xb0/0x120
>     do_munmap+0x264/0x438
>     vm_munmap+0x58/0xa0
>     sys_munmap+0x10/0x20
>     syscall_common+0x24/0x38
>
> Signed-off-by: Jianxing Wang <wangjianxing@loongson.cn>
> ---
>   include/asm-generic/tlb.h | 7 ++++++-
>   mm/mmu_gather.c           | 7 +++++--
>   2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 2c68a545ffa7..47c7f93ca695 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -230,8 +230,13 @@ struct mmu_gather_batch {
>   	struct page		*pages[0];
>   };
>   
> +#if PAGE_SIZE > 4096UL
> +#define MAX_GATHER_BATCH_SZ	4096
> +#else
> +#define MAX_GATHER_BATCH_SZ	PAGE_SIZE
> +#endif
>   #define MAX_GATHER_BATCH	\
> -	((PAGE_SIZE - sizeof(struct mmu_gather_batch)) / sizeof(void *))
> +	((MAX_GATHER_BATCH_SZ - sizeof(struct mmu_gather_batch)) / sizeof(void *))
>   
>   /*
>    * Limit the maximum number of mmu_gather batches to reduce a risk of soft
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index afb7185ffdc4..f2c105810b3f 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -8,6 +8,7 @@
>   #include <linux/rcupdate.h>
>   #include <linux/smp.h>
>   #include <linux/swap.h>
> +#include <linux/slab.h>
>   
>   #include <asm/pgalloc.h>
>   #include <asm/tlb.h>
> @@ -27,7 +28,7 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
>   	if (tlb->batch_count == MAX_GATHER_BATCH_COUNT)
>   		return false;
>   
> -	batch = (void *)__get_free_pages(GFP_NOWAIT | __GFP_NOWARN, 0);
> +	batch = kmalloc(MAX_GATHER_BATCH_SZ, GFP_NOWAIT | __GFP_NOWARN);
>   	if (!batch)
>   		return false;
>   
> @@ -49,6 +50,8 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
>   	for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
>   		free_pages_and_swap_cache(batch->pages, batch->nr);
>   		batch->nr = 0;
> +
> +		cond_resched();
>   	}
>   	tlb->active = &tlb->local;
>   }
> @@ -59,7 +62,7 @@ static void tlb_batch_list_free(struct mmu_gather *tlb)
>   
>   	for (batch = tlb->local.next; batch; batch = next) {
>   		next = batch->next;
> -		free_pages((unsigned long)batch, 0);
> +		kfree(batch);
>   	}
>   	tlb->local.next = NULL;
>   }

