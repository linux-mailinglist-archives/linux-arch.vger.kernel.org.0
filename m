Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C6C40F220
	for <lists+linux-arch@lfdr.de>; Fri, 17 Sep 2021 08:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244994AbhIQGOR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Sep 2021 02:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245097AbhIQGOH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Sep 2021 02:14:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F54C0613CF;
        Thu, 16 Sep 2021 23:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tJXV477/RaeB+r2pgRpn5QCN1Mb0VeVLQoEkCebZFIs=; b=DiqL+SSZxX+4TLGuTRM0jgVY9k
        9ewuEb/+GHADKBklbWk7ZdWWXaX428g4BBuyWnKx869p0VLs1wqOetaOb9s9RdWNhYxNu5/iJaCJz
        Rt5DzCJnOXPHGAxrPE/evxlKlFm6J8w1DWp1Ua4UkdiJSD+leDBS08NgEGPpV5OexjT2/eym72KJQ
        134AU9YdyVQqXaWzjJ5tsd5QmOmeZXXF1Np1gvnjpFIeZ9pUjkT6FQ3HPiKoHuEG9Ucy3HsrxRqXu
        CPWerdbqfKoxYpeQAhYSDVJkZAy/daQrVH0N7SxqYZwbAUPcnY2Vs5oGH86R59vm4pmcuSvKKyeEe
        2P3Dvt6g==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mR74s-00HYfJ-U6; Fri, 17 Sep 2021 06:10:34 +0000
Date:   Fri, 17 Sep 2021 07:10:26 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V3 16/22] LoongArch: Add misc common routines
Message-ID: <YUQxUgN5AseF7k8F@infradead.org>
References: <20210917035736.3934017-1-chenhuacai@loongson.cn>
 <20210917035736.3934017-17-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917035736.3934017-17-chenhuacai@loongson.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> +
> +/*
> + * Change "struct page" to physical address.
> + */
> +#define page_to_phys(page)	((dma_addr_t)page_to_pfn(page) << PAGE_SHIFT)

Why is this using a dma_addr_t?  phys_addr_t would be the right type
here.

> +
> +extern void __init __iomem *early_ioremap(u64 phys_addr, unsigned long size);
> +extern void __init early_iounmap(void __iomem *addr, unsigned long size);
> +
> +#define early_memremap early_ioremap
> +#define early_memunmap early_iounmap
> +
> +static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
> +					 unsigned long prot_val)
> +{
> +	if (prot_val == _CACHE_CC)
> +		return (void __iomem *)(unsigned long)(CAC_BASE + offset);
> +	else
> +		return (void __iomem *)(unsigned long)(UNCAC_BASE + offset);
> +}

There is no real need for this ioremap_prot multiplexer

> +/*
> + * ioremap_cache -  map bus memory into CPU space
> + * @offset:	    bus address of the memory
> + * @size:	    size of the resource to map
> + *
> + * ioremap_cache performs a platform specific sequence of operations to
> + * make bus memory CPU accessible via the readb/readw/readl/writeb/
> + * writew/writel functions and the other mmio helpers. The returned
> + * address is not guaranteed to be usable directly as a virtual
> + * address.
> + *
> + * This version of ioremap ensures that the memory is marked cachable by
> + * the CPU.  Also enables full write-combining.	 Useful for some
> + * memory-like regions on I/O busses.
> + */
> +#define ioremap_cache(offset, size)				\
> +	ioremap_prot((offset), (size), _CACHE_CC)

Please don't add ioremap_cache to new ports.
