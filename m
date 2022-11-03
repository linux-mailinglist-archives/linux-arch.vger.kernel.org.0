Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A46617715
	for <lists+linux-arch@lfdr.de>; Thu,  3 Nov 2022 08:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiKCHCW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Nov 2022 03:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiKCHCS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Nov 2022 03:02:18 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADECDD2DA;
        Thu,  3 Nov 2022 00:02:17 -0700 (PDT)
Received: from anrayabh-desk (unknown [167.220.238.193])
        by linux.microsoft.com (Postfix) with ESMTPSA id ACB98205DA28;
        Thu,  3 Nov 2022 00:02:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ACB98205DA28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667458937;
        bh=RmEBOp1jxEl8jwEbvovgwfpLMRKzIAy0S5U6ohu6+bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m9MMFzTo/nB7xnKk0cPXEyb6SJh2xqugsdtgatgmPxVViwL4Tlt4bItVcOcypcwxg
         dcpIbBclhVerd3pZM43yQeML6souvDXMgHq/g26GoLejZGd6nhL70URh2Ivm6ILLWH
         4mq1brUlVJv/5q8iLliIikEBN94bQ9iglF/ZBH+Q=
Date:   Thu, 3 Nov 2022 12:32:06 +0530
From:   Anirudh Rayabharam <anrayabh@linux.microsoft.com>
To:     Jinank Jain <jinankjain@linux.microsoft.com>
Cc:     jinankjain@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, arnd@arndb.de, peterz@infradead.org,
        jpoimboe@kernel.org, seanjc@google.com,
        kirill.shutemov@linux.intel.com, ak@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 4/5] hv: Enable vmbus driver for nested root partition
Message-ID: <Y2Nnbs7o7aRd/E07@anrayabh-desk>
References: <cover.1667406350.git.jinankjain@linux.microsoft.com>
 <b5ea40f7e84e17a4338a313ab74292a293b1efa4.1667406350.git.jinankjain@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5ea40f7e84e17a4338a313ab74292a293b1efa4.1667406350.git.jinankjain@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 02, 2022 at 04:36:01PM +0000, Jinank Jain wrote:
> Currently VMBus driver is not initialized for root partition but we need
> to enable the VMBus driver for nested root partition. This is required
> to expose VMBus devices to the L2 guest in the nested setup.

Perhaps more importantly, this is required so that L2 _root_ can use the
VMBus devices.

> 
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 8b2e413bf19c..2f0cf75e811b 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2723,7 +2723,7 @@ static int __init hv_acpi_init(void)
>  	if (!hv_is_hyperv_initialized())
>  		return -ENODEV;
>  
> -	if (hv_root_partition)
> +	if (hv_root_partition && !hv_nested)
>  		return 0;
>  
>  	/*
> -- 
> 2.25.1
