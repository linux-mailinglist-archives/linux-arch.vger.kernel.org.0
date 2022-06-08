Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C53E543B8B
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jun 2022 20:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbiFHScJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Jun 2022 14:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiFHScI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jun 2022 14:32:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25D413F14;
        Wed,  8 Jun 2022 11:32:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87971B82997;
        Wed,  8 Jun 2022 18:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4EFC34116;
        Wed,  8 Jun 2022 18:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654713125;
        bh=YTLnd+oIKmgXRZgCJvVEoThO11zKOXHnDIydeVWWZvE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uD66j8tqhjuXks8exmMiAf7WMrr0tzeXdDirOWbOlW+mwzr2LrIENsJFjylWCXDDU
         9ZQnifQd3jR4U887LLtGHmJquaVsDhi1W3OHnJtSp4c3zGYX/r5eLbhDQ8JojuxjZp
         /X3WUlc3420CZqo5h+GNS/fahNZXgk02YQbJrPJBJRWGZ/u32ndsby9GaaMZ+1NUQJ
         bCmQNxPJ/eFJhBtXh99BuCb316KwNWgcKCUPJbFcLKEE6yziG2nlmh5HmWHpehT6Kw
         J1kSF5xO+Fi/UKPqlEFX2XHsZQnQtxQY7AKbPkZDt4zW2SeFPa3zIaCPZWQas0ecSO
         BmBX7q4AtuLSw==
Date:   Wed, 8 Jun 2022 13:32:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC v2 24/39] PCI/sysfs: make I/O resource depend on HAS_IOPORT
Message-ID: <20220608183203.GA409460@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429135108.2781579-42-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 29, 2022 at 03:50:39PM +0200, Niklas Schnelle wrote:
> Exporting I/O resources only makes sense if legacy I/O spaces are
> supported so conditionally add them only if HAS_IOPORT is set.

Same comments as for 23/39.

Once addressed,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

One more comment below.

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

I would probably move the #ifdefs inside the function to avoid
repeating the function signature.

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
>  
>  /**
>   * pci_remove_resource_files - cleanup resource files
> -- 
> 2.32.0
> 
