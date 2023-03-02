Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67DD6A7D56
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 10:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjCBJKT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 04:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjCBJKQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 04:10:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927F614992
        for <linux-arch@vger.kernel.org>; Thu,  2 Mar 2023 01:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677748169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BAmp8cQXmAY8O+zkFjEu1kD8x7lwlOJ1BmEXR6luRcA=;
        b=Mf7i5btw/inxfHGyyEtjHuKN2H7+PIyB+HXIq9QB0N4pMJiTkaFtVcNFHs3M4UdkLHMyGb
        yn2Vmk6JO7Hf+iaCDBVap+X31AhfG70NbO+jVfGR/Yfo4ob33NIu1/EY+s6BuLNYOPa30I
        rVxV0KMiaDUObMRQG27vwU3Li3hH4ao=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-S7owwZrhMpm03B2s7hegTg-1; Thu, 02 Mar 2023 04:09:23 -0500
X-MC-Unique: S7owwZrhMpm03B2s7hegTg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C59DD80351F;
        Thu,  2 Mar 2023 09:09:22 +0000 (UTC)
Received: from localhost (ovpn-12-142.pek2.redhat.com [10.72.12.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E8382492B00;
        Thu,  2 Mar 2023 09:09:21 +0000 (UTC)
Date:   Thu, 2 Mar 2023 17:09:18 +0800
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
Message-ID: <ZABnvqNJR/8oQbbM@bhe.users.ipa.redhat.com>
References: <20230301102208.148490-1-bhe@redhat.com>
 <20230301102208.148490-2-bhe@redhat.com>
 <5edd5304-ef11-4607-9189-a07613ecfee2@app.fastmail.com>
 <ZAAiJcx80RU0QuHw@MiWiFi-R3L-srv>
 <b2958824-786b-46d7-a880-17c948fbe2b0@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2958824-786b-46d7-a880-17c948fbe2b0@app.fastmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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

Ah, I didn't notice the comment. Then will change the definition to
wmb(). Thanks.

