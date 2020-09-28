Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F31B27AAC4
	for <lists+linux-arch@lfdr.de>; Mon, 28 Sep 2020 11:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgI1JbP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Sep 2020 05:31:15 -0400
Received: from foss.arm.com ([217.140.110.172]:48156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgI1JbO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 Sep 2020 05:31:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F2AA101E;
        Mon, 28 Sep 2020 02:31:14 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA2A73F73B;
        Mon, 28 Sep 2020 02:31:12 -0700 (PDT)
Date:   Mon, 28 Sep 2020 10:31:07 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        George Cherian <george.cherian@marvell.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 0/3] Fix pci_iounmap() on !CONFIG_GENERIC_IOMAP
Message-ID: <20200928093107.GA12010@e121166-lin.cambridge.arm.com>
References: <20200915093203.16934-1-lorenzo.pieralisi@arm.com>
 <cover.1600254147.git.lorenzo.pieralisi@arm.com>
 <20200918114508.GA20110@e121166-lin.cambridge.arm.com>
 <CAK8P3a1f9Qj+yhMB4QaAu36ZUQ1p6oKHm2MZQ3zU31q6xmymGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1f9Qj+yhMB4QaAu36ZUQ1p6oKHm2MZQ3zU31q6xmymGA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 18, 2020 at 09:58:51PM +0200, Arnd Bergmann wrote:
> On Fri, Sep 18, 2020 at 1:45 PM Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > >
> > > Lorenzo Pieralisi (3):
> > >   sparc32: Remove useless io_32.h __KERNEL__ preprocessor guard
> > >   sparc32: Move ioremap/iounmap declaration before asm-generic/io.h
> > >     include
> > >   asm-generic/io.h: Fix !CONFIG_GENERIC_IOMAP pci_iounmap()
> > >     implementation
> > >
> > >  arch/sparc/include/asm/io_32.h | 17 ++++++---------
> > >  include/asm-generic/io.h       | 39 +++++++++++++++++++++++-----------
> > >  2 files changed, 34 insertions(+), 22 deletions(-)
> >
> > Arnd, David, Bjorn,
> >
> > I have got review/test tags, is it OK if we merge this series please ?
> >
> > Can we pull it in the PCI tree or you want it to go via a different
> > route upstream ?
> >
> > Please let me know.
> 
> Going through the PCI tree sounds good to me, but I can
> take it through the asm-generic tree if Bjorn doesn't want to
> pick it up there.

Bjorn, can we pull this series into PCI tree please - if that's OK
with you ?

Thanks,
Lorenzo
