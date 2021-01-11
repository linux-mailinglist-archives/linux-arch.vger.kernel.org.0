Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F742F1F84
	for <lists+linux-arch@lfdr.de>; Mon, 11 Jan 2021 20:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391302AbhAKTcD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Jan 2021 14:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391299AbhAKTcD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Jan 2021 14:32:03 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2046C061794
        for <linux-arch@vger.kernel.org>; Mon, 11 Jan 2021 11:31:22 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id q1so811945ion.8
        for <linux-arch@vger.kernel.org>; Mon, 11 Jan 2021 11:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R2I4BbShbTu/yJpEZj0PNRRdCnuLwVEUr5DQ9wFpqcE=;
        b=srZzPZyePcV1kAldudiypZ0rRVK8bt8lvJ2u9G/OM6L5wyUuvQJ6iiE7U54MXmR8LI
         8v01ioV782Fz0JH5/1ojhhDjdU3OogkTVx5hoJmg/pcXWDg1H4kM/vPV6FiAKdGSTtfd
         UzFfVK7HotL53AU5ROuFl/mbmJPrAkzBpOqRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R2I4BbShbTu/yJpEZj0PNRRdCnuLwVEUr5DQ9wFpqcE=;
        b=BPuxwwcErq37995wcvcQj3CTr+1xR/NWX4HfjOwKWNiS9hgnwTzm65Af2lge4u8yiN
         BGM1Ml4zv+51jbr/WlHy9ygIBietPmCdzs+Qm2WDNmr8V2LrJ86LYyHnxc9g/IvbzW1N
         mEh04wmS4GQEpg849iYKRD6kaIR00hXwgZJq46DkqgWoWpWjtaAA316fjseYyurF3sQ6
         WStQcHV14zT5CxGhtqFOrMRXVKi0uOgeWHPeBIWngHxhtVhh35n0Dp6MlknaDH5rNg9F
         qg0MPL5HbINuYgHgxlkJHGX4DCUGNCu7cwmvWkSyDSvttJTX/fbvC7lmWIkkutLkW//9
         9WlA==
X-Gm-Message-State: AOAM530nRHAzsWluk+26dWIlioLIQQRVT0NkX987da5tUE5xTD5nBv10
        wa2spt2wa1JDFzLVqLc2GDlUOXLXnWAC+nvPiPhK
X-Google-Smtp-Source: ABdhPJzhe7x3UfUvfOZk8hrT4czPh4HNfXiB6nfRWX8ysGPV0CWtXhWKQhiUlsD3i77pSSTTtW+at4ya/ydmJxPk2PA=
X-Received: by 2002:a6b:b74e:: with SMTP id h75mr670195iof.0.1610393482014;
 Mon, 11 Jan 2021 11:31:22 -0800 (PST)
MIME-Version: 1.0
References: <CAOnJCULPCxhirYH8xCciKDNJ=zfWKwiOOfAoT8QQBOKqTuWuTA@mail.gmail.com>
 <mhng-94c90991-c4e8-49fe-a225-854ae0343d8d@palmerdabbelt-glaptop>
In-Reply-To: <mhng-94c90991-c4e8-49fe-a225-854ae0343d8d@palmerdabbelt-glaptop>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 11 Jan 2021 11:31:11 -0800
Message-ID: <CAOnJCUJq5e7W1UXkFFMkKje_BTedekoUT=32ia6t+Sc4UVDhEQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Unify NUMA implementation between ARM64 & RISC-V
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "will@kernel.org" <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-arch@vger.kernel.org,
        Zhengyuan Liu <liuzhengyuan@tj.kylinos.cn>,
        Baoquan He <bhe@redhat.com>, Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Steven Price <steven.price@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 9, 2021 at 12:51 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Sun, 13 Dec 2020 17:02:19 PST (-0800), atishp@atishpatra.org wrote:
