Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FFE705891
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 22:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjEPURv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 16:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjEPURs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 16:17:48 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 827D96A72
        for <linux-arch@vger.kernel.org>; Tue, 16 May 2023 13:17:46 -0700 (PDT)
Received: (qmail 846405 invoked by uid 1000); 16 May 2023 16:17:45 -0400
Date:   Tue, 16 May 2023 16:17:45 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v4 35/41] usb: uhci: handle HAS_IOPORT dependencies
Message-ID: <2c03973e-0635-4dbb-a1df-bfda8cbee161@rowland.harvard.edu>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
 <20230516110038.2413224-36-schnelle@linux.ibm.com>
 <2023051643-overtime-unbridle-7cdd@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023051643-overtime-unbridle-7cdd@gregkh>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 16, 2023 at 06:29:56PM +0200, Greg Kroah-Hartman wrote:
> On Tue, May 16, 2023 at 01:00:31PM +0200, Niklas Schnelle wrote:
> > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > not being declared. We thus need to guard sections of code calling them
> > as alternative access methods with CONFIG_HAS_IOPORT checks. For
> > uhci-hcd there are a lot of I/O port uses that do have MMIO alternatives
> > all selected by uhci_has_pci_registers() so this can be handled by
> > UHCI_IN/OUT macros and making uhci_has_pci_registers() constant 0 if
> > CONFIG_HAS_IOPORT is unset.
> > 
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> > Note: The HAS_IOPORT Kconfig option was added in v6.4-rc1 so
> >       per-subsystem patches may be applied independently
> > 
> >  drivers/usb/host/uhci-hcd.c |  2 +-
> >  drivers/usb/host/uhci-hcd.h | 36 +++++++++++++++++++++++-------------
> >  2 files changed, 24 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
> > index 7cdc2fa7c28f..fd2408b553cf 100644
> > --- a/drivers/usb/host/uhci-hcd.c
> > +++ b/drivers/usb/host/uhci-hcd.c
> > @@ -841,7 +841,7 @@ static int uhci_count_ports(struct usb_hcd *hcd)
> >  
> >  static const char hcd_name[] = "uhci_hcd";
> >  
> > -#ifdef CONFIG_USB_PCI
> > +#if defined(CONFIG_USB_PCI) && defined(CONFIG_HAS_IOPORT)
> >  #include "uhci-pci.c"
> >  #define	PCI_DRIVER		uhci_pci_driver
> >  #endif
> > diff --git a/drivers/usb/host/uhci-hcd.h b/drivers/usb/host/uhci-hcd.h
> > index 0688c3e5bfe2..c77705d03ed0 100644
> > --- a/drivers/usb/host/uhci-hcd.h
> > +++ b/drivers/usb/host/uhci-hcd.h
> > @@ -505,41 +505,49 @@ static inline bool uhci_is_aspeed(const struct uhci_hcd *uhci)
> >   * we use memory mapped registers.
> >   */
> >  
> > +#ifdef CONFIG_HAS_IOPORT
> > +#define UHCI_IN(x)	x
> > +#define UHCI_OUT(x)	x
> > +#else
> > +#define UHCI_IN(x)	0
> > +#define UHCI_OUT(x)
> > +#endif
> > +
> >  #ifndef CONFIG_USB_UHCI_SUPPORT_NON_PCI_HC
> >  /* Support PCI only */
> >  static inline u32 uhci_readl(const struct uhci_hcd *uhci, int reg)
> >  {
> > -	return inl(uhci->io_addr + reg);
> > +	return UHCI_IN(inl(uhci->io_addr + reg));
> >  }
> >  
> >  static inline void uhci_writel(const struct uhci_hcd *uhci, u32 val, int reg)
> >  {
> > -	outl(val, uhci->io_addr + reg);
> > +	UHCI_OUT(outl(val, uhci->io_addr + reg));
> 
> I'm confused now.
> 
> So if CONFIG_HAS_IOPORT is enabled, wonderful, all is good.
> 
> But if it isn't, then these are just no-ops that do nothing?  So then
> the driver will fail to work?  Why have these stubs at all?
> 
> Why not just not build the driver at all if this option is not enabled?

I should add something to my previous email.  This particular section of 
code is protected by:

#ifndef CONFIG_USB_UHCI_SUPPORT_NON_PCI_HC
/* Support PCI only */

So it gets used only in cases where the driver supports just a PCI bus 
-- no other sorts of non-PCI on-chip devices.  But the preceding patch 
in this series changes the Kconfig file to say:

 config USB_UHCI_HCD
	tristate "UHCI HCD (most Intel and VIA) support"
	depends on (USB_PCI && HAS_IOPORT) || USB_UHCI_SUPPORT_NON_PCI_HC

As a result, when the configuration includes support only for PCI 
controllers the driver won't get built unless HAS_IOPORT is set.  Thus 
the no-op case (in this part of the code) can't arise.

Which is a long-winded way of saying that you're right; the UHCI_IN() 
and UHCI_OUT() wrappers aren't needed in this part of the driver.  I 
guess Niklas put them in either for consistency with the rest of the 
code or because it didn't occur to him that they could be omitted.  (And 
I didn't spot it either.)

Alan Stern
