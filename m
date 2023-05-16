Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA717045BB
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 09:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjEPHCk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 03:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjEPHCi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 03:02:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD1B40C0;
        Tue, 16 May 2023 00:02:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8C386351C;
        Tue, 16 May 2023 07:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4998C4339B;
        Tue, 16 May 2023 07:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684220554;
        bh=X9UrfPvqqhVbnlEuITxxN82KxDibpUaM4pahEhKSVQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dqKO7pq5UGDtIJ1c5ASW+yMbd+dr+SgekKIq/AifX6XgNmFCfW50hv5yfQTrDLvDr
         M4utw2ZSRmQ96/DsD9ZUmp/r+VaLrJr1LX1FI6MoMYF4GvbYPN3L0DC7KZE0fTEGrJ
         wRGz2Vc0tURGM6JPz/zlzk7K22VrIScJh+vJ2aYdsXYibBBAxnf6geAyMG7cuxJ7V8
         8CQz/I5BxR/sof/mhEQkRq1eBp5AHh4Ys9onieZWZkw4e/VX/lxen2drPKmOZ2FQr5
         zsYRvuA3svHu+9GOVUfcp17byP8gyjlSzUmiEFCKjHzuBacNZJc5qqy5w7qj2EGvfV
         zyKuKFKeQlTdw==
Date:   Tue, 16 May 2023 10:02:27 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de
Subject: Re: [PATCH v5 RESEND 17/17] mm: ioremap: remove unneeded
 ioremap_allowed and iounmap_allowed
Message-ID: <ZGMqg8D0LOSH6SpX@kernel.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-18-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-18-bhe@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 15, 2023 at 05:08:48PM +0800, Baoquan He wrote:
> Now there are no users of ioremap_allowed and iounmap_allowed, clean
> them up.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/asm-generic/io.h | 26 --------------------------
>  mm/ioremap.c             |  6 ------
>  2 files changed, 32 deletions(-)
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 39244c3ee797..bac63e874c7b 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -1047,32 +1047,6 @@ static inline void iounmap(volatile void __iomem *addr)
>  #elif defined(CONFIG_GENERIC_IOREMAP)
>  #include <linux/pgtable.h>
>  
> -/*
> - * Arch code can implement the following two hooks when using GENERIC_IOREMAP
> - * ioremap_allowed() return a bool,
> - *   - true means continue to remap
> - *   - false means skip remap and return directly
> - * iounmap_allowed() return a bool,
> - *   - true means continue to vunmap
> - *   - false means skip vunmap and return directly
> - */
> -#ifndef ioremap_allowed
> -#define ioremap_allowed ioremap_allowed
> -static inline bool ioremap_allowed(phys_addr_t phys_addr, size_t size,
> -				   unsigned long prot)
> -{
> -	return true;
> -}
> -#endif
> -
> -#ifndef iounmap_allowed
> -#define iounmap_allowed iounmap_allowed
> -static inline bool iounmap_allowed(void *addr)
> -{
> -	return true;
> -}
> -#endif
> -
>  void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
>  				   pgprot_t prot);
>  
> diff --git a/mm/ioremap.c b/mm/ioremap.c
> index 4a7749d85044..8cb337446bba 100644
> --- a/mm/ioremap.c
> +++ b/mm/ioremap.c
> @@ -32,9 +32,6 @@ void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
>  	phys_addr -= offset;
>  	size = PAGE_ALIGN(size + offset);
>  
> -	if (!ioremap_allowed(phys_addr, size, pgprot_val(prot)))
> -		return NULL;
> -
>  #ifdef IOREMAP_START
>  	area = __get_vm_area_caller(size, VM_IOREMAP, IOREMAP_START,
>  				    IOREMAP_END, __builtin_return_address(0));
> @@ -68,9 +65,6 @@ void generic_iounmap(volatile void __iomem *addr)
>  {
>  	void *vaddr = (void *)((unsigned long)addr & PAGE_MASK);
>  
> -	if (!iounmap_allowed(vaddr))
> -		return;
> -
>  	if (is_ioremap_addr(vaddr))
>  		vunmap(vaddr);
>  }
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.
