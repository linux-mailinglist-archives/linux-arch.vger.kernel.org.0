Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E0E2A9AA5
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 18:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgKFRS0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 12:18:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:38322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727608AbgKFRS0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Nov 2020 12:18:26 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90B4E22227;
        Fri,  6 Nov 2020 17:18:21 +0000 (UTC)
Date:   Fri, 6 Nov 2020 17:18:19 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Atish Patra <Atish.Patra@wdc.com>,
        Will Deacon <willdeacon@google.com>, maz@kernel.org,
        linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com,
        aou@eecs.berkeley.edu, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, anup@brainfault.org,
        Arnd Bergmann <arnd@arndb.de>, david@redhat.com,
        greentime.hu@sifive.com, Greg KH <gregkh@linuxfoundation.org>,
        justin.he@arm.com, wangkefeng.wang@huawei.com,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        rppt@kernel.org, nsaenzjulienne@suse.de,
        Paul Walmsley <paul.walmsley@sifive.com>, rafael@kernel.org,
        steven.price@arm.com, will@kernel.org, zong.li@sifive.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/5] Unify NUMA implementation between ARM64 & RISC-V
Message-ID: <20201106171818.GL29329@gaia>
References: <20201006001752.248564-1-atish.patra@wdc.com>
 <mhng-6971ba28-0cea-42bc-a26c-c23b9ba2af9e@palmerdabbelt-glaptop1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-6971ba28-0cea-42bc-a26c-c23b9ba2af9e@palmerdabbelt-glaptop1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 05, 2020 at 10:07:00AM -0800, Palmer Dabbelt wrote:
> On Mon, 05 Oct 2020 17:17:47 PDT (-0700), Atish Patra wrote:
> > arch/arm64/Kconfig                            |  1 +
> > arch/arm64/include/asm/numa.h                 | 45 +----------------
> > arch/arm64/kernel/acpi_numa.c                 | 13 -----
> > arch/arm64/mm/Makefile                        |  1 -
> > arch/arm64/mm/init.c                          |  4 +-
> > arch/riscv/Kconfig                            | 31 +++++++++++-
> > arch/riscv/include/asm/mmzone.h               | 13 +++++
> > arch/riscv/include/asm/numa.h                 |  8 +++
> > arch/riscv/include/asm/pci.h                  | 14 ++++++
> > arch/riscv/include/asm/pgtable.h              | 21 ++++++++
> > arch/riscv/kernel/setup.c                     | 11 ++++-
> > arch/riscv/kernel/smpboot.c                   | 12 ++++-
> > arch/riscv/mm/init.c                          | 10 +++-
> > drivers/base/Kconfig                          |  6 +++
> > drivers/base/Makefile                         |  1 +
> > .../mm/numa.c => drivers/base/arch_numa.c     | 30 ++++++++++--
> > include/asm-generic/numa.h                    | 49 +++++++++++++++++++
> > 17 files changed, 199 insertions(+), 71 deletions(-)
> > create mode 100644 arch/riscv/include/asm/mmzone.h
> > create mode 100644 arch/riscv/include/asm/numa.h
> > rename arch/arm64/mm/numa.c => drivers/base/arch_numa.c (95%)
> > create mode 100644 include/asm-generic/numa.h
[...]
> arm64 guys: do you want to try and do some sort of shared base tag sort of
> thing for these, or do you want me to refactor this such that it adds the
> generic stuff before removing the arm64 stuff so we can decouble that way?

I had a comment on the second patch (probably impacting the first) but
otherwise they look fine.

I'm happy for this series to go in via the riscv tree but, if we run
into conflicts, please provide a stable branch somewhere containing the
arm64 changes (first two patches).

-- 
Catalin