> > On Wed, Nov 18, 2020 at 4:39 PM Atish Patra <atish.patra@wdc.com> wrote:
> >>
> >> This series attempts to move the ARM64 numa implementation to common
> >> code so that RISC-V can leverage that as well instead of reimplementing
> >> it again.
> >>
> >> RISC-V specific bits are based on initial work done by Greentime Hu [1] but
> >> modified to reuse the common implementation to avoid duplication.
> >>
> >> [1] https://lkml.org/lkml/2020/1/10/233
> >>
> >> This series has been tested on qemu with numa enabled for both RISC-V & ARM64.
> >> It would be great if somebody can test it on numa capable ARM64 hardware platforms.
> >> This patch series doesn't modify the maintainers list for the common code (arch_numa)
> >> as I am not sure if somebody from ARM64 community or Greg should take up the
> >> maintainership. Ganapatrao was the original author of the arm64 version.
> >> I would be happy to update that in the next revision once it is decided.
> >>
> >> # numactl --hardware
> >> available: 2 nodes (0-1)
> >> node 0 cpus: 0 1 2 3
> >> node 0 size: 486 MB
> >> node 0 free: 470 MB
> >> node 1 cpus: 4 5 6 7
> >> node 1 size: 424 MB
> >> node 1 free: 408 MB
> >> node distances:
> >> node   0   1
> >>   0:  10  20
> >>   1:  20  10
> >> # numactl -show
> >> policy: default
> >> preferred node: current
> >> physcpubind: 0 1 2 3 4 5 6 7
> >> cpubind: 0 1
> >> nodebind: 0 1
> >> membind: 0 1
> >>
> >> The patches are also available at
> >> https://github.com/atishp04/linux/tree/5.11_numa_unified_v5
> >>
> >> For RISC-V, the following qemu series is a pre-requisite(already available in upstream)
> >> https://patchwork.kernel.org/project/qemu-devel/list/?series=303313
> >>
> >> Testing:
> >> RISC-V:
> >> Tested in Qemu and 2 socket OmniXtend FPGA.
> >>
> >> ARM64:
> >> 2 socket kunpeng920 (4 nodes around 250G a node)
> >> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>
> >> Changes from v4->v5:
> >> 1. Added by Acked-by & Reviewed-by tags.
> >> 2. Swapped patch 1 & 2 in v4 version.
> >>
> >> Changes from v3->v4:
> >> 1. Removed redundant duplicate header.
> >> 2. Added Reviewed-by tags.
> >>
> >> Changes from v2->v3:
> >> 1. Added Acked-by/Reviewed-by tags.
> >> 2. Replaced asm/acpi.h with linux/acpi.h
> >> 3. Defined arch_acpi_numa_init as static.
> >>
> >> Changes from v1->v2:
> >> 1. Replaced ARM64 specific compile time protection with ACPI specific ones.
> >> 2. Dropped common pcibus_to_node changes. Added required changes in RISC-V.
> >> 3. Fixed few typos.
> >>
> >> Atish Patra (4):
> >> arm64, numa: Change the numa init functions name to be generic
> >> numa: Move numa implementation to common code
> >> riscv: Separate memory init from paging init
> >> riscv: Add numa support for riscv64 platform
> >>
> >> Greentime Hu (1):
> >> riscv: Add support pte_protnone and pmd_protnone if
> >> CONFIG_NUMA_BALANCING
> >>
> >> arch/arm64/Kconfig                            |  1 +
> >> arch/arm64/include/asm/numa.h                 | 48 +----------------
> >> arch/arm64/kernel/acpi_numa.c                 | 12 -----
> >> arch/arm64/mm/Makefile                        |  1 -
> >> arch/arm64/mm/init.c                          |  4 +-
> >> arch/riscv/Kconfig                            | 31 ++++++++++-
> >> arch/riscv/include/asm/mmzone.h               | 13 +++++
> >> arch/riscv/include/asm/numa.h                 |  8 +++
> >> arch/riscv/include/asm/pci.h                  | 14 +++++
> >> arch/riscv/include/asm/pgtable.h              | 21 ++++++++
> >> arch/riscv/kernel/setup.c                     | 11 +++-
> >> arch/riscv/kernel/smpboot.c                   | 12 ++++-
> >> arch/riscv/mm/init.c                          | 10 +++-
> >> drivers/base/Kconfig                          |  6 +++
> >> drivers/base/Makefile                         |  1 +
> >> .../mm/numa.c => drivers/base/arch_numa.c     | 27 ++++++++--
> >> include/asm-generic/numa.h                    | 52 +++++++++++++++++++
> >> 17 files changed, 200 insertions(+), 72 deletions(-)
> >> create mode 100644 arch/riscv/include/asm/mmzone.h
> >> create mode 100644 arch/riscv/include/asm/numa.h
> >> rename arch/arm64/mm/numa.c => drivers/base/arch_numa.c (96%)
> >> create mode 100644 include/asm-generic/numa.h
> >>
> >> --
> >> 2.25.1
> >>
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> > Hey Palmer,
> > I did not see this series in for-next. Let me know if you need
> > anything else to be done for this series.
>
> Sorry about that.  It's on for-next, with Randy's comment addressed.  There was
> one merge conflict: we don't have resource_init() in for-next yet (which I
> think means I missed something else).

resource_init is changed to init_resource and moved to setup.c in the
following patch which was merged in 5.11 MW.
00ab027a3b82 RISC-V: Add kernel image sections to the resource tree

IDK if that's necessary for the NUMA
> stuff, I just dropped it.  I haven't tested this yet.



-- 
Regards,
Atish
