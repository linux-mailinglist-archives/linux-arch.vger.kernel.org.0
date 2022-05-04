Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDE1519E77
	for <lists+linux-arch@lfdr.de>; Wed,  4 May 2022 13:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349046AbiEDLuV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 07:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237744AbiEDLuT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 07:50:19 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 136131F623;
        Wed,  4 May 2022 04:46:43 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id A4B0A92009C; Wed,  4 May 2022 13:46:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 9DFED92009B;
        Wed,  4 May 2022 12:46:41 +0100 (BST)
Date:   Wed, 4 May 2022 12:46:41 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     David Laight <David.Laight@ACULAB.COM>
cc:     'Linus Walleij' <linus.walleij@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: RE: [RFC v2 10/39] gpio: add HAS_IOPORT dependencies
In-Reply-To: <c3a3cdd99d4645e2bbbe082808cbb2a5@AcuMS.aculab.com>
Message-ID: <alpine.DEB.2.21.2205041226160.64942@angie.orcam.me.uk>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com> <20220429135108.2781579-19-schnelle@linux.ibm.com> <Ymv3DnS1vPMY8QIg@fedora> <f006229ae056d4cdcf57fc5722a695ad4c257182.camel@linux.ibm.com> <YmwGLrh4U+pVJo0m@fedora>
 <CACRpkdaha37y-ZNSqYSbf=TvsJNcvbH1Y=N0JkVCewB-Lvf81Q@mail.gmail.com> <c3a3cdd99d4645e2bbbe082808cbb2a5@AcuMS.aculab.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 3 May 2022, David Laight wrote:

> > > There is such a thing as ISA DMA, but you'll still need to initialize
> > > the device via the IO Port bus first, so perhaps setting HAS_IOPORT for
> > > "config ISA" is the right thing to do: all ISA devices are expected to
> > > communicate in some way via ioport.
> > 
> > Adding that dependency seems like the right solution to me.
> 
> I think it all depends on what HAS_IOPORT is meant to mean and
> how portable kernel binaries need to be.
> 
> x86 is (probably) the only architecture that actually has 'in'
> and 'out' instructions - but that doesn't mean that some other
> cpu (and I mean cpu+pcb not architecture) have the ability to
> generate 'IO' bus cycles on a specific physical bus.

 I am fairly sure IA-64 has some form of IN/OUT machine instructions too.

> While the obvious case is a physical address window that generates
> PCI(e) IO cycles from normal memory cycles it isn't the only one.
> 
> I've used sparc cpu systems that have pcmcia card slots.
> These are pretty much ISA and the drivers might expect to
> access port 0x300 (etc) - certainly that would be right on x86.
> 
> In this case is isn't so much that the ISA_BUS depends on support
> for in/out but that presence of the ISA bus provides the required
> in/out support.

 Well, one can implement a pluggable PCI/e expansion card with a PCI-ISA 
bridge on it and a backplane to plug ISA cards into.  Without support for 
issuing I/O cycles to PCI from the host however you won't be able to make 
use of the ISA backplane except maybe for some ancient ISA memory cards.  
So logically I think CONFIG_ISA should depend on CONFIG_HAS_IOPORT and 
CONFIG_HAS_IOPORT ought to be selected by platform configurations.

 ISTR there was a company that manufactured a USB-ISA option (providing an 
external ISA backplane).  We never supported it, but in principle if we 
wanted to, then it would be the USB-ISA device's driver config option that 
CONFIG_ISA would additionally depend on as an alternative.  That wouldn't 
enable CONFIG_HAS_IOPORT though because the presence of this particular 
USB-ISA device would not itself permit the use of I/O cycles with any 
PCI/e buses a machine might independently have, so devices for PCI/e 
options that require port I/O shouldn't be made available at the same 
time.

 I think that company might have actually manufactured a similar PCI-ISA 
option as well, but that I suppose did rely on support for I/O cycles on 
PCI.  Early 2000s BTW.

  Maciej
