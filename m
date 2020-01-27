Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9D014A72A
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2020 16:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbgA0P0M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jan 2020 10:26:12 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:36216 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729146AbgA0P0M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Jan 2020 10:26:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=guoren@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TociXAZ_1580138757;
Received: from localhost(mailfrom:guoren@linux.alibaba.com fp:SMTPD_---0TociXAZ_1580138757)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Jan 2020 23:25:57 +0800
Date:   Mon, 27 Jan 2020 23:25:57 +0800
From:   Guo Ren <guoren@linux.alibaba.com>
To:     paul.walmsley@sifive.com, andrew@sifive.com, palmer@dabbelt.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH V2] riscv: Use flush_icache_mm for flush_icache_user_range
Message-ID: <20200127152557.GA8980@parallels-Parallels-Virtual-Platform>
References: <20200127145008.2850-1-guoren@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127145008.2850-1-guoren@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

No ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1 in this patch, I'll remove it
in V3.

The update_mmu_cache() is wrong with sfence.vma and I'll give another
patch to fixup it with ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1.

Best Regards
 Guo Ren

On Mon, Jan 27, 2020 at 10:50:08PM +0800, Guo Ren wrote:
> The patch is the fixup for the commit 08f051eda33b by Andrew.
> 
> For copy_to_user_page, the only call path is:
> __access_remote_vm -> copy_to_user_page -> flush_icache_user_range
> 
> Seems it's ok to use flush_icache_mm instead of flush_icache_all and
> it could reduce flush_icache_all called on other harts.
> 
> Add (vma->vm_flags & VM_EXEC) condition to flush icache only for
> executable vma area.
> 
> ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE is used in a lot of fs/block codes.
> We need it to make their pages dirty and defer sync i/dcache in
> update_mmu_cache().
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Andrew Waterman <andrew@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> 
> ---
> Changelog V2:
>  - Add VM_EXEC condition.
>  - Remove flush_icache_user_range definition.
>  - define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
> ---
>  arch/riscv/include/asm/cacheflush.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> index b69aecbb36d3..ae57d6ce63a9 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -8,7 +8,7 @@
>  
>  #include <linux/mm.h>
>  
> -#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
> +#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
>  
>  /*
>   * The cache doesn't need to be flushed when TLB entries change when
> @@ -62,7 +62,8 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
>  #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
>  	do { \
>  		memcpy(dst, src, len); \
> -		flush_icache_user_range(vma, page, vaddr, len); \
> +		if (vma->vm_flags & VM_EXEC) \
> +			flush_icache_mm(vma->vm_mm, 0); \
>  	} while (0)
>  #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
>  	memcpy(dst, src, len)
> @@ -85,7 +86,6 @@ static inline void flush_dcache_page(struct page *page)
>   * so instead we just flush the whole thing.
>   */
>  #define flush_icache_range(start, end) flush_icache_all()
> -#define flush_icache_user_range(vma, pg, addr, len) flush_icache_all()
>  
>  void dma_wbinv_range(unsigned long start, unsigned long end);
>  void dma_wb_range(unsigned long start, unsigned long end);
> -- 
> 2.17.0
