Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB128273717
	for <lists+linux-arch@lfdr.de>; Tue, 22 Sep 2020 02:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgIVAIp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Sep 2020 20:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbgIVAIp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Sep 2020 20:08:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7B7C061755
        for <linux-arch@vger.kernel.org>; Mon, 21 Sep 2020 17:08:45 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l9so1512613wme.3
        for <linux-arch@vger.kernel.org>; Mon, 21 Sep 2020 17:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hEV8TO4mdFZF8/iM9S4OFGlFE4L0gQ5gzDQBkMBrODI=;
        b=gYIGIDI+OKHtg00WTkRcUagV3FN4QuKjLS6GPsx/DCSktOkq2OQmm8LosqoZDTsii5
         1zvRr9v2n81J/6UtZvWxHyTMW/8BqDj5AF4HJ6V7HCaasuIJMiRLytw6mWIhQ+iZeZMY
         zCOb+PV+//UAFc+RhirY6n79q0VnYXyL1V+E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hEV8TO4mdFZF8/iM9S4OFGlFE4L0gQ5gzDQBkMBrODI=;
        b=TMgJR2N7vGiI/3lhunuj2sc1qsTG9u0av20+lXRh4uRal6qTnIjx43F5t4UizghG4v
         54LKTtoB/5eE/a3Atly855eY9nIGmLjnYMkbtAeklxcQtlb1cJlkKe4GrYPudTncDGbn
         peyyJFwP2DRxeLBcuKX0U5CeZ+cclcuJUjugkQzkXbwKh8RYwFqk+U8uUfocMHhL1Svu
         YdortpVneTlZvHb6cLRqnUVzH2dOaR80/nCNxslbPp6bQbihPetvySdhvpYT0cm/JJwO
         JLck8s6eB+fQs5Lp8gQlzb614FV9cidq3PWowWubq1eAiVOa2Fi+PTckm6GgfSBDfB4M
         HgHg==
X-Gm-Message-State: AOAM532H+HA7U80uytJ4ng5gEbNrVedvLQIfK9ev6nEX2L8xisq5O0xQ
        e4vKXX26NHcYCaNu5o2kRNGqHo4vPjfTDxvi1qck
X-Google-Smtp-Source: ABdhPJwjJextrW2u2RMl/77W5IKbRzlLI/rNGeMx1PYcfnUc2oAuEhYU9I1Obt1omiSn8H/SIpY/n0H/ktHwbS9FQrk=
X-Received: by 2002:a1c:a988:: with SMTP id s130mr1589106wme.31.1600733323651;
 Mon, 21 Sep 2020 17:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200918201140.3172284-1-atish.patra@wdc.com> <20200921164947.000048e1@Huawei.com>
In-Reply-To: <20200921164947.000048e1@Huawei.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 21 Sep 2020 17:08:32 -0700
Message-ID: <CAOnJCU+mg13P609kut2cK9igmyepOvDc4kU-EzXsdjde7D_RpQ@mail.gmail.com>
Subject: Re: [RFT PATCH v3 0/5] Unify NUMA implementation between ARM64 & RISC-V
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Atish Patra <atish.patra@wdc.com>, linux-arch@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Arnd Bergmann <arnd@arndb.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <anup@brainfault.org>,
        David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Steven Price <steven.price@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 21, 2020 at 8:51 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 18 Sep 2020 13:11:35 -0700
> Atish Patra <atish.patra@wdc.com> wrote:
>
> > This series attempts to move the ARM64 numa implementation to common
> > code so that RISC-V can leverage that as well instead of reimplementing
> > it again.
> >
> > RISC-V specific bits are based on initial work done by Greentime Hu [1] but
> > modified to reuse the common implementation to avoid duplication.
> >
> > [1] https://lkml.org/lkml/2020/1/10/233
> >
> > This series has been tested on qemu with numa enabled for both RISC-V & ARM64.
> > It would be great if somebody can test it on numa capable ARM64 hardware platforms.
> > This patch series doesn't modify the maintainers list for the common code (arch_numa)
> > as I am not sure if somebody from ARM64 community or Greg should take up the
> > maintainership. Ganapatrao was the original author of the arm64 version.
> > I would be happy to update that in the next revision once it is decided.
>

Any thoughts on the maintenanership of this code ?

> Was fairly sure this set was a noop on arm64 ACPI systems, but ran a quick
> sanity check on a 2 socket kunpeng920 and everything came up as normal
> (4 nodes, around 250G a node)
>
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> For patches 1 and 2.  Doesn't seem relevant to the rest :)
>

Thanks a lot!

> >
> > # numactl --hardware
> > available: 2 nodes (0-1)
> > node 0 cpus: 0 1 2 3
> > node 0 size: 486 MB
> > node 0 free: 470 MB
> > node 1 cpus: 4 5 6 7
> > node 1 size: 424 MB
> > node 1 free: 408 MB
> > node distances:
> > node   0   1
> >   0:  10  20
> >   1:  20  10
> > # numactl -show
> > policy: default
> > preferred node: current
> > physcpubind: 0 1 2 3 4 5 6 7
> > cpubind: 0 1
> > nodebind: 0 1
> > membind: 0 1
> >
> > For RISC-V, the following qemu series is a pre-requisite(already available in upstream)
> > to test the patches in Qemu and 2 socket OmniXtend FPGA.
> >
> > https://patchwork.kernel.org/project/qemu-devel/list/?series=303313
> >
> > The patches are also available at
> >
> > https://github.com/atishp04/linux/tree/5.10_numa_unified_v3
> >
> > There may be some minor conflicts with Mike's cleanup series [2] depending on the
> > order in which these two series are being accepted. I can rebase on top his series
> > if required.
> >
> > [2] https://lkml.org/lkml/2020/8/18/754
> >
> > Changes from v2->v3:
> > 1. Added Acked-by/Reviewed-by tags.
> > 2. Replaced asm/acpi.h with linux/acpi.h
> > 3. Defined arch_acpi_numa_init as static.
> >
> > Changes from v1->v2:
> > 1. Replaced ARM64 specific compile time protection with ACPI specific ones.
> > 2. Dropped common pcibus_to_node changes. Added required changes in RISC-V.
> > 3. Fixed few typos.
> >
> > Atish Patra (4):
> > numa: Move numa implementation to common code
> > arm64, numa: Change the numa init functions name to be generic
> > riscv: Separate memory init from paging init
> > riscv: Add numa support for riscv64 platform
> >
> > Greentime Hu (1):
> > riscv: Add support pte_protnone and pmd_protnone if
> > CONFIG_NUMA_BALANCING
> >
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
> > .../mm/numa.c => drivers/base/arch_numa.c     | 31 ++++++++++--
> > include/asm-generic/numa.h                    | 49 +++++++++++++++++++
> > 17 files changed, 201 insertions(+), 70 deletions(-)
> > create mode 100644 arch/riscv/include/asm/mmzone.h
> > create mode 100644 arch/riscv/include/asm/numa.h
> > rename arch/arm64/mm/numa.c => drivers/base/arch_numa.c (95%)
> > create mode 100644 include/asm-generic/numa.h
> >
> > --
> > 2.25.1
> >
>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
