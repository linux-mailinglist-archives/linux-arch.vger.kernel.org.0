Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4698674C1D3
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jul 2023 12:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjGIKMC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jul 2023 06:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjGIKMC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jul 2023 06:12:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BCF9C
        for <linux-arch@vger.kernel.org>; Sun,  9 Jul 2023 03:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688897473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ov3JfUvGcvY/gub0yO+OM0+NYIpkg7qweTL0CdVo1Bg=;
        b=WWEGEl+jXXHGo87jQ2aZ2TPnOTC+EkJeqaT/o6kWtht/UI/98N5ehBbdBMssN6WPJ/TTdX
        3OSQ1Oq96fMghdbYzy1vNUU3Na+/O7puc9ZN4f/vc34+Km/10bIpcblZEynQZWWDVHbjg4
        Oo3jNLk4nie5EDTmTZJb1ftqBTgoxBY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-ZPfXDT6uPQy1mNFrnfZTpw-1; Sun, 09 Jul 2023 06:11:12 -0400
X-MC-Unique: ZPfXDT6uPQy1mNFrnfZTpw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D9DC104458E;
        Sun,  9 Jul 2023 10:11:11 +0000 (UTC)
Received: from localhost (ovpn-12-38.pek2.redhat.com [10.72.12.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0119D111F3CB;
        Sun,  9 Jul 2023 10:11:09 +0000 (UTC)
Date:   Sun, 9 Jul 2023 18:11:06 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, hch@lst.de,
        christophe.leroy@csgroup.eu, rppt@kernel.org, willy@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@aculab.com, deller@gmx.de,
        nathan@kernel.org, glaubitz@physik.fu-berlin.de,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v7 09/19] openrisc: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZKqHuhNt7ElIqaqe@MiWiFi-R3L-srv>
References: <20230620131356.25440-1-bhe@redhat.com>
 <20230620131356.25440-10-bhe@redhat.com>
 <ZKiu1hjMPHRTYBLy@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKiu1hjMPHRTYBLy@antec>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 07/08/23 at 01:33am, Stafford Horne wrote:
> On Tue, Jun 20, 2023 at 09:13:46PM +0800, Baoquan He wrote:
> > By taking GENERIC_IOREMAP method, the generic generic_ioremap_prot(),
> > generic_iounmap(), and their generic wrapper ioremap_prot(), ioremap()
> > and iounmap() are all visible and available to arch. Arch needs to
> > provide wrapper functions to override the generic versions if there's
> > arch specific handling in its ioremap_prot(), ioremap() or iounmap().
> > This change will simplify implementation by removing duplicated codes
> > with generic_ioremap_prot() and generic_iounmap(), and has the equivalent
> > functioality as before.
> > 
> > For openrisc, the current ioremap() and iounmap() are the same as
> > generic version. After taking GENERIC_IOREMAP way, the old ioremap()
> > and iounmap() can be completely removed.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > Cc: Stafford Horne <shorne@gmail.com>
> > Cc: Jonas Bonn <jonas@southpole.se>
> > Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > Cc: openrisc@lists.librecores.org
> > ---
> >  arch/openrisc/Kconfig          |  1 +
> >  arch/openrisc/include/asm/io.h | 11 ++++----
> >  arch/openrisc/mm/ioremap.c     | 49 ----------------------------------
> >  3 files changed, 7 insertions(+), 54 deletions(-)
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
> > index ee6043a03173..5a6f0f16a5ce 100644
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
> > @@ -27,11 +29,10 @@
> >  #define PIO_OFFSET		0
> >  #define PIO_MASK		0
> >  
> > -#define ioremap ioremap
> > -void __iomem *ioremap(phys_addr_t offset, unsigned long size);
> > -
> > -#define iounmap iounmap
> > -extern void iounmap(volatile void __iomem *addr);
> > +/*
> > + * I/O memory mapping functions.
> > + */
> > +#define _PAGE_IOREMAP (pgprot_val(PAGE_KERNEL) | _PAGE_CI)
> >  
> >  #include <asm-generic/io.h>
> >  
> > diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
> > index cdbcc7e73684..91c8259d4b7e 100644
> > --- a/arch/openrisc/mm/ioremap.c
> > +++ b/arch/openrisc/mm/ioremap.c
> > @@ -22,55 +22,6 @@
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
> > -void iounmap(volatile void __iomem *addr)
> > -{
> > -	return vfree((void *)(PAGE_MASK & (unsigned long)addr));
> > -}
> > -EXPORT_SYMBOL(iounmap);
> > -
> 
> Hello,
> 
> Thanks for the patch, I was able to test this booting openrisc and running a few
> glibc tests and see no issues.  Also the code cleanup looks good to me.
> 
> Acked-by: Stafford Horne <shorne@gmail.com>

Thanks a lot, Stafford. 

I later posted v8 to add update for hexagon and s390, this is the link:
https://lore.kernel.org/all/20230706154520.11257-10-bhe@redhat.com/T/#u

Thanks

