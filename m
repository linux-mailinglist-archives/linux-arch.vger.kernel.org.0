Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18645514F98
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 17:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbiD2Pj3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 11:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbiD2Pj2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 11:39:28 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CECED5EB3;
        Fri, 29 Apr 2022 08:36:09 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 10EB5101D81; Fri, 29 Apr 2022 16:36:05 +0100 (BST)
Date:   Fri, 29 Apr 2022 16:36:05 +0100
From:   Sean Young <sean@mess.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "open list:MEDIA INPUT INFRASTRUCTURE (V4L/DVB)" 
        <linux-media@vger.kernel.org>
Subject: Re: [RFC v2 17/39] media: add HAS_IOPORT dependencies
Message-ID: <YmwF5TLJy2ZiU25a@gofer.mess.org>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
 <20220429135108.2781579-30-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429135108.2781579-30-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 29, 2022 at 03:50:27PM +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/media/pci/dm1105/Kconfig |  2 +-
>  drivers/media/radio/Kconfig      | 14 +++++++++++++-
>  drivers/media/rc/Kconfig         |  6 ++++++

For drivers/media/rc/Kconfig:

Reviewed-by: Sean Young <sean@mess.org>

Sean

>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/pci/dm1105/Kconfig b/drivers/media/pci/dm1105/Kconfig
> index e0e3af67c99c..4498c37f4990 100644
> --- a/drivers/media/pci/dm1105/Kconfig
> +++ b/drivers/media/pci/dm1105/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config DVB_DM1105
>  	tristate "SDMC DM1105 based PCI cards"
> -	depends on DVB_CORE && PCI && I2C && I2C_ALGOBIT
> +	depends on DVB_CORE && PCI && I2C && I2C_ALGOBIT && HAS_IOPORT
>  	select DVB_PLL if MEDIA_SUBDRV_AUTOSELECT
>  	select DVB_STV0299 if MEDIA_SUBDRV_AUTOSELECT
>  	select DVB_STV0288 if MEDIA_SUBDRV_AUTOSELECT
> diff --git a/drivers/media/radio/Kconfig b/drivers/media/radio/Kconfig
> index cca03bd2cc42..e15d50d9161f 100644
> --- a/drivers/media/radio/Kconfig
> +++ b/drivers/media/radio/Kconfig
> @@ -15,7 +15,7 @@ if RADIO_ADAPTERS
>  
>  config RADIO_MAXIRADIO
>  	tristate "Guillemot MAXI Radio FM 2000 radio"
> -	depends on PCI
> +	depends on PCI && HAS_IOPORT
>  	select RADIO_TEA575X
>  	help
>  	  Choose Y here if you have this radio card.  This card may also be
> @@ -232,6 +232,7 @@ source "drivers/media/radio/wl128x/Kconfig"
>  menuconfig V4L_RADIO_ISA_DRIVERS
>  	bool "ISA radio devices"
>  	depends on ISA || COMPILE_TEST
> +	depends on HAS_IOPORT
>  	help
>  	  Say Y here to enable support for these ISA drivers.
>  
> @@ -240,6 +241,7 @@ if V4L_RADIO_ISA_DRIVERS
>  config RADIO_AZTECH
>  	tristate "Aztech/Packard Bell Radio"
>  	depends on ISA || COMPILE_TEST
> +	depends on HAS_IOPORT
>  	select RADIO_ISA
>  	help
>  	  Choose Y here if you have one of these FM radio cards, and then fill
> @@ -260,6 +262,7 @@ config RADIO_AZTECH_PORT
>  config RADIO_CADET
>  	tristate "ADS Cadet AM/FM Tuner"
>  	depends on ISA || COMPILE_TEST
> +	depends on HAS_IOPORT
>  	help
>  	  Choose Y here if you have one of these AM/FM radio cards, and then
>  	  fill in the port address below.
> @@ -270,6 +273,7 @@ config RADIO_CADET
>  config RADIO_GEMTEK
>  	tristate "GemTek Radio card (or compatible) support"
>  	depends on ISA || COMPILE_TEST
> +	depends on HAS_IOPORT
>  	select RADIO_ISA
>  	help
>  	  Choose Y here if you have this FM radio card, and then fill in the
> @@ -309,6 +313,7 @@ config RADIO_GEMTEK_PROBE
>  
>  config RADIO_ISA
>  	depends on ISA || COMPILE_TEST
> +	depends on HAS_IOPORT
>  	tristate
>  
>  config RADIO_MIROPCM20
> @@ -329,6 +334,7 @@ config RADIO_MIROPCM20
>  config RADIO_RTRACK
>  	tristate "AIMSlab RadioTrack (aka RadioReveal) support"
>  	depends on ISA || COMPILE_TEST
> +	depends on HAS_IOPORT
>  	select RADIO_ISA
>  	help
>  	  Choose Y here if you have one of these FM radio cards, and then fill
> @@ -383,6 +389,7 @@ config RADIO_RTRACK_PORT
>  config RADIO_SF16FMI
>  	tristate "SF16-FMI/SF16-FMP/SF16-FMD Radio"
>  	depends on ISA || COMPILE_TEST
> +	depends on HAS_IOPORT
>  	help
>  	  Choose Y here if you have one of these FM radio cards.
>  
> @@ -392,6 +399,7 @@ config RADIO_SF16FMI
>  config RADIO_SF16FMR2
>  	tristate "SF16-FMR2/SF16-FMD2 Radio"
>  	depends on ISA || COMPILE_TEST
> +	depends on HAS_IOPORT
>  	select RADIO_TEA575X
>  	help
>  	  Choose Y here if you have one of these FM radio cards.
> @@ -402,6 +410,7 @@ config RADIO_SF16FMR2
>  config RADIO_TERRATEC
>  	tristate "TerraTec ActiveRadio ISA Standalone"
>  	depends on ISA || COMPILE_TEST
> +	depends on HAS_IOPORT
>  	select RADIO_ISA
>  	help
>  	  Choose Y here if you have this FM radio card.
> @@ -416,6 +425,7 @@ config RADIO_TERRATEC
>  config RADIO_TRUST
>  	tristate "Trust FM radio card"
>  	depends on ISA || COMPILE_TEST
> +	depends on HAS_IOPORT
>  	select RADIO_ISA
>  	help
>  	  This is a driver for the Trust FM radio cards. Say Y if you have
> @@ -439,6 +449,7 @@ config RADIO_TRUST_PORT
>  config RADIO_TYPHOON
>  	tristate "Typhoon Radio (a.k.a. EcoRadio)"
>  	depends on ISA || COMPILE_TEST
> +	depends on HAS_IOPORT
>  	select RADIO_ISA
>  	help
>  	  Choose Y here if you have one of these FM radio cards, and then fill
> @@ -473,6 +484,7 @@ config RADIO_TYPHOON_PORT
>  config RADIO_ZOLTRIX
>  	tristate "Zoltrix Radio"
>  	depends on ISA || COMPILE_TEST
> +	depends on HAS_IOPORT
>  	select RADIO_ISA
>  	help
>  	  Choose Y here if you have one of these FM radio cards, and then fill
> diff --git a/drivers/media/rc/Kconfig b/drivers/media/rc/Kconfig
> index f560fc38895f..96528e6532fd 100644
> --- a/drivers/media/rc/Kconfig
> +++ b/drivers/media/rc/Kconfig
> @@ -148,6 +148,7 @@ if RC_DEVICES
>  config IR_ENE
>  	tristate "ENE eHome Receiver/Transceiver (pnp id: ENE0100/ENE02xxx)"
>  	depends on PNP || COMPILE_TEST
> +	depends on HAS_IOPORT
>  	help
>  	   Say Y here to enable support for integrated infrared receiver
>  	   /transceiver made by ENE.
> @@ -161,6 +162,7 @@ config IR_ENE
>  config IR_FINTEK
>  	tristate "Fintek Consumer Infrared Transceiver"
>  	depends on PNP || COMPILE_TEST
> +	depends on HAS_IOPORT
>  	help
>  	   Say Y here to enable support for integrated infrared receiver
>  	   /transceiver made by Fintek. This chip is found on assorted
> @@ -249,6 +251,7 @@ config IR_IMON_RAW
>  config IR_ITE_CIR
>  	tristate "ITE Tech Inc. IT8712/IT8512 Consumer Infrared Transceiver"
>  	depends on PNP || COMPILE_TEST
> +	depends on HAS_IOPORT
>  	help
>  	   Say Y here to enable support for integrated infrared receivers
>  	   /transceivers made by ITE Tech Inc. These are found in
> @@ -301,6 +304,7 @@ config IR_MTK
>  config IR_NUVOTON
>  	tristate "Nuvoton w836x7hg Consumer Infrared Transceiver"
>  	depends on PNP || COMPILE_TEST
> +	depends on HAS_IOPORT
>  	help
>  	   Say Y here to enable support for integrated infrared receiver
>  	   /transceiver made by Nuvoton (formerly Winbond). This chip is
> @@ -345,6 +349,7 @@ config IR_RX51
>  
>  config IR_SERIAL
>  	tristate "Homebrew Serial Port Receiver"
> +	depends on HAS_IOPORT
>  	help
>  	   Say Y if you want to use Homebrew Serial Port Receivers and
>  	   Transceivers.
> @@ -412,6 +417,7 @@ config IR_TTUSBIR
>  config IR_WINBOND_CIR
>  	tristate "Winbond IR remote control"
>  	depends on (X86 && PNP) || COMPILE_TEST
> +	depends on HAS_IOPORT
>  	select NEW_LEDS
>  	select LEDS_CLASS
>  	select BITREVERSE
> -- 
> 2.32.0
