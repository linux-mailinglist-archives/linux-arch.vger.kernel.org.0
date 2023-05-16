Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E643770450E
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 08:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjEPGRn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 02:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjEPGRm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 02:17:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F372D43;
        Mon, 15 May 2023 23:17:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29D99634D1;
        Tue, 16 May 2023 06:17:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB20C433EF;
        Tue, 16 May 2023 06:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684217856;
        bh=ht2toMa7sB2FoOI2dtiANjaURujeEantEFIqRkx7p7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QjjFtngU/0ixMZ52uwdKMxFrkJKzGP+tm/9qrh/Q6dVb9GZRcefaaUGzwnBtR4U/Z
         DWcLX/QxVM1TgVjctlB6nDURbN/lLQZij1s9K3r8NakQxfbG2RZM6ij7BLM3iPTzeJ
         MgFCaYx1yU6mIT2lZZjoNYkqMBuzamBxAskeAdSI6jLBJH1YZMVoT68rFUMBj9IF7L
         Fz8e+Z5YIETnNUeFiVLksbZwKCjm31YFmfhEldQcpAZDQ/3DtOKd9iq29VwdbmS5hn
         gfy6E6RjhZIj0nePsJUXxa/DUtqZ28kcv0LuCgkD6dJ8GNk8fqlHiNkOYXAdc91zyW
         P3j/+q4UyFPmA==
Date:   Tue, 16 May 2023 09:17:28 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v5 RESEND 03/17] openrisc: mm: remove unneeded early
 ioremap code
Message-ID: <ZGMf+P6yccCYYI07@kernel.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-4-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-4-bhe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 15, 2023 at 05:08:34PM +0800, Baoquan He wrote:
> Under arch/openrisc, there isn't any place where ioremap() is called.
> It means that there isn't early ioremap handling needed in openrisc,
> So the early ioremap handling code in ioremap() of
> arch/openrisc/mm/ioremap.c is unnecessary and can be removed.

It looks like early ioremap was the only user of fixmap on openrisc, so it
can be removed as well.
 
> Link: https://lore.kernel.org/linux-mm/YwxfxKrTUtAuejKQ@oscomms1/
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Acked-by: Stafford Horne <shorne@gmail.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: openrisc@lists.librecores.org
> ---
>  arch/openrisc/mm/ioremap.c | 22 +++++-----------------
>  1 file changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
> index 8ec0dafecf25..90b59bc53c8c 100644
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
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.
