Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CD6714C18
	for <lists+linux-arch@lfdr.de>; Mon, 29 May 2023 16:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjE2Oes (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 May 2023 10:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjE2Oeq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 May 2023 10:34:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21663A0;
        Mon, 29 May 2023 07:34:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A53C06259C;
        Mon, 29 May 2023 14:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94580C433D2;
        Mon, 29 May 2023 14:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685370884;
        bh=GJMlPkfiBRehYueIEr8g//eXbGFihHTHSmG8zMigUe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xX0dqLt8Y01r+5+NFqeEhUEBzv1rVVNeNFAjfhv9asauDPVpSmOLGKrmLGGaGEBTT
         P+JDISnbiJzkDgF//fD58BwkduXtWi99+qT20GpEfrqGr2uUrT8PpxBWhd8U08LS6m
         PeWrnZG3Fu/1Z1cxw28ArgBGZ6Q6f0+Yk0oYZ9Lc=
Date:   Mon, 29 May 2023 15:34:41 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 38/44] usb: pci-quirks: handle HAS_IOPORT dependencies
Message-ID: <2023052910-motivator-angler-bed7@gregkh>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
 <20230522105049.1467313-39-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522105049.1467313-39-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 22, 2023 at 12:50:43PM +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. In the pci-quirks case the I/O port acceses are
> used in the quirks for several AMD south bridges. Move unrelated
> ASMEDIA quirks out of the way and introduce an additional config option
> for the AMD quirks that depends on HAS_IOPORT.

This is really messy and hard to review in one commit.  I know I got
lost a bunch, and it's still messy:

> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/usb/Kconfig           |  10 +++
>  drivers/usb/core/hcd-pci.c    |   2 +
>  drivers/usb/host/pci-quirks.c | 125 ++++++++++++++++++----------------
>  drivers/usb/host/pci-quirks.h |  30 ++++++--
>  4 files changed, 101 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> index 7f33bcc315f2..abf8c6cdea9e 100644
> --- a/drivers/usb/Kconfig
> +++ b/drivers/usb/Kconfig
> @@ -91,6 +91,16 @@ config USB_PCI
>  	  If you have such a device you may say N here and PCI related code
>  	  will not be built in the USB driver.
>  
> +config USB_PCI_AMD
> +	bool "AMD PCI USB host support"
> +	depends on USB_PCI && HAS_IOPORT
> +	default X86 || MACH_LOONGSON64 || PPC_PASEMI
> +	help
> +	  Enable workarounds for USB implementation quirks in SB600/SB700/SB800
> +	  and later south bridge implementations. These are common on x86 PCs
> +	  with AMD CPUs but rarely used elsewhere, with the exception of a few
> +	  powerpc and mips desktop machines.

This is fine, make one commit for this, and then we can argue if you
really need it. :)

> +
>  if USB
>  
>  source "drivers/usb/core/Kconfig"
> diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
> index ab2f3737764e..85a0aeae85cd 100644
> --- a/drivers/usb/core/hcd-pci.c
> +++ b/drivers/usb/core/hcd-pci.c
> @@ -206,8 +206,10 @@ int usb_hcd_pci_probe(struct pci_dev *dev, const struct hc_driver *driver)
>  		goto free_irq_vectors;
>  	}
>  
> +#ifdef CONFIG_USB_PCI_AMD
>  	hcd->amd_resume_bug = (usb_hcd_amd_remote_wakeup_quirk(dev) &&
>  			driver->flags & (HCD_USB11 | HCD_USB3)) ? 1 : 0;
> +#endif /* CONFIG_USB_PCI_AMD */

No #ifdef in .c files if at all possible please.  Why is this needed?

And I hate ? : logic, please spell it out.

