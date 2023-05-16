Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C045704EA7
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 15:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbjEPNFu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 09:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbjEPNF2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 09:05:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F314E64
        for <linux-arch@vger.kernel.org>; Tue, 16 May 2023 06:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684242228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tINlKvgyQ2vAChliCA1uarlkfAXboH0fEYXvp0VtNa8=;
        b=TB1e6oxuT9N6GTlNQzt7AxyfAzAl6fkz9jAPVTbK30WmQXAbsqkb/KdtqZiL07oPKSsJdm
        TismGO7CMoZUgCCFT3UYGJZA6u4bB93zQBkkrOD8poSaLyhAGKEP0dgq5QJzgGezlMFF8N
        bRs47eMPKbm5wIX2NVOggn7HgPeYb3Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-RiGwLzi-MrG956DbXJ3JHg-1; Tue, 16 May 2023 09:03:42 -0400
X-MC-Unique: RiGwLzi-MrG956DbXJ3JHg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96A52101A551;
        Tue, 16 May 2023 13:03:41 +0000 (UTC)
Received: from localhost (ovpn-12-79.pek2.redhat.com [10.72.12.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EDF3C63F5F;
        Tue, 16 May 2023 13:03:39 +0000 (UTC)
Date:   Tue, 16 May 2023 21:03:36 +0800
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
Subject: Re: [PATCH v5 RESEND 03/17] openrisc: mm: remove unneeded early
 ioremap code
Message-ID: <ZGN/KDhJDc0oSUi/@MiWiFi-R3L-srv>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-4-bhe@redhat.com>
 <ZGMf+P6yccCYYI07@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGMf+P6yccCYYI07@kernel.org>
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

On 05/16/23 at 09:17am, Mike Rapoport wrote:
> On Mon, May 15, 2023 at 05:08:34PM +0800, Baoquan He wrote:
> > Under arch/openrisc, there isn't any place where ioremap() is called.
> > It means that there isn't early ioremap handling needed in openrisc,
> > So the early ioremap handling code in ioremap() of
> > arch/openrisc/mm/ioremap.c is unnecessary and can be removed.
> 
> It looks like early ioremap was the only user of fixmap on openrisc, so it
> can be removed as well.

You are right, and you are saying the relic in iounmap() about fixmap
handling, hope I got it right. I will remove it, the code will be more
cleaner. Thanks.

>  
> > Link: https://lore.kernel.org/linux-mm/YwxfxKrTUtAuejKQ@oscomms1/
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Acked-by: Stafford Horne <shorne@gmail.com>
> > Cc: Jonas Bonn <jonas@southpole.se>
> > Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > Cc: Stafford Horne <shorne@gmail.com>
> > Cc: openrisc@lists.librecores.org
> > ---
> >  arch/openrisc/mm/ioremap.c | 22 +++++-----------------
> >  1 file changed, 5 insertions(+), 17 deletions(-)
> > 
> > diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
> > index 8ec0dafecf25..90b59bc53c8c 100644
> > --- a/arch/openrisc/mm/ioremap.c
> > +++ b/arch/openrisc/mm/ioremap.c
> > @@ -22,8 +22,6 @@
> >  
> >  extern int mem_init_done;
> >  
> > -static unsigned int fixmaps_used __initdata;
> > -
> >  /*
> >   * Remap an arbitrary physical address space into the kernel virtual
> >   * address space. Needed when the kernel wants to access high addresses
> > @@ -52,24 +50,14 @@ void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
> >  	p = addr & PAGE_MASK;
> >  	size = PAGE_ALIGN(last_addr + 1) - p;
> >  
> > -	if (likely(mem_init_done)) {
> > -		area = get_vm_area(size, VM_IOREMAP);
> > -		if (!area)
> > -			return NULL;
> > -		v = (unsigned long)area->addr;
> > -	} else {
> > -		if ((fixmaps_used + (size >> PAGE_SHIFT)) > FIX_N_IOREMAPS)
> > -			return NULL;
> > -		v = fix_to_virt(FIX_IOREMAP_BEGIN + fixmaps_used);
> > -		fixmaps_used += (size >> PAGE_SHIFT);
> > -	}
> > +	area = get_vm_area(size, VM_IOREMAP);
> > +	if (!area)
> > +		return NULL;
> > +	v = (unsigned long)area->addr;
> >  
> >  	if (ioremap_page_range(v, v + size, p,
> >  			__pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_CI))) {
> > -		if (likely(mem_init_done))
> > -			vfree(area->addr);
> > -		else
> > -			fixmaps_used -= (size >> PAGE_SHIFT);
> > +		vfree(area->addr);
> >  		return NULL;
> >  	}
> >  
> > -- 
> > 2.34.1
> > 
> > 
> 
> -- 
> Sincerely yours,
> Mike.
> 

