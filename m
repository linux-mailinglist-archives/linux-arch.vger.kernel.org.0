Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C73D480508
	for <lists+linux-arch@lfdr.de>; Mon, 27 Dec 2021 23:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhL0WEr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 17:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhL0WEr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Dec 2021 17:04:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D117C06173E;
        Mon, 27 Dec 2021 14:04:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61D21B80D8E;
        Mon, 27 Dec 2021 22:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF63FC36AEA;
        Mon, 27 Dec 2021 22:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640642684;
        bh=WJL+K0hI3nwJke136i/0N4gSC4MX2UG4T24o5kI2ZCo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LPLcrpwmwEpR6GXtmPDQxAS5U0HsQLi/CB9P+gregE+DcfQwu7ErElWcKXTZbMdU6
         XsCtsWEk0WBE+mdjM1tKbunFxcFQikU/+TA0D89rcFi86Y85WxzRdoIY86PRvjVdtG
         diIwKaiI3YvY4kYq43BX3PuQVbuHlqLoF3LUbX+n+6aL1J9DGg4HhKBvQx2P0XfAy7
         WusCUz7/Y5id3h1FfcJgYrgH5um91lNX8uL0nwr0Tpepdou9dSJJIXZ6GCtfCdLfBD
         LIlhhqwlkP3AiKo8eLFOy/k3gO8zizcoVOTtD8CF1BbmHHWy/myCg1kQ1We1WzE6Nq
         9m7bdLO4V7+kA==
Date:   Mon, 27 Dec 2021 16:04:42 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
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
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org
Subject: Re: [RFC 27/32] PCI/sysfs: make I/O resource depend on HAS_IOPORT
Message-ID: <20211227220442.GA1544995@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227164317.4146918-28-schnelle@linux.ibm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Make the subject match historical convention (capitalize "Make").

On Mon, Dec 27, 2021 at 05:43:12PM +0100, Niklas Schnelle wrote:
> Exporting I/O resources only makes sense if legacy I/O spaces are
> supported so conditionally add them only if HAS_IOPORT is set.

IIUC, the effect of this is that the "resource%d" file for an I/O BAR
still appears in /sys, but reads or writes will fail with ENXIO.
Worth mentioning that in the commit log, since one could interpret the
above as meaning that the "resource%d" file exists only if HAS_IOPORT
is set.  I think I will *exist* but not be very useful.

I also wonder what this looks like in the sysfs "resource" file and
via lspci.  I suppose it's useful if lspci shows the fact that the BAR
exists and is an I/O BAR, even if the arch doesn't set HAS_IOPORT.

> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/pci/pci-sysfs.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index cfe2f85af09e..a59a85593972 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1099,6 +1099,7 @@ static int pci_mmap_resource_wc(struct file *filp, struct kobject *kobj,
>  	return pci_mmap_resource(kobj, attr, vma, 1);
>  }
>  
> +#ifdef CONFIG_HAS_IOPORT
>  static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
>  			       struct bin_attribute *attr, char *buf,
>  			       loff_t off, size_t count, bool write)
> @@ -1157,6 +1158,21 @@ static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
>  
>  	return pci_resource_io(filp, kobj, attr, buf, off, count, true);
>  }
> +#else
> +static ssize_t pci_read_resource_io(struct file *filp, struct kobject *kobj,
> +				    struct bin_attribute *attr, char *buf,
> +				    loff_t off, size_t count)
> +{
> +	return -ENXIO;
> +}

I assume the sysfs infrastructure prevents or fails reads/write if
res_attr->read and res_attr->write are not set at all, so maybe we
wouldn't need the stubs if we did something like this?

    if (pci_resource_flags(pdev, num) & IORESOURCE_IO) {
  #ifdef CONFIG_HAS_IOPORT
      res_attr->read = pci_read_resource_io;
      res_attr->write = pci_write_resource_io;
      ...
  #endif
    } else {

> +static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
> +				     struct bin_attribute *attr, char *buf,
> +				     loff_t off, size_t count)
> +{
> +	return -ENXIO;
> +}
> +#endif
>  
>  /**
>   * pci_remove_resource_files - cleanup resource files
> -- 
> 2.32.0
> 
