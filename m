Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6959E274A8D
	for <lists+linux-arch@lfdr.de>; Tue, 22 Sep 2020 23:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgIVVE3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Sep 2020 17:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgIVVE3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Sep 2020 17:04:29 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2135AC061755
        for <linux-arch@vger.kernel.org>; Tue, 22 Sep 2020 14:04:29 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t10so18614753wrv.1
        for <linux-arch@vger.kernel.org>; Tue, 22 Sep 2020 14:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CY6nb8G0qLvT+19gnqmRvOP7iYy+NDmqCyqksYDWTPk=;
        b=HNiF/Fd9SDJpX7Wj/YWGV4ikRVCq6feHBiWsMkelzLqsWmHNvkWpzoxMbnkn54Pf8C
         PEs06azMVjhoqcLkG6yUVuMKfVYo7vmcCCsEfuXJqreE7dVlqQMa6qUbaaTgZJt+8RQ6
         dfDcen7wKA1cjh5gFRbOoxx/94mkllUFRV2uI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CY6nb8G0qLvT+19gnqmRvOP7iYy+NDmqCyqksYDWTPk=;
        b=JiE/f336ygoXFz1zQdYSZcfcHhm4L3ldeI6WC7WlNLbdWUBUTGHl5/9x+CdHoD51/V
         BIfcmEmt9GHPmMoYOs7kaYA30yahXJVlumTbRQVRUJhnYbxLSDPOHUU+ginCeVtWMurh
         m7yBZgT5mzODmazdlInlSSXFrZmOxN+pr2WODBA8mTYkYssC0raSASDnjk0qcsMHi8/t
         pTOGz4Ofwy2/PYk6a/megyrZrzJf9JU2Vz+lt47Y3Fc9VbkhGnhTI5X1/bwO8x/pFLZy
         3CioIKmSOKCWr+DZRhW2a6EIAznE7GNM649bftMhQz22jFPf2FowApcwTOnfGAZ71o9m
         EDGw==
X-Gm-Message-State: AOAM533Iq7hNLT4rhnkLtPQq4HbNbwOENLO4F9ZYZXkxLtiORmdR+s4U
        dZPbTBSZiAvvJwaytkH+s3clJA/bwiRsNZv4BAzX
X-Google-Smtp-Source: ABdhPJxPW96N1YmBldjxT3/hJJ8ZkPt7zs1MA7vd2que3V+r+lEN7W9dAdh1A8YCBXAgxYyGqngQURp6XgfRsLxTgNM=
X-Received: by 2002:a5d:4c4c:: with SMTP id n12mr7247874wrt.162.1600808667659;
 Tue, 22 Sep 2020 14:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200918201140.3172284-1-atish.patra@wdc.com> <20200921164947.000048e1@Huawei.com>
 <CAOnJCU+mg13P609kut2cK9igmyepOvDc4kU-EzXsdjde7D_RpQ@mail.gmail.com> <20200922122912.00004bcb@Huawei.com>
In-Reply-To: <20200922122912.00004bcb@Huawei.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 22 Sep 2020 14:04:16 -0700
Message-ID: <CAOnJCULdRR1JOkZq6aHW3Xv6ZHo8edOAU-3gf1zxNqQdioek9w@mail.gmail.com>
Subject: Re: [RFT PATCH v3 0/5] Unify NUMA implementation between ARM64 & RISC-V
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        Anup Patel <anup@brainfault.org>,
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
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 22, 2020 at 4:30 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 21 Sep 2020 17:08:32 -0700
> Atish Patra <atishp@atishpatra.org> wrote:
>
> > On Mon, Sep 21, 2020 at 8:51 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Fri, 18 Sep 2020 13:11:35 -0700
> > > Atish Patra <atish.patra@wdc.com> wrote:
> > >
> > > > This series attempts to move the ARM64 numa implementation to common
> > > > code so that RISC-V can leverage that as well instead of reimplementing
> > > > it again.
> > > >
> > > > RISC-V specific bits are based on initial work done by Greentime Hu [1] but
> > > > modified to reuse the common implementation to avoid duplication.
> > > >
> > > > [1] https://lkml.org/lkml/2020/1/10/233
> > > >
> > > > This series has been tested on qemu with numa enabled for both RISC-V & ARM64.
> > > > It would be great if somebody can test it on numa capable ARM64 hardware platforms.
> > > > This patch series doesn't modify the maintainers list for the common code (arch_numa)
> > > > as I am not sure if somebody from ARM64 community or Greg should take up the
> > > > maintainership. Ganapatrao was the original author of the arm64 version.
> > > > I would be happy to update that in the next revision once it is decided.
> > >
> >
> > Any thoughts on the maintenanership of this code ?
>
> Currently it is a trivial enough bit of code, I'd not be too worried
> as long as it doesn't fall through the cracks.  Changes that directory are going
> to need a GregKH Ack so unlikely anything will get missed.
>

