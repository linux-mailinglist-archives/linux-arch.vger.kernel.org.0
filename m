Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC69704F2C
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 15:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbjEPNYB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 09:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbjEPNYA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 09:24:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CC23A9D;
        Tue, 16 May 2023 06:23:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D7B760C22;
        Tue, 16 May 2023 13:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF6DC433D2;
        Tue, 16 May 2023 13:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684243438;
        bh=UL05v1CxiIyUPOZmHWruyIR0tfa5m8s8C8wAP+LPjdc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GkEVedlmTyptfEIZKoQ81kwJ20PnRcJ927GnommytUFGNKKJR+u7ksDiDK2U/ILkR
         GdkM1iEEo8dXui4/tL2SzNisN6nuLZL/UnsOS2CknJ/AylUs/bIPscsyluPd7Ffqym
         rVcGEtM2wCj1ftdAzgp3Mf5KPosYEbLHsE5jGAHrIqqNLHI1cOjpSZlN5kci1pxn9W
         aH0Pr3C7IX8IaWmW7/K7RE9qScMgguOYAO9KlQbsG3pFbgvUbq8KksTVywG+E8teJ0
         yG97VzdnTp/T/LU5CEkhN0TUjunK7wKAd8x7d87Q+5SrlCZDRr2J4EVzsFA1t0aw1v
         qfYvc6C2Fs55Q==
Message-ID: <33d99147-74c9-d62a-7591-a569e11a401d@kernel.org>
Date:   Tue, 16 May 2023 22:23:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 02/41] ata: add HAS_IOPORT dependencies
Content-Language: en-US
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
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
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
 <20230516110038.2413224-3-schnelle@linux.ibm.com>
 <da77a377-4a9e-be8d-7b14-aeb270b7183e@kernel.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <da77a377-4a9e-be8d-7b14-aeb270b7183e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/16/23 22:18, Damien Le Moal wrote:
