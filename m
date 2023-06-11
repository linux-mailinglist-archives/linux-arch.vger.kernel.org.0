Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C7C72B068
	for <lists+linux-arch@lfdr.de>; Sun, 11 Jun 2023 07:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjFKFpa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Jun 2023 01:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKFpa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Jun 2023 01:45:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E86430EC;
        Sat, 10 Jun 2023 22:45:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB7A261B74;
        Sun, 11 Jun 2023 05:45:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9AAC433EF;
        Sun, 11 Jun 2023 05:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686462328;
        bh=n0udy2xioTBgU05GRm67QikACKmHKTs0zVskv1Tl+18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NFzJ2OtogPgQZUttN3MDnq4YUxBIU2YS/cmf/gLqWnMQVbpBTU7MKblX3z3KRRHut
         g8PD/rX4lO29jMW/3MiHLOxhNnf7kmk6dBydY4lf7iF367Eqz98tMFeBXPRMJHfxAo
         sUvxXdleTneeyJf81JS2iJgbcFSLtH43VF1r3R+1zYG74BSs6iBtqNEEdL4/NSMoNQ
         VdL4CNkGv3wHeavm80Ow3pEFYN/e5ZJrBJ/UcrOepsKFZjbQWG/5/rh/dVKQee3HU8
         98tCwzbacxieoTaiaahjbuMqd2xSZ7xxXxszPV+OoPtwOqQSm9uAdH1fbu0cxw5ItW
         8Pr3BN2K0cePw==
Date:   Sun, 11 Jun 2023 08:44:55 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@lst.de, willy@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@ACULAB.COM, shorne@gmail.com, deller@gmx.de,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v6 03/19] openrisc: mm: remove unneeded early ioremap code
Message-ID: <20230611054455.GM52412@kernel.org>
References: <20230609075528.9390-1-bhe@redhat.com>
 <20230609075528.9390-4-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609075528.9390-4-bhe@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 09, 2023 at 03:55:12PM +0800, Baoquan He wrote:
> Under arch/openrisc, there isn't any place where ioremap() is called.
> It means that there isn't early ioremap handling needed in openrisc,
> So the early ioremap handling code in ioremap() of
> arch/openrisc/mm/ioremap.c is unnecessary and can be removed.
> 
> And also remove the special handling in iounmap() since no page
> is got from fixmap pool along with early ioremap code removing
> in ioremap().
> 
> Link: https://lore.kernel.org/linux-mm/YwxfxKrTUtAuejKQ@oscomms1/
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Acked-by: Stafford Horne <shorne@gmail.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: openrisc@lists.librecores.org

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
> v5->v6:
>   Remove the special handling in iounmap() because no page is got from
>   fixmap pool along with early ioremap code removing in ioremap() - Mike.
> 
>  arch/openrisc/mm/ioremap.c | 43 +++++---------------------------------
>  1 file changed, 5 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
> index 8ec0dafecf25..cdbcc7e73684 100644
> --- a/arch/openrisc/mm/ioremap.c
> +++ b/arch/openrisc/mm/ioremap.c
> @@ -22,8 +22,6 @@
>  
>  extern int mem_init_done;
>  
> -static unsigned int fixmaps_used __initdata;
> -
>  /*
>   * Remap an arbitrary physical address space into the kernel virtual
>   * address space. Needed when the kernel wants to access high addresses
> @@ -52,24 +50,14 @@ void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
>  	p = addr & PAGE_MASK;
>  	size = PAGE_ALIGN(last_addr + 1) - p;
>  
> -	if (likely(mem_init_done)) {
> -		area = get_vm_area(size, VM_IOREMAP);
> -		if (!area)
> -			return NULL;
> -		v = (unsigned long)area->addr;
> -	} else {
> -		if ((fixmaps_used + (size >> PAGE_SHIFT)) > FIX_N_IOREMAPS)
> -			return NULL;
> -		v = fix_to_virt(FIX_IOREMAP_BEGIN + fixmaps_used);
> -		fixmaps_used += (size >> PAGE_SHIFT);
> -	}
> +	area = get_vm_area(size, VM_IOREMAP);
> +	if (!area)
> +		return NULL;
> +	v = (unsigned long)area->addr;
>  
>  	if (ioremap_page_range(v, v + size, p,
>  			__pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_CI))) {
> -		if (likely(mem_init_done))
> -			vfree(area->addr);
> -		else
> -			fixmaps_used -= (size >> PAGE_SHIFT);
> +		vfree(area->addr);
>  		return NULL;
>  	}
>  
> @@ -79,27 +67,6 @@ EXPORT_SYMBOL(ioremap);
>  
>  void iounmap(volatile void __iomem *addr)
>  {
> -	/* If the page is from the fixmap pool then we just clear out
> -	 * the fixmap mapping.
> -	 */
> -	if (unlikely((unsigned long)addr > FIXADDR_START)) {
> -		/* This is a bit broken... we don't really know
> -		 * how big the area is so it's difficult to know
> -		 * how many fixed pages to invalidate...
> -		 * just flush tlb and hope for the best...
> -		 * consider this a FIXME
> -		 *
> -		 * Really we should be clearing out one or more page
> -		 * table entries for these virtual addresses so that
> -		 * future references cause a page fault... for now, we
> -		 * rely on two things:
> -		 *   i)  this code never gets called on known boards
> -		 *   ii) invalid accesses to the freed areas aren't made
> -		 */
> -		flush_tlb_all();
> -		return;
> -	}
> -
>  	return vfree((void *)(PAGE_MASK & (unsigned long)addr));
>  }
>  EXPORT_SYMBOL(iounmap);
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.
