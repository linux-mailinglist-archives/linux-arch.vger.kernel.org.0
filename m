Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3370E6B9403
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 13:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCNMkQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 08:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjCNMkN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 08:40:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0728692BDC;
        Tue, 14 Mar 2023 05:39:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 017F2B81900;
        Tue, 14 Mar 2023 12:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17B2C433D2;
        Tue, 14 Mar 2023 12:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678796461;
        bh=OO0XCrZpTVFyqYcGDB+jvUpcqUr1ezrMMU6aDjj+ZcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SELptXcUqeILr3pRNuFBHFlNnQEivcUAD05st1KhFEeYecEpWM9lCDeXfkDlC5sIg
         p2G0DXz/NOsoXkjRUdydmAxTuunskqRaapBYXjwfJSXdoBomvU+qJkRRM6qCJ6wNWK
         OM9PHp1iVWT5ayHIiyEe5W04E2itRg60ldtmG1Xu58TZeEnGQi/3ZfezU/NPTDxE3P
         /HaeyiF0dNoTBfvYq0uge2ubBZwxfqQ6fc3SBGRplEXHbSgfCb5DYCeKN5ev8NkGQD
         9qoA+1OULVwRy62YzttoUxqIUAHva2BLx+z2GsChE+l6zZnsth7wT704kFnYHk74um
         tAH6KAudJ2WiQ==
Date:   Tue, 14 Mar 2023 14:20:56 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Corey Minyard <minyard@acm.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
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
        openipmi-developer@lists.sourceforge.net,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 03/38] char: impi, tpm: depend on HAS_IOPORT
