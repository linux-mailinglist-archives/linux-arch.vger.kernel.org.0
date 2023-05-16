Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39177704510
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 08:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjEPGSE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 02:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjEPGSD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 02:18:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7C02D42;
        Mon, 15 May 2023 23:18:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5D29634E8;
        Tue, 16 May 2023 06:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB929C433D2;
        Tue, 16 May 2023 06:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684217879;
        bh=KGg4vNFKC0FHIdj1tqnZudinSZ5tBcJNQhXldA3DVwM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tucX/9Zxs0lVyiGplSICMROFhdeDetrKuUXJMpSR2R+9RV28i4yXXv3AMOD2Eexor
         y8PucAdUocbnJ9rFAAN8JOPT7FVfyKxNdfm9Tjh9DGB2RybETdbMSW8irHElPlLLtQ
         IgT9un164z+io7Mbe6pQLxYZ35jaA7rw0CeHTalN5vY+vVCfpYPY5IVuywb8W9KBKL
         smL2zzlSrPXxAcoEVAhrjcJeyUbM4Y2YB9ykBCzBcTTAAzybu9gGy22J1qFQmu7eL4
         BhGPqUQqg+XNH4Njk2xk7X+y4T9dcs/85/GuMO/VTBfvCF/MQwO7y58lfPUdQGQKb+
         wMRqU04Rs72Gw==
Date:   Tue, 16 May 2023 09:17:51 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de
Subject: Re: [PATCH v5 RESEND 04/17] mm/ioremap: Define
 generic_ioremap_prot() and generic_iounmap()
Message-ID: <ZGMgD178fqCF2fZf@kernel.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-5-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-5-bhe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 15, 2023 at 05:08:35PM +0800, Baoquan He wrote:
> From: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> Define a generic version of ioremap_prot() and iounmap() that
> architectures can call after they have performed the necessary
> alteration to parameters and/or necessary verifications.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/asm-generic/io.h |  4 ++++
>  mm/ioremap.c             | 22 ++++++++++++++++------
>  2 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 587e7e9b9a37..a7ca2099ba19 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -1073,9 +1073,13 @@ static inline bool iounmap_allowed(void *addr)
>  }
>  #endif
>  
> +void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
> +				   pgprot_t prot);
> +
>  void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
>  			   unsigned long prot);
>  void iounmap(volatile void __iomem *addr);
> +void generic_iounmap(volatile void __iomem *addr);
>  
>  static inline void __iomem *ioremap(phys_addr_t addr, size_t size)
>  {
> diff --git a/mm/ioremap.c b/mm/ioremap.c
> index 8652426282cc..db6234b9db59 100644
> --- a/mm/ioremap.c
> +++ b/mm/ioremap.c
> @@ -11,8 +11,8 @@
>  #include <linux/io.h>
>  #include <linux/export.h>
>  
> -void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> -			   unsigned long prot)
> +void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
> +				   pgprot_t prot)
>  {
>  	unsigned long offset, vaddr;
>  	phys_addr_t last_addr;
> @@ -28,7 +28,7 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
>  	phys_addr -= offset;
>  	size = PAGE_ALIGN(size + offset);
>  
> -	if (!ioremap_allowed(phys_addr, size, prot))
> +	if (!ioremap_allowed(phys_addr, size, pgprot_val(prot)))
>  		return NULL;
>  
>  	area = get_vm_area_caller(size, VM_IOREMAP,
> @@ -38,17 +38,22 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
>  	vaddr = (unsigned long)area->addr;
>  	area->phys_addr = phys_addr;
>  
> -	if (ioremap_page_range(vaddr, vaddr + size, phys_addr,
> -			       __pgprot(prot))) {
> +	if (ioremap_page_range(vaddr, vaddr + size, phys_addr, prot)) {
>  		free_vm_area(area);
>  		return NULL;
>  	}
>  
>  	return (void __iomem *)(vaddr + offset);
>  }
> +
> +void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> +			   unsigned long prot)
> +{
> +	return generic_ioremap_prot(phys_addr, size, __pgprot(prot));
> +}
>  EXPORT_SYMBOL(ioremap_prot);
>  
> -void iounmap(volatile void __iomem *addr)
> +void generic_iounmap(volatile void __iomem *addr)
>  {
>  	void *vaddr = (void *)((unsigned long)addr & PAGE_MASK);
>  
> @@ -58,4 +63,9 @@ void iounmap(volatile void __iomem *addr)
>  	if (is_vmalloc_addr(vaddr))
>  		vunmap(vaddr);
>  }
> +
> +void iounmap(volatile void __iomem *addr)
> +{
> +	generic_iounmap(addr);
> +}
>  EXPORT_SYMBOL(iounmap);
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.
