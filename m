Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0A451A023
	for <lists+linux-arch@lfdr.de>; Wed,  4 May 2022 15:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349855AbiEDNGG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 09:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241199AbiEDNGF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 09:06:05 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2837235DE7;
        Wed,  4 May 2022 06:02:29 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 3B7EF92009C; Wed,  4 May 2022 15:02:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 3198792009B;
        Wed,  4 May 2022 14:02:28 +0100 (BST)
Date:   Wed, 4 May 2022 14:02:28 +0100 (BST)
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
In-Reply-To: <7bb4d0286f44462581d96320cfe105d6@AcuMS.aculab.com>
Message-ID: <alpine.DEB.2.21.2205041352520.9548@angie.orcam.me.uk>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com> <20220429135108.2781579-19-schnelle@linux.ibm.com> <Ymv3DnS1vPMY8QIg@fedora> <f006229ae056d4cdcf57fc5722a695ad4c257182.camel@linux.ibm.com> <YmwGLrh4U+pVJo0m@fedora>
 <CACRpkdaha37y-ZNSqYSbf=TvsJNcvbH1Y=N0JkVCewB-Lvf81Q@mail.gmail.com> <c3a3cdd99d4645e2bbbe082808cbb2a5@AcuMS.aculab.com> <alpine.DEB.2.21.2205041226160.64942@angie.orcam.me.uk> <7bb4d0286f44462581d96320cfe105d6@AcuMS.aculab.com>
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

On Wed, 4 May 2022, David Laight wrote:

> >  Well, one can implement a pluggable PCI/e expansion card with a PCI-ISA
> > bridge on it and a backplane to plug ISA cards into.  Without support for
> > issuing I/O cycles to PCI from the host however you won't be able to make
> > use of the ISA backplane except maybe for some ancient ISA memory cards.
> > So logically I think CONFIG_ISA should depend on CONFIG_HAS_IOPORT and
> > CONFIG_HAS_IOPORT ought to be selected by platform configurations.
> 
> But generating a PCI(e) I/O cycle doesn't need the cpu to be able to
> generate an I/O cycle on its local bus interface.
> All that required is for the PCI(e) host bridge to determine that it
> needs to relevant kind of cycle on the target bus.
> This can easily be based on the physical address.

 Sure, you can encode address spaces however you like (there are no 
special machine instructions either for PCI/e configuration space access 
that I would know of in any CPU architecture), but the host bridge must be 
willing to issue those PCI/e I/O cycles in the first place (see my other 
message on POWER9 in this thread).

> What you should probably be doing is (outside of 'platform' code)
> change the drivers to use ioread8() instead of inb().
> Then adding in the required calls to get the correct 'token' to
> pass to ioread8() to perform an I/O cycle on the correct target bus.

 Yes, probably.

> It is really the attachment of the driver that can't succeed, not the
> compilation.

 Except it makes no sense to offer those drivers for platforms known not 
to provide for port I/O on PCI/e.

  Maciej