Message-ID: <ZBBmqKDh97KexRH9@kernel.org>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-4-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314121216.413434-4-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 14, 2023 at 01:11:41PM +0100, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add this dependency and ifdef
> sections of code using inb()/outb() as alternative access methods.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/char/Kconfig             |  3 ++-
>  drivers/char/ipmi/Makefile       | 11 ++++-------
>  drivers/char/ipmi/ipmi_si_intf.c |  3 ++-
>  drivers/char/ipmi/ipmi_si_pci.c  |  3 +++
>  drivers/char/pcmcia/Kconfig      |  8 ++++----
>  drivers/char/tpm/Kconfig         |  1 +
>  drivers/char/tpm/tpm_infineon.c  | 14 ++++++++++----
>  drivers/char/tpm/tpm_tis_core.c  | 19 ++++++++-----------
>  8 files changed, 34 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 30fe9848dac1..c34679c6da70 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -34,6 +34,7 @@ config TTY_PRINTK_LEVEL
>  config PRINTER
>  	tristate "Parallel printer support"
>  	depends on PARPORT
> +	depends on HAS_IOPORT
>  	help
>  	  If you intend to attach a printer to the parallel port of your Linux
>  	  box (as opposed to using a serial printer; if the connector at the
> @@ -342,7 +343,7 @@ config NVRAM
>  
>  config DEVPORT
>  	bool "/dev/port character device"
> -	depends on ISA || PCI
> +	depends on HAS_IOPORT
>  	default y
>  	help
>  	  Say Y here if you want to support the /dev/port device. The /dev/port
> diff --git a/drivers/char/ipmi/Makefile b/drivers/char/ipmi/Makefile
> index cb6138b8ded9..e0944547c9d0 100644
> --- a/drivers/char/ipmi/Makefile
> +++ b/drivers/char/ipmi/Makefile
> @@ -5,13 +5,10 @@
>  
>  ipmi_si-y := ipmi_si_intf.o ipmi_kcs_sm.o ipmi_smic_sm.o ipmi_bt_sm.o \
>  	ipmi_si_hotmod.o ipmi_si_hardcode.o ipmi_si_platform.o \
> -	ipmi_si_port_io.o ipmi_si_mem_io.o
> -ifdef CONFIG_PCI
> -ipmi_si-y += ipmi_si_pci.o
> -endif
> -ifdef CONFIG_PARISC
> -ipmi_si-y += ipmi_si_parisc.o
> -endif
> +	ipmi_si_mem_io.o
> +ipmi_si-$(CONFIG_HAS_IOPORT) += ipmi_si_port_io.o
> +ipmi_si-$(CONFIG_PCI) += ipmi_si_pci.o
> +ipmi_si-$(CONFIG_PARISC) += ipmi_si_parisc.o
>  
>  obj-$(CONFIG_IPMI_HANDLER) += ipmi_msghandler.o
>  obj-$(CONFIG_IPMI_DEVICE_INTERFACE) += ipmi_devintf.o
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index abddd7e43a9a..edbbdb804913 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -1882,7 +1882,8 @@ int ipmi_si_add_smi(struct si_sm_io *io)
>  	}
>  
>  	if (!io->io_setup) {
> -		if (io->addr_space == IPMI_IO_ADDR_SPACE) {
> +		if (IS_ENABLED(CONFIG_HAS_IOPORT) &&
> +		    io->addr_space == IPMI_IO_ADDR_SPACE) {
>  			io->io_setup = ipmi_si_port_setup;
>  		} else if (io->addr_space == IPMI_MEM_ADDR_SPACE) {
>  			io->io_setup = ipmi_si_mem_setup;
> diff --git a/drivers/char/ipmi/ipmi_si_pci.c b/drivers/char/ipmi/ipmi_si_pci.c
> index 74fa2055868b..b83d55685b22 100644
> --- a/drivers/char/ipmi/ipmi_si_pci.c
> +++ b/drivers/char/ipmi/ipmi_si_pci.c
> @@ -97,6 +97,9 @@ static int ipmi_pci_probe(struct pci_dev *pdev,
>  	}
>  
>  	if (pci_resource_flags(pdev, 0) & IORESOURCE_IO) {
> +		if (!IS_ENABLED(CONFIG_HAS_IOPORT))
> +			return -ENXIO;
> +
>  		io.addr_space = IPMI_IO_ADDR_SPACE;
>  		io.io_setup = ipmi_si_port_setup;
>  	} else {
> diff --git a/drivers/char/pcmcia/Kconfig b/drivers/char/pcmcia/Kconfig
> index f5d589b2be44..788422627b43 100644
> --- a/drivers/char/pcmcia/Kconfig
> +++ b/drivers/char/pcmcia/Kconfig
> @@ -8,7 +8,7 @@ menu "PCMCIA character devices"
>  
>  config SYNCLINK_CS
>  	tristate "SyncLink PC Card support"
> -	depends on PCMCIA && TTY
> +	depends on PCMCIA && TTY && HAS_IOPORT
>  	help
>  	  Enable support for the SyncLink PC Card serial adapter, running
>  	  asynchronous and HDLC communications up to 512Kbps. The port is
> @@ -21,7 +21,7 @@ config SYNCLINK_CS
>  
>  config CARDMAN_4000
>  	tristate "Omnikey Cardman 4000 support"
> -	depends on PCMCIA
> +	depends on PCMCIA && HAS_IOPORT
>  	select BITREVERSE
>  	help
>  	  Enable support for the Omnikey Cardman 4000 PCMCIA Smartcard
> @@ -33,7 +33,7 @@ config CARDMAN_4000
>  
>  config CARDMAN_4040
>  	tristate "Omnikey CardMan 4040 support"
> -	depends on PCMCIA
> +	depends on PCMCIA && HAS_IOPORT
>  	help
>  	  Enable support for the Omnikey CardMan 4040 PCMCIA Smartcard
>  	  reader.
> @@ -57,7 +57,7 @@ config SCR24X
>  
>  config IPWIRELESS
>  	tristate "IPWireless 3G UMTS PCMCIA card support"
> -	depends on PCMCIA && NETDEVICES && TTY
> +	depends on PCMCIA && NETDEVICES && TTY && HAS_IOPORT
>  	select PPP
>  	help
>  	  This is a driver for 3G UMTS PCMCIA card from IPWireless company. In
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 927088b2c3d3..418c9ed59ffd 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -149,6 +149,7 @@ config TCG_NSC
>  config TCG_ATMEL
>  	tristate "Atmel TPM Interface"
>  	depends on PPC64 || HAS_IOPORT_MAP
> +	depends on HAS_IOPORT
>  	help
>  	  If you have a TPM security chip from Atmel say Yes and it 
>  	  will be accessible from within Linux.  To compile this driver 
> diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
> index 9c924a1440a9..2d2ae37153ba 100644
> --- a/drivers/char/tpm/tpm_infineon.c
> +++ b/drivers/char/tpm/tpm_infineon.c
> @@ -51,34 +51,40 @@ static struct tpm_inf_dev tpm_dev;
>  
>  static inline void tpm_data_out(unsigned char data, unsigned char offset)
>  {
> +#ifdef CONFIG_HAS_IOPORT
>  	if (tpm_dev.iotype == TPM_INF_IO_PORT)
>  		outb(data, tpm_dev.data_regs + offset);
>  	else
> +#endif
>  		writeb(data, tpm_dev.mem_base + tpm_dev.data_regs + offset);
>  }
>  
>  static inline unsigned char tpm_data_in(unsigned char offset)
>  {
> +#ifdef CONFIG_HAS_IOPORT
>  	if (tpm_dev.iotype == TPM_INF_IO_PORT)
>  		return inb(tpm_dev.data_regs + offset);
> -	else
> -		return readb(tpm_dev.mem_base + tpm_dev.data_regs + offset);
> +#endif
> +	return readb(tpm_dev.mem_base + tpm_dev.data_regs + offset);
>  }
>  
>  static inline void tpm_config_out(unsigned char data, unsigned char offset)
>  {
> +#ifdef CONFIG_HAS_IOPORT
>  	if (tpm_dev.iotype == TPM_INF_IO_PORT)
>  		outb(data, tpm_dev.config_port + offset);
>  	else
> +#endif
>  		writeb(data, tpm_dev.mem_base + tpm_dev.index_off + offset);
>  }
>  
>  static inline unsigned char tpm_config_in(unsigned char offset)
>  {
> +#ifdef CONFIG_HAS_IOPORT
>  	if (tpm_dev.iotype == TPM_INF_IO_PORT)
>  		return inb(tpm_dev.config_port + offset);
> -	else
> -		return readb(tpm_dev.mem_base + tpm_dev.index_off + offset);
> +#endif
> +	return readb(tpm_dev.mem_base + tpm_dev.index_off + offset);
>  }
>  
>  /* TPM header definitions */
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 3f98e587b3e8..e43d2a1da3ea 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -897,11 +897,6 @@ static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value)
>  		clkrun_val &= ~LPC_CLKRUN_EN;
>  		iowrite32(clkrun_val, data->ilb_base_addr + LPC_CNTRL_OFFSET);
>  
> -		/*
> -		 * Write any random value on port 0x80 which is on LPC, to make
> -		 * sure LPC clock is running before sending any TPM command.
> -		 */
> -		outb(0xCC, 0x80);
>  	} else {
>  		data->clkrun_enabled--;
>  		if (data->clkrun_enabled)
> @@ -912,13 +907,15 @@ static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value)
>  		/* Enable LPC CLKRUN# */
>  		clkrun_val |= LPC_CLKRUN_EN;
>  		iowrite32(clkrun_val, data->ilb_base_addr + LPC_CNTRL_OFFSET);
> -
> -		/*
> -		 * Write any random value on port 0x80 which is on LPC, to make
> -		 * sure LPC clock is running before sending any TPM command.
> -		 */
> -		outb(0xCC, 0x80);
>  	}
> +
> +#ifdef CONFIG_HAS_IOPORT
> +	/*
> +	 * Write any random value on port 0x80 which is on LPC, to make
> +	 * sure LPC clock is running before sending any TPM command.
> +	 */
> +	outb(0xCC, 0x80);
> +#endif
>  }
>  
>  static const struct tpm_class_ops tpm_tis = {
> -- 
> 2.37.2
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Who should pick this?

BR, Jarkko
