Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8467A480495
	for <lists+linux-arch@lfdr.de>; Mon, 27 Dec 2021 21:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhL0Ug2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 15:36:28 -0500
Received: from netrider.rowland.org ([192.131.102.5]:39989 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S232982AbhL0Ug1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Dec 2021 15:36:27 -0500
Received: (qmail 1062827 invoked by uid 1000); 27 Dec 2021 15:36:25 -0500
Date:   Mon, 27 Dec 2021 15:36:25 -0500
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
Message-ID: <YcojyRhALdm40gfk@rowland.harvard.edu>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-32-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227164317.4146918-32-schnelle@linux.ibm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 27, 2021 at 05:43:16PM +0100, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to guard sections of code calling them
> as alternative access methods with CONFIG_HAS_IOPORT checks. Similarly
> drivers requiring these functions need to depend on HAS_IOPORT.

A few things in here can be improved.

> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/usb/core/hcd-pci.c    |   3 +-
>  drivers/usb/host/Kconfig      |   4 +-
>  drivers/usb/host/pci-quirks.c | 127 ++++++++++++++++++----------------
>  drivers/usb/host/pci-quirks.h |  33 ++++++---
>  drivers/usb/host/uhci-hcd.c   |   2 +-
>  drivers/usb/host/uhci-hcd.h   |  77 ++++++++++++++-------
>  6 files changed, 148 insertions(+), 98 deletions(-)

> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index ef08d68b9714..bba320194027 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c

> +#ifdef CONFIG_USB_PCI_AMD
> +#if IS_ENABLED(CONFIG_USB_UHCI_HCD) && defined(CONFIG_HAS_IOPORT)

In the original, the following code will be compiled even if
CONFIG_USB_UHCI_HCD is not enabled.  You shouldn't change that.

>  /*
>   * Make sure the controller is completely inactive, unable to
>   * generate interrupts or do DMA.

> @@ -1273,7 +1277,8 @@ static void quirk_usb_early_handoff(struct pci_dev *pdev)
>  			 "Can't enable PCI device, BIOS handoff failed.\n");
>  		return;
>  	}
> -	if (pdev->class == PCI_CLASS_SERIAL_USB_UHCI)
> +	if (IS_ENABLED(CONFIG_USB_UHCI_HCD) &&
> +	    pdev->class == PCI_CLASS_SERIAL_USB_UHCI)
>  		quirk_usb_handoff_uhci(pdev);

Same idea here.

>  	else if (pdev->class == PCI_CLASS_SERIAL_USB_OHCI)
>  		quirk_usb_handoff_ohci(pdev);
> diff --git a/drivers/usb/host/pci-quirks.h b/drivers/usb/host/pci-quirks.h
> index e729de21fad7..42eb18be37af 100644
> --- a/drivers/usb/host/pci-quirks.h
> +++ b/drivers/usb/host/pci-quirks.h
> @@ -2,33 +2,50 @@
>  #ifndef __LINUX_USB_PCI_QUIRKS_H
>  #define __LINUX_USB_PCI_QUIRKS_H
>  
> -#ifdef CONFIG_USB_PCI
>  void uhci_reset_hc(struct pci_dev *pdev, unsigned long base);
>  int uhci_check_and_reset_hc(struct pci_dev *pdev, unsigned long base);
> -int usb_hcd_amd_remote_wakeup_quirk(struct pci_dev *pdev);
> +
> +struct pci_dev;

This can't be right; struct pci_dev is referred to three lines earlier.
You could move this up, but it may not be needed at all.

> diff --git a/drivers/usb/host/uhci-hcd.h b/drivers/usb/host/uhci-hcd.h
> index 8ae5ccd26753..8e30116b6fd2 100644
> --- a/drivers/usb/host/uhci-hcd.h
> +++ b/drivers/usb/host/uhci-hcd.h
> @@ -586,12 +586,14 @@ static inline int uhci_aspeed_reg(unsigned int reg)
>  
>  static inline u32 uhci_readl(const struct uhci_hcd *uhci, int reg)
>  {
> +#ifdef CONFIG_HAS_IOPORT
>  	if (uhci_has_pci_registers(uhci))
>  		return inl(uhci->io_addr + reg);
> -	else if (uhci_is_aspeed(uhci))
> +#endif

Instead of making all these changes (here and in the hunks below), you
can simply modify the definition of uhci_has_pci_registers() so that it
always gives 0 when CONFIG_HAS_IOPORT is N.

Alan Stern
