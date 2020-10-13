Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303D528D547
	for <lists+linux-arch@lfdr.de>; Tue, 13 Oct 2020 22:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732632AbgJMUTr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Oct 2020 16:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732365AbgJMUTq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Oct 2020 16:19:46 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17EEC061755
        for <linux-arch@vger.kernel.org>; Tue, 13 Oct 2020 13:19:46 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t12so2043318ilh.3
        for <linux-arch@vger.kernel.org>; Tue, 13 Oct 2020 13:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nhTxF9kZTn4QXwlE0viBXy24iL+UNB/bQsWHxd58+3A=;
        b=lTPBGIviCJS0XkVWi0Bwb47IvvUF5R9NgubdCLLP2ptSJRzLEhOxEcUSlocEYcKzSS
         W5bJpwwbj3QAueVsNweRPmEWBbilkknIoRgM8q/TwpxZ4U4SDeBbPpGKdZWphvKNgFSV
         DN94hFpV1myN/clvkIS9AYApUokWMrRiSRlD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nhTxF9kZTn4QXwlE0viBXy24iL+UNB/bQsWHxd58+3A=;
        b=IdA4ofPUcPo65o1bYZVOdlwTJdrvw3lDHCMGoQF0HdpbnEt5ZQFxRZk+PMjef/rprC
         LST2JNVn6UOpbWJVWMuDIisnciZaaz/EFLBB66SaabKXnxa6IZNLolD/ffK6C3cGKX/Y
         i4grNKrji82q+VhcnFgVcLpbQtiR6/GELAz/phZHNZEbIwUx6YLtJ1DQyhK8fEF/ElYI
         +1YPvdNfAh2+HZ6Jbhv0Wol6CyXvciwOXpzypYZkGnrts61oMD6buH0ueGVyoyY3a5nz
         0MxCzGEZ1GWXY5Bfz3eVErYoBSuESrIqrsZp50zCASsBqVgMedj68tFywEwhxVK2uJut
         traQ==
X-Gm-Message-State: AOAM531gXFEX5X85Gtl/s6X+YFipPPRYtDTJ43Fb2oflU6YlODzbjeV2
        BQOsbOEUKywr4/+hXgcO7t5lX8M/X5E3gHTbciQG
X-Google-Smtp-Source: ABdhPJwFfo+XbYfmplpXssGQco9373OMIZto6M/4dz2EaRjEZ7t9KtrFWJ2w17j7Yyexuy/R9SbNn0UIVmGSNI0pBpw=
X-Received: by 2002:a05:6e02:54d:: with SMTP id i13mr1301698ils.219.1602620385949;
 Tue, 13 Oct 2020 13:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201006001752.248564-1-atish.patra@wdc.com>
In-Reply-To: <20201006001752.248564-1-atish.patra@wdc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 13 Oct 2020 13:19:35 -0700
Message-ID: <CAOnJCULba4qEO-8MmTDw5rWBep9mPUdq-iA-UpBN=-SXB13nmg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] Unify NUMA implementation between ARM64 & RISC-V
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        Jia He <justin.he@arm.com>, Anup Patel <anup@brainfault.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 5, 2020 at 5:18 PM Atish Patra <atish.patra@wdc.com> wrote:
>
> This series attempts to move the ARM64 numa implementation to common
> code so that RISC-V can leverage that as well instead of reimplementing
> it again.
>
> RISC-V specific bits are based on initial work done by Greentime Hu [1] but
> modified to reuse the common implementation to avoid duplication.
>
> [1] https://lkml.org/lkml/2020/1/10/233
>
> This series has been tested on qemu with numa enabled for both RISC-V & ARM64.
> It would be great if somebody can test it on numa capable ARM64 hardware platforms.
> This patch series doesn't modify the maintainers list for the common code (arch_numa)
> as I am not sure if somebody from ARM64 community or Greg should take up the
> maintainership. Ganapatrao was the original author of the arm64 version.
> I would be happy to update that in the next revision once it is decided.
>
> # numactl --hardware
> available: 2 nodes (0-1)
> node 0 cpus: 0 1 2 3
> node 0 size: 486 MB
> node 0 free: 470 MB
> node 1 cpus: 4 5 6 7
> node 1 size: 424 MB
> node 1 free: 408 MB
> node distances:
> node   0   1
>   0:  10  20
>   1:  20  10
> # numactl -show
> policy: default
> preferred node: current
> physcpubind: 0 1 2 3 4 5 6 7
> cpubind: 0 1
> nodebind: 0 1
> membind: 0 1
>
> The patches are also available at
> https://github.com/atishp04/linux/tree/5.10_numa_unified_v4
>
> For RISC-V, the following qemu series is a pre-requisite(already available in upstream)
> https://patchwork.kernel.org/project/qemu-devel/list/?series=303313
>
> Testing:
> RISC-V:
> Tested in Qemu and 2 socket OmniXtend FPGA.
>
> ARM64:
> 2 socket kunpeng920 (4 nodes around 250G a node)
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> There may be some minor conflicts with Mike's cleanup series [2] depending on the
> order in which these two series are being accepted. I can rebase on top his series
> if required.
>
> [2] https://lkml.org/lkml/2020/8/18/754
>
> Changes from v3->v4:
> 1. Removed redundant duplicate header.
> 2. Added Reviewed-by tags.
>
> Changes from v2->v3:
> 1. Added Acked-by/Reviewed-by tags.
> 2. Replaced asm/acpi.h with linux/acpi.h
> 3. Defined arch_acpi_numa_init as static.
>
> Changes from v1->v2:
> 1. Replaced ARM64 specific compile time protection with ACPI specific ones.
> 2. Dropped common pcibus_to_node changes. Added required changes in RISC-V.
> 3. Fixed few typos.
>
> Atish Patra (4):
> numa: Move numa implementation to common code
> arm64, numa: Change the numa init functions name to be generic
> riscv: Separate memory init from paging init
> riscv: Add numa support for riscv64 platform
>
> Greentime Hu (1):
> riscv: Add support pte_protnone and pmd_protnone if
> CONFIG_NUMA_BALANCING
>
> arch/arm64/Kconfig                            |  1 +
> arch/arm64/include/asm/numa.h                 | 45 +----------------
> arch/arm64/kernel/acpi_numa.c                 | 13 -----
> arch/arm64/mm/Makefile                        |  1 -
> arch/arm64/mm/init.c                          |  4 +-
> arch/riscv/Kconfig                            | 31 +++++++++++-
> arch/riscv/include/asm/mmzone.h               | 13 +++++
> arch/riscv/include/asm/numa.h                 |  8 +++
> arch/riscv/include/asm/pci.h                  | 14 ++++++
> arch/riscv/include/asm/pgtable.h              | 21 ++++++++
> arch/riscv/kernel/setup.c                     | 11 ++++-
> arch/riscv/kernel/smpboot.c                   | 12 ++++-
> arch/riscv/mm/init.c                          | 10 +++-
> drivers/base/Kconfig                          |  6 +++
> drivers/base/Makefile                         |  1 +
> .../mm/numa.c => drivers/base/arch_numa.c     | 30 ++++++++++--
> include/asm-generic/numa.h                    | 49 +++++++++++++++++++
> 17 files changed, 199 insertions(+), 71 deletions(-)
> create mode 100644 arch/riscv/include/asm/mmzone.h
> create mode 100644 arch/riscv/include/asm/numa.h
> rename arch/arm64/mm/numa.c => drivers/base/arch_numa.c (95%)
> create mode 100644 include/asm-generic/numa.h
>
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Ping ?

-- 
Regards,
Atish