>  
>  	if (driver->flags & HCD_MEMORY) {
>  		/* EHCI, OHCI */
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index 2665832f9add..e0612f909fad 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -60,6 +60,23 @@
>  #define EHCI_USBLEGCTLSTS	4		/* legacy control/status */
>  #define EHCI_USBLEGCTLSTS_SOOE	(1 << 13)	/* SMI on ownership change */
>  
> +/* ASMEDIA quirk use */
> +#define ASMT_DATA_WRITE0_REG	0xF8
> +#define ASMT_DATA_WRITE1_REG	0xFC
> +#define ASMT_CONTROL_REG	0xE0
> +#define ASMT_CONTROL_WRITE_BIT	0x02
> +#define ASMT_WRITEREG_CMD	0x10423
> +#define ASMT_FLOWCTL_ADDR	0xFA30
> +#define ASMT_FLOWCTL_DATA	0xBA
> +#define ASMT_PSEUDO_DATA	0
> +
> +/* Intel quirk use */
> +#define USB_INTEL_XUSB2PR      0xD0
> +#define USB_INTEL_USB2PRM      0xD4
> +#define USB_INTEL_USB3_PSSEN   0xD8
> +#define USB_INTEL_USB3PRM      0xDC
> +
> +#ifdef CONFIG_USB_PCI_AMD
>  /* AMD quirk use */
>  #define	AB_REG_BAR_LOW		0xe0
>  #define	AB_REG_BAR_HIGH		0xe1
> @@ -93,21 +110,6 @@
>  #define	NB_PIF0_PWRDOWN_0	0x01100012
>  #define	NB_PIF0_PWRDOWN_1	0x01100013
>  
> -#define USB_INTEL_XUSB2PR      0xD0
> -#define USB_INTEL_USB2PRM      0xD4
> -#define USB_INTEL_USB3_PSSEN   0xD8
> -#define USB_INTEL_USB3PRM      0xDC
> -
> -/* ASMEDIA quirk use */
> -#define ASMT_DATA_WRITE0_REG	0xF8
> -#define ASMT_DATA_WRITE1_REG	0xFC
> -#define ASMT_CONTROL_REG	0xE0
> -#define ASMT_CONTROL_WRITE_BIT	0x02
> -#define ASMT_WRITEREG_CMD	0x10423
> -#define ASMT_FLOWCTL_ADDR	0xFA30
> -#define ASMT_FLOWCTL_DATA	0xBA
> -#define ASMT_PSEUDO_DATA	0
> -
>  /*
>   * amd_chipset_gen values represent AMD different chipset generations
>   */
> @@ -458,50 +460,6 @@ void usb_amd_quirk_pll_disable(void)
>  }
>  EXPORT_SYMBOL_GPL(usb_amd_quirk_pll_disable);
>  
> -static int usb_asmedia_wait_write(struct pci_dev *pdev)

Moving these is odd, why?  They are just doing pci accesses.


