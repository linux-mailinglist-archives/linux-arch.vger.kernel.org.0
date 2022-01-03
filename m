Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCAF48349B
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 17:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbiACQPS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 11:15:18 -0500
Received: from netrider.rowland.org ([192.131.102.5]:41187 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S233046AbiACQPR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 11:15:17 -0500
Received: (qmail 1188656 invoked by uid 1000); 3 Jan 2022 11:15:16 -0500
Date:   Mon, 3 Jan 2022 11:15:16 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [RFC 31/32] usb: handle HAS_IOPORT dependencies
Message-ID: <YdMhFKOdBsDvFStt@rowland.harvard.edu>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-32-schnelle@linux.ibm.com>
 <YcojyRhALdm40gfk@rowland.harvard.edu>
 <8bda347ea30b60f1edb55693ff7509e7f7b1f979.camel@linux.ibm.com>
 <Yc86mvCUe2mHCa57@rowland.harvard.edu>
 <5a271c9e80ee394ecb41297e66d687e035a823ce.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a271c9e80ee394ecb41297e66d687e035a823ce.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 03, 2022 at 12:35:45PM +0100, Niklas Schnelle wrote:
> On Fri, 2021-12-31 at 12:15 -0500, Alan Stern wrote:
> > On Fri, Dec 31, 2021 at 12:06:24PM +0100, Niklas Schnelle wrote:
> > > On Mon, 2021-12-27 at 15:36 -0500, Alan Stern wrote:
> > > > On Mon, Dec 27, 2021 at 05:43:16PM +0100, Niklas Schnelle wrote:

> > > > > diff --git a/drivers/usb/host/uhci-hcd.h b/drivers/usb/host/uhci-hcd.h
> > > > > index 8ae5ccd26753..8e30116b6fd2 100644
> > > > > --- a/drivers/usb/host/uhci-hcd.h
> > > > > +++ b/drivers/usb/host/uhci-hcd.h
> > > > > @@ -586,12 +586,14 @@ static inline int uhci_aspeed_reg(unsigned int reg)
> > > > >  
> > > > >  static inline u32 uhci_readl(const struct uhci_hcd *uhci, int reg)
> > > > >  {
> > > > > +#ifdef CONFIG_HAS_IOPORT
> > > > >  	if (uhci_has_pci_registers(uhci))
> > > > >  		return inl(uhci->io_addr + reg);
> > > > > -	else if (uhci_is_aspeed(uhci))
> > > > > +#endif
> > > > 
> > > > Instead of making all these changes (here and in the hunks below), you
> > > > can simply modify the definition of uhci_has_pci_registers() so that it
> > > > always gives 0 when CONFIG_HAS_IOPORT is N.
> > > > 
> > > > Alan Stern
> > > 
> > > I don't think that works, for example in the hunk you quoted returning
> > > 0 from uhci_has_pci_registers() only skips over the inl() at run-time.
> > > We're aiming to have inl() undeclared if HAS_IOPORT is unset though.
> > 
> > I see.  Do you think the following would be acceptable?  Add:
> > 
> > #ifdef CONFIG_HAS_IOPORT
> > #define UHCI_IN(x)	x
> > #define UHCI_OUT(x)	x
> > #else
> > #define UHCI_IN(x)	0
> > #define UHCI_OUT(x)
> > #endif
> > 
> > and then replace for example inl(uhci->io_addr + reg) with 
> > UHCI_IN(inl(uhci->io_addr + reg)).
> 
> In principle that looks like a valid approach. Not sure this is better
> than explicit ifdefs though.

The general preference in the kernel is to avoid sprinkling #ifdef's 
throughout function definitions, and instead encapsulate their effects 
with macros or inline functions -- like this.

>  With this approach one could add
> UHCI_IN()/UHCI_OUT() calls which end up as nops without realizing it as
> it would disable any compile time warning for using them without
> guarding against CONFIG_HAS_IOPORT being undefined.

To help prevent that, we can add

#undef UHCI_IN
#undef UHCI_OUT

at the end of this section.

> > The definition of uhci_has_pci_registers() should be updated in any 
> > case; there's no reason for it to do a runtime check of uhci->io_addr 
> > when HAS_IOPORT is disabled.
> 
> Agree. Interestingly same as with the "if
> (IS_ENABLED(CONFIG_HAS_IOPORT))" it seems having
> uhci_has_pci_registers() compile-time defined to 0 (I added a
> defined(CONFIG_HAS_IOPORT) to it) makes the compiler ignore the missing
> inl() decleration already. But I'm not sure if we should rely on that.

I definitely would not rely on it.

Alan Stern
