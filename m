Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAC5272ABC
	for <lists+linux-arch@lfdr.de>; Mon, 21 Sep 2020 17:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgIUPv3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Sep 2020 11:51:29 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2907 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726883AbgIUPv3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 21 Sep 2020 11:51:29 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id B4E22E4553585E499F4E;
        Mon, 21 Sep 2020 16:51:27 +0100 (IST)
Received: from localhost (10.52.127.185) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 21 Sep
 2020 16:51:26 +0100
Date:   Mon, 21 Sep 2020 16:49:47 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Atish Patra <atish.patra@wdc.com>
CC:     <linux-kernel@vger.kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <anup@brainfault.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David Hildenbrand" <david@redhat.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-arch@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        "Mike Rapoport" <rppt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFT PATCH v3 0/5] Unify NUMA implementation between ARM64 &
 RISC-V
Message-ID: <20200921164947.000048e1@Huawei.com>
In-Reply-To: <20200918201140.3172284-1-atish.patra@wdc.com>
References: <20200918201140.3172284-1-atish.patra@wdc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.127.185]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 18 Sep 2020 13:11:35 -0700
Atish Patra <atish.patra@wdc.com> wrote:

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

Was fairly sure this set was a noop on arm64 ACPI systems, but ran a quick
sanity check on a 2 socket kunpeng920 and everything came up as normal
(4 nodes, around 250G a node) 

Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
For patches 1 and 2.  Doesn't seem relevant to the rest :)

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
> For RISC-V, the following qemu series is a pre-requisite(already available in upstream)
> to test the patches in Qemu and 2 socket OmniXtend FPGA.
> 
> https://patchwork.kernel.org/project/qemu-devel/list/?series=303313
> 
> The patches are also available at
> 
> https://github.com/atishp04/linux/tree/5.10_numa_unified_v3
> 
> There may be some minor conflicts with Mike's cleanup series [2] depending on the
> order in which these two series are being accepted. I can rebase on top his series
> if required.
> 
> [2] https://lkml.org/lkml/2020/8/18/754
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
> .../mm/numa.c => drivers/base/arch_numa.c     | 31 ++++++++++--
> include/asm-generic/numa.h                    | 49 +++++++++++++++++++
> 17 files changed, 201 insertions(+), 70 deletions(-)
> create mode 100644 arch/riscv/include/asm/mmzone.h
> create mode 100644 arch/riscv/include/asm/numa.h
> rename arch/arm64/mm/numa.c => drivers/base/arch_numa.c (95%)
> create mode 100644 include/asm-generic/numa.h
> 
> --
> 2.25.1
> 


