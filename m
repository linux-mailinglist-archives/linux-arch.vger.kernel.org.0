Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4071540F22D
	for <lists+linux-arch@lfdr.de>; Fri, 17 Sep 2021 08:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhIQGS4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Sep 2021 02:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbhIQGS4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Sep 2021 02:18:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA20C061574;
        Thu, 16 Sep 2021 23:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qm38hcFwUX9FW/ci+/zYJ0a1d/k4aBvN8whvlAXgqA4=; b=ASNg2Vs1c3CalDy2e42QIziEkF
        5sDgcumGnphwcntt1heh39lu989AF5R9Cja18mQOJ2YiXRLRi9REvLu4kHMxSPriysAYGzuuLWNn8
        iUq/wb7SfMV/ActM7LlgkZRWV/+iAS7/vrQdIy8a85fxDJkPiurYqqbGTTXPRbwrmBJ5W7qutr3ED
        8QLXQmu0wAJ/UeJEgPPsxP3dkWPsnTeT75CqwJU8laf0RzjVAvETXqpqUJVdPdD1L0EGvAgg2fw+M
        bGoflxb6CwGgBuS/0IjsXVb3oZjkOKo+V/j7p+AObiLJ/27ScbrobnlSardfUuZII+2orTtrERw+T
        VjKo04GA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mR79k-00HZ0j-6R; Fri, 17 Sep 2021 06:15:37 +0000
Date:   Fri, 17 Sep 2021 07:15:28 +0100
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
Subject: Re: [PATCH V3 21/22] LoongArch: Add Non-Uniform Memory Access (NUMA)
 support
Message-ID: <YUQygKWFMU8zrkFi@infradead.org>
References: <20210917035736.3934017-1-chenhuacai@loongson.cn>
 <20210917035736.3934017-22-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917035736.3934017-22-chenhuacai@loongson.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> +/*
> + * We extract 4bit node id (bit 44~47) from Loongson-3's
> + * 48bit physical address space and embed it into 40bit.
> + */
> +
> +static int node_id_offset;
> +
> +static dma_addr_t loongson_phys_to_dma(struct device *dev, phys_addr_t paddr)
> +{
> +	long nid = (paddr >> 44) & 0xf;
> +
> +	return ((nid << 44) ^ paddr) | (nid << node_id_offset);
> +}
> +
> +static phys_addr_t loongson_dma_to_phys(struct device *dev, dma_addr_t daddr)
> +{
> +	long nid = (daddr >> node_id_offset) & 0xf;
> +
> +	return ((nid << node_id_offset) ^ daddr) | (nid << 44);
> +}
> +
> +static struct loongson_addr_xlate_ops {
> +	dma_addr_t (*phys_to_dma)(struct device *dev, phys_addr_t paddr);
> +	phys_addr_t (*dma_to_phys)(struct device *dev, dma_addr_t daddr);
> +} xlate_ops;
> +
> +dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
> +{
> +	return xlate_ops.phys_to_dma(dev, paddr);
> +}
> +
> +phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
> +{
> +	return xlate_ops.dma_to_phys(dev, daddr);
> +}

Please don't add unused indirections.  Also please just use the generic
translations 

