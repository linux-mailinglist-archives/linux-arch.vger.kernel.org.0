Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16348480744
	for <lists+linux-arch@lfdr.de>; Tue, 28 Dec 2021 09:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhL1IPS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Dec 2021 03:15:18 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35962 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhL1IPR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Dec 2021 03:15:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70A68B81162;
        Tue, 28 Dec 2021 08:15:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002F8C36AE7;
        Tue, 28 Dec 2021 08:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640679315;
        bh=VBxcm5mbsbYVIp6HBaklzK/nPNC0PMjZn2VE4aLnAOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vwrzngpastuetBPEvMyaV2HOPaZCNDjEmFST41sBawwyngnYsNBJX/XyP+ZCbvzZ8
         Er2f017CXxfpLME5JRrqRrQnRjuRfFNLO6IG8ZTZxbUtALVHMFkfIONWhjLATAEmjr
         tECrWtGEKyjGgMi907uTqCBWIv6X8bAZJnOy1xJY=
Date:   Tue, 28 Dec 2021 09:15:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org
Subject: Re: [RFC 16/32] misc: handle HAS_IOPORT dependencies
Message-ID: <YcrHi7cZDWZlTZ2w@kroah.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-17-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227164317.4146918-17-schnelle@linux.ibm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 27, 2021 at 05:43:01PM +0100, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/misc/altera-stapl/Makefile | 3 ++-
>  drivers/misc/altera-stapl/altera.c | 6 +++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/altera-stapl/Makefile b/drivers/misc/altera-stapl/Makefile
> index dd0f8189666b..90f18e7bf9b0 100644
> --- a/drivers/misc/altera-stapl/Makefile
> +++ b/drivers/misc/altera-stapl/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -altera-stapl-objs = altera-lpt.o altera-jtag.o altera-comp.o altera.o
> +altera-stapl-y = altera-jtag.o altera-comp.o altera.o
> +altera-stapl-$(CONFIG_HAS_IOPORT) += altera-lpt.o
>  
>  obj-$(CONFIG_ALTERA_STAPL) += altera-stapl.o
> diff --git a/drivers/misc/altera-stapl/altera.c b/drivers/misc/altera-stapl/altera.c
> index 92c0611034b0..c7ae64de8bb4 100644
> --- a/drivers/misc/altera-stapl/altera.c
> +++ b/drivers/misc/altera-stapl/altera.c
> @@ -2431,6 +2431,10 @@ int altera_init(struct altera_config *config, const struct firmware *fw)
>  
>  	astate->config = config;
>  	if (!astate->config->jtag_io) {
> +		if (!IS_ENABLED(CONFIG_HAS_IOPORT)) {
> +			retval = -ENODEV;
> +			goto free_state;
> +		}

A comment as to why you are doing this check here would be nice, as it
is not obvious at all what is going on.

thanks,

greg k-h
