Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9216A9378
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 10:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjCCJOI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Mar 2023 04:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCCJOE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2023 04:14:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6F916AD2
        for <linux-arch@vger.kernel.org>; Fri,  3 Mar 2023 01:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677834800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qkqklC5AeYT4qdgTWNNx2hQvOWihhGqU0jJXIqFqlS0=;
        b=V53BOkK2Qtb+ktTVmDxXUiEn3RLwW6PzdQ4ZwQwTkrkd0Xbm9gTJSx7LZts3mnxm4EFMpn
        4wqCt/IMlJX89YgC32lEUFVJY/HvV4nsrcPo2UBNvu61G4jf8RfZWthtD6wQbMJlfm1922
        vqZVAB2R38PLvtNTGqdCtbma9dBuOtI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-76-EJzhNn_ZP7yE2cz9Z08MrQ-1; Fri, 03 Mar 2023 04:13:17 -0500
X-MC-Unique: EJzhNn_ZP7yE2cz9Z08MrQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E12D185A5A3;
        Fri,  3 Mar 2023 09:13:16 +0000 (UTC)
Received: from localhost (ovpn-13-150.pek2.redhat.com [10.72.13.150])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B380D492B00;
        Fri,  3 Mar 2023 09:13:15 +0000 (UTC)
Date:   Fri, 3 Mar 2023 17:13:06 +0800
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
Message-ID: <ZAG6Ilwj7+pcJdK7@MiWiFi-R3L-srv>
References: <20230301102208.148490-1-bhe@redhat.com>
 <20230301102208.148490-2-bhe@redhat.com>
 <5edd5304-ef11-4607-9189-a07613ecfee2@app.fastmail.com>
 <ZAAiJcx80RU0QuHw@MiWiFi-R3L-srv>
 <b2958824-786b-46d7-a880-17c948fbe2b0@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2958824-786b-46d7-a880-17c948fbe2b0@app.fastmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 03/02/23 at 08:12am, Arnd Bergmann wrote:
> On Thu, Mar 2, 2023, at 05:12, Baoquan He wrote:
> > On 03/01/23 at 03:06pm, Arnd Bergmann wrote:
> >
> > Yeah, defining mmiowb() to wmb() directly is also good to me. I tried
> > to comb including sequence and find where asm/io.h is included, but
> > failed. Mainly asm/mmiowb.h including asm/io.h will cause below
> > compiling error, the asm/io.h need see mmiowb_set_pending which is
> > defnined in asm-generic/mmiowb.h. Moving asm-generic/mmiowb.h to above
> > asm/io.h can also fix the compiling error.
> >
> > =============
> > diff --git a/arch/mips/include/asm/mmiowb.h b/arch/mips/include/asm/mmiowb.h
> > index a40824e3ef8e..cae2745935bc 100644
> > --- a/arch/mips/include/asm/mmiowb.h
> > +++ b/arch/mips/include/asm/mmiowb.h
> > @@ -2,10 +2,8 @@
> >  #ifndef _ASM_MMIOWB_H
> >  #define _ASM_MMIOWB_H
> > 
> > +#include <asm-generic/mmiowb.h>
> >  #include <asm/io.h>
> > 
> >  #define mmiowb()       iobarrier_w()
> > -
> > -#include <asm-generic/mmiowb.h>
> > -
> >  #endif /* _ASM_MMIOWB_H */
> 
> According to the comment in asm-generic/mmiowb.h, the intention is
> to have the mmiowb definition before the #include, though this would
> only be necessary if there was an "#ifndef mmiowb" fallback in that
> file. If the definition to wmb() works, I'd go for that one and
> leave the include order unchanged.

I didn't add definition of outb(), so it caused the compiling error at
below. Adding it can fix that. I will leave the asm/mmiowb.h as is
since no issue now.

In file included from ./arch/mips/include/asm/io.h:611,
                 from ./arch/mips/include/asm/mmiowb.h:5,
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

