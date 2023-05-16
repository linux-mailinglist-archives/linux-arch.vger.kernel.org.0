Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D80C7057F0
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 21:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjEPTvl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 15:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjEPTvi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 15:51:38 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 9C0E313E
        for <linux-arch@vger.kernel.org>; Tue, 16 May 2023 12:51:31 -0700 (PDT)
Received: (qmail 845160 invoked by uid 1000); 16 May 2023 15:51:30 -0400
Date:   Tue, 16 May 2023 15:51:30 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v4 35/41] usb: uhci: handle HAS_IOPORT dependencies
Message-ID: <23936929-80e4-4599-827a-d09b4960f3ab@rowland.harvard.edu>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
 <20230516110038.2413224-36-schnelle@linux.ibm.com>
 <2023051643-overtime-unbridle-7cdd@gregkh>
 <4e291030-99d9-4b8b-9389-9b8f2560b8e8@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e291030-99d9-4b8b-9389-9b8f2560b8e8@app.fastmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 16, 2023 at 06:44:34PM +0200, Arnd Bergmann wrote:
> On Tue, May 16, 2023, at 18:29, Greg Kroah-Hartman wrote:
> > On Tue, May 16, 2023 at 01:00:31PM +0200, Niklas Schnelle wrote:
> 
> >>  #ifndef CONFIG_USB_UHCI_SUPPORT_NON_PCI_HC
> >>  /* Support PCI only */
> >>  static inline u32 uhci_readl(const struct uhci_hcd *uhci, int reg)
> >>  {
> >> -	return inl(uhci->io_addr + reg);
> >> +	return UHCI_IN(inl(uhci->io_addr + reg));
> >>  }
> >>  
> >>  static inline void uhci_writel(const struct uhci_hcd *uhci, u32 val, int reg)
> >>  {
> >> -	outl(val, uhci->io_addr + reg);
> >> +	UHCI_OUT(outl(val, uhci->io_addr + reg));
> >
> > I'm confused now.
> >
> > So if CONFIG_HAS_IOPORT is enabled, wonderful, all is good.
> >
> > But if it isn't, then these are just no-ops that do nothing?  So then
> > the driver will fail to work?  Why have these stubs at all?
> >
> > Why not just not build the driver at all if this option is not enabled?
> 
> If I remember correctly, the problem here is the lack of
> abstractions in the uhci driver, it instead supports all
> combinations of on-chip non-PCI devices using readb()/writeb()
> and PCI devices using inb()/outb() in a shared codebase.

Isn't that an abstraction?  A single set of operations (uhci_readl(), 
uhci_writel(), etc.) that always does the right sort of I/O even when 
talking to different buses?

So I'm not sure what you mean by "the lack of abstractions".

> A particularly tricky combination is a kernel that supports on-chip
> UHCI as well as CONFIG_USB_PCI (for EHCI/XHCI) but does not support
> I/O ports because of platform limitations. The trick is to come up
> with a set of changes that doesn't have to rewrite the entire logic
> but also doesn't add an obscene number of #ifdef checks.

Indeed, in a kernel supporting that tricky combination the no-op code 
would be generated.  But it would never execute at runtime because the 
uhci_has_pci_registers(uhci) test would always return 0, and so the 
driver wouldn't fail.

> That said, there is a minor problem with the empty definition
> 
> +#define UHCI_OUT(x)
> 
> I think this should be "do { } while (0)" to avoid warnings
> about empty if/else blocks.

I'm sure Niklas wouldn't mind making such a change.  But do we really 
get such warnings?  Does the compiler really think that this kind of 
(macro-expanded) code:

	if (uhci_has_pci_registers(uhci))
		;
	else if (uhci_is_aspeed(uhci))
		writel(val, uhci->regs + uhci_aspeed_reg(reg));

deserves a warning?  I write stuff like that fairly often; it's a good 
way to showcase a high-probability do-nothing pathway at the start of a 
series of conditional cases.  And I haven't noticed any complaints from 
the compiler.

Alan Stern
