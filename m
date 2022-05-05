Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D678651CB8A
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 23:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385645AbiEEVpm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 May 2022 17:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386010AbiEEVpl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2022 17:45:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A0452B3B;
        Thu,  5 May 2022 14:42:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C73CB83064;
        Thu,  5 May 2022 21:41:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A806C385A8;
        Thu,  5 May 2022 21:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651786917;
        bh=BPc9WqWpC3xrMl996l+n7A3XBqaa6XGpUCSdSclEs+E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EMGb04jn1LeJ/uNSX6Y5NGwPzHOJemqCUID1fnIVtnFbIwd6gREps/l7Ejr+LvqE7
         0xEHbNSG1VTRg6Ua6wWYk9YKPyxxyonBQt+mLdsmniRpPgAAfKTIXREL4EErOGF0iS
         Y1s0f60JBrkfBZJ9DFs4wrH+H79wU/t3JOrAUPBMIsAD+UOaklxesXh4wFX5nSiCUv
         Yq5VBFI8hGt8m/h4QTyLYMQozQ0k6FKK2uMqI3NYKD1MJ3eQ9P1kTN9wrUR70yCtaN
         OeXHYgWW3VsoLZq15G3hITOXa19BHdVyddcf5SXBaHDeQvhXjH3xbgZAHvoZD07Zt4
         90xDfcqRFy9mQ==
Date:   Thu, 5 May 2022 16:41:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 32/37] PCI/sysfs: make I/O resource depend on HAS_IOPORT
Message-ID: <20220505214154.GA513742@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429135108.2781579-58-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Capitalize "Make" in the subject to match previous drivers/pci
history.

On Fri, Apr 29, 2022 at 03:50:55PM +0200, Niklas Schnelle wrote:
> Exporting I/O resources only makes sense if legacy I/O spaces are
> supported so conditionally add them only if HAS_IOPORT is set.

This doesn't quite match what the patch does.  We still *add* the
sysfs files, it's just that reads/writes return error.

> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/pci/pci-sysfs.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index c263ffc5884a..eda258fa4981 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1091,6 +1091,7 @@ static int pci_mmap_resource_wc(struct file *filp, struct kobject *kobj,
>  	return pci_mmap_resource(kobj, attr, vma, 1);
>  }
>  
> +#ifdef CONFIG_HAS_IOPORT
>  static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
>  			       struct bin_attribute *attr, char *buf,
>  			       loff_t off, size_t count, bool write)
> @@ -1149,6 +1150,21 @@ static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
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
> +
> +static ssize_t pci_write_resource_io(struct file *filp, struct kobject *kobj,
> +				     struct bin_attribute *attr, char *buf,
> +				     loff_t off, size_t count)
> +{
> +	return -ENXIO;
> +}
> +#endif

I would move the #ifdef inside pci_resource_io().  Only need one
#ifdef and it's closer to the inb/outb.
