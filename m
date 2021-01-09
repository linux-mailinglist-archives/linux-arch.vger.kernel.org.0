Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FA32F0397
	for <lists+linux-arch@lfdr.de>; Sat,  9 Jan 2021 21:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbhAIUwC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 Jan 2021 15:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbhAIUwC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 Jan 2021 15:52:02 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C3CC061786
        for <linux-arch@vger.kernel.org>; Sat,  9 Jan 2021 12:51:16 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 11so8513234pfu.4
        for <linux-arch@vger.kernel.org>; Sat, 09 Jan 2021 12:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=62H/x/rByJ7ggse69TMiJJtItRYsUHxpZdki7cQ0WSY=;
        b=DoveRgb7gXjFv1+ebT4gOVEgstLeS7xoNCzngzTIpcb6n9yiwNrt81KUF+6Amd0gkK
         RGOK1gcWgCICsIv/c4SURHsg8OztnlMoRMvJj1dh4E31jGgzNJHrIsngtGwccM9Jsj4C
         9b9CVH3nW16+SldrGzvq9Ba75tpJeOrozHIVJPhC3hmxCisbOwttLLbPBvaOZBFFGKkD
         XktLpcJcbFL6JN2BGMGY4HrfC6+FDi1WDm1zO9/9mJcqnx7TjtgEp766x1eOWP3DZwCH
         F4ZEalrhwuWiTxNFAId3p3wnknrkMI8Qfo8JUy1Va1ajglff2/EfQinLBe74NKFd7CK9
         M6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=62H/x/rByJ7ggse69TMiJJtItRYsUHxpZdki7cQ0WSY=;
        b=F9tDzTMq9fBGM2F00zoX3ZMHQIQKyEKSmP2Q2ZFii3EFWcY82q2zTW86r0xD5f8tRn
         d5vwnv39TsR6k8cO1oc1wFmYBpT69R7qLvJegC99+hLdChAIpT0Uc89OIQv1dF0CHoZv
         pAcsQutXTb8nwgWSV8fxYEvRZPR5hVi11P3lc37ilVNjHlnWeH+wthPKoRh1eNaQ2S5/
         WzmJvQnN+1E8oDYcROXXfRvlf4O6CecluR1mzhxG3qWg9xh0uLS52LNtLaCmtWtxPJ2N
         7pGFtDEcQzldVN+i4f0NsUJoZ/AovZeJiEPVn/hJYhFQS7Fc8+2evReTpUXX1hmppyGF
         W7zQ==
X-Gm-Message-State: AOAM530g/pJ3S/uqmW43C3xg4vzldSi4wsqF9kk+uvL37KBkN5hpkQie
        oRn4Ykd6rkYaxkQsdhKxobtJzQ==
X-Google-Smtp-Source: ABdhPJzvQxmL/8rMOc/FYAbYs90guGWjhjVKrS4AG8vAK2ohMHxboO5/LTHzyHEKf2KsQsS1OtwLHQ==
X-Received: by 2002:a63:e:: with SMTP id 14mr13053823pga.253.1610225475399;
        Sat, 09 Jan 2021 12:51:15 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id z13sm9312972pjt.45.2021.01.09.12.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jan 2021 12:51:14 -0800 (PST)
Date:   Sat, 09 Jan 2021 12:51:14 -0800 (PST)
X-Google-Original-Date: Sat, 09 Jan 2021 12:51:12 PST (-0800)
Subject:     Re: [PATCH v5 0/5] Unify NUMA implementation between ARM64 & RISC-V
In-Reply-To: <CAOnJCULPCxhirYH8xCciKDNJ=zfWKwiOOfAoT8QQBOKqTuWuTA@mail.gmail.com>
CC:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        catalin.marinas@arm.com, Jonathan.Cameron@huawei.com,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv@lists.infradead.org, will@kernel.org, ardb@kernel.org,
        linux-arch@vger.kernel.org, liuzhengyuan@tj.kylinos.cn,
        bhe@redhat.com, anup@brainfault.org, daniel.lezcano@linaro.org,
        steven.price@arm.com, greentime.hu@sifive.com,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        anshuman.khandual@arm.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-arm-kernel@lists.infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, rppt@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     atishp@atishpatra.org
