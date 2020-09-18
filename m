Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC6C26FBC4
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 13:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIRLpQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 07:45:16 -0400
Received: from foss.arm.com ([217.140.110.172]:40078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgIRLpP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Sep 2020 07:45:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5B7B11D4;
        Fri, 18 Sep 2020 04:45:14 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B2F13F73B;
        Fri, 18 Sep 2020 04:45:13 -0700 (PDT)
Date:   Fri, 18 Sep 2020 12:45:08 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>, bhelgaas@google.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        George Cherian <george.cherian@marvell.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] Fix pci_iounmap() on !CONFIG_GENERIC_IOMAP
Message-ID: <20200918114508.GA20110@e121166-lin.cambridge.arm.com>
References: <20200915093203.16934-1-lorenzo.pieralisi@arm.com>
 <cover.1600254147.git.lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1600254147.git.lorenzo.pieralisi@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 16, 2020 at 12:06:55PM +0100, Lorenzo Pieralisi wrote:
> v2 of a previous posting.
> 
> v1->v2:
> 	- Added additional patch to remove sparc32 useless __KERNEL__
> 	  guard
> 
> v1: https://lore.kernel.org/lkml/20200915093203.16934-1-lorenzo.pieralisi@arm.com
> 
> Original cover letter
> ---
> 
> Fix the empty pci_iounmap() implementation that is causing memory leaks on
> !CONFIG_GENERIC_IOMAP configs relying on asm-generic/io.h.
> 
> A small tweak is required on sparc32 to pull in some declarations,
> hopefully nothing problematic, subject to changes as requested.
> 
> Previous tentatives:
> https://lore.kernel.org/lkml/20200905024811.74701-1-yangyingliang@huawei.com
> https://lore.kernel.org/lkml/20200824132046.3114383-1-george.cherian@marvell.com
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: George Cherian <george.cherian@marvell.com>
> Cc: Yang Yingliang <yangyingliang@huawei.com>
> 
> Lorenzo Pieralisi (3):
>   sparc32: Remove useless io_32.h __KERNEL__ preprocessor guard
>   sparc32: Move ioremap/iounmap declaration before asm-generic/io.h
>     include
>   asm-generic/io.h: Fix !CONFIG_GENERIC_IOMAP pci_iounmap()
>     implementation
> 
>  arch/sparc/include/asm/io_32.h | 17 ++++++---------
>  include/asm-generic/io.h       | 39 +++++++++++++++++++++++-----------
>  2 files changed, 34 insertions(+), 22 deletions(-)

Arnd, David, Bjorn,

I have got review/test tags, is it OK if we merge this series please ?

Can we pull it in the PCI tree or you want it to go via a different
route upstream ?

Please let me know.

Thanks,
Lorenzo
