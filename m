Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F3C54F8DC
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jun 2022 16:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382566AbiFQOCi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jun 2022 10:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382551AbiFQOCh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jun 2022 10:02:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A102F2BC9;
        Fri, 17 Jun 2022 07:02:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CA0712FC;
        Fri, 17 Jun 2022 07:02:36 -0700 (PDT)
Received: from [10.57.84.65] (unknown [10.57.84.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40BA13F7D8;
        Fri, 17 Jun 2022 07:02:33 -0700 (PDT)
Message-ID: <f5085d38-c596-61d4-befc-9b9f8bb8c11e@arm.com>
Date:   Fri, 17 Jun 2022 15:02:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/3] scsi: BusLogic remove bus_to_virt
Content-Language: en-GB
To:     Arnd Bergmann <arnd@kernel.org>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Miquel van Smoorenburg <mikevs@xs4all.net>,
        linux-parisc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linuxppc-dev@lists.ozlabs.org,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        linux-m68k@lists.linux-m68k.org, Denis Efremov <efremov@linux.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org, Matt Wang <wwentao@vmware.com>,
        linux-alpha@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Khalid Aziz <khalid@gonehiking.org>
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-3-arnd@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220617125750.728590-3-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2022-06-17 13:57, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The BusLogic driver is the last remaining driver that relies on the
> deprecated bus_to_virt() function, which in turn only works on a few
> architectures, and is incompatible with both swiotlb and iommu support.
> 
> Before commit 391e2f25601e ("[SCSI] BusLogic: Port driver to 64-bit."),
> the driver had a dependency on x86-32, presumably because of this
> problem. However, the change introduced another bug that made it still
> impossible to use the driver on any 64-bit machine.
> 
> This was in turn fixed in commit 56f396146af2 ("scsi: BusLogic: Fix
> 64-bit system enumeration error for Buslogic"), 8 years later, which
> shows that there are not a lot of users.
> 
> Maciej is still using the driver on 32-bit hardware, and Khalid mentioned
> that the driver works with the device emulation used in VirtualBox
> and VMware. Both of those only emulate it for Windows 2000 and older
> operating systems that did not ship with the better LSI logic driver.
> 
> Do a minimum fix that searches through the list of descriptors to find
> one that matches the bus address. This is clearly as inefficient as
> was indicated in the code comment about the lack of a bus_to_virt()
> replacement. A better fix would likely involve changing out the entire
> descriptor allocation for a simpler one, but that would be much
> more invasive.

FWIW, if efficiency *is* a practical concern, even under the current 
allocation scheme it looks like there are only 4 actual DMA allocations 
to search through. From a quick scan (since it's too hot here not to get 
distracted...), if I wanted to optimise this in future I'd probably 
remove the semi-redundant allocgrp_* fields from struct blogic_ccb and 
hang a dedicated list of the block allocations off the adapter - at that 
point the lookup could likely already be more efficient than a 
theoretical dma_to_virt() interface would be if it had to go off and 
walk an IOMMU pagetable. Then the next question would be whether it's 
viable to make a single 32KB allocation rather 4*8KB, so it's no longer 
even a list.

For now, though, I agree with the simple change that's clear and easy to 
reason about:

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks,
Robin.

> Cc: Maciej W. Rozycki <macro@orcam.me.uk>
> Cc: Matt Wang <wwentao@vmware.com>
> Cc: Khalid Aziz <khalid@gonehiking.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/scsi/BusLogic.c | 27 ++++++++++++++++-----------
>   drivers/scsi/Kconfig    |  2 +-
>   2 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
> index a897c8f914cf..d057abfcdd5c 100644
> --- a/drivers/scsi/BusLogic.c
> +++ b/drivers/scsi/BusLogic.c
> @@ -2515,12 +2515,26 @@ static int blogic_resultcode(struct blogic_adapter *adapter,
>   	return (hoststatus << 16) | tgt_status;
>   }
>   
> +/*
> + * turn the dma address from an inbox into a ccb pointer
> + * This is rather inefficient.
> + */
> +static struct blogic_ccb *
> +blogic_inbox_to_ccb(struct blogic_adapter *adapter, struct blogic_inbox *inbox)
> +{
> +	struct blogic_ccb *ccb;
> +
> +	for (ccb = adapter->all_ccbs; ccb; ccb = ccb->next_all)
> +		if (inbox->ccb == ccb->dma_handle)
> +			break;
> +
> +	return ccb;
> +}
>   
>   /*
>     blogic_scan_inbox scans the Incoming Mailboxes saving any
>     Incoming Mailbox entries for completion processing.
>   */
> -
>   static void blogic_scan_inbox(struct blogic_adapter *adapter)
>   {
>   	/*
> @@ -2540,16 +2554,7 @@ static void blogic_scan_inbox(struct blogic_adapter *adapter)
>   	enum blogic_cmplt_code comp_code;
>   
>   	while ((comp_code = next_inbox->comp_code) != BLOGIC_INBOX_FREE) {
> -		/*
> -		   We are only allowed to do this because we limit our
> -		   architectures we run on to machines where bus_to_virt(
> -		   actually works.  There *needs* to be a dma_addr_to_virt()
> -		   in the new PCI DMA mapping interface to replace
> -		   bus_to_virt() or else this code is going to become very
> -		   innefficient.
> -		 */
> -		struct blogic_ccb *ccb =
> -			(struct blogic_ccb *) bus_to_virt(next_inbox->ccb);
> +		struct blogic_ccb *ccb = blogic_inbox_to_ccb(adapter, adapter->next_inbox);
>   		if (comp_code != BLOGIC_CMD_NOTFOUND) {
>   			if (ccb->status == BLOGIC_CCB_ACTIVE ||
>   					ccb->status == BLOGIC_CCB_RESET) {
> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index cf75588a2587..56bdc08d0b77 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -513,7 +513,7 @@ config SCSI_HPTIOP
>   
>   config SCSI_BUSLOGIC
>   	tristate "BusLogic SCSI support"
> -	depends on PCI && SCSI && VIRT_TO_BUS
> +	depends on PCI && SCSI
>   	help
>   	  This is support for BusLogic MultiMaster and FlashPoint SCSI Host
>   	  Adapters. Consult the SCSI-HOWTO, available from
