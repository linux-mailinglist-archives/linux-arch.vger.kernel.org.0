Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C415529307A
	for <lists+linux-arch@lfdr.de>; Mon, 19 Oct 2020 23:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732996AbgJSV3a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Oct 2020 17:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbgJSV31 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Oct 2020 17:29:27 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6F8C0613CE
        for <linux-arch@vger.kernel.org>; Mon, 19 Oct 2020 14:29:25 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id v12so462311ply.12
        for <linux-arch@vger.kernel.org>; Mon, 19 Oct 2020 14:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ZfDVboFUi3PL20oeahZURT/wAnBCLrU/u8rK/q4mNM4=;
        b=IIzfpDadzNjwKyZ5cvtnhOoML0jGSc4vEqrP+U3PY2m/SaTdm71GVeNequFbvKgRqG
         R1HDGwHlE2x4D6ZN+qrYkllFLT/Uv1+xCZhAbo001dGropx1jl9T4PAFsIwWYTgSRzqJ
         cYdb+6l58JjznjXjuVtb3msoZ0nHhnscoaZRa/jAb1y9QU6IqIO/qnADwyjkbUHTKh11
         JqAT31AjB+RRopsIChKWzeBjdO1DI0Sn4uxlOdhoVLaTQOzcEHlt1gqTqT5QK63AqXf+
         e2y7xwogZ3kbRGF5MbtFLvufZTnQVBnLLlk3leJqxGX165FfHcsnyUYECj2C5CTVcB6E
         qTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ZfDVboFUi3PL20oeahZURT/wAnBCLrU/u8rK/q4mNM4=;
        b=QLEBZwoOVhGylDfx4j/Jt/WB6v2bc36QJlDo4Ge6QsHN5LMMJts2fM1a5XCs8DWtei
         G7CsamYwlidsUqpIpIO0uP33vT9F3UQLNf6Ic9GlcKnYuqWY5eYG3ZkaiubXQYg8fsa5
         2Moj7gqGwM4eQHvXZwr84H7/6GCPSqHyDQIHOIqg9vhsDn8e+RYTW/w2IYv064Ec+aLy
         u/xlvx9sZbeRoEKWnP5pWVk+uoC/3VVqAU525HAXA2uCU9WgAENw1WB3VQ8la5sMyu8E
         2ulBMVuKQaj6ItcwxDhItljVVBUupQfi1/X/VavHQAKCQAxr7j0b29UDM0yiHcE10DCt
         2kcg==
X-Gm-Message-State: AOAM532pNUqY1xgX/WYWDYWFtWjoyyyW5QZanaQ3ofx7vFGijOAez7ay
        rAKaiJWzYk9GPkCDtI/LevN13Q==
X-Google-Smtp-Source: ABdhPJzVaGDA6wX2KJ6cd/pzhLTg3CGDeACAttfyO3vDd6Mgdnf5ad6gmSm7BQSW4xbE8phWqISXyQ==
X-Received: by 2002:a17:902:6845:b029:d4:d1d5:2139 with SMTP id f5-20020a1709026845b02900d4d1d52139mr1779774pln.53.1603142965213;
        Mon, 19 Oct 2020 14:29:25 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id j23sm478919pgh.31.2020.10.19.14.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 14:29:24 -0700 (PDT)
Date:   Mon, 19 Oct 2020 14:29:24 -0700 (PDT)
X-Google-Original-Date: Mon, 19 Oct 2020 14:29:23 PDT (-0700)
Subject:     Re: [PATCH v4 0/5] Unify NUMA implementation between ARM64 & RISC-V
In-Reply-To: <CAOnJCULba4qEO-8MmTDw5rWBep9mPUdq-iA-UpBN=-SXB13nmg@mail.gmail.com>
CC:     Atish Patra <Atish.Patra@wdc.com>, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com, david@redhat.com,
        catalin.marinas@arm.com, Jonathan.Cameron@huawei.com,
        zong.li@sifive.com, linux-riscv@lists.infradead.org,
        will@kernel.org, linux-arch@vger.kernel.org, justin.he@arm.com,
        anup@brainfault.org, rafael@kernel.org, steven.price@arm.com,
        greentime.hu@sifive.com, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, anshuman.khandual@arm.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-arm-kernel@lists.infradead.org,
        Greg KH <gregkh@linuxfoundation.org>, rppt@kernel.org,
        akpm@linux-foundation.org, nsaenzjulienne@suse.de
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     atishp@atishpatra.org
Message-ID: <mhng-c28b83e1-43b5-4798-8f9e-da7292fa8d12@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 13 Oct 2020 13:19:35 PDT (-0700), atishp@atishpatra.org wrote:
> On Mon, Oct 5, 2020 at 5:18 PM Atish Patra <atish.patra@wdc.com> wrote:
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
>> https://github.com/atishp04/linux/tree/5.10_numa_unified_v4
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
>> There may be some minor conflicts with Mike's cleanup series [2] depending on the
>> order in which these two series are being accepted. I can rebase on top his series
>> if required.
>>
>> [2] https://lkml.org/lkml/2020/8/18/754
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
>> numa: Move numa implementation to common code
>> arm64, numa: Change the numa init functions name to be generic
>> riscv: Separate memory init from paging init
>> riscv: Add numa support for riscv64 platform
>>
>> Greentime Hu (1):
>> riscv: Add support pte_protnone and pmd_protnone if
>> CONFIG_NUMA_BALANCING
>>
>> arch/arm64/Kconfig                            |  1 +
>> arch/arm64/include/asm/numa.h                 | 45 +----------------
>> arch/arm64/kernel/acpi_numa.c                 | 13 -----
>> arch/arm64/mm/Makefile                        |  1 -
>> arch/arm64/mm/init.c                          |  4 +-
>> arch/riscv/Kconfig                            | 31 +++++++++++-
>> arch/riscv/include/asm/mmzone.h               | 13 +++++
>> arch/riscv/include/asm/numa.h                 |  8 +++
>> arch/riscv/include/asm/pci.h                  | 14 ++++++
>> arch/riscv/include/asm/pgtable.h              | 21 ++++++++
>> arch/riscv/kernel/setup.c                     | 11 ++++-
>> arch/riscv/kernel/smpboot.c                   | 12 ++++-
>> arch/riscv/mm/init.c                          | 10 +++-
>> drivers/base/Kconfig                          |  6 +++
>> drivers/base/Makefile                         |  1 +
>> .../mm/numa.c => drivers/base/arch_numa.c     | 30 ++++++++++--
>> include/asm-generic/numa.h                    | 49 +++++++++++++++++++
>> 17 files changed, 199 insertions(+), 71 deletions(-)
>> create mode 100644 arch/riscv/include/asm/mmzone.h
>> create mode 100644 arch/riscv/include/asm/numa.h
>> rename arch/arm64/mm/numa.c => drivers/base/arch_numa.c (95%)
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
> Ping ?

This has been at the top of my inbox for a week or two now, I just haven't
gotten around to taking a look yet because of all the other fires going on.
Sorry.
