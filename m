Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB32F515D19
	for <lists+linux-arch@lfdr.de>; Sat, 30 Apr 2022 14:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359740AbiD3NAE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Apr 2022 09:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354968AbiD3NAB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Apr 2022 09:00:01 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1E54D674F5
        for <linux-arch@vger.kernel.org>; Sat, 30 Apr 2022 05:56:38 -0700 (PDT)
Received: (qmail 986304 invoked by uid 1000); 30 Apr 2022 08:56:38 -0400
Date:   Sat, 30 Apr 2022 08:56:38 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>
Subject: Re: [RFC v2 35/39] usb: handle HAS_IOPORT dependencies
Message-ID: <Ym0yBti0J5w2S59W@rowland.harvard.edu>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
 <20220429135108.2781579-65-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429135108.2781579-65-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 29, 2022 at 03:51:02PM +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to guard sections of code calling them
> as alternative access methods with CONFIG_HAS_IOPORT checks. Similarly
> drivers requiring these functions need to depend on HAS_IOPORT.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---

...

> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index ef08d68b9714..4fd06b48149d 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c

> @@ -632,7 +590,53 @@ bool usb_amd_pt_check_port(struct device *device, int port)
>  	return !(value & BIT(port_shift));
>  }
>  EXPORT_SYMBOL_GPL(usb_amd_pt_check_port);
> +#endif
> @@ -1273,7 +1280,8 @@ static void quirk_usb_early_handoff(struct pci_dev *pdev)
>  			 "Can't enable PCI device, BIOS handoff failed.\n");
>  		return;
>  	}
> -	if (pdev->class == PCI_CLASS_SERIAL_USB_UHCI)
> +	if (IS_ENABLED(CONFIG_USB_UHCI_HCD) &&
> +	    pdev->class == PCI_CLASS_SERIAL_USB_UHCI)
>  		quirk_usb_handoff_uhci(pdev);

We discussed this already.  quirk_usb_handoff_uhci() is supposed to be 
called even when CONFIG_USB_UHCI_HCD isn't enabled.

...

> diff --git a/drivers/usb/host/uhci-hcd.h b/drivers/usb/host/uhci-hcd.h
> index 8ae5ccd26753..be4aee1f0ca5 100644
> --- a/drivers/usb/host/uhci-hcd.h
> +++ b/drivers/usb/host/uhci-hcd.h
> @@ -505,36 +505,43 @@ static inline bool uhci_is_aspeed(const struct uhci_hcd *uhci)
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

Should have a blank line here.

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
>  }
>  
>  static inline u16 uhci_readw(const struct uhci_hcd *uhci, int reg)
>  {
> -	return inw(uhci->io_addr + reg);
> +	return UHCI_IN(inw(uhci->io_addr + reg));
>  }
>  
>  static inline void uhci_writew(const struct uhci_hcd *uhci, u16 val, int reg)
>  {
> -	outw(val, uhci->io_addr + reg);
> +	UHCI_OUT(outw(val, uhci->io_addr + reg));
>  }
>  
>  static inline u8 uhci_readb(const struct uhci_hcd *uhci, int reg)
>  {
> -	return inb(uhci->io_addr + reg);
> +	return UHCI_IN(inb(uhci->io_addr + reg));
>  }
>  
>  static inline void uhci_writeb(const struct uhci_hcd *uhci, u8 val, int reg)
>  {
> -	outb(val, uhci->io_addr + reg);
> +	UHCI_OUT(outb(val, uhci->io_addr + reg));
>  }
>  
>  #else

I thought you were going to update the definition of 
uhci_has_pci_registers().  It shouldn't do a test at runtime if 
CONFIG_HAS_IOPORT is disabled.

Alan Stern
