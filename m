Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C8826A6EE
	for <lists+linux-arch@lfdr.de>; Tue, 15 Sep 2020 16:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgIOOSu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 10:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgIOORz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Sep 2020 10:17:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8BCC061223;
        Tue, 15 Sep 2020 07:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VAFP2+lHvsV1SPJ5crPA3cULhiQoRhi403/H/7JF2+8=; b=QR2hMiotY714HixEB18KO4UMkA
        dsT/mYwU5lOtboVpU9HPkIUwXQl1fjqq2TkMtIp/eolnn0tdunOBGHvtS2J+tqZECpTXEZYXP9qo+
        dv4cJ2UfqvDb7FW3A1dKdum8o+v4hovMfAcqknVms0cyPD1S6VhFKHeHHqifn124i0TEPhEO1GVWj
        jEZnfquFDd97jHMreoDhubWvfLR1Zp3VEXbi06WxXW6OempRGF5ubBTujfEiVJWQL7/WzBHe36+8r
        mnN+YhqrYxB//1UNxJQtxXjIxF5R0i2hBqTumFxM4cNGpLUWEdjLVPMb8ZpQRq86LV4btHypzNp5o
        OSs+c7Gw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIBjQ-00051X-Ac; Tue, 15 Sep 2020 14:14:52 +0000
Date:   Tue, 15 Sep 2020 15:14:52 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        George Cherian <george.cherian@marvell.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH 1/2] sparc32: Move ioremap/iounmap declaration before
 asm-generic/io.h include
Message-ID: <20200915141452.GA19202@infradead.org>
References: <20200915093203.16934-1-lorenzo.pieralisi@arm.com>
 <20200915093203.16934-2-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915093203.16934-2-lorenzo.pieralisi@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> diff --git a/arch/sparc/include/asm/io_32.h b/arch/sparc/include/asm/io_32.h
> index 9a52d9506f80..042201c79ad1 100644
> --- a/arch/sparc/include/asm/io_32.h
> +++ b/arch/sparc/include/asm/io_32.h
> @@ -11,6 +11,16 @@
>  #define memcpy_fromio(d,s,sz) _memcpy_fromio(d,s,sz)
>  #define memcpy_toio(d,s,sz)   _memcpy_toio(d,s,sz)
>  
> +#ifdef __KERNEL__
> +
> +/*
> + * Bus number may be embedded in the higher bits of the physical address.
> + * This is why we have no bus number argument to ioremap().
> + */
> +void __iomem *ioremap(phys_addr_t offset, size_t size);
> +void iounmap(volatile void __iomem *addr);
> +#endif

No need for an __KERNEL__ in non-uapi headers.
