Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B0151BAE0
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 10:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiEEItY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 May 2022 04:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241214AbiEEIs5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2022 04:48:57 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30906B93;
        Thu,  5 May 2022 01:45:15 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 4E39792009C; Thu,  5 May 2022 10:45:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 4A38F92009B;
        Thu,  5 May 2022 09:45:14 +0100 (BST)
Date:   Thu, 5 May 2022 09:45:14 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Arnd Bergmann <arnd@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [RFC v2 25/39] pcmcia: add HAS_IOPORT dependencies
In-Reply-To: <20220504172201.GA454911@bhelgaas>
Message-ID: <alpine.DEB.2.21.2205050917160.52331@angie.orcam.me.uk>
References: <20220504172201.GA454911@bhelgaas>
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

On Wed, 4 May 2022, Bjorn Helgaas wrote:

> >  Well, yes, except I would expect POWER9_CPU (and any higher versions we 
> > eventually get) to clear HAS_IOPORT.  Generic configurations (GENERIC_CPU) 
> > would set HAS_IOPORT of course, as would any lower architecture variants 
> > that do or may support port I/O (it's not clear to me if there are any 
> > that do not).  Ideally a generic configuration would not issue accesses to 
> > random MMIO locations for port I/O accesses via `inb'/`outb', etc. for 
> > systems that do not support port I/O (which it now does, or at least used 
> > to until recently).
> 
> It would seem weird to me that a module would build and run on a
> generic kernel running on POWER9 (with some safe way of handling
> inb/outb that don't actually work), but not on a kernel built
> specifically for POWER9_CPU.

 Why?  If you say configure your Alpha kernel for ALPHA_JENSEN, a pure 
EISA system, then you won't get PCI support nor any PCI drivers offered 
even though a generic Alpha kernel will get them all and still run on a 
Jensen system.  I find that no different from our case here.

 And if we do ever get TURBOchannel Alpha support, then a generic kernel 
configuration will offer EISA, PCI and TURBOchannel drivers, while you 
won't be offered TURBOchannel drivers for a PCI system and vice versa.  
It would make no sense to me.

 Please mind that the main objective for system-specific configurations is 
optimisation, including both size and speed, and a part of the solution is 
discarding stuff that's irrelevant for the respective system.  So in our 
case we do want any port I/O code not to be there at all in compiled code 
and consequently any driver that absolutely requires port I/O code to work 
will have to become a useless stub in its compiled form.  What would be 
the point then of having it there in the first place except to spread 
confusion?

  Maciej
