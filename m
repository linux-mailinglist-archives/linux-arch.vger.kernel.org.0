Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E087704EBD
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 15:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjEPNHU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 09:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbjEPNGt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 09:06:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EA97694
        for <linux-arch@vger.kernel.org>; Tue, 16 May 2023 06:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684242350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hOeS/Moq8QRL6oaFvPEPC6z/Y8ReCQRtGAiBZK40l1Q=;
        b=bTIyKsURsykA4+G96Ccu4pIkVNCB0G88XxYgg03DIe6jA/rHXwgR3zGdg0m9+2vVA7DMD4
        kVbLwohLmcoNz62mjbnMp5Lcp+rd55GPal6Vfa0rSAHa+Kgh2UDaXhm4FhTDkAcBe3DOav
        SzFAc8J2r6WC/QVCFj52tfvqwaQjP+M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-GhdKlOAUPYyoefAVSH87Kw-1; Tue, 16 May 2023 09:05:48 -0400
X-MC-Unique: GhdKlOAUPYyoefAVSH87Kw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8965B101A555;
        Tue, 16 May 2023 13:05:46 +0000 (UTC)
Received: from localhost (ovpn-12-79.pek2.redhat.com [10.72.12.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE20DBC88;
        Tue, 16 May 2023 13:05:45 +0000 (UTC)
Date:   Tue, 16 May 2023 21:05:41 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v5 RESEND 09/17] openrisc: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZGN/pfd6WZ8PlYCs@MiWiFi-R3L-srv>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-10-bhe@redhat.com>
 <ZGMnlZK1/pZIBCud@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGMnlZK1/pZIBCud@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/16/23 at 09:49am, Mike Rapoport wrote:
> Hi,
> 
> On Mon, May 15, 2023 at 05:08:40PM +0800, Baoquan He wrote:
> > By taking GENERIC_IOREMAP method, the generic generic_ioremap_prot(),
> > generic_iounmap(), and their generic wrapper ioremap_prot(), ioremap()
> > and iounmap() are all visible and available to arch. Arch needs to
> > provide wrapper functions to override the generic versions if there's
> > arch specific handling in its ioremap_prot(), ioremap() or iounmap().
> > This change will simplify implementation by removing duplicated codes
> > with generic_ioremap_prot() and generic_iounmap(), and has the equivalent
> > functioality as before.
> > 
> > Here, add wrapper function iounmap() for openrisc's special operation
> > when iounmap().
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Cc: Stafford Horne <shorne@gmail.com>
> > Cc: Jonas Bonn <jonas@southpole.se>
> > Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > Cc: openrisc@lists.librecores.org
> > ---
> >  arch/openrisc/Kconfig          |  1 +
> >  arch/openrisc/include/asm/io.h | 11 +++++---
> >  arch/openrisc/mm/ioremap.c     | 46 +---------------------------------
> >  3 files changed, 9 insertions(+), 49 deletions(-)
> > 
> > diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> > index c7f282f60f64..fd9bb76a610b 100644
> > --- a/arch/openrisc/Kconfig
> > +++ b/arch/openrisc/Kconfig
> > @@ -21,6 +21,7 @@ config OPENRISC
> >  	select GENERIC_IRQ_PROBE
> >  	select GENERIC_IRQ_SHOW
> >  	select GENERIC_PCI_IOMAP
> > +	select GENERIC_IOREMAP
> >  	select GENERIC_CPU_DEVICES
> >  	select HAVE_PCI
> >  	select HAVE_UID16
> > diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
> > index ee6043a03173..e640960c26c2 100644
> > --- a/arch/openrisc/include/asm/io.h
> > +++ b/arch/openrisc/include/asm/io.h
> > @@ -15,6 +15,8 @@
> >  #define __ASM_OPENRISC_IO_H
> >  
> >  #include <linux/types.h>
> > +#include <asm/pgalloc.h>
> > +#include <asm/pgtable.h>
> >  
> >  /*
> >   * PCI: We do not use IO ports in OpenRISC
> > @@ -27,11 +29,12 @@
> >  #define PIO_OFFSET		0
> >  #define PIO_MASK		0
> >  
> > -#define ioremap ioremap
> > -void __iomem *ioremap(phys_addr_t offset, unsigned long size);
> > -
> > +/*
> > + * I/O memory mapping functions.
> > + */
> >  #define iounmap iounmap
> > -extern void iounmap(volatile void __iomem *addr);
> > +
> > +#define _PAGE_IOREMAP (pgprot_val(PAGE_KERNEL) | _PAGE_CI)
> >  
> >  #include <asm-generic/io.h>
> >  
> > diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
> > index 90b59bc53c8c..9f9941df7d4c 100644
> > --- a/arch/openrisc/mm/ioremap.c
> > +++ b/arch/openrisc/mm/ioremap.c
> > @@ -22,49 +22,6 @@
> >  
> >  extern int mem_init_done;
> >  
> > -/*
> > - * Remap an arbitrary physical address space into the kernel virtual
> > - * address space. Needed when the kernel wants to access high addresses
> > - * directly.
> > - *
> > - * NOTE! We need to allow non-page-aligned mappings too: we will obviously
> > - * have to convert them into an offset in a page-aligned mapping, but the
> > - * caller shouldn't need to know that small detail.
> > - */
> > -void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
> > -{
> > -	phys_addr_t p;
> > -	unsigned long v;
> > -	unsigned long offset, last_addr;
> > -	struct vm_struct *area = NULL;
> > -
> > -	/* Don't allow wraparound or zero size */
> > -	last_addr = addr + size - 1;
> > -	if (!size || last_addr < addr)
> > -		return NULL;
> > -
> > -	/*
> > -	 * Mappings have to be page-aligned
> > -	 */
> > -	offset = addr & ~PAGE_MASK;
> > -	p = addr & PAGE_MASK;
> > -	size = PAGE_ALIGN(last_addr + 1) - p;
> > -
> > -	area = get_vm_area(size, VM_IOREMAP);
> > -	if (!area)
> > -		return NULL;
> > -	v = (unsigned long)area->addr;
> > -
> > -	if (ioremap_page_range(v, v + size, p,
> > -			__pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_CI))) {
> > -		vfree(area->addr);
> > -		return NULL;
> > -	}
> > -
> > -	return (void __iomem *)(offset + (char *)v);
> > -}
> > -EXPORT_SYMBOL(ioremap);
> > -
> >  void iounmap(volatile void __iomem *addr)
> >  {
> >  	/* If the page is from the fixmap pool then we just clear out
> 
> The page cannot be from fixmap pool since we removed fixmap support from
> ioremap in an earlier patch.
> I believe that patch should also remove special casing of fixmap in
> iounmap() and then openrisc does not need to override any of ioremap
> methods.

Totally agree. I will clean it up in iounmap() in patch 3, and rearrange
this patch. Thanks again.

> 
> > @@ -88,9 +45,8 @@ void iounmap(volatile void __iomem *addr)
> >  		return;
> >  	}
> >  
> > -	return vfree((void *)(PAGE_MASK & (unsigned long)addr));
> > +	generic_iounmap(addr);
> >  }
> > -EXPORT_SYMBOL(iounmap);
> >  
> >  /**
> >   * OK, this one's a bit tricky... ioremap can get called before memory is
> > -- 
> > 2.34.1
> > 
> > 
> 
> -- 
> Sincerely yours,
> Mike.
> 

