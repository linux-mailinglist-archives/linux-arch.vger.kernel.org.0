Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC3F24C776
	for <lists+linux-arch@lfdr.de>; Thu, 20 Aug 2020 23:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgHTVzx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Aug 2020 17:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbgHTVzw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Aug 2020 17:55:52 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17417204FD;
        Thu, 20 Aug 2020 21:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597960551;
        bh=5ULzVEcGtTnweVu+hyjjAnP9S4wCcq1qytib5KiiV2w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=1XKDiQcwbYSrv8Z4WVaOtJLooY4nfviEtxoPo0Y2NitTUuU8LYIu2bSKyRd8WQr0L
         aN+ZWgAz5Hc65TmNcYJVWDD/yr5T+tCdq/45aqqethpzi9q7hBrkKKy8P8WzFsEOnq
         NIWuz91tc4hJtRfSZd1UAfb3iDvkP5BRBg2NWEaU=
Date:   Thu, 20 Aug 2020 16:55:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     George Cherian <george.cherian@marvell.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com, arnd@arndb.de,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv2] PCI: Add pci_iounmap
Message-ID: <20200820215549.GA1569713@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820050306.2015009-1-george.cherian@marvell.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[+cc Michael, author of 66eab4df288a ("lib: add GENERIC_PCI_IOMAP")]

On Thu, Aug 20, 2020 at 10:33:06AM +0530, George Cherian wrote:
> In case if any architecture selects CONFIG_GENERIC_PCI_IOMAP and not
> CONFIG_GENERIC_IOMAP, then the pci_iounmap function is reduced to a NULL
> function. Due to this the managed release variants or even the explicit
> pci_iounmap calls doesn't really remove the mappings.
> 
> This issue is seen on an arm64 based system. arm64 by default selects
> only CONFIG_GENERIC_PCI_IOMAP and not CONFIG_GENERIC_IOMAP from this
> 'commit cb61f6769b88 ("ARM64: use GENERIC_PCI_IOMAP")'
> 
> Simple bind/unbind test of any pci driver using pcim_iomap/pci_iomap,
> would lead to the following error message after long hour tests
> 
> "allocation failed: out of vmalloc space - use vmalloc=<size> to
> increase size."
> 
> Signed-off-by: George Cherian <george.cherian@marvell.com>
> ---
> * Changes from v1
> 	- Fix the 0-day compilation error.
> 	- Mark the lib/iomap pci_iounmap call as weak incase 
> 	  if any architecture have there own implementation.
> 
>  include/asm-generic/io.h |  4 ++++
>  lib/pci_iomap.c          | 10 ++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index dabf8cb7203b..5986b37226b7 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -915,12 +915,16 @@ static inline void iowrite64_rep(volatile void __iomem *addr,
>  struct pci_dev;
>  extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
>  
> +#ifdef CONFIG_GENERIC_PCI_IOMAP
> +extern void pci_iounmap(struct pci_dev *dev, void __iomem *p);
> +#else
>  #ifndef pci_iounmap
>  #define pci_iounmap pci_iounmap
>  static inline void pci_iounmap(struct pci_dev *dev, void __iomem *p)
>  {
>  }
>  #endif
> +#endif /* CONFIG_GENERIC_PCI_IOMAP */
>  #endif /* CONFIG_GENERIC_IOMAP */
>  
>  /*
> diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
> index 2d3eb1cb73b8..ecd1eb3f6c25 100644
> --- a/lib/pci_iomap.c
> +++ b/lib/pci_iomap.c
> @@ -134,4 +134,14 @@ void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long maxlen)
>  	return pci_iomap_wc_range(dev, bar, 0, maxlen);
>  }
>  EXPORT_SYMBOL_GPL(pci_iomap_wc);
> +
> +#ifndef CONFIG_GENERIC_IOMAP
> +#define pci_iounmap pci_iounmap
> +void __weak pci_iounmap(struct pci_dev *dev, void __iomem *addr);
> +void __weak pci_iounmap(struct pci_dev *dev, void __iomem *addr)
> +{
> +	iounmap(addr);
> +}
> +EXPORT_SYMBOL(pci_iounmap);
> +#endif

I completely agree that this looks like a leak that needs to be fixed.

But my head hurts after trying to understand pci_iomap() and
pci_iounmap().  I hate to add even more #ifdefs here.  Can't we
somehow rationalize this and put pci_iounmap() next to pci_iomap()?

66eab4df288a ("lib: add GENERIC_PCI_IOMAP") moved pci_iomap() from
lib/iomap.c to lib/pci_iomap.c, but left pci_iounmap() in lib/iomap.c.
There must be some good reason why they're separated, but I don't know
what it is.

>  #endif /* CONFIG_PCI */
> -- 
> 2.25.1
> 
