Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCDE26B389
	for <lists+linux-arch@lfdr.de>; Wed, 16 Sep 2020 01:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgIOXEt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Sep 2020 19:04:49 -0400
Received: from foss.arm.com ([217.140.110.172]:37454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727202AbgIOOzE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Sep 2020 10:55:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 831F131B;
        Tue, 15 Sep 2020 07:54:56 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F161B3F68F;
        Tue, 15 Sep 2020 07:54:54 -0700 (PDT)
Date:   Tue, 15 Sep 2020 15:54:48 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Christoph Hellwig <hch@infradead.org>
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
Message-ID: <20200915145448.GA6316@e121166-lin.cambridge.arm.com>
References: <20200915093203.16934-1-lorenzo.pieralisi@arm.com>
 <20200915093203.16934-2-lorenzo.pieralisi@arm.com>
 <20200915141452.GA19202@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915141452.GA19202@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 15, 2020 at 03:14:52PM +0100, Christoph Hellwig wrote:
> > diff --git a/arch/sparc/include/asm/io_32.h b/arch/sparc/include/asm/io_32.h
> > index 9a52d9506f80..042201c79ad1 100644
> > --- a/arch/sparc/include/asm/io_32.h
> > +++ b/arch/sparc/include/asm/io_32.h
> > @@ -11,6 +11,16 @@
> >  #define memcpy_fromio(d,s,sz) _memcpy_fromio(d,s,sz)
> >  #define memcpy_toio(d,s,sz)   _memcpy_toio(d,s,sz)
> >  
> > +#ifdef __KERNEL__
> > +
> > +/*
> > + * Bus number may be embedded in the higher bits of the physical address.
> > + * This is why we have no bus number argument to ioremap().
> > + */
> > +void __iomem *ioremap(phys_addr_t offset, size_t size);
> > +void iounmap(volatile void __iomem *addr);
> > +#endif
> 
> No need for an __KERNEL__ in non-uapi headers.

Sure, just kept the same preproc guard as current code, will add a patch
to remove the guard first before this one then.

Thanks,
Lorenzo
