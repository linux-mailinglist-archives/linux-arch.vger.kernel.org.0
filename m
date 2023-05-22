Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3625770BC2F
	for <lists+linux-arch@lfdr.de>; Mon, 22 May 2023 13:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbjEVLti (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 May 2023 07:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjEVLth (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 07:49:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B6BAB;
        Mon, 22 May 2023 04:49:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF261611AC;
        Mon, 22 May 2023 11:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D08FC433D2;
        Mon, 22 May 2023 11:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684756175;
        bh=MksqE9gv1SGdf5zP2megR4doE0nMrzoziEQVjPRPgGA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ezTeSjZcoE828dZ4AfFTu2b1XRysWjgqhj4it4+vVaDGbuctXN9X2pDqmjF3mwcT+
         B48yzvikaBwpbaPYDO9k1y4ag61WWuTfAfOO+IqX02YrrbldcjpnnDNHHgpSV/MOI5
         O4SORRiVE1OdAZ7uQbkGyrstBHVpnRO9PI3+awszLeBJg729xnuUDKTzDUvXXnFtk1
         0d+lm1vHd5dMgsX2yJIpcE+gudJaMxmJCcDv0MnPBXy+BfFjDg19rwAq7h6oMWyjvz
         Plj2U0xnqIo9HByUX6+NgH3C48FaeHj2YRRe2XBrbD21Wsc22RHB3+2nj+gjkOsNzb
         UxlCU2MpDfl/g==
Message-ID: <27e793b1-8676-d90a-4808-b5e194a8741f@kernel.org>
Date:   Mon, 22 May 2023 20:49:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 02/44] ata: add HAS_IOPORT dependencies
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-ide@vger.kernel.org
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
 <20230522105049.1467313-3-schnelle@linux.ibm.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230522105049.1467313-3-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/22/23 19:50, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

This new version looks much nicer !

Please change my Ack to:

Acked-by: Damien Le Moal <dlemoal@kernel.org>

> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/ata/Kconfig      | 28 ++++++++++++++--------------
>  drivers/ata/libata-sff.c |  4 ++++
>  2 files changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 42b51c9812a0..c521cdc51f8c 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -557,7 +557,7 @@ comment "PATA SFF controllers with BMDMA"
>  
>  config PATA_ALI
>  	tristate "ALi PATA support"
> -	depends on PCI
> +	depends on PCI && HAS_IOPORT
>  	select PATA_TIMINGS
>  	help
>  	  This option enables support for the ALi ATA interfaces
> @@ -567,7 +567,7 @@ config PATA_ALI
>  
>  config PATA_AMD
>  	tristate "AMD/NVidia PATA support"
> -	depends on PCI
> +	depends on PCI && HAS_IOPORT
>  	select PATA_TIMINGS
>  	help
>  	  This option enables support for the AMD and NVidia PATA
> @@ -585,7 +585,7 @@ config PATA_ARASAN_CF
>  
>  config PATA_ARTOP
>  	tristate "ARTOP 6210/6260 PATA support"
> -	depends on PCI
> +	depends on PCI && HAS_IOPORT
>  	help
>  	  This option enables support for ARTOP PATA controllers.
>  
> @@ -612,7 +612,7 @@ config PATA_ATP867X
>  
>  config PATA_CMD64X
>  	tristate "CMD64x PATA support"
> -	depends on PCI
> +	depends on PCI && HAS_IOPORT
>  	select PATA_TIMINGS
>  	help
>  	  This option enables support for the CMD64x series chips
> @@ -659,7 +659,7 @@ config PATA_CS5536
>  
>  config PATA_CYPRESS
>  	tristate "Cypress CY82C693 PATA support (Very Experimental)"
> -	depends on PCI
> +	depends on PCI && HAS_IOPORT
>  	select PATA_TIMINGS
>  	help
>  	  This option enables support for the Cypress/Contaq CY82C693
> @@ -707,7 +707,7 @@ config PATA_HPT366
>  
>  config PATA_HPT37X
>  	tristate "HPT 370/370A/371/372/374/302 PATA support"
> -	depends on PCI
> +	depends on PCI && HAS_IOPORT
>  	help
>  	  This option enables support for the majority of the later HPT
>  	  PATA controllers via the new ATA layer.
> @@ -716,7 +716,7 @@ config PATA_HPT37X
>  
>  config PATA_HPT3X2N
>  	tristate "HPT 371N/372N/302N PATA support"
> -	depends on PCI
> +	depends on PCI && HAS_IOPORT
>  	help
>  	  This option enables support for the N variant HPT PATA
>  	  controllers via the new ATA layer.
> @@ -819,7 +819,7 @@ config PATA_MPC52xx
>  
>  config PATA_NETCELL
>  	tristate "NETCELL Revolution RAID support"
> -	depends on PCI
> +	depends on PCI && HAS_IOPORT
>  	help
>  	  This option enables support for the Netcell Revolution RAID
>  	  PATA controller.
> @@ -855,7 +855,7 @@ config PATA_OLDPIIX
>  
>  config PATA_OPTIDMA
>  	tristate "OPTI FireStar PATA support (Very Experimental)"
> -	depends on PCI
> +	depends on PCI && HAS_IOPORT
>  	help
>  	  This option enables DMA/PIO support for the later OPTi
>  	  controllers found on some old motherboards and in some
> @@ -865,7 +865,7 @@ config PATA_OPTIDMA
>  
>  config PATA_PDC2027X
>  	tristate "Promise PATA 2027x support"
> -	depends on PCI
> +	depends on PCI && HAS_IOPORT
>  	help
>  	  This option enables support for Promise PATA pdc20268 to pdc20277 host adapters.
>  
> @@ -873,7 +873,7 @@ config PATA_PDC2027X
>  
>  config PATA_PDC_OLD
>  	tristate "Older Promise PATA controller support"
> -	depends on PCI
> +	depends on PCI && HAS_IOPORT
>  	help
>  	  This option enables support for the Promise 20246, 20262, 20263,
>  	  20265 and 20267 adapters.
> @@ -901,7 +901,7 @@ config PATA_RDC
>  
>  config PATA_SC1200
>  	tristate "SC1200 PATA support"
> -	depends on PCI && (X86_32 || COMPILE_TEST)
> +	depends on PCI && (X86_32 || COMPILE_TEST) && HAS_IOPORT
>  	help
>  	  This option enables support for the NatSemi/AMD SC1200 SoC
>  	  companion chip used with the Geode processor family.
> @@ -919,7 +919,7 @@ config PATA_SCH
>  
>  config PATA_SERVERWORKS
>  	tristate "SERVERWORKS OSB4/CSB5/CSB6/HT1000 PATA support"
> -	depends on PCI
> +	depends on PCI && HAS_IOPORT
>  	help
>  	  This option enables support for the Serverworks OSB4/CSB5/CSB6 and
>  	  HT1000 PATA controllers, via the new ATA layer.
> @@ -1183,7 +1183,7 @@ config ATA_GENERIC
>  
>  config PATA_LEGACY
>  	tristate "Legacy ISA PATA support (Experimental)"
> -	depends on (ISA || PCI)
> +	depends on (ISA || PCI) && HAS_IOPORT
>  	select PATA_TIMINGS
>  	help
>  	  This option enables support for ISA/VLB/PCI bus legacy PATA
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 9d28badfe41d..c8cb7ed28f83 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -3042,6 +3042,7 @@ EXPORT_SYMBOL_GPL(ata_bmdma_port_start32);
>   */
>  int ata_pci_bmdma_clear_simplex(struct pci_dev *pdev)
>  {
> +#ifdef CONFIG_HAS_IOPORT
>  	unsigned long bmdma = pci_resource_start(pdev, 4);
>  	u8 simplex;
>  
> @@ -3054,6 +3055,9 @@ int ata_pci_bmdma_clear_simplex(struct pci_dev *pdev)
>  	if (simplex & 0x80)
>  		return -EOPNOTSUPP;
>  	return 0;
> +#else
> +	return -ENOENT;
> +#endif /* CONFIG_HAS_IOPORT */
>  }
>  EXPORT_SYMBOL_GPL(ata_pci_bmdma_clear_simplex);
>  

-- 
Damien Le Moal
Western Digital Research

