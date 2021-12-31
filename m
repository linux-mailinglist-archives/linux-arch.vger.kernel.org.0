Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3491248254D
	for <lists+linux-arch@lfdr.de>; Fri, 31 Dec 2021 18:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhLaRPH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Dec 2021 12:15:07 -0500
Received: from netrider.rowland.org ([192.131.102.5]:43085 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229632AbhLaRPH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Dec 2021 12:15:07 -0500
Received: (qmail 1134742 invoked by uid 1000); 31 Dec 2021 12:15:06 -0500
Date:   Fri, 31 Dec 2021 12:15:06 -0500
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
Message-ID: <Yc86mvCUe2mHCa57@rowland.harvard.edu>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-32-schnelle@linux.ibm.com>
 <YcojyRhALdm40gfk@rowland.harvard.edu>
 <8bda347ea30b60f1edb55693ff7509e7f7b1f979.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bda347ea30b60f1edb55693ff7509e7f7b1f979.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 31, 2021 at 12:06:24PM +0100, Niklas Schnelle wrote:
> On Mon, 2021-12-27 at 15:36 -0500, Alan Stern wrote:
> > On Mon, Dec 27, 2021 at 05:43:16PM +0100, Niklas Schnelle wrote:
> > > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > > not being declared. We thus need to guard sections of code calling them
> > > as alternative access methods with CONFIG_HAS_IOPORT checks. Similarly
> > > drivers requiring these functions need to depend on HAS_IOPORT.
> > 
> > A few things in here can be improved.
> > 
> > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > ---

> > > diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> > > index ef08d68b9714..bba320194027 100644
> > > --- a/drivers/usb/host/pci-quirks.c
> > > +++ b/drivers/usb/host/pci-quirks.c
> > > +#ifdef CONFIG_USB_PCI_AMD
> > > +#if IS_ENABLED(CONFIG_USB_UHCI_HCD) && defined(CONFIG_HAS_IOPORT)
> > 
> > In the original, the following code will be compiled even if
> > CONFIG_USB_UHCI_HCD is not enabled.  You shouldn't change that.
> 
> If this was only '#ifdef CONFIG_HAS_IOPORT' we would leave
> uhci_reset_hc() undeclared in the case where CONFIG_HAS_IOPORT is
> unset. This function however is also called from uhci-pci.c. That on
> the other hand is built only if CONFIG_USB_UHCI_HCD is set so if we
> depend on both config options we can get rid of all calls and have the
> functions undeclared.

But you changed the guard around the '#include "uhci-pci.c"' line in 
uhci-hcd.c, so uhci-pci.c won't be built if CONFIG_HAS_IOPORT is unset.  
Thus there won't be an undefined function call regardless.

You see, even if the kernel isn't configured to include a UHCI driver, 
it's still important to hand off and disable any PCI UHCI hardware when 
the system starts up.  Otherwise you can get all sorts of crazy 
interrupts and DMA from the BIOS.

> > >  /*
> > >   * Make sure the controller is completely inactive, unable to
> > >   * generate interrupts or do DMA.
> > > @@ -1273,7 +1277,8 @@ static void quirk_usb_early_handoff(struct pci_dev *pdev)
> > >  			 "Can't enable PCI device, BIOS handoff failed.\n");
> > >  		return;
> > >  	}
> > > -	if (pdev->class == PCI_CLASS_SERIAL_USB_UHCI)
> > > +	if (IS_ENABLED(CONFIG_USB_UHCI_HCD) &&
> > > +	    pdev->class == PCI_CLASS_SERIAL_USB_UHCI)
> > >  		quirk_usb_handoff_uhci(pdev);
> > 
> > Same idea here.
> 
> Hmm, I'm not 100% sure if the IS_ENABLED(CONFIG_USB_UHCI_HCD) depends
> on some compiler optimizations for it to be ok that
> uhci_check_and_reset_hc() is not declared in the case where both
> CONFIG_HAS_IOPORT and CONFIG_USB_UHCI_HCD are unset. Maybe that should
> be a plain ifdef.

The reasoning should be exactly the same as in the previous case.

> > > diff --git a/drivers/usb/host/uhci-hcd.h b/drivers/usb/host/uhci-hcd.h
> > > index 8ae5ccd26753..8e30116b6fd2 100644
> > > --- a/drivers/usb/host/uhci-hcd.h
> > > +++ b/drivers/usb/host/uhci-hcd.h
> > > @@ -586,12 +586,14 @@ static inline int uhci_aspeed_reg(unsigned int reg)
> > >  
> > >  static inline u32 uhci_readl(const struct uhci_hcd *uhci, int reg)
> > >  {
> > > +#ifdef CONFIG_HAS_IOPORT
> > >  	if (uhci_has_pci_registers(uhci))
> > >  		return inl(uhci->io_addr + reg);
> > > -	else if (uhci_is_aspeed(uhci))
> > > +#endif
> > 
> > Instead of making all these changes (here and in the hunks below), you
> > can simply modify the definition of uhci_has_pci_registers() so that it
> > always gives 0 when CONFIG_HAS_IOPORT is N.
> > 
> > Alan Stern
> 
> I don't think that works, for example in the hunk you quoted returning
> 0 from uhci_has_pci_registers() only skips over the inl() at run-time.
> We're aiming to have inl() undeclared if HAS_IOPORT is unset though.

I see.  Do you think the following would be acceptable?  Add:

#ifdef CONFIG_HAS_IOPORT
#define UHCI_IN(x)	x
#define UHCI_OUT(x)	x
#else
#define UHCI_IN(x)	0
#define UHCI_OUT(x)
#endif

and then replace for example inl(uhci->io_addr + reg) with 
UHCI_IN(inl(uhci->io_addr + reg)).

The definition of uhci_has_pci_registers() should be updated in any 
case; there's no reason for it to do a runtime check of uhci->io_addr 
when HAS_IOPORT is disabled.

Alan Stern
