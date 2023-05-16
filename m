Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AC47045B9
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 09:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjEPHCX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 03:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjEPHCU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 03:02:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7213C26;
        Tue, 16 May 2023 00:02:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B457B6354D;
        Tue, 16 May 2023 07:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2488C433EF;
        Tue, 16 May 2023 07:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684220537;
        bh=0oIdahxmDcks/2I2njxfN/C39E1GVYEqbwY+cPgU10U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lFWmtz+SVS8WKz6sXrGBaXts2fFXA+qshSS6blyCsJR6AqF7t0JOZgPVjyZSO6eLh
         gYGpj9NwRda+r4uaUo8fMKUvO84rzoo13pa2Ybxj5USHpSSKfxnhQblW8rkf2uiJ/y
         A0i0hdXKjG4H2DZY6LEqn+GBz7IQEdNiPv76r5/pvKryx2xdx6QizqQadPDdbe2srD
         XSRmH7K7f7rPVqroJe/wonig8z2ryl/UkWBJZxaAMGJhGMZ5uUwgPswVzHf08f02Cr
         PiUHfAWBeEvECflYTrM4I0vE0ipunJt0ENiq1Lu/T867LZ5X+c7n8rsEjfi1ftEyAB
         0QrjywtKuLnsA==
Date:   Tue, 16 May 2023 10:02:08 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 RESEND 16/17] arm64 : mm: add wrapper function
 ioremap_prot()
Message-ID: <ZGMqcOM3b3KTwFUa@kernel.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-17-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-17-bhe@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 15, 2023 at 05:08:47PM +0800, Baoquan He wrote:
> Since hook functions ioremap_allowed() and iounmap_allowed() will be
> obsoleted, add wrapper function ioremap_prot() to contain the
> the specific handling in addition to generic_ioremap_prot() invocation.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/arm64/include/asm/io.h |  3 +--
>  arch/arm64/mm/ioremap.c     | 10 ++++++----
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index 877495a0fd0c..97dd4ff1253b 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -139,8 +139,7 @@ extern void __memset_io(volatile void __iomem *, int, size_t);
>   * I/O memory mapping functions.
>   */
>  
> -bool ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot);
> -#define ioremap_allowed ioremap_allowed
> +#define ioremap_prot ioremap_prot
>  
>  #define _PAGE_IOREMAP PROT_DEVICE_nGnRE
>  
> diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
> index c5af103d4ad4..269f2f63ab7d 100644
> --- a/arch/arm64/mm/ioremap.c
> +++ b/arch/arm64/mm/ioremap.c
> @@ -3,20 +3,22 @@
>  #include <linux/mm.h>
>  #include <linux/io.h>
>  
> -bool ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot)
> +void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> +			   unsigned long prot)
>  {
>  	unsigned long last_addr = phys_addr + size - 1;
>  
>  	/* Don't allow outside PHYS_MASK */
>  	if (last_addr & ~PHYS_MASK)
> -		return false;
> +		return NULL;
>  
>  	/* Don't allow RAM to be mapped. */
>  	if (WARN_ON(pfn_is_map_memory(__phys_to_pfn(phys_addr))))
> -		return false;
> +		return NULL;
>  
> -	return true;
> +	return generic_ioremap_prot(phys_addr, size, __pgprot(prot));
>  }
> +EXPORT_SYMBOL(ioremap_prot);
>  
>  /*
>   * Must be called after early_fixmap_init
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.
