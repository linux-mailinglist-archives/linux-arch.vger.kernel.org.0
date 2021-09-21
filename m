Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C408F413DA3
	for <lists+linux-arch@lfdr.de>; Wed, 22 Sep 2021 00:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbhIUWhq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Sep 2021 18:37:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbhIUWhq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Sep 2021 18:37:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 054F06044F;
        Tue, 21 Sep 2021 22:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632263777;
        bh=th3qmPaUNQjiJHw2074qzi6M8+lsZxz3EyRRcE77AdI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=N3V50aLck3umR7T+IFg91Ni1G4xICympd/f/PRvUvUoF83JyMq/4G+7D0GMPML6JN
         DoRL+w1+pA3sM38+COOT5MX5ugR8+G47LsMljgSS5eui3gBWevytzp/jybvykkizaQ
         NGZXppqWkILz6E93KrUFYrIL0wVxfxIO2NCJGRQ27YDNp3SzWEHV8WEHsTu/txHRpo
         g+i1+/YtUZQNQin3jZL61KKNA0lWR/dZBFpRfbCneKNbJ9bzEDOggrmptg5nv0932Z
         aolA0H92iCs/oK3SVA21xsJ99K6CHmXsETUsH6KiJyHYzB6iWV0pqUr/D9LlohLxB0
         YDE/kD/1nY3vg==
Date:   Tue, 21 Sep 2021 17:36:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@gmail.com>, a@bhelgaas
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH V3 18/22] LoongArch: Add PCI controller support
Message-ID: <20210921223615.GA137894@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H5=Ut+rymv1RH+1GVS2oVZogtuwY_Sk-dDosJh6=USr0Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 18, 2021 at 03:36:52PM +0800, Huacai Chen wrote:
> On Fri, Sep 17, 2021 at 5:02 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Fri, Sep 17, 2021 at 5:57 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > >
> > > Loongson64 based systems are PC-like systems which use PCI/PCIe as its
> > > I/O bus, This patch adds the PCI host controller support for LoongArch.
> > >
> > > Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >
> > As discussed before, I think the PCI support should not be part of the
> > architecture code or this patch series. The headers are ok, but the pci.c
> > and acpi.c files have nothing loongarch specific in them, and you clearly
> > just copied most of this from arm64 or x86.
>
> In V2 part of the PCI code (pci-loongson.c) has moved to
> drivers/pci/controllers. For pci.c and acpi.c, I agree that "the thing
> should be like that", but have some different ideas about "the way to
> arrive at that". In my opinion, we can let this series be merged at
> first, and then do another series to "restructure the files and move
> common parts to the drivers directory". That way looks more natural to
> me (doing the other series at first may block the whole thing).
> 
> > What I would suggest you do instead is:
> >
> > - start a separate patch series, addressed to the ACPI, PCI host driver
> >   and ARM64 maintainers.
> >
> > - Move all the bits you need from arch/{arm64,ia64,x86} into
> >   drivers/acpi/pci/pci_root.c, duplicating them with #if/#elif/#else
> >   where they are too different, making the #else path the
> >   default that can be shared with loongarch.
> >
> > - Move the bits from pci_root_info/acpi_pci_root_info that are
> >   always needed into struct pci_host_bridge, with an
> >   #ifdef CONFIG_ACPI where appropriate.
> >
> > - Simplify as much as you can easily do.

I would love to see this done.

But we already have this kind of redundant code for arm64/ia64/x86.
Arguably, we should have refactored it for ia64 or arm64.  It's
unfortunate to add loongarch to that list, but why should we penalize
loongarch more than arm64 and ia64?

Bjorn
