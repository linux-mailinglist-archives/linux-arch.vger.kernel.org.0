Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D8E51AF9A
	for <lists+linux-arch@lfdr.de>; Wed,  4 May 2022 22:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378344AbiEDUqQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 May 2022 16:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378345AbiEDUqN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2022 16:46:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C37517CE;
        Wed,  4 May 2022 13:42:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EB4F618B4;
        Wed,  4 May 2022 20:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5766DC385A4;
        Wed,  4 May 2022 20:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651696953;
        bh=VHSa4GEXYgtRjGmNPuVVqJEuTANBA7a7IX32GVjUX2M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=F4yBn9jwctPNtQdKRFs/6nHnRsWwaxCScPBz+U95zYo6dgmIwNFZAmvmX7H6MWZbj
         aGvZ1pgPWtQsqSGILPdOAZleOpFkfWLo+wv8aaE7UKRDq8McmpziK3S6XGv6ImLaK4
         tEbzS+Iqg48BRS5nCKv0CRIqemfOXDaxRKVdoh7wbAWgrM7H5wsoZWdOyazV+SDgZl
         MRPe3TPPKyrBXLf6V4al432Bt3TcUbNMCS+JgbLjeqSTWqAHMWVMtiLEJoJTIzNs2b
         M4jQ+193ZgSgs/uLc4iz06CJPMzzGshZFYU6awy5fB7XKK9MOgLm/w0EQM0sW9ZJm+
         t+6uIbwIIQGXg==
Date:   Wed, 4 May 2022 15:42:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Nilesh Javali <njavali@marvell.com>,
        "supporter:QLOGIC QLA2XXX FC-SCSI DRIVER" 
        <GR-QLogic-Storage-Upstream@marvell.com>,
        "open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
        "open list:MEGARAID SCSI/SAS DRIVERS" 
        <megaraidlinux.pdl@broadcom.com>
Subject: Re: [RFC v2 30/39] scsi: add HAS_IOPORT dependencies
Message-ID: <20220504204231.GA463295@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429135108.2781579-54-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 29, 2022 at 03:50:51PM +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.

Some of these drivers support devices using either I/O ports or MMIO.
Adding the HAS_IOPORT dependency means MMIO devices that *could* work
on systems without I/O ports, won't work.

Even the MMIO-only devices are probably old and not of much interest.
But if you want to disable them even though they *could* work, I think
that's worth mentioning in the commit log.

> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
>  config SCSI_IPS
>  	tristate "IBM ServeRAID support"
> -	depends on PCI && SCSI
> +	depends on PCI && HAS_IOPORT && SCSI

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/ips.c?id=v5.17#n6867

> diff --git a/drivers/scsi/aic7xxx/Kconfig.aic7xxx b/drivers/scsi/aic7xxx/Kconfig.aic7xxx
>  config SCSI_AIC94XX
>  	tristate "Adaptec AIC94xx SAS/SATA support"
> -	depends on PCI
> +	depends on PCI && HAS_IOPORT
>  	select SCSI_SAS_LIBSAS
>  	select FW_LOADER
>  	help

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/aic7xxx/aic79xx_osm_pci.c?id=v5.17#n304

> diff --git a/drivers/scsi/megaraid/Kconfig.megaraid b/drivers/scsi/megaraid/Kconfig.megaraid
>  config MEGARAID_LEGACY
>  	tristate "LSI Logic Legacy MegaRAID Driver"
> -	depends on PCI && SCSI
> +	depends on PCI && HAS_IOPORT && SCSI

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/megaraid.c?id=v5.17#n4190

> diff --git a/drivers/scsi/mvsas/Kconfig b/drivers/scsi/mvsas/Kconfig
>  config SCSI_MVSAS
>  	tristate "Marvell 88SE64XX/88SE94XX SAS/SATA support"
> -	depends on PCI
> +	depends on PCI && HAS_IOPORT
>  	select SCSI_SAS_LIBSAS
>  	select FW_LOADER
>  	help

This turns off all MVSAS support, but apparently only mv_64xx.c uses
I/O ports:

  git grep -E "\<(in|out)[bwl]\>" drivers/scsi/mvsas
  git grep -E "\<io[rw](8|16|32)\>" drivers/scsi/mvsas

It doesn't look like the Makefile is currently set up to build
mv_64xx.c separately.

Bjorn
