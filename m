Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A5D6B9AA3
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 17:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjCNQFq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 12:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjCNQFi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 12:05:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270D51F5E0;
        Tue, 14 Mar 2023 09:05:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCAC5B81A0D;
        Tue, 14 Mar 2023 16:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BA8C433D2;
        Tue, 14 Mar 2023 16:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678809916;
        bh=sg7oOJjbwfFYSoLpr5WGCAKppdkWvG5HInKuZ//PcQc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hcug/2Lbt4KG6c59HznuL1yyW3RHViWs5B8rzOJcWGJudpmwedspzzXhWTvpmnB0T
         ETDP1WGMpfcw0zMpY3I39A9MXHvcjmTFwrMPBKn8eryiZPSpVY0tSlVhW99WPcQPrL
         Pt3eodsrXugaqj6daYyECPb+vYODCMNAXGA6w4Y/F97mVXibHpz71whfPhXhFQCmIy
         aFnGRj8J0+gO0dQhEZK5NgsfYZdmc+RXHbCvVyQnsCcO9xr2o+OP0OawT/iqtIjbKY
         Ei9HZf9G7C6Qm3iO9FspCPjrLk+4PLxyjg2ShbinxvICxlzMed1Vk+39A17p2wtPAn
         5pxuhAukU6cnw==
Date:   Tue, 14 Mar 2023 11:05:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v3 23/38] PCI/sysfs: Make I/O resource depend on
 HAS_IOPORT
Message-ID: <20230314160514.GA1648498@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314121216.413434-24-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 14, 2023 at 01:12:01PM +0100, Niklas Schnelle wrote:
> If legacy I/O spaces are not supported simply return an error when
> trying to access them via pci_resource_io(). This allows inb() and
> friends to become undefined when they are known at compile time to be
> non-functional in a later patch.
> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci-sysfs.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index dd0d9d9bc509..11e92d106761 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1083,6 +1083,7 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
>  			       struct bin_attribute *attr, char *buf,
>  			       loff_t off, size_t count, bool write)
>  {
> +#ifdef CONFIG_HAS_IOPORT
>  	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
>  	int bar = (unsigned long)attr->private;
>  	unsigned long port = off;
> @@ -1116,6 +1117,9 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
>  		return 4;
>  	}
>  	return -EINVAL;
> +#else
> +	return -ENXIO;
> +#endif
>  }
>  
>  static ssize_t pci_read_resource_io(struct file *filp, struct kobject *kobj,
> -- 
> 2.37.2
> 