> On 5/16/23 19:59, Niklas Schnelle wrote:
>> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
>> not being declared. We thus need to add HAS_IOPORT as dependency for
>> those drivers using them.
>>
>> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
>> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
>> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> ---
>> Note: The HAS_IOPORT Kconfig option was added in v6.4-rc1 so
>>       per-subsystem patches may be applied independently
>>
>>  drivers/ata/Kconfig       | 28 ++++++++++++++--------------
>>  drivers/ata/ata_generic.c |  2 ++
>>  drivers/ata/libata-sff.c  |  2 ++
>>  include/linux/libata.h    |  2 ++
>>  4 files changed, 20 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>> index 42b51c9812a0..c521cdc51f8c 100644
>> --- a/drivers/ata/Kconfig
>> +++ b/drivers/ata/Kconfig
>> @@ -557,7 +557,7 @@ comment "PATA SFF controllers with BMDMA"
>>  
>>  config PATA_ALI
>>  	tristate "ALi PATA support"
>> -	depends on PCI
>> +	depends on PCI && HAS_IOPORT
>>  	select PATA_TIMINGS
>>  	help
>>  	  This option enables support for the ALi ATA interfaces
>> @@ -567,7 +567,7 @@ config PATA_ALI
>>  
>>  config PATA_AMD
>>  	tristate "AMD/NVidia PATA support"
>> -	depends on PCI
>> +	depends on PCI && HAS_IOPORT
>>  	select PATA_TIMINGS
>>  	help
>>  	  This option enables support for the AMD and NVidia PATA
>> @@ -585,7 +585,7 @@ config PATA_ARASAN_CF
>>  
>>  config PATA_ARTOP
>>  	tristate "ARTOP 6210/6260 PATA support"
>> -	depends on PCI
>> +	depends on PCI && HAS_IOPORT
>>  	help
>>  	  This option enables support for ARTOP PATA controllers.
>>  
>> @@ -612,7 +612,7 @@ config PATA_ATP867X
>>  
>>  config PATA_CMD64X
>>  	tristate "CMD64x PATA support"
>> -	depends on PCI
>> +	depends on PCI && HAS_IOPORT
>>  	select PATA_TIMINGS
>>  	help
>>  	  This option enables support for the CMD64x series chips
>> @@ -659,7 +659,7 @@ config PATA_CS5536
>>  
>>  config PATA_CYPRESS
>>  	tristate "Cypress CY82C693 PATA support (Very Experimental)"
>> -	depends on PCI
>> +	depends on PCI && HAS_IOPORT
>>  	select PATA_TIMINGS
>>  	help
>>  	  This option enables support for the Cypress/Contaq CY82C693
>> @@ -707,7 +707,7 @@ config PATA_HPT366
>>  
>>  config PATA_HPT37X
>>  	tristate "HPT 370/370A/371/372/374/302 PATA support"
>> -	depends on PCI
>> +	depends on PCI && HAS_IOPORT
>>  	help
>>  	  This option enables support for the majority of the later HPT
>>  	  PATA controllers via the new ATA layer.
>> @@ -716,7 +716,7 @@ config PATA_HPT37X
>>  
>>  config PATA_HPT3X2N
>>  	tristate "HPT 371N/372N/302N PATA support"
>> -	depends on PCI
>> +	depends on PCI && HAS_IOPORT
>>  	help
>>  	  This option enables support for the N variant HPT PATA
>>  	  controllers via the new ATA layer.
>> @@ -819,7 +819,7 @@ config PATA_MPC52xx
>>  
>>  config PATA_NETCELL
>>  	tristate "NETCELL Revolution RAID support"
>> -	depends on PCI
>> +	depends on PCI && HAS_IOPORT
>>  	help
>>  	  This option enables support for the Netcell Revolution RAID
>>  	  PATA controller.
>> @@ -855,7 +855,7 @@ config PATA_OLDPIIX
>>  
>>  config PATA_OPTIDMA
>>  	tristate "OPTI FireStar PATA support (Very Experimental)"
>> -	depends on PCI
>> +	depends on PCI && HAS_IOPORT
>>  	help
>>  	  This option enables DMA/PIO support for the later OPTi
>>  	  controllers found on some old motherboards and in some
>> @@ -865,7 +865,7 @@ config PATA_OPTIDMA
>>  
>>  config PATA_PDC2027X
>>  	tristate "Promise PATA 2027x support"
>> -	depends on PCI
>> +	depends on PCI && HAS_IOPORT
>>  	help
>>  	  This option enables support for Promise PATA pdc20268 to pdc20277 host adapters.
>>  
>> @@ -873,7 +873,7 @@ config PATA_PDC2027X
>>  
>>  config PATA_PDC_OLD
>>  	tristate "Older Promise PATA controller support"
>> -	depends on PCI
>> +	depends on PCI && HAS_IOPORT
>>  	help
>>  	  This option enables support for the Promise 20246, 20262, 20263,
>>  	  20265 and 20267 adapters.
>> @@ -901,7 +901,7 @@ config PATA_RDC
>>  
>>  config PATA_SC1200
>>  	tristate "SC1200 PATA support"
>> -	depends on PCI && (X86_32 || COMPILE_TEST)
>> +	depends on PCI && (X86_32 || COMPILE_TEST) && HAS_IOPORT
>>  	help
>>  	  This option enables support for the NatSemi/AMD SC1200 SoC
>>  	  companion chip used with the Geode processor family.
>> @@ -919,7 +919,7 @@ config PATA_SCH
>>  
>>  config PATA_SERVERWORKS
>>  	tristate "SERVERWORKS OSB4/CSB5/CSB6/HT1000 PATA support"
>> -	depends on PCI
>> +	depends on PCI && HAS_IOPORT
>>  	help
>>  	  This option enables support for the Serverworks OSB4/CSB5/CSB6 and
>>  	  HT1000 PATA controllers, via the new ATA layer.
>> @@ -1183,7 +1183,7 @@ config ATA_GENERIC
>>  
>>  config PATA_LEGACY
>>  	tristate "Legacy ISA PATA support (Experimental)"
>> -	depends on (ISA || PCI)
>> +	depends on (ISA || PCI) && HAS_IOPORT
>>  	select PATA_TIMINGS
>>  	help
>>  	  This option enables support for ISA/VLB/PCI bus legacy PATA
>> diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
>> index 2f57ec00ab82..2d391d117f74 100644
>> --- a/drivers/ata/ata_generic.c
>> +++ b/drivers/ata/ata_generic.c
>> @@ -197,8 +197,10 @@ static int ata_generic_init_one(struct pci_dev *dev, const struct pci_device_id
>>  	if (!(command & PCI_COMMAND_IO))
>>  		return -ENODEV;
>>  
>> +#ifdef CONFIG_PATA_ALI
>>  	if (dev->vendor == PCI_VENDOR_ID_AL)
>>  		ata_pci_bmdma_clear_simplex(dev);
>> +#endif /* CONFIG_PATA_ALI */
> 
> You can drop this change if...
> 
>>  
>>  	if (dev->vendor == PCI_VENDOR_ID_ATI) {
>>  		int rc = pcim_enable_device(dev);
>> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
>> index 9d28badfe41d..80137edb7ebf 100644
>> --- a/drivers/ata/libata-sff.c
>> +++ b/drivers/ata/libata-sff.c
>> @@ -3031,6 +3031,7 @@ EXPORT_SYMBOL_GPL(ata_bmdma_port_start32);
>>  
>>  #ifdef CONFIG_PCI
>>  
>> +#ifdef CONFIG_HAS_IOPORT
>>  /**
>>   *	ata_pci_bmdma_clear_simplex -	attempt to kick device out of simplex
>>   *	@pdev: PCI device
>> @@ -3056,6 +3057,7 @@ int ata_pci_bmdma_clear_simplex(struct pci_dev *pdev)
>>  	return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(ata_pci_bmdma_clear_simplex);
>> +#endif /* CONFIG_HAS_IOPORT */
> 
> ...you move the #ifdef CONFIG_HAS_IOPORT inside the function as the first line
> and have the #endif right before the last "return 0;" (so the function only does
> return 0 for the !CONFIG_HAS_IOPORT case).
> 
>>  
>>  static void ata_bmdma_nodma(struct ata_host *host, const char *reason)
>>  {
>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>> index 311cd93377c7..90002d4a785b 100644
>> --- a/include/linux/libata.h
>> +++ b/include/linux/libata.h
>> @@ -2012,7 +2012,9 @@ extern int ata_bmdma_port_start(struct ata_port *ap);
>>  extern int ata_bmdma_port_start32(struct ata_port *ap);
>>  
>>  #ifdef CONFIG_PCI
>> +#ifdef CONFIG_HAS_IOPORT
>>  extern int ata_pci_bmdma_clear_simplex(struct pci_dev *pdev);
>> +#endif /* CONFIG_HAS_IOPORT */
> 
> And then you do not need these #ifdef/endif here. Overall, a lot less of #ifdef
> which I personally really dislike to see in .c files :)

Actually, thinking more about this, the function should probably be:

int ata_pci_bmdma_clear_simplex(struct pci_dev *pdev)
{
#ifdef CONFIG_HAS_IOPORT
	unsigned long bmdma = pci_resource_start(pdev, 4);
	u8 simplex;

	if (bmdma == 0)
		return -ENOENT;

	simplex = inb(bmdma + 0x02);
	outb(simplex & 0x60, bmdma + 0x02);
	simplex = inb(bmdma + 0x02);
	if (simplex & 0x80)
		return -EOPNOTSUPP;
	return 0;
#else
	return -ENOENT;
#endif
}

And then no other "#ifdef CONFIG_HAS_IOPORT" needed.

> 
>>  extern void ata_pci_bmdma_init(struct ata_host *host);
>>  extern int ata_pci_bmdma_prepare_host(struct pci_dev *pdev,
>>  				      const struct ata_port_info * const * ppi,
> 

-- 
Damien Le Moal
Western Digital Research