Message-ID: <mhng-94c90991-c4e8-49fe-a225-854ae0343d8d@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 13 Dec 2020 17:02:19 PST (-0800), atishp@atishpatra.org wrote:
> On Wed, Nov 18, 2020 at 4:39 PM Atish Patra <atish.patra@wdc.com> wrote:
>>
>> This series attempts to move the ARM64 numa implementation to common
>> code so that RISC-V can leverage that as well instead of reimplementing
>> it again.
>>
>> RISC-V specific bits are based on initial work done by Greentime Hu [1] but
>> modified to reuse the common implementation to avoid duplication.
>>
>> [1] https://lkml.org/lkml/2020/1/10/233
>>
>> This series has been tested on qemu with numa enabled for both RISC-V & ARM64.
>> It would be great if somebody can test it on numa capable ARM64 hardware platforms.
>> This patch series doesn't modify the maintainers list for the common code (arch_numa)
>> as I am not sure if somebody from ARM64 community or Greg should take up the
>> maintainership. Ganapatrao was the original author of the arm64 version.
>> I would be happy to update that in the next revision once it is decided.
>>
>> # numactl --hardware
>> available: 2 nodes (0-1)
>> node 0 cpus: 0 1 2 3
>> node 0 size: 486 MB
>> node 0 free: 470 MB
>> node 1 cpus: 4 5 6 7
>> node 1 size: 424 MB
>> node 1 free: 408 MB
>> node distances:
>> node   0   1
>>   0:  10  20
>>   1:  20  10
>> # numactl -show
>> policy: default
>> preferred node: current
>> physcpubind: 0 1 2 3 4 5 6 7
>> cpubind: 0 1
>> nodebind: 0 1
>> membind: 0 1
>>
>> The patches are also available at
>> https://github.com/atishp04/linux/tree/5.11_numa_unified_v5
>>
>> For RISC-V, the following qemu series is a pre-requisite(already available in upstream)
>> https://patchwork.kernel.org/project/qemu-devel/list/?series=303313
>>
>> Testing:
>> RISC-V:
>> Tested in Qemu and 2 socket OmniXtend FPGA.
>>
>> ARM64:
>> 2 socket kunpeng920 (4 nodes around 250G a node)
>> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>
>> Changes from v4->v5:
>> 1. Added by Acked-by & Reviewed-by tags.
>> 2. Swapped patch 1 & 2 in v4 version.
>>
>> Changes from v3->v4:
>> 1. Removed redundant duplicate header.
>> 2. Added Reviewed-by tags.
>>
>> Changes from v2->v3:
>> 1. Added Acked-by/Reviewed-by tags.
>> 2. Replaced asm/acpi.h with linux/acpi.h
>> 3. Defined arch_acpi_numa_init as static.
>>
>> Changes from v1->v2:
>> 1. Replaced ARM64 specific compile time protection with ACPI specific ones.
>> 2. Dropped common pcibus_to_node changes. Added required changes in RISC-V.
>> 3. Fixed few typos.
>>
>> Atish Patra (4):
>> arm64, numa: Change the numa init functions name to be generic
>> numa: Move numa implementation to common code
>> riscv: Separate memory init from paging init
>> riscv: Add numa support for riscv64 platform
>>
>> Greentime Hu (1):
>> riscv: Add support pte_protnone and pmd_protnone if
>> CONFIG_NUMA_BALANCING
>>
>> arch/arm64/Kconfig                            |  1 +
>> arch/arm64/include/asm/numa.h                 | 48 +----------------
>> arch/arm64/kernel/acpi_numa.c                 | 12 -----
>> arch/arm64/mm/Makefile                        |  1 -
>> arch/arm64/mm/init.c                          |  4 +-
>> arch/riscv/Kconfig                            | 31 ++++++++++-
>> arch/riscv/include/asm/mmzone.h               | 13 +++++
>> arch/riscv/include/asm/numa.h                 |  8 +++
>> arch/riscv/include/asm/pci.h                  | 14 +++++
>> arch/riscv/include/asm/pgtable.h              | 21 ++++++++
>> arch/riscv/kernel/setup.c                     | 11 +++-
>> arch/riscv/kernel/smpboot.c                   | 12 ++++-
>> arch/riscv/mm/init.c                          | 10 +++-
>> drivers/base/Kconfig                          |  6 +++
>> drivers/base/Makefile                         |  1 +
>> .../mm/numa.c => drivers/base/arch_numa.c     | 27 ++++++++--
>> include/asm-generic/numa.h                    | 52 +++++++++++++++++++
>> 17 files changed, 200 insertions(+), 72 deletions(-)
>> create mode 100644 arch/riscv/include/asm/mmzone.h
>> create mode 100644 arch/riscv/include/asm/numa.h
>> rename arch/arm64/mm/numa.c => drivers/base/arch_numa.c (96%)
>> create mode 100644 include/asm-generic/numa.h
>>
>> --
>> 2.25.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> Hey Palmer,
> I did not see this series in for-next. Let me know if you need
> anything else to be done for this series.

Sorry about that.  It's on for-next, with Randy's comment addressed.  There was
one merge conflict: we don't have resource_init() in for-next yet (which I
think means I missed something else).  IDK if that's necessary for the NUMA
stuff, I just dropped it.  I haven't tested this yet.
