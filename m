Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4991870459E
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 08:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjEPGxr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 02:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjEPGxn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 02:53:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5676149DD;
        Mon, 15 May 2023 23:53:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E03C963525;
        Tue, 16 May 2023 06:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D0EC433D2;
        Tue, 16 May 2023 06:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684219993;
        bh=zWowfpys7cJayhdbWlMlfG/naveXwBOaomK6G6YOhwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RvjD1vSAOBJNjAg/ZIxaNqS2rkN1ZlKb87FTH1wyjTGlUAIpNihimQCBehxLwyAKY
         54gGynJbfKhqXVBUQs0KQ5WYkVlgEiax4NBUKAMqRlDABOcDkYEQfDmUqFd0cVc2Rg
         +5tFUZtIuw2D3sq94eU18Cng/cxiFjnZIBRL6URAQLCsD8pXVC2rWlKWmYLB4LFNvN
         wVK415zfFdbPS4SjHqipuLQlYFG9zEqB51Of6oXmNOm2u/s3/wcGcmOyz4LvWqOjOz
         LoLHKaP50dbu7dxYKnvW3H+Vp/2FDG5ni4ZVU0tjPUFUOJobipbyYJvhN2PD5zGfJW
         0OpmVx2CJIC7g==
Date:   Tue, 16 May 2023 09:53:06 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de
Subject: Re: [PATCH v5 RESEND 14/17] mm/ioremap: Consider IOREMAP space in
 generic ioremap
Message-ID: <ZGMoUoska+oSTfWl@kernel.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-15-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-15-bhe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 15, 2023 at 05:08:45PM +0800, Baoquan He wrote:
> From: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> Architectures like powerpc have a dedicated space for IOREMAP mappings.
> 
> If so, use it in generic_ioremap_pro().
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Baoquan He <bhe@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/ioremap.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/ioremap.c b/mm/ioremap.c
> index 2fbe6b9bc50e..4a7749d85044 100644
> --- a/mm/ioremap.c
> +++ b/mm/ioremap.c
> @@ -35,8 +35,13 @@ void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
>  	if (!ioremap_allowed(phys_addr, size, pgprot_val(prot)))
>  		return NULL;
>  
> +#ifdef IOREMAP_START
> +	area = __get_vm_area_caller(size, VM_IOREMAP, IOREMAP_START,
> +				    IOREMAP_END, __builtin_return_address(0));
> +#else
>  	area = get_vm_area_caller(size, VM_IOREMAP,
>  			__builtin_return_address(0));
> +#endif
>  	if (!area)
>  		return NULL;
>  	vaddr = (unsigned long)area->addr;
> @@ -66,7 +71,7 @@ void generic_iounmap(volatile void __iomem *addr)
>  	if (!iounmap_allowed(vaddr))
>  		return;
>  
> -	if (is_vmalloc_addr(vaddr))
> +	if (is_ioremap_addr(vaddr))
>  		vunmap(vaddr);
>  }
>  
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.
