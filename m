Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5537426D7D6
	for <lists+linux-arch@lfdr.de>; Thu, 17 Sep 2020 11:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgIQJkU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Sep 2020 05:40:20 -0400
Received: from foss.arm.com ([217.140.110.172]:43330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgIQJkU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 17 Sep 2020 05:40:20 -0400
X-Greylist: delayed 633 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 05:40:19 EDT
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F40A101E;
        Thu, 17 Sep 2020 02:29:46 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7C733F718;
        Thu, 17 Sep 2020 02:29:44 -0700 (PDT)
Date:   Thu, 17 Sep 2020 10:29:39 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        George Cherian <george.cherian@marvell.com>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 3/3] asm-generic/io.h: Fix !CONFIG_GENERIC_IOMAP
 pci_iounmap() implementation
Message-ID: <20200917092939.GA1629@e121166-lin.cambridge.arm.com>
References: <20200915093203.16934-1-lorenzo.pieralisi@arm.com>
 <cover.1600254147.git.lorenzo.pieralisi@arm.com>
 <a9daf8d8444d0ebd00bc6d64e336ec49dbb50784.1600254147.git.lorenzo.pieralisi@arm.com>
 <20200916145111.GB3122@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916145111.GB3122@gaia>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 16, 2020 at 03:51:11PM +0100, Catalin Marinas wrote:
> On Wed, Sep 16, 2020 at 12:06:58PM +0100, Lorenzo Pieralisi wrote:
> > For arches that do not select CONFIG_GENERIC_IOMAP, the current
> > pci_iounmap() function does nothing causing obvious memory leaks
> > for mapped regions that are backed by MMIO physical space.
> > 
> > In order to detect if a mapped pointer is IO vs MMIO, a check must made
> > available to the pci_iounmap() function so that it can actually detect
> > whether the pointer has to be unmapped.
> > 
> > In configurations where CONFIG_HAS_IOPORT_MAP && !CONFIG_GENERIC_IOMAP,
> > a mapped port is detected using an ioport_map() stub defined in
> > asm-generic/io.h.
> > 
> > Use the same logic to implement a stub (ie __pci_ioport_unmap()) that
> > detects if the passed in pointer in pci_iounmap() is IO vs MMIO to
> > iounmap conditionally and call it in pci_iounmap() fixing the issue.
> > 
> > Leave __pci_ioport_unmap() as a NOP for all other config options.
> > 
> > Reported-by: George Cherian <george.cherian@marvell.com>
> > Link: https://lore.kernel.org/lkml/20200905024811.74701-1-yangyingliang@huawei.com
> > Link: https://lore.kernel.org/lkml/20200824132046.3114383-1-george.cherian@marvell.com
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: George Cherian <george.cherian@marvell.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Yang Yingliang <yangyingliang@huawei.com>
> > ---
> >  include/asm-generic/io.h | 39 +++++++++++++++++++++++++++------------
> >  1 file changed, 27 insertions(+), 12 deletions(-)
> 
> This works for me. The only question I have is whether pci_iomap.h is
> better than io.h for __pci_ioport_unmap(). These headers are really
> confusing.

Yes they are, in total honesty there is much more to do to make them
sane, this patch is just a band-aid.

I thought about moving this stuff into pci_iomap.h, though that
file is included _independently_ from io.h from some arches so
I tried to keep everything in io.h to minimize disruption.

We can merge this patch - since it is a fix after all - and then I can
try to improve the whole pci_iounmap() includes.

> Either way:
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks a lot. I'd appreciate a tested-by from the George as he is
the one who reported the problem.

Lorenzo