> -{
> -	unsigned long retry_count;
> -	unsigned char value;
> -
> -	for (retry_count = 1000; retry_count > 0; --retry_count) {
> -
> -		pci_read_config_byte(pdev, ASMT_CONTROL_REG, &value);
> -
> -		if (value == 0xff) {
> -			dev_err(&pdev->dev, "%s: check_ready ERROR", __func__);
> -			return -EIO;
> -		}
> -
> -		if ((value & ASMT_CONTROL_WRITE_BIT) == 0)
> -			return 0;
> -
> -		udelay(50);
> -	}
> -
> -	dev_warn(&pdev->dev, "%s: check_write_ready timeout", __func__);
> -	return -ETIMEDOUT;
> -}
> -
> -void usb_asmedia_modifyflowcontrol(struct pci_dev *pdev)
> -{
> -	if (usb_asmedia_wait_write(pdev) != 0)
> -		return;
> -
> -	/* send command and address to device */
> -	pci_write_config_dword(pdev, ASMT_DATA_WRITE0_REG, ASMT_WRITEREG_CMD);
> -	pci_write_config_dword(pdev, ASMT_DATA_WRITE1_REG, ASMT_FLOWCTL_ADDR);
> -	pci_write_config_byte(pdev, ASMT_CONTROL_REG, ASMT_CONTROL_WRITE_BIT);
> -
> -	if (usb_asmedia_wait_write(pdev) != 0)
> -		return;
> -
> -	/* send data to device */
> -	pci_write_config_dword(pdev, ASMT_DATA_WRITE0_REG, ASMT_FLOWCTL_DATA);
> -	pci_write_config_dword(pdev, ASMT_DATA_WRITE1_REG, ASMT_PSEUDO_DATA);
> -	pci_write_config_byte(pdev, ASMT_CONTROL_REG, ASMT_CONTROL_WRITE_BIT);
> -}
> -EXPORT_SYMBOL_GPL(usb_asmedia_modifyflowcontrol);
> -
>  void usb_amd_quirk_pll_enable(void)
>  {
>  	usb_amd_quirk_pll(0);
> @@ -630,7 +588,53 @@ bool usb_amd_pt_check_port(struct device *device, int port)
>  	return !(value & BIT(port_shift));
>  }
>  EXPORT_SYMBOL_GPL(usb_amd_pt_check_port);
> +#endif /* CONFIG_USB_PCI_AMD */
>  
> +static int usb_asmedia_wait_write(struct pci_dev *pdev)
> +{
> +	unsigned long retry_count;
> +	unsigned char value;
> +
> +	for (retry_count = 1000; retry_count > 0; --retry_count) {
> +
> +		pci_read_config_byte(pdev, ASMT_CONTROL_REG, &value);
> +
> +		if (value == 0xff) {
> +			dev_err(&pdev->dev, "%s: check_ready ERROR", __func__);
> +			return -EIO;
> +		}
> +
> +		if ((value & ASMT_CONTROL_WRITE_BIT) == 0)
> +			return 0;
> +
> +		udelay(50);
> +	}
> +
> +	dev_warn(&pdev->dev, "%s: check_write_ready timeout", __func__);
> +	return -ETIMEDOUT;
> +}
> +
> +void usb_asmedia_modifyflowcontrol(struct pci_dev *pdev)
> +{
> +	if (usb_asmedia_wait_write(pdev) != 0)
> +		return;
> +
> +	/* send command and address to device */
> +	pci_write_config_dword(pdev, ASMT_DATA_WRITE0_REG, ASMT_WRITEREG_CMD);
> +	pci_write_config_dword(pdev, ASMT_DATA_WRITE1_REG, ASMT_FLOWCTL_ADDR);
> +	pci_write_config_byte(pdev, ASMT_CONTROL_REG, ASMT_CONTROL_WRITE_BIT);
> +
> +	if (usb_asmedia_wait_write(pdev) != 0)
> +		return;
> +
> +	/* send data to device */
> +	pci_write_config_dword(pdev, ASMT_DATA_WRITE0_REG, ASMT_FLOWCTL_DATA);
> +	pci_write_config_dword(pdev, ASMT_DATA_WRITE1_REG, ASMT_PSEUDO_DATA);
> +	pci_write_config_byte(pdev, ASMT_CONTROL_REG, ASMT_CONTROL_WRITE_BIT);
> +}
> +EXPORT_SYMBOL_GPL(usb_asmedia_modifyflowcontrol);
> +
> +#if defined(CONFIG_HAS_IOPORT) && defined(CONFIG_USB_UHCI_HCD)

Is this really needed?  This feels wrong, why is ioport odd like this?

