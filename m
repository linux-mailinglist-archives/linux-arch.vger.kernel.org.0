Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE41E57A2AC
	for <lists+linux-arch@lfdr.de>; Tue, 19 Jul 2022 17:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbiGSPJl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 19 Jul 2022 11:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiGSPJk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jul 2022 11:09:40 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60F2B50721
        for <linux-arch@vger.kernel.org>; Tue, 19 Jul 2022 08:09:39 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-183-zqQ9LstYPPWsc5DQ7f8mTg-1; Tue, 19 Jul 2022 16:09:36 +0100
X-MC-Unique: zqQ9LstYPPWsc5DQ7f8mTg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Tue, 19 Jul 2022 16:09:35 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Tue, 19 Jul 2022 16:09:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Stafford Horne' <shorne@gmail.com>, Arnd Bergmann <arnd@arndb.de>
CC:     Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] asm-generic: Add new pci.h and use it
Thread-Topic: [PATCH v2 2/2] asm-generic: Add new pci.h and use it
Thread-Index: AQHYm2+TjSo9GtSn30WwmySb6t2iTK2Fy5bA
Date:   Tue, 19 Jul 2022 15:09:35 +0000
Message-ID: <874af766883a4c0da6759eff433ec6d6@AcuMS.aculab.com>
References: <20220717033453.2896843-1-shorne@gmail.com>
 <20220717033453.2896843-3-shorne@gmail.com> <YtTjeEnKr8f8z4JS@infradead.org>
 <CAK8P3a1KJe4K5g1z-Faoxc9NhXqjCUWxnvk2HPxsj2wzG_iDbg@mail.gmail.com>
 <CAAfxs740yz1vJmtFHOPTXT6fqi0+37SR_OhoGsONe4mx_21+_g@mail.gmail.com>
 <CAK8P3a1Mo9+-t21rkP8SDnPrmbj3-uuVPtmHbeUerAevxN3TNw@mail.gmail.com>
 <YtaNvpE7AA/4eV1I@antec>
 <CAK8P3a2UTND+F83k2uQ+f=o1GWV=oa5coshy8Hy+cKHUGuNzEg@mail.gmail.com>
 <YtaiSEAnMhVqR4HS@antec>
In-Reply-To: <YtaiSEAnMhVqR4HS@antec>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Stafford Horne
> Sent: 19 July 2022 13:24
> 
> On Tue, Jul 19, 2022 at 01:55:03PM +0200, Arnd Bergmann wrote:
> > On Tue, Jul 19, 2022 at 12:55 PM Stafford Horne <shorne@gmail.com> wrote:
> >
> > > diff --git a/drivers/comedi/drivers/comedi_isadma.c b/drivers/comedi/drivers/comedi_isadma.c
> > > index 700982464c53..508421809128 100644
> > > --- a/drivers/comedi/drivers/comedi_isadma.c
> > > +++ b/drivers/comedi/drivers/comedi_isadma.c
> > > @@ -104,8 +104,10 @@ unsigned int comedi_isadma_poll(struct comedi_isadma *dma)
> > >
> > >         flags = claim_dma_lock();
> > >         clear_dma_ff(desc->chan);
> > > +#ifdef CONFIG_X86_32
> > >         if (!isa_dma_bridge_buggy)
> > >                 disable_dma(desc->chan);
> > > +#endif
> >
> > There is a logic mistake here: if we are on something other than x86-32,
> > this always needs to call the disable_dma()/enable_dma().
> 
> Oops, thats right.  Sorry, I should have noticed that.
> 
> > Not sure how to best express this in a readable way, something like this
> > would work:
> 
> Option 1:
> 
> > #ifdef CONFIG_X86_32
> >         if (!isa_dma_bridge_buggy)
> > #endif
> >                disable_dma(desc->chan);
> >
> >
> > or possibly at the start of this file, a
> 
> Option 2:
> 
> > #ifndef CONFIG_X86_32
> > #define isa_dma_bridge_buggy 0
> > #endif
> 
> Option 3:
> 
> > Or we could try to keep the generic definition in a global header
> > like linux/isa-dma.h.
> 
> Perhaps option 3 makes the whole patch the most clean.

Isn't there a define that can be used inside an if?
So you could do:
		if (!IS_CONFIG_X86_32 || !isa_dma_bridge_buggy)
			disable_dma();
(but I can't remember the name!)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

