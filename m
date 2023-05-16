Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF3B70450B
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 08:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjEPGRW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 02:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjEPGRV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 02:17:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF5B40EC;
        Mon, 15 May 2023 23:17:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 425A36347D;
        Tue, 16 May 2023 06:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC75C433EF;
        Tue, 16 May 2023 06:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684217835;
        bh=SISxQIMZ3aoEYbelSxp6Io1CmQNeweA4g5bNKPjqm+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SPOLd+7JnyEKaOU2K5LUQsQK9/j1vK2WGpOTiprmvaHqBigWT6CkiFXXCFGLytJW4
         JSk0BOEsog8klByEqKSH5UJp/Y5o3CMA17F1bAvUhBuqqcPH5gYlH99VMeD/1brMZ3
         A9U0/uABWxZ7OsssRO/+xmmH4dvOPhgNadCSIMNNseqdtU2ICEk6SRQIkwXnYaFAdd
         IjPenDLCQ+G7fkuke89adIQGnzZxAADssTWFXuNMnxmjJq6rqGZ0a8VAQL15wIvT2o
         VCp/Se9uwez0vlJSC80RaxdmMXtl1Y4Y9XaNRFmKwXNnleaFCqOOrI5K535fWf/Hao
         +T9X1f6prM2sg==
Date:   Tue, 16 May 2023 09:17:07 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de, Brian Cain <bcain@quicinc.com>,
        linux-hexagon@vger.kernel.org
Subject: Re: [PATCH v5 RESEND 02/17] hexagon: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZGMf40ID9LOSS+8g@kernel.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-3-bhe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 15, 2023 at 05:08:33PM +0800, Baoquan He wrote:
> By taking GENERIC_IOREMAP method, the generic ioremap_prot() and
> iounmap() are visible and available to arch. This change will
> simplify implementation by removing duplicated codes with generic
> ioremap_prot() and iounmap(), and has the equivalent functioality.
> 
> For hexagon, the current ioremap() and iounmap() are the same as
> generic version. After taking GENERIC_IOREMAP way, the old ioremap()
> and iounmap() can be completely removed.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Brian Cain <bcain@quicinc.com>
> Cc: linux-hexagon@vger.kernel.org

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/hexagon/Kconfig          |  1 +
>  arch/hexagon/include/asm/io.h |  9 +++++--
>  arch/hexagon/mm/ioremap.c     | 44 -----------------------------------
>  3 files changed, 8 insertions(+), 46 deletions(-)
>  delete mode 100644 arch/hexagon/mm/ioremap.c
> 
> diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
> index 54eadf265178..17afffde1a7f 100644
> --- a/arch/hexagon/Kconfig
> +++ b/arch/hexagon/Kconfig
> @@ -25,6 +25,7 @@ config HEXAGON
>  	select NEED_SG_DMA_LENGTH
>  	select NO_IOPORT_MAP
>  	select GENERIC_IOMAP
> +	select GENERIC_IOREMAP
>  	select GENERIC_SMP_IDLE_THREAD
>  	select STACKTRACE_SUPPORT
>  	select GENERIC_CLOCKEVENTS_BROADCAST
> diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
> index 46a099de85b7..dcd9cbbf5934 100644
> --- a/arch/hexagon/include/asm/io.h
> +++ b/arch/hexagon/include/asm/io.h
> @@ -170,8 +170,13 @@ static inline void writel(u32 data, volatile void __iomem *addr)
>  #define writew_relaxed __raw_writew
>  #define writel_relaxed __raw_writel
>  
> -void __iomem *ioremap(unsigned long phys_addr, unsigned long size);
> -#define ioremap_uc(X, Y) ioremap((X), (Y))
> +/*
> + * I/O memory mapping functions.
> + */
> +#define _PAGE_IOREMAP (_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
> +		       (__HEXAGON_C_DEV << 6))
> +
> +#define ioremap_uc(addr, size) ioremap((addr), (size))
>  
>  
>  #define __raw_writel writel
> diff --git a/arch/hexagon/mm/ioremap.c b/arch/hexagon/mm/ioremap.c
> deleted file mode 100644
> index 255c5b1ee1a7..000000000000
> --- a/arch/hexagon/mm/ioremap.c
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * I/O remap functions for Hexagon
> - *
> - * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
> - */
> -
> -#include <linux/io.h>
> -#include <linux/vmalloc.h>
> -#include <linux/mm.h>
> -
> -void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
> -{
> -	unsigned long last_addr, addr;
> -	unsigned long offset = phys_addr & ~PAGE_MASK;
> -	struct vm_struct *area;
> -
> -	pgprot_t prot = __pgprot(_PAGE_PRESENT|_PAGE_READ|_PAGE_WRITE
> -					|(__HEXAGON_C_DEV << 6));
> -
> -	last_addr = phys_addr + size - 1;
> -
> -	/*  Wrapping not allowed  */
> -	if (!size || (last_addr < phys_addr))
> -		return NULL;
> -
> -	/*  Rounds up to next page size, including whole-page offset */
> -	size = PAGE_ALIGN(offset + size);
> -
> -	area = get_vm_area(size, VM_IOREMAP);
> -	addr = (unsigned long)area->addr;
> -
> -	if (ioremap_page_range(addr, addr+size, phys_addr, prot)) {
> -		vunmap((void *)addr);
> -		return NULL;
> -	}
> -
> -	return (void __iomem *) (offset + addr);
> -}
> -
> -void iounmap(const volatile void __iomem *addr)
> -{
> -	vunmap((void *) ((unsigned long) addr & PAGE_MASK));
> -}
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.
