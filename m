Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585EB716F1E
	for <lists+linux-arch@lfdr.de>; Tue, 30 May 2023 22:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjE3Uwt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 May 2023 16:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjE3Uv4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 May 2023 16:51:56 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE9CBE;
        Tue, 30 May 2023 13:51:50 -0700 (PDT)
Received: from [192.168.1.103] (178.176.75.218) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Tue, 30 May
 2023 23:51:39 +0300
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH v4 02/41] ata: add HAS_IOPORT dependencies
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Damien Le Moal <dlemoal@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
 <20230516110038.2413224-3-schnelle@linux.ibm.com>
Organization: Open Mobile Platform
Message-ID: <3af407e3-76a4-23df-8742-8f7b9a98f088@omp.ru>
Date:   Tue, 30 May 2023 23:51:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230516110038.2413224-3-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.75.218]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 05/30/2023 20:36:28
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 177729 [May 30 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 514 514 afae95493a83d1ad2cafbfa8c38dfd9c90c52a7a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_phishing_log_reg_50_60}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.75.218 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;178.176.75.218:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.75.218
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/30/2023 20:41:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 5/30/2023 6:29:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Hello!

On 5/16/23 1:59 PM, Niklas Schnelle wrote:

> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Note: The HAS_IOPORT Kconfig option was added in v6.4-rc1 so
>       per-subsystem patches may be applied independently
> 
>  drivers/ata/Kconfig       | 28 ++++++++++++++--------------
>  drivers/ata/ata_generic.c |  2 ++
>  drivers/ata/libata-sff.c  |  2 ++
>  include/linux/libata.h    |  2 ++
>  4 files changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 42b51c9812a0..c521cdc51f8c 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
[...]

   Shouldn't there be an entry for the ATIIXP driver here? It doesn't
call in*/out*() but it does call ata_bmdma_{start|stop}() that call
ioread*/iowrite*()...
   And shouldn't there be an entry for APT867x driver too? It does call
ioread*/iowrite*()...
 
[...]

   Shouldn't there be an entry for the HPT3x3 driver too? It does call
ioread*/iowrite*()... and also for the IT821x driver? And the Marvall
driver?

> @@ -819,7 +819,7 @@ config PATA_MPC52xx
>  
>  config PATA_NETCELL
>  	tristate "NETCELL Revolution RAID support"
> -	depends on PCI
> +	depends on PCI && HAS_IOPORT

   Not clear why -- because it calls ata_pci_bmdma_clear_simplex()?

[...]

   Shouldn't there be an entry for the NS87415 driver too? It does
call ioread*/iowrite*()...

[...]
> @@ -919,7 +919,7 @@ config PATA_SCH
>  
>  config PATA_SERVERWORKS
>  	tristate "SERVERWORKS OSB4/CSB5/CSB6/HT1000 PATA support"
> -	depends on PCI
> +	depends on PCI && HAS_IOPORT

   Not clear why -- because it calls ata_pci_bmdma_clear_simplex()?

[...]

   Shouldn't there be an entry for the VIA driver too? It does call
ioread*/iowrite*()... and SiL680 driver too... and Winbond SL82C105
driver too... and OPTi PIO driver too... and PCMCIA driver too...

[...]
> @@ -1183,7 +1183,7 @@ config ATA_GENERIC
>  
>  config PATA_LEGACY
>  	tristate "Legacy ISA PATA support (Experimental)"
> -	depends on (ISA || PCI)
> +	depends on (ISA || PCI) && HAS_IOPORT
>  	select PATA_TIMINGS

   Hm, won't it override the HAS_IOPORT dependency, if you enable
PATA_QDI or PATA_WINBOD_VLB?

>  	help
>  	  This option enables support for ISA/VLB/PCI bus legacy PATA
> diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
> index 2f57ec00ab82..2d391d117f74 100644
> --- a/drivers/ata/ata_generic.c
> +++ b/drivers/ata/ata_generic.c

   This driver calls ioread8() as well...

> @@ -197,8 +197,10 @@ static int ata_generic_init_one(struct pci_dev *dev, const struct pci_device_id
>  	if (!(command & PCI_COMMAND_IO))
>  		return -ENODEV;
>  
> +#ifdef CONFIG_PATA_ALI

   This #ifdef doesn't make sense to me -- pata_ali.c will call
the below function anyway, no?
>  	if (dev->vendor == PCI_VENDOR_ID_AL)
>  		ata_pci_bmdma_clear_simplex(dev);
> +#endif /* CONFIG_PATA_ALI */
>  	if (dev->vendor == PCI_VENDOR_ID_ATI) {
>  		int rc = pcim_enable_device(dev);
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 9d28badfe41d..80137edb7ebf 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -3031,6 +3031,7 @@ EXPORT_SYMBOL_GPL(ata_bmdma_port_start32);
>  
>  #ifdef CONFIG_PCI
>  
> +#ifdef CONFIG_HAS_IOPORT
>  /**
>   *	ata_pci_bmdma_clear_simplex -	attempt to kick device out of simplex
>   *	@pdev: PCI device
> @@ -3056,6 +3057,7 @@ int ata_pci_bmdma_clear_simplex(struct pci_dev *pdev)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(ata_pci_bmdma_clear_simplex);
> +#endif /* CONFIG_HAS_IOPORT */
>  
>  static void ata_bmdma_nodma(struct ata_host *host, const char *reason)
>  {
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 311cd93377c7..90002d4a785b 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -2012,7 +2012,9 @@ extern int ata_bmdma_port_start(struct ata_port *ap);
>  extern int ata_bmdma_port_start32(struct ata_port *ap);
>  
>  #ifdef CONFIG_PCI
> +#ifdef CONFIG_HAS_IOPORT
>  extern int ata_pci_bmdma_clear_simplex(struct pci_dev *pdev);
> +#endif /* CONFIG_HAS_IOPORT */

   Hm, wouldn't it be better if you used #else and declare an inline
variant of this function simply retirning an error?

[...]

MBR, Sergey
