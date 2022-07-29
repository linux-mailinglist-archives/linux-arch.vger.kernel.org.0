Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336D158541D
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jul 2022 19:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238270AbiG2REx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jul 2022 13:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237332AbiG2REw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jul 2022 13:04:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87606E8A9;
        Fri, 29 Jul 2022 10:04:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 782A061ED2;
        Fri, 29 Jul 2022 17:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5827C433D6;
        Fri, 29 Jul 2022 17:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659114290;
        bh=DcWx9p4/hRXdIOIZbgcqzhHWPEITyeP4nUssIzvB3QM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MyuwebyxPwQX7aoJ6RCB20cBgehfI0qjQcX0JWaKec8cxithLKyNyi0FgneLt4bVq
         X1+RmgpKRchKldM2MZ1Cqr8W9euSgS/WGgNv+uY/peCtZ3b6ex1s8+4L0+cq2Y4V8w
         b01nBuvqGoqzhiaXxUxNqcbskHujUGgOrKgpd9+BkRzGxzqxreE7GSAIMN0vvdsteA
         YwqgtgMKYUWWkViZaSdpAwuy9/10trHlG0ei5dulY1c1enAq919MWmxAfPcKHBBnPn
         NtHQn03U/F974h4EUM9H1n+8Z6v6owM1J4nY9UP4Nm25rgLJ7q0kOrHe6JPyejuKIY
         n+5sswJDTAxcw==
Date:   Fri, 29 Jul 2022 12:04:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH] asm-generic: Support NO_IOPORT_MAP in pci_iomap.h
Message-ID: <20220729170449.GA463615@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722212248.802500-1-shorne@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 23, 2022 at 06:22:48AM +0900, Stafford Horne wrote:
> When building OpenRISC PCI which has no ioport_map we get the following build
> error.
> 
>     lib/pci_iomap.c: In function 'pci_iomap_range':
>       CC      drivers/i2c/i2c-core-base.o
>     ./include/asm-generic/pci_iomap.h:29:41: error: implicit declaration of function 'ioport_map'; did you mean 'ioremap'? [-Werror=implicit-function-declaration]
>        29 | #define __pci_ioport_map(dev, port, nr) ioport_map((port), (nr))
>           |                                         ^~~~~~~~~~
>     lib/pci_iomap.c:44:24: note: in expansion of macro '__pci_ioport_map'
>        44 |                 return __pci_ioport_map(dev, start, len);
>           |                        ^~~~~~~~~~~~~~~~
> 
> This patch adds a NULL definition of __pci_ioport_map for architetures
> which do not support ioport_map.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Appended to my pci/header-cleanup-immutable branch for v5.20, thanks!

> ---
> The Kconfig I am using to test this is here:
>   https://github.com/stffrdhrn/linux/commits/or1k-virt-4
> 
>  include/asm-generic/pci_iomap.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_iomap.h
> index 5a2f9bf53384..8fbb0a55545d 100644
> --- a/include/asm-generic/pci_iomap.h
> +++ b/include/asm-generic/pci_iomap.h
> @@ -25,6 +25,8 @@ extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
>  #ifdef CONFIG_NO_GENERIC_PCI_IOPORT_MAP
>  extern void __iomem *__pci_ioport_map(struct pci_dev *dev, unsigned long port,
>  				      unsigned int nr);
> +#elif !defined(CONFIG_HAS_IOPORT_MAP)
> +#define __pci_ioport_map(dev, port, nr) NULL
>  #else
>  #define __pci_ioport_map(dev, port, nr) ioport_map((port), (nr))
>  #endif
> -- 
> 2.36.1
> 
