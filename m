Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10BF3EAB2B
	for <lists+linux-arch@lfdr.de>; Thu, 12 Aug 2021 21:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbhHLTn6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Aug 2021 15:43:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233823AbhHLTn6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Aug 2021 15:43:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3303D60F57;
        Thu, 12 Aug 2021 19:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628797412;
        bh=mycw/N87DcjoHhRJ24PqFxiKdFx6FKqzLp6B9V1Bci0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=U12QjMP3CnJpA4KXSSptXiM7d4U5MWdCrpeOte+jO3bwyMUv8NPwvxLUgFBkLPzJG
         0+V8IWPqotJnu14+YIThfkvpHQAUd8VQQT75qa7ba7XsebzxEAnPz0qWtfUFG26Bp/
         q5JQjRUPXRmxnk0Tg5uqJxW2nMU4F0seSzZa9wJepceDj4orZlm9IUhtLrdN964cZS
         nWBQm7819X7a6zF4A6FMBvJIdwsl0M8HnoT7m+ZeqOgExq1wq+NyL7UFbBdXdQbAHF
         2RxCZLDi/pGlG0ECy/gcR0mz6EpSMbgaPlm/7h16BZ8WCKqXkDjRsUh6LRlcxGRkKE
         adLdtJCQmOiuw==
Date:   Thu, 12 Aug 2021 14:43:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James E J Bottomley <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 09/15] pci: Consolidate pci_iomap* and pci_iomap*wc
Message-ID: <20210812194330.GA2500473@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805005218.2912076-10-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Is there a branch with all of this applied?  I was going to apply this
to help take a look at it, but it doesn't apply to v5.14-rc1.  I know
you listed some prereqs in the cover letter, but it's a fair amount of
work to sort all that out.

On Wed, Aug 04, 2021 at 05:52:12PM -0700, Kuppuswamy Sathyanarayanan wrote:
> From: Andi Kleen <ak@linux.intel.com>

If I were applying these, I would silently update the subject lines to
match previous commits.  Since these will probably be merged via a
different tree, you can update if there's a v5:

  PCI: Consolidate pci_iomap_range(), pci_iomap_wc_range()

Also applies to 11/15 and 12/15.

> pci_iomap* and pci_iomap*wc are currently duplicated code, except
> that the _wc variant does not support IO ports. Replace them
> with a common helper and a callback for the mapping. I used
> wrappers for the maps because some architectures implement ioremap
> and friends with macros.

Maybe spell some of this out:

  pci_iomap_range() and pci_iomap_wc_range() are currently duplicated
  code, ...  Implement them using a common helper,
  pci_iomap_range_map(), ...

Using "pci_iomap*" obscures the name and doesn't save any space.

Why is it safe to make pci_iomap_wc_range() support IO ports when it
didn't before?  That might be desirable, but I think it *is* a
functional change here.

IIUC, pci_iomap_wc_range() on an IO port range previously returned
NULL, and after this patch it will work the same as pci_iomap_range(),
i.e., it will return the result of __pci_ioport_map().

> This will allow to add more variants without excessive code
> duplications. This patch should have no behavior change.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  lib/pci_iomap.c | 81 +++++++++++++++++++++++++++----------------------
>  1 file changed, 44 insertions(+), 37 deletions(-)
> 
> diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
> index 2d3eb1cb73b8..6251c3f651c6 100644
> --- a/lib/pci_iomap.c
> +++ b/lib/pci_iomap.c
> @@ -10,6 +10,46 @@
>  #include <linux/export.h>
>  
>  #ifdef CONFIG_PCI
> +
> +/*
> + * Callback wrappers because some architectures define ioremap et.al.
> + * as macros.
> + */
> +static void __iomem *map_ioremap(phys_addr_t addr, size_t size)
> +{
> +	return ioremap(addr, size);
> +}
> +
> +static void __iomem *map_ioremap_wc(phys_addr_t addr, size_t size)
> +{
> +	return ioremap_wc(addr, size);
> +}
> +
> +static void __iomem *pci_iomap_range_map(struct pci_dev *dev,
> +					 int bar,
> +					 unsigned long offset,
> +					 unsigned long maxlen,
> +					 void __iomem *(*mapm)(phys_addr_t,
> +							       size_t))
> +{
> +	resource_size_t start = pci_resource_start(dev, bar);
> +	resource_size_t len = pci_resource_len(dev, bar);
> +	unsigned long flags = pci_resource_flags(dev, bar);
> +
> +	if (len <= offset || !start)
> +		return NULL;
> +	len -= offset;
> +	start += offset;
> +	if (maxlen && len > maxlen)
> +		len = maxlen;
> +	if (flags & IORESOURCE_IO)
> +		return __pci_ioport_map(dev, start, len);
> +	if (flags & IORESOURCE_MEM)
> +		return mapm(start, len);
> +	/* What? */
> +	return NULL;
> +}
> +
>  /**
>   * pci_iomap_range - create a virtual mapping cookie for a PCI BAR
>   * @dev: PCI device that owns the BAR
> @@ -30,22 +70,8 @@ void __iomem *pci_iomap_range(struct pci_dev *dev,
>  			      unsigned long offset,
>  			      unsigned long maxlen)
>  {
> -	resource_size_t start = pci_resource_start(dev, bar);
> -	resource_size_t len = pci_resource_len(dev, bar);
> -	unsigned long flags = pci_resource_flags(dev, bar);
> -
> -	if (len <= offset || !start)
> -		return NULL;
> -	len -= offset;
> -	start += offset;
> -	if (maxlen && len > maxlen)
> -		len = maxlen;
> -	if (flags & IORESOURCE_IO)
> -		return __pci_ioport_map(dev, start, len);
> -	if (flags & IORESOURCE_MEM)
> -		return ioremap(start, len);
> -	/* What? */
> -	return NULL;
> +	return pci_iomap_range_map(dev, bar, offset, maxlen,
> +				   map_ioremap);
>  }
>  EXPORT_SYMBOL(pci_iomap_range);
>  
> @@ -70,27 +96,8 @@ void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
>  				 unsigned long offset,
>  				 unsigned long maxlen)
>  {
> -	resource_size_t start = pci_resource_start(dev, bar);
> -	resource_size_t len = pci_resource_len(dev, bar);
> -	unsigned long flags = pci_resource_flags(dev, bar);
> -
> -
> -	if (flags & IORESOURCE_IO)
> -		return NULL;
> -
> -	if (len <= offset || !start)
> -		return NULL;
> -
> -	len -= offset;
> -	start += offset;
> -	if (maxlen && len > maxlen)
> -		len = maxlen;
> -
> -	if (flags & IORESOURCE_MEM)
> -		return ioremap_wc(start, len);
> -
> -	/* What? */
> -	return NULL;
> +	return pci_iomap_range_map(dev, bar, offset, maxlen,
> +				   map_ioremap_wc);
>  }
>  EXPORT_SYMBOL_GPL(pci_iomap_wc_range);
>  
> -- 
> 2.25.1
> 
