Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39EC2A85B0
	for <lists+linux-arch@lfdr.de>; Thu,  5 Nov 2020 19:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbgKESHD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Nov 2020 13:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKESHD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Nov 2020 13:07:03 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E7EC0613CF
        for <linux-arch@vger.kernel.org>; Thu,  5 Nov 2020 10:07:01 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id e21so1867817pgr.11
        for <linux-arch@vger.kernel.org>; Thu, 05 Nov 2020 10:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=evErAM+3R8POckj6BoWNfzcQKezQH3REiwTi+k5Ke30=;
        b=cvZYUkjBWInIl2l1mjIWf1vI7V8s6znitGQb6c5FeaYxHv0JPbh4k6w9pz9IC9AVgi
         gDivP8WJC+El0KFshMutO5n1YhCRHEIxrqzYwu6bCUnrciwL9E/9tGm25eHqZdW/XI91
         T59XUK3EUSN6RVDl9mXW4WPshbsdGRiNI8znzVKFYGQbhx9IrGxgBTrOhued5XD/a+Rl
         jGfmJLxTf7oGVAKBpYdYB481ef3UnuDvjfFSwTdh0stV94i0MsDhYbrVvvmy+VsOz+Ip
         B26F8d2w0VLVBJD8zghUyljlnVXk+Mse1xJEVITFTDvRgVup52j0H2KEoatpkwDS97+8
         tARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=evErAM+3R8POckj6BoWNfzcQKezQH3REiwTi+k5Ke30=;
        b=QfAoRmFF5jahvlkbLbYkUYnc/suH/UtjCXA01kDHGhR/vr2c766FviupFCHQPCkOPN
         Qrqdahyj7OZi//TAunavb9B8D0FGJBDsqIZV/lBk1L0cs+i46VK7D83+HXusNaYeI+8E
         q6yjNb81ojy/CwBeE9vIkSHUMPdXszIjQnKclDGasSdGChpOOYms4Go819/dfcwwgqC4
         LMqSgDRaX4NOAKd2SPthctQUMFXicW+31pdkZcR2W1SpITo0qapvfV52UkmjSuibD33V
         FRPEs29ywDxHbVBvOZyJzt6MvuIBJW6Y85YJzpGXGL5eRVBBLG5ed+QkqOjy8aNrOxVP
         CNfQ==
X-Gm-Message-State: AOAM531r5IXJCkKUMfSu4v345x1+maW4OJjSp1k5NLHMY4XzzINAmo2Q
        Sh3SlgC1Vgdo6gVg112ynYPTsg==
X-Google-Smtp-Source: ABdhPJyRc3dpCSILr1s7f7biptBWJz9+L1an7mUZwA/tps7uFu35JlM1E3LkORf3mPe7ALBUxC60+A==
X-Received: by 2002:aa7:9607:0:b029:155:2b85:93f5 with SMTP id q7-20020aa796070000b02901552b8593f5mr3642353pfg.36.1604599621026;
        Thu, 05 Nov 2020 10:07:01 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id b16sm3180544pju.16.2020.11.05.10.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 10:07:00 -0800 (PST)
Date:   Thu, 05 Nov 2020 10:07:00 -0800 (PST)
X-Google-Original-Date: Thu, 05 Nov 2020 09:33:55 PST (-0800)
Subject:     Re: [PATCH v4 0/5] Unify NUMA implementation between ARM64 & RISC-V
In-Reply-To: <20201006001752.248564-1-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        Jonathan.Cameron@huawei.com, aou@eecs.berkeley.edu,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        anup@brainfault.org, Arnd Bergmann <arnd@arndb.de>,
        catalin.marinas@arm.com, david@redhat.com, greentime.hu@sifive.com,
        Greg KH <gregkh@linuxfoundation.org>, justin.he@arm.com,
        wangkefeng.wang@huawei.com, linux-arch@vger.kernel.org,
        linux-riscv@lists.infradead.org, rppt@kernel.org,
        nsaenzjulienne@suse.de, Paul Walmsley <paul.walmsley@sifive.com>,
        rafael@kernel.org, steven.price@arm.com, will@kernel.org,
        zong.li@sifive.com, linux-arm-kernel@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>,
        Will Deacon <willdeacon@google.com>, maz@kernel.org
Message-ID: <mhng-6971ba28-0cea-42bc-a26c-c23b9ba2af9e@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 05 Oct 2020 17:17:47 PDT (-0700), Atish Patra wrote:
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

Sorry it took me a while to get around to this, I had some work stuff to deal
with and have managed to get buried in email.  This all looks fine to me, but
the way it's structured make it kind of hard to apply -- essentially I can't
take the first two without at least some Acks from the arm64 folks, and it
smells to me like it'd be better to have those go through the arm64 tree.  The
RISC-V stuff isn't that heavywight, but I'd like it to at least land in my
for-next at some point as otherwise it'll be completely untested.

arm64 guys: do you want to try and do some sort of shared base tag sort of
thing for these, or do you want me to refactor this such that it adds the
generic stuff before removing the arm64 stuff so we can decouble that way?
