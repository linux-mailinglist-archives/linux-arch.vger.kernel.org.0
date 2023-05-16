Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58577053D1
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 18:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjEPQad (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 12:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjEPQaI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 12:30:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFA76EA2;
        Tue, 16 May 2023 09:30:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F09DF63253;
        Tue, 16 May 2023 16:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2DDC433D2;
        Tue, 16 May 2023 16:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684254599;
        bh=vttB+w6xhJh6dQEXGeNl47yxmySBqTNQCwQjRAMFsBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F35ios5qxCuQ8Is3q1fZpStxc+iW66BXvZYrkzqLOkKDTag5NbB7jod6P/5EHuvI3
         DgtV+qxbyGinI4dTDsUlPLU7Aw0X8+E2yO1h7ml7lD1Bq7Al8I83El4agQ6NIBQ9uf
         ci9BKiUesi8dhdZekHeu6J3VaAgz8KWPHoeR938g=
Date:   Tue, 16 May 2023 18:29:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <2023051643-overtime-unbridle-7cdd@gregkh>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
 <20230516110038.2413224-36-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516110038.2413224-36-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 16, 2023 at 01:00:31PM +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to guard sections of code calling them
> as alternative access methods with CONFIG_HAS_IOPORT checks. For
> uhci-hcd there are a lot of I/O port uses that do have MMIO alternatives
> all selected by uhci_has_pci_registers() so this can be handled by
> UHCI_IN/OUT macros and making uhci_has_pci_registers() constant 0 if
> CONFIG_HAS_IOPORT is unset.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Note: The HAS_IOPORT Kconfig option was added in v6.4-rc1 so
>       per-subsystem patches may be applied independently
> 
>  drivers/usb/host/uhci-hcd.c |  2 +-
>  drivers/usb/host/uhci-hcd.h | 36 +++++++++++++++++++++++-------------
>  2 files changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
> index 7cdc2fa7c28f..fd2408b553cf 100644
> --- a/drivers/usb/host/uhci-hcd.c
> +++ b/drivers/usb/host/uhci-hcd.c
> @@ -841,7 +841,7 @@ static int uhci_count_ports(struct usb_hcd *hcd)
>  
>  static const char hcd_name[] = "uhci_hcd";
>  
> -#ifdef CONFIG_USB_PCI
> +#if defined(CONFIG_USB_PCI) && defined(CONFIG_HAS_IOPORT)
>  #include "uhci-pci.c"
>  #define	PCI_DRIVER		uhci_pci_driver
>  #endif
> diff --git a/drivers/usb/host/uhci-hcd.h b/drivers/usb/host/uhci-hcd.h
> index 0688c3e5bfe2..c77705d03ed0 100644
> --- a/drivers/usb/host/uhci-hcd.h
> +++ b/drivers/usb/host/uhci-hcd.h
> @@ -505,41 +505,49 @@ static inline bool uhci_is_aspeed(const struct uhci_hcd *uhci)
>   * we use memory mapped registers.
>   */
>  
> +#ifdef CONFIG_HAS_IOPORT
> +#define UHCI_IN(x)	x
> +#define UHCI_OUT(x)	x
> +#else
> +#define UHCI_IN(x)	0
> +#define UHCI_OUT(x)
> +#endif
> +
>  #ifndef CONFIG_USB_UHCI_SUPPORT_NON_PCI_HC
>  /* Support PCI only */
>  static inline u32 uhci_readl(const struct uhci_hcd *uhci, int reg)
>  {
> -	return inl(uhci->io_addr + reg);
> +	return UHCI_IN(inl(uhci->io_addr + reg));
>  }
>  
>  static inline void uhci_writel(const struct uhci_hcd *uhci, u32 val, int reg)
>  {
> -	outl(val, uhci->io_addr + reg);
> +	UHCI_OUT(outl(val, uhci->io_addr + reg));

I'm confused now.

So if CONFIG_HAS_IOPORT is enabled, wonderful, all is good.

But if it isn't, then these are just no-ops that do nothing?  So then
the driver will fail to work?  Why have these stubs at all?

Why not just not build the driver at all if this option is not enabled?

thanks,

greg k-h
