Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE6A519FD6
	for <lists+linux-arch@lfdr.de>; Wed,  4 May 2022 14:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349941AbiEDMtn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 4 May 2022 08:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344100AbiEDMtm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 08:49:42 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8313635DE6
        for <linux-arch@vger.kernel.org>; Wed,  4 May 2022 05:46:02 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-321-6Zv0gshzMsK-8vWOOuH8bg-1; Wed, 04 May 2022 13:45:59 +0100
X-MC-Unique: 6Zv0gshzMsK-8vWOOuH8bg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Wed, 4 May 2022 13:45:58 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Wed, 4 May 2022 13:45:58 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Maciej W. Rozycki'" <macro@orcam.me.uk>
CC:     'Linus Walleij' <linus.walleij@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: RE: [RFC v2 10/39] gpio: add HAS_IOPORT dependencies
Thread-Topic: [RFC v2 10/39] gpio: add HAS_IOPORT dependencies
Thread-Index: AQHYXaY4HSGVKKYe1UmuRZfv/6NY/a0NHk4QgAFu34CAABvB8A==
Date:   Wed, 4 May 2022 12:45:58 +0000
Message-ID: <7bb4d0286f44462581d96320cfe105d6@AcuMS.aculab.com>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
 <20220429135108.2781579-19-schnelle@linux.ibm.com> <Ymv3DnS1vPMY8QIg@fedora>
 <f006229ae056d4cdcf57fc5722a695ad4c257182.camel@linux.ibm.com>
 <YmwGLrh4U+pVJo0m@fedora>
 <CACRpkdaha37y-ZNSqYSbf=TvsJNcvbH1Y=N0JkVCewB-Lvf81Q@mail.gmail.com>
 <c3a3cdd99d4645e2bbbe082808cbb2a5@AcuMS.aculab.com>
 <alpine.DEB.2.21.2205041226160.64942@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2205041226160.64942@angie.orcam.me.uk>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Maciej W. Rozycki
> Sent: 04 May 2022 12:47
> 
> On Tue, 3 May 2022, David Laight wrote:
> 
> > > > There is such a thing as ISA DMA, but you'll still need to initialize
> > > > the device via the IO Port bus first, so perhaps setting HAS_IOPORT for
> > > > "config ISA" is the right thing to do: all ISA devices are expected to
> > > > communicate in some way via ioport.
> > >
> > > Adding that dependency seems like the right solution to me.
> >
> > I think it all depends on what HAS_IOPORT is meant to mean and
> > how portable kernel binaries need to be.
> >
> > x86 is (probably) the only architecture that actually has 'in'
> > and 'out' instructions - but that doesn't mean that some other
> > cpu (and I mean cpu+pcb not architecture) have the ability to
> > generate 'IO' bus cycles on a specific physical bus.
> 
>  I am fairly sure IA-64 has some form of IN/OUT machine instructions too.
> 
> > While the obvious case is a physical address window that generates
> > PCI(e) IO cycles from normal memory cycles it isn't the only one.
> >
> > I've used sparc cpu systems that have pcmcia card slots.
> > These are pretty much ISA and the drivers might expect to
> > access port 0x300 (etc) - certainly that would be right on x86.
> >
> > In this case is isn't so much that the ISA_BUS depends on support
> > for in/out but that presence of the ISA bus provides the required
> > in/out support.
> 
>  Well, one can implement a pluggable PCI/e expansion card with a PCI-ISA
> bridge on it and a backplane to plug ISA cards into.  Without support for
> issuing I/O cycles to PCI from the host however you won't be able to make
> use of the ISA backplane except maybe for some ancient ISA memory cards.
> So logically I think CONFIG_ISA should depend on CONFIG_HAS_IOPORT and
> CONFIG_HAS_IOPORT ought to be selected by platform configurations.

But generating a PCI(e) I/O cycle doesn't need the cpu to be able to
generate an I/O cycle on its local bus interface.
All that required is for the PCI(e) host bridge to determine that it
needs to relevant kind of cycle on the target bus.
This can easily be based on the physical address.

Many years ago I used a system with the strongarm SA1100/1101 pair.
(Not running Linux, but I think that it could have - slowly.)
Two (adjacent?) areas of the physical address map generated memory
and I/O cycles to a pair of pcmcia slots.
What you end up with is definitely ISA, but ARM definitely doesn't
have in/out instructions.

Now, while this is rather hypothetical, a 'generic' arm kernel running
on that hardware would be able to support drivers that expect an ISA bus.
But on different hardware the same generic kernel would have nowhere
to 'attach' the same drivers - but they could still be part of the kernel
(maybe as modules).

What you should probably be doing is (outside of 'platform' code)
change the drivers to use ioread8() instead of inb().
Then adding in the required calls to get the correct 'token' to
pass to ioread8() to perform an I/O cycle on the correct target bus.

It is really the attachment of the driver that can't succeed, not the
compilation.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

