Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282B9704570
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 08:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjEPGsX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 02:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjEPGsX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 02:48:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B071FFA;
        Mon, 15 May 2023 23:48:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA00A63465;
        Tue, 16 May 2023 06:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8C4C433EF;
        Tue, 16 May 2023 06:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684219701;
        bh=R+bN+Jb2kJNplNYenuVF5QgSUK9IhdlaUvOPxPK/xz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pupmp9bN4mIe64U2fo9F8UefKptAy5mWp6F7MRU+/TiwNMhQ++TKFwcOXaw5QdM94
         1bj8pkiTr0h1CWYOZwnQXpccEoR7RAosqv2vPzU6IUNP+h7e5qiL+ZDjrz2vAG7UzJ
         M3HFj+J7Eg/kV7Hu/Xlfhr4Ox54CrH8ydp6Ifd7BtrsFr791FbjKjBqEtOikLh9qaB
         SEq/1clH/ih6m7ixI+finZ1REBz1JevfVLcF190KsO6fiagiAaJfYwKDO6CmSjNIYg
         51OAK+Dnci+faVsBi+J9Uc/LAPw1JKOib7qFQiIp4unwCIRov8FmdZIOU4BUw+AY1X
         C5lCE6g3CjXpQ==
Date:   Tue, 16 May 2023 09:48:13 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de
Subject: Re: [PATCH v5 RESEND 05/17] mm: ioremap: allow ARCH to have its own
 ioremap method definition
Message-ID: <ZGMnLTPYXuPGHXtp@kernel.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-6-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-6-bhe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 15, 2023 at 05:08:36PM +0800, Baoquan He wrote:
> Architectures can be converted to GENERIC_IOREMAP, to take standard
> ioremap_xxx() and iounmap() way. But some ARCH-es could have specific
> handling for ioremap_prot(), ioremap() and iounmap(), than standard
> methods.
> 
> In oder to convert these ARCH-es to take GENERIC_IOREMAP method, allow
> these architecutres to have their own ioremap_prot(), ioremap() and
> iounmap() definitions.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/asm-generic/io.h | 3 +++
>  mm/ioremap.c             | 4 ++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index a7ca2099ba19..39244c3ee797 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -1081,11 +1081,14 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
>  void iounmap(volatile void __iomem *addr);
>  void generic_iounmap(volatile void __iomem *addr);
>  
> +#ifndef ioremap
> +#define ioremap ioremap
>  static inline void __iomem *ioremap(phys_addr_t addr, size_t size)
>  {
>  	/* _PAGE_IOREMAP needs to be supplied by the architecture */
>  	return ioremap_prot(addr, size, _PAGE_IOREMAP);
>  }
> +#endif
>  #endif /* !CONFIG_MMU || CONFIG_GENERIC_IOREMAP */
>  
>  #ifndef ioremap_wc
> diff --git a/mm/ioremap.c b/mm/ioremap.c
> index db6234b9db59..9f34a8f90b58 100644
> --- a/mm/ioremap.c
> +++ b/mm/ioremap.c
> @@ -46,12 +46,14 @@ void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
>  	return (void __iomem *)(vaddr + offset);
>  }
>  
> +#ifndef ioremap_prot
>  void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
>  			   unsigned long prot)
>  {
>  	return generic_ioremap_prot(phys_addr, size, __pgprot(prot));
>  }
>  EXPORT_SYMBOL(ioremap_prot);
> +#endif
>  
>  void generic_iounmap(volatile void __iomem *addr)
>  {
> @@ -64,8 +66,10 @@ void generic_iounmap(volatile void __iomem *addr)
>  		vunmap(vaddr);
>  }
>  
> +#ifndef iounmap
>  void iounmap(volatile void __iomem *addr)
>  {
>  	generic_iounmap(addr);
>  }
>  EXPORT_SYMBOL(iounmap);
> +#endif
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.
