Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF04F51D836
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 14:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392178AbiEFM5Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Fri, 6 May 2022 08:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347324AbiEFM5V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 08:57:21 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2BE25AA72
        for <linux-arch@vger.kernel.org>; Fri,  6 May 2022 05:53:36 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-209-ZJ1dDxuMNtSxZCO0jLpoxQ-1; Fri, 06 May 2022 13:53:34 +0100
X-MC-Unique: ZJ1dDxuMNtSxZCO0jLpoxQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.32; Fri, 6 May 2022 13:53:32 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.033; Fri, 6 May 2022 13:53:32 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Maciej W. Rozycki'" <macro@orcam.me.uk>,
        Arnd Bergmann <arnd@kernel.org>
CC:     Rich Felker <dalias@libc.org>,
        "open list:IA64 (Itanium) PLATFORM" <linux-ia64@vger.kernel.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "open list:SPARC + UltraSPARC (sparc/sparc64)" 
        <sparclinux@vger.kernel.org>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Helge Deller <deller@gmx.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: [RFC v2 01/39] Kconfig: introduce HAS_IOPORT option and select it
 as necessary
Thread-Topic: [RFC v2 01/39] Kconfig: introduce HAS_IOPORT option and select
 it as necessary
Thread-Index: AQHYYUSwX3QwDKjE7kKG/gGNt1cnA60Rx6Pg
Date:   Fri, 6 May 2022 12:53:32 +0000
Message-ID: <5239892986c94239a122ab2f7a18a7a5@AcuMS.aculab.com>
References: <CAK8P3a0sJgMSpZB_Butx2gO0hapYZy-Dm_QH-hG5rOaq_ZgsXg@mail.gmail.com>
 <20220505161028.GA492600@bhelgaas>
 <CAK8P3a3fmPExr70+fVb564hZdGAuPtYa-QxgMMe5KLpnY_sTrQ@mail.gmail.com>
 <alpine.DEB.2.21.2205061058540.52331@angie.orcam.me.uk>
 <CAK8P3a0NzG=3tDLCdPj2=A__2r_+xiiUTW=WJCBNp29x_A63Og@mail.gmail.com>
 <alpine.DEB.2.21.2205061314110.52331@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2205061314110.52331@angie.orcam.me.uk>
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
> Sent: 06 May 2022 13:27
> 
> On Fri, 6 May 2022, Arnd Bergmann wrote:
> 
> > >  If this is PCI/PCIe indeed, then an I/O access is just a different bit
> > > pattern put on the bus/in the TLP in the address phase.  So what is there
> > > inherent to the s390 architecture that prevents that different bit pattern
> > > from being used?
> >
> > The hardware design for PCI on s390 is very different from any other
> > architecture, and more abstract. Rather than implementing MMIO register
> > access as pointer dereference, this is a separate CPU instruction that
> > takes a device/bar plus offset as arguments rather than a pointer, and
> > Linux encodes this back into a fake __iomem token.
> 
>  OK, that seems to me like a reasonable and quite a clean design (on the
> hardware side).
> 
>  So what happens if the instruction is given an I/O rather than memory BAR
> as the relevant argument?  Is the address space indicator bit (bit #0)
> simply ignored or what?

You don't understand something...

For a memory BAR pci_ioremap() returns a token that can be used with readl().
On most architectures readl() is just a memory access.
This all fails on an I/O BAR.

For an I/O BAR you want a similar pair of functions.
On x86 the access function would need to use the 'in/out' instructions but
there is no requirement for the token to be the native io port number.
On many non-x86 architectures the access function would be a simple memory
access - but a specific system (eg many ppc) may never actually allow
such mappings to succeed.

You might also want a third PCI mapping function that can map a memory
BAR or an I/O BAR - with a suitable access function.
On x86 this would need something like ioread8() for accesses.
Except that function uses small integers for io port numbers
(which is inherently dangerous).

Nothing except the architecture specific implementation of the function
to access an io BAR would ever go near a function called inb().

The same is really true for other bus type - including ISA and EISA.
(Ignoring the horrid of probing ISI bus devices - hopefully they
are in the ACPI tables??_
If a driver is probed on a ISA bus there ought to be functions
equivalent to pci_ioremap() (for both memory and IO addresses)
that return tokens appropriate for the specific bus.

That is all a different load of churn.


> > >  But that has nothing to do with the presence or absence of any specific
> > > processor instructions.  It's just a limitation of bus glue.  So I guess
> > > it's just that all PCI/PCIe glue logic implementations for s390 have such
> > > a limitation, right?
> >
> > There are separate instructions for PCI memory and config space, but
> > no instructions for I/O space, or for non-PCI MMIO that it could be mapped
> > into.
> 
>  The PCI configuration space was retrofitted into x86 systems (and is
> accessed in an awkward manner with them), but with a new design such a
> clean approach is most welcome IMHO.  Thank you for your explanation.

Actually I think x86 was the initial system for PCI.
The PCI config space 'mess' is all about trying to make
something that wouldn't break existing memory maps.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