Yeah. I am fine with the current structure. I just wanted to confirm that
everybody is on board with that.

> If you feel a specific entry is needed in MAINTAINERS go for it.
> Feel free to stick me down as a reviewer and I'll keep an eye on
> it from ARM64 side of things.
>

I will not add any specific entry in MAINTAINERS unless somebody
complains about it.


> Thanks,
>
> Jonathan
>
>
> >
> > > Was fairly sure this set was a noop on arm64 ACPI systems, but ran a quick
> > > sanity check on a 2 socket kunpeng920 and everything came up as normal
> > > (4 nodes, around 250G a node)
> > >
> > > Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > For patches 1 and 2.  Doesn't seem relevant to the rest :)
> > >
> >
> > Thanks a lot!
> >
> > > >
> > > > # numactl --hardware
> > > > available: 2 nodes (0-1)
> > > > node 0 cpus: 0 1 2 3
> > > > node 0 size: 486 MB
> > > > node 0 free: 470 MB
> > > > node 1 cpus: 4 5 6 7
> > > > node 1 size: 424 MB
> > > > node 1 free: 408 MB
> > > > node distances:
> > > > node   0   1
> > > >   0:  10  20
> > > >   1:  20  10
> > > > # numactl -show
> > > > policy: default
> > > > preferred node: current
> > > > physcpubind: 0 1 2 3 4 5 6 7
> > > > cpubind: 0 1
> > > > nodebind: 0 1
> > > > membind: 0 1
> > > >
> > > > For RISC-V, the following qemu series is a pre-requisite(already available in upstream)
> > > > to test the patches in Qemu and 2 socket OmniXtend FPGA.
> > > >
> > > > https://patchwork.kernel.org/project/qemu-devel/list/?series=303313
> > > >
> > > > The patches are also available at
> > > >
> > > > https://github.com/atishp04/linux/tree/5.10_numa_unified_v3
> > > >
> > > > There may be some minor conflicts with Mike's cleanup series [2] depending on the
> > > > order in which these two series are being accepted. I can rebase on top his series
> > > > if required.
> > > >
> > > > [2] https://lkml.org/lkml/2020/8/18/754
> > > >
> > > > Changes from v2->v3:
> > > > 1. Added Acked-by/Reviewed-by tags.
> > > > 2. Replaced asm/acpi.h with linux/acpi.h
> > > > 3. Defined arch_acpi_numa_init as static.
> > > >
> > > > Changes from v1->v2:
> > > > 1. Replaced ARM64 specific compile time protection with ACPI specific ones.
> > > > 2. Dropped common pcibus_to_node changes. Added required changes in RISC-V.
> > > > 3. Fixed few typos.
> > > >
> > > > Atish Patra (4):
> > > > numa: Move numa implementation to common code
> > > > arm64, numa: Change the numa init functions name to be generic
> > > > riscv: Separate memory init from paging init
> > > > riscv: Add numa support for riscv64 platform
> > > >
> > > > Greentime Hu (1):
> > > > riscv: Add support pte_protnone and pmd_protnone if
> > > > CONFIG_NUMA_BALANCING
> > > >
> > > > arch/arm64/Kconfig                            |  1 +
> > > > arch/arm64/include/asm/numa.h                 | 45 +----------------
> > > > arch/arm64/kernel/acpi_numa.c                 | 13 -----
> > > > arch/arm64/mm/Makefile                        |  1 -
> > > > arch/arm64/mm/init.c                          |  4 +-
> > > > arch/riscv/Kconfig                            | 31 +++++++++++-
> > > > arch/riscv/include/asm/mmzone.h               | 13 +++++
> > > > arch/riscv/include/asm/numa.h                 |  8 +++
> > > > arch/riscv/include/asm/pci.h                  | 14 ++++++
> > > > arch/riscv/include/asm/pgtable.h              | 21 ++++++++
> > > > arch/riscv/kernel/setup.c                     | 11 ++++-
> > > > arch/riscv/kernel/smpboot.c                   | 12 ++++-
> > > > arch/riscv/mm/init.c                          | 10 +++-
> > > > drivers/base/Kconfig                          |  6 +++
> > > > drivers/base/Makefile                         |  1 +
> > > > .../mm/numa.c => drivers/base/arch_numa.c     | 31 ++++++++++--
> > > > include/asm-generic/numa.h                    | 49 +++++++++++++++++++
> > > > 17 files changed, 201 insertions(+), 70 deletions(-)
> > > > create mode 100644 arch/riscv/include/asm/mmzone.h
> > > > create mode 100644 arch/riscv/include/asm/numa.h
> > > > rename arch/arm64/mm/numa.c => drivers/base/arch_numa.c (95%)
> > > > create mode 100644 include/asm-generic/numa.h
> > > >
> > > > --
> > > > 2.25.1
> > > >
> > >
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> >
> >
>
>


--
Regards,
Atish
