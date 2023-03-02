Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5CE6A7A55
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 05:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjCBENr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 23:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjCBENW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 23:13:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B835D43932
        for <linux-arch@vger.kernel.org>; Wed,  1 Mar 2023 20:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677730349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tno3Vr1mvpPmJU/vowr9H20am1PHtRl+UdqDzn6fuo4=;
        b=PyFhHLd3Y8bpes7+nbj35hvQPkXYP3XQUbIK/QScbjxmvyOeJd+EnhBONZXoZF1QhpkFkw
        zFNAuRm+ZIqTGZFb/pecAxJ53kgM8rLS+sNHvSKCPqKdLfBdaroMzluGuGoU29tKyE8EpP
        Q3rj9sgfXD5U5s35oZXtmgCR9FHRDSQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-ynaR-CPyMDCVg9CUd9qrGA-1; Wed, 01 Mar 2023 23:12:26 -0500
X-MC-Unique: ynaR-CPyMDCVg9CUd9qrGA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0651985A588;
        Thu,  2 Mar 2023 04:12:26 +0000 (UTC)
Received: from localhost (ovpn-12-47.pek2.redhat.com [10.72.12.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EDD291121315;
        Thu,  2 Mar 2023 04:12:24 +0000 (UTC)
Date:   Thu, 2 Mar 2023 12:12:21 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mips: add <asm-generic/io.h> including
Message-ID: <ZAAiJcx80RU0QuHw@MiWiFi-R3L-srv>
References: <20230301102208.148490-1-bhe@redhat.com>
 <20230301102208.148490-2-bhe@redhat.com>
 <5edd5304-ef11-4607-9189-a07613ecfee2@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5edd5304-ef11-4607-9189-a07613ecfee2@app.fastmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 03/01/23 at 03:06pm, Arnd Bergmann wrote:
> On Wed, Mar 1, 2023, at 11:22, Baoquan He wrote:
> > With the adding, some default ioremap_xx methods defined in
> > asm-generic/io.h can be used. E.g the default ioremap_uc() returning
> > NULL.
> >
> > Here, remove the <asm/io.h> including in asm/mmiowb.h, otherwise nested
> > including will cause compiling error.
> >
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Huacai Chen <chenhuacai@kernel.org>
> > Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Cc: linux-mips@vger.kernel.org
> 
> This looks good to me,
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> but it obviously needs to be properly reviewed by the MIPS
> maintainers as well. I think others have tried to do this
> in the past but did not make it in.

Thanks for reviewing. Then let's wait for MIPS people to help check
this.

> 
> > @@ -548,6 +552,46 @@ extern void (*_dma_cache_inv)(unsigned long start, 
> > unsigned long size);
> >  #define csr_out32(v, a) (*(volatile u32 *)((unsigned long)(a) + 
> > __CSR_32_ADJUST) = (v))
> >  #define csr_in32(a)    (*(volatile u32 *)((unsigned long)(a) + 
> > __CSR_32_ADJUST))
> > 
> > +
> > +#define inb_p inb_p
> > +#define inw_p inw_p
> > +#define inl_p inl_p
> > +#define insb insb
> > +#define insw insw
> > +#define insl insl
> 
> I would prefer to put the #defines next to the function declarations,
> even when they come from macros.

Yeah, sounds reasonable, will change.

> 
> > 
> > -#include <asm/io.h>
> > -
> >  #define mmiowb()	iobarrier_w()
> > 
> 
> I think this only works as long as asm/spinlock.h also includes
> asm/io.h, otherwise linux/spinlock.h will be missing the
> iobarrier_w definition.
> 
> Most likely this is implicitly included from somewhere else
> below linux/spinlock.h, but it would be better not to rely
> on that, and instead define mmiowb() to wmb() directly.

Yeah, defining mmiowb() to wmb() directly is also good to me. I tried
to comb including sequence and find where asm/io.h is included, but
failed. Mainly asm/mmiowb.h including asm/io.h will cause below
compiling error, the asm/io.h need see mmiowb_set_pending which is
defnined in asm-generic/mmiowb.h. Moving asm-generic/mmiowb.h to above
asm/io.h can also fix the compiling error.

=============
diff --git a/arch/mips/include/asm/mmiowb.h b/arch/mips/include/asm/mmiowb.h
index a40824e3ef8e..cae2745935bc 100644
--- a/arch/mips/include/asm/mmiowb.h
+++ b/arch/mips/include/asm/mmiowb.h
@@ -2,10 +2,8 @@
 #ifndef _ASM_MMIOWB_H
 #define _ASM_MMIOWB_H
 
+#include <asm-generic/mmiowb.h>
 #include <asm/io.h>
 
 #define mmiowb()       iobarrier_w()
-
-#include <asm-generic/mmiowb.h>
-
 #endif /* _ASM_MMIOWB_H */


============
  CC      arch/mips/kernel/asm-offsets.s
In file included from ./arch/mips/include/asm/io.h:602,
                 from ./arch/mips/include/asm/mmiowb.h:6,
                 from ./include/linux/spinlock.h:65,
                 from ./include/linux/ipc.h:5,
                 from ./include/uapi/linux/sem.h:5,
                 from ./include/linux/sem.h:5,
                 from ./include/linux/compat.h:14,
                 from arch/mips/kernel/asm-offsets.c:12:
./include/asm-generic/io.h: In function ‘_outb’:
./include/asm-generic/io.h:46:24: error: implicit declaration of function ‘mmiowb_set_pending’ [-Werror=implicit-function-declaration]
   46 | #define __io_aw()      mmiowb_set_pending()
      |                        ^~~~~~~~~~~~~~~~~~
./include/asm-generic/io.h:54:24: note: in expansion of macro ‘__io_aw’
   54 | #define __io_paw()     __io_aw()
      |                        ^~~~~~~
./include/asm-generic/io.h:585:9: note: in expansion of macro ‘__io_paw’
  585 |         __io_paw();
      |         ^~~~~~~~