>  /*
>   * Make sure the controller is completely inactive, unable to
>   * generate interrupts or do DMA.
> @@ -711,6 +715,7 @@ int uhci_check_and_reset_hc(struct pci_dev *pdev, unsigned long base)
>  	return 1;
>  }
>  EXPORT_SYMBOL_GPL(uhci_check_and_reset_hc);
> +#endif /* defined(CONFIG_HAS_IOPORT && defined(CONFIG_USB_UHCI_HCD) */
>  
>  static inline int io_type_enabled(struct pci_dev *pdev, unsigned int mask)
>  {
> @@ -723,6 +728,7 @@ static inline int io_type_enabled(struct pci_dev *pdev, unsigned int mask)
>  
>  static void quirk_usb_handoff_uhci(struct pci_dev *pdev)
>  {
> +#ifdef CONFIG_HAS_IOPORT
>  	unsigned long base = 0;
>  	int i;
>  
> @@ -737,6 +743,7 @@ static void quirk_usb_handoff_uhci(struct pci_dev *pdev)
>  
>  	if (base)
>  		uhci_check_and_reset_hc(pdev, base);
> +#endif /* CONFIG_HAS_IOPORT */
>  }
>  
>  static int mmio_resource_enabled(struct pci_dev *pdev, int idx)
> diff --git a/drivers/usb/host/pci-quirks.h b/drivers/usb/host/pci-quirks.h
> index e729de21fad7..8c87505f0abc 100644
> --- a/drivers/usb/host/pci-quirks.h
> +++ b/drivers/usb/host/pci-quirks.h
> @@ -2,9 +2,10 @@
>  #ifndef __LINUX_USB_PCI_QUIRKS_H
>  #define __LINUX_USB_PCI_QUIRKS_H
>  
> -#ifdef CONFIG_USB_PCI
>  void uhci_reset_hc(struct pci_dev *pdev, unsigned long base);
>  int uhci_check_and_reset_hc(struct pci_dev *pdev, unsigned long base);
> +
> +#ifdef CONFIG_USB_PCI_AMD
>  int usb_hcd_amd_remote_wakeup_quirk(struct pci_dev *pdev);
>  bool usb_amd_hang_symptom_quirk(void);
>  bool usb_amd_prefetch_quirk(void);
> @@ -12,23 +13,38 @@ void usb_amd_dev_put(void);
>  bool usb_amd_quirk_pll_check(void);
>  void usb_amd_quirk_pll_disable(void);
>  void usb_amd_quirk_pll_enable(void);
> -void usb_asmedia_modifyflowcontrol(struct pci_dev *pdev);
> -void usb_enable_intel_xhci_ports(struct pci_dev *xhci_pdev);
> -void usb_disable_xhci_ports(struct pci_dev *xhci_pdev);
>  void sb800_prefetch(struct device *dev, int on);
>  bool usb_amd_pt_check_port(struct device *device, int port);
>  #else
> -struct pci_dev;
> +static inline bool usb_amd_hang_symptom_quirk(void)
> +{
> +	return false;
> +};
> +static inline bool usb_amd_prefetch_quirk(void)
> +{
> +	return false;
> +}
> +static inline bool usb_amd_quirk_pll_check(void)
> +{
> +	return false;
> +}
>  static inline void usb_amd_quirk_pll_disable(void) {}
>  static inline void usb_amd_quirk_pll_enable(void) {}
> -static inline void usb_asmedia_modifyflowcontrol(struct pci_dev *pdev) {}
>  static inline void usb_amd_dev_put(void) {}
> -static inline void usb_disable_xhci_ports(struct pci_dev *xhci_pdev) {}
>  static inline void sb800_prefetch(struct device *dev, int on) {}
>  static inline bool usb_amd_pt_check_port(struct device *device, int port)
>  {
>  	return false;
>  }
> +#endif /* CONFIG_USB_PCI_AMD */
> +
> +#ifdef CONFIG_USB_PCI
> +void usb_asmedia_modifyflowcontrol(struct pci_dev *pdev);
> +void usb_enable_intel_xhci_ports(struct pci_dev *xhci_pdev);
> +void usb_disable_xhci_ports(struct pci_dev *xhci_pdev);
> +#else
> +static inline void usb_asmedia_modifyflowcontrol(struct pci_dev *pdev) {}
> +static inline void usb_disable_xhci_ports(struct pci_dev *xhci_pdev) {}
>  #endif  /* CONFIG_USB_PCI */

Again, the changes here are hard to follow, why?

Please break up into smaller pieces.

thanks,

greg k-h
