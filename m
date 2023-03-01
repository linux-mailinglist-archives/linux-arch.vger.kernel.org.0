Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECFD6A653F
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 03:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjCACFB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 21:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCACFA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 21:05:00 -0500
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313B455B6;
        Tue, 28 Feb 2023 18:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1677636295; bh=Uo15ING92T44epF0XvfiEFF/VdpfwGmZMh2j1FZp090=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CL8D43/PuZwHtZQiCJinQkzRL8BThzHOVpu7cim8WvbyVZ4isJ63P4oGI/nZMl3sY
         r1uhmpUBG1YdYcdogvYOf/To3SzD0QL/HIyxsDH2cvVDhyflzy5dg6hOwmvvaq9h1/
         N77+7pST+RksLMc2SYvnxc9EBrEp89LV64V98SLo=
Received: from [192.168.9.172] (unknown [114.93.192.93])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 17334600D4;
        Wed,  1 Mar 2023 10:04:55 +0800 (CST)
Message-ID: <277cd2a7-9550-2ed6-1b66-a2e6612a2565@xen0n.name>
Date:   Wed, 1 Mar 2023 10:04:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 12/34] loongarch: Implement the new page table range
 API
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev
References: <20230228213738.272178-1-willy@infradead.org>
 <20230228213738.272178-13-willy@infradead.org>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230228213738.272178-13-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 3/1/23 05:37, Matthew Wilcox (Oracle) wrote:
> Add set_ptes() and update_mmu_cache_range().  It would probably be
> more efficient to implement __update_tlb() by flushing the entire
> folio instead of calling it __update_tlb() N times, but I'll leave
> that for someone who understands the architecture better.
Thanks for the patch! Unfortunately it doesn't seem possible 
architecture-wise to batch-flush pages right now on loongarch, but AFAIK 
the vendor *could* be listening so a future model could have the feature 
supported... who knows!
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: loongarch@lists.linux.dev
> ---
>   arch/loongarch/include/asm/cacheflush.h |  2 ++
>   arch/loongarch/include/asm/pgtable.h    | 30 +++++++++++++++++++------
>   2 files changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/cacheflush.h b/arch/loongarch/include/asm/cacheflush.h
> index 0681788eb474..7907eb42bfbd 100644
> --- a/arch/loongarch/include/asm/cacheflush.h
> +++ b/arch/loongarch/include/asm/cacheflush.h
> @@ -47,8 +47,10 @@ void local_flush_icache_range(unsigned long start, unsigned long end);
>   #define flush_cache_vmap(start, end)			do { } while (0)
>   #define flush_cache_vunmap(start, end)			do { } while (0)
>   #define flush_icache_page(vma, page)			do { } while (0)
> +#define flush_icache_pages(vma, page)			do { } while (0)
>   #define flush_icache_user_page(vma, page, addr, len)	do { } while (0)
>   #define flush_dcache_page(page)				do { } while (0)
> +#define flush_dcache_folio(folio)			do { } while (0)
This will break the build because the surrounding code is unnecessarily 
redefining the stubs that the asm-generic include at the end of the file 
will properly take care of. With the build fixed (patch attached below), 
I can successfully boot-test and stress mm for a while on a Loongson 
3A5000. I haven't done the benchmarks though.
>   #define flush_dcache_mmap_lock(mapping)			do { } while (0)
>   #define flush_dcache_mmap_unlock(mapping)		do { } while (0)
>   
> <snip>

Cleanup patch:

-- >8 --

 From 0de3f49e6ba23c1b45e7b5da355f87398c4a7feb Mon Sep 17 00:00:00 2001
From: WANG Xuerui <git@xen0n.name>
Date: Wed, 1 Mar 2023 09:32:18 +0800
Subject: [PATCH] LoongArch: Remove stub definitions in cacheflush.h

Per the current best practice in mm, it's unnecessary to define no-op
stubs explicitly in arch code, because the asm-generic inclusion at the
end of the file will properly take care of these. And the definition of
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE to 0 is going to confuse the
asm-generic code, so remove the stubs for clarity and avoiding misuse.

Signed-off-by: WANG Xuerui <git@xen0n.name>
---
  arch/loongarch/include/asm/cacheflush.h | 15 ---------------
  1 file changed, 15 deletions(-)

diff --git a/arch/loongarch/include/asm/cacheflush.h b/arch/loongarch/include/asm/cacheflush.h
index 326ac6f1b27c..cb8c046b4f17 100644
--- a/arch/loongarch/include/asm/cacheflush.h
+++ b/arch/loongarch/include/asm/cacheflush.h
@@ -37,21 +37,6 @@ void local_flush_icache_range(unsigned long start, unsigned long end);
  #define flush_icache_range     local_flush_icache_range
  #define flush_icache_user_range        local_flush_icache_range
  
-#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
-
-#define flush_cache_all()                              do { } while (0)
-#define flush_cache_mm(mm)                             do { } while (0)
-#define flush_cache_dup_mm(mm)                         do { } while (0)
-#define flush_cache_range(vma, start, end)             do { } while (0)
-#define flush_cache_page(vma, vmaddr, pfn)             do { } while (0)
-#define flush_cache_vmap(start, end)                   do { } while (0)
-#define flush_cache_vunmap(start, end)                 do { } while (0)
-#define flush_icache_user_page(vma, page, addr, len)   do { } while (0)
-#define flush_dcache_page(page)                                do { } while (0)
-#define flush_dcache_folio(folio)                      do { } while (0)
-#define flush_dcache_mmap_lock(mapping)                        do { } while (0)
-#define flush_dcache_mmap_unlock(mapping)              do { } while (0)
-
  #define cache_op(op, addr)                                             \
         __asm__ __volatile__(                                           \
         "       cacop   %0, %1                                  \n"     \

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

