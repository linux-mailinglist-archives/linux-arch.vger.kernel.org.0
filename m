Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF036AB8BB
	for <lists+linux-arch@lfdr.de>; Mon,  6 Mar 2023 09:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjCFIri (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Mar 2023 03:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCFIrg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Mar 2023 03:47:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C522D48
        for <linux-arch@vger.kernel.org>; Mon,  6 Mar 2023 00:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678092408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vSd8hwHPbmWReXdvpQsZ0BwbyP6BUUMBochFuTwRaSI=;
        b=KS/dRXNTcR1O9WPP1MoaqlVHfqMjLL8CqnLBvke9JZm1q8fnKotqXjrBZVd2kvIThh3yXx
        hbvkDM7kfb9/G/eqHTbN4QInQFgXKj1Dg5Ork7fdmBqo5WmcswzdSYleA9va8Dvy2ZcWnt
        rJcwrShBtciRtGgl4ZPC/3kdJsPxcpI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-LYVAfDgZPR-21MvuG0sNlw-1; Mon, 06 Mar 2023 03:46:44 -0500
X-MC-Unique: LYVAfDgZPR-21MvuG0sNlw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2893E802C18;
        Mon,  6 Mar 2023 08:46:43 +0000 (UTC)
Received: from localhost (ovpn-12-63.pek2.redhat.com [10.72.12.63])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 20EFAC16029;
        Mon,  6 Mar 2023 08:46:41 +0000 (UTC)
Date:   Mon, 6 Mar 2023 16:46:38 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mips: add <asm-generic/io.h> including
Message-ID: <ZAWobtBuBYBng6s+@MiWiFi-R3L-srv>
References: <20230303102817.212148-1-bhe@redhat.com>
 <20230303102817.212148-2-bhe@redhat.com>
 <a845b6b3-9f5f-4328-8c69-bbd4dd17caee@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a845b6b3-9f5f-4328-8c69-bbd4dd17caee@app.fastmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 03/03/23 at 01:40pm, Arnd Bergmann wrote:
> On Fri, Mar 3, 2023, at 11:28, Baoquan He wrote:
> > With the adding, some default ioremap_xx methods defined in
> > asm-generic/io.h can be used. E.g the default ioremap_uc() returning
> > NULL.
> >
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: Helge Deller <deller@gmx.de>
> > Cc: Serge Semin <fancer.lancer@gmail.com>
> > Cc: Florian Fainelli <f.fainelli@gmail.com>
> > Cc: Huacai Chen <chenhuacai@kernel.org>
> > Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Cc: linux-mips@vger.kernel.org
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> I think this is all good. I had look at what cleanups we could do as
> follow-ups:

Thanks a lot for careful reviewing and great suggestions.

> 
> > +#define phys_to_virt phys_to_virt
> >  static inline void * phys_to_virt(unsigned long address)
> >  {
> >  	return __va(address);
> 
> This is the same as the asm-generic version, so the mips definition
> is no longer needed.

Agree, I can clean this up with a followup patch.

> 
> > @@ -359,6 +360,27 @@ __BUILD_MEMORY_PFX(__raw_, q, u64, 0)
> >  __BUILD_MEMORY_PFX(__mem_, q, u64, 0)
> >  #endif
> > 
> > +#define readb readb
> > +#define readw readw
> > +#define readl readl
> > +#define writeb writeb
> > +#define writew writew
> > +#define writel writel
> > +
> > +#ifdef CONFIG_64BIT
> > +#define readq readq
> > +#define writeq writeq
> > +#define __raw_readq __raw_readq
> > +#define __raw_writeq __raw_writeq
> > +#endif
> > +
> > +#define __raw_readb __raw_readb
> > +#define __raw_readw __raw_readw
> > +#define __raw_readl __raw_readl
> > +#define __raw_writeb __raw_writeb
> > +#define __raw_writew __raw_writew
> > +#define __raw_writel __raw_writel
> 
> The mips code defines the __raw variants with slightly different
> semantics on both barriers and byteswap, which makes it impractical
> to share any of the above.				
> 
> > +#define memset_io memset_io
> >  static inline void memset_io(volatile void __iomem *addr, unsigned 
> > char val, int count)
> >  {
> >  	memset((void __force *) addr, val, count);
> >  }
> > +#define memcpy_fromio memcpy_fromio
> >  static inline void memcpy_fromio(void *dst, const volatile void 
> > __iomem *src, int count)
> >  {
> >  	memcpy(dst, (void __force *) src, count);
> >  }
> > +#define memcpy_toio memcpy_toio
> 
> These are again the same as the generic version

OK, can remove this with the above change.

