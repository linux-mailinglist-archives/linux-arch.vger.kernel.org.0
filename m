Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2C82706E3
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 22:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgIRUWu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 16:22:50 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4416 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgIRUWu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 16:22:50 -0400
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 16:22:49 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600460585; x=1631996585;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GI3H7FI5MM8SnAiJ9n4LYSUWOw7izossiuo/gw2bk/g=;
  b=FeaXvMT5lLjEbd8JiQuyTEKACxgbf27Urr6dwkn5EgDmU+GCOejqrQmH
   M+xEf7Xa3Hd1BoPcqcEGfYh8zLqtnuRY39kqiB0gy2zjt+NyGeFzcF73o
   K4FddX2tBJLRXvy6ikTnWCBnxZlNIEWokmwTkCY4LJBZDi2nXANL/u+li
   oV0Pk8dG3OOZ5SoWYOxMlOwZsYa4UPHdK1YkkEuDAmXEP+jnuYAmORj/i
   xylPZideMPdMc3z9vPfYPC4RHB6wEvSPCvmp0E2NUB+sYHEhY4FF6l8yU
   7gxYnHd1vlNd74lUSVVkjvy625l3nG7dDrLSMGgAeq2b1ksikFT91F0g1
   g==;
IronPort-SDR: n7gL7+au+kwg8pVzlX7pj5lxuL/mgXCFDnewZC9Z4ZyFZLi7wj/YHBUOU4i0K7wIuwoaGUnFZN
 10q06f280xX30MBvVxr3+xlK2kWd8vTNHNN973bPSSOZUFDPIqe05GTCvw57uVljMyYg1jzjCW
 O1P6wWi8bvhrMs+uVqB1OjuIoc41I38m7v+sX1PfGP2144Fb5wubmwjEZTIbRtnYI5fHo4hpwh
 jmqTAbs0KFUWZaEgNrAGxhFqMtoGsr9wsXooPS0YitAAmxiMmN/EmyWtN8g1mQCYkbaGFjLXlM
 MFI=
X-IronPort-AV: E=Sophos;i="5.77,274,1596470400"; 
   d="scan'208";a="251108770"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2020 04:12:51 +0800
IronPort-SDR: N67rpcmvGxCc7H2ofiTkgJvnyHggQdG55gAoviszUa3jb2Qd8Zs/fc2q8UUtu+2i1iEC2yRF2u
 bcrQJ6bWebwA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 12:59:53 -0700
IronPort-SDR: Q+Z6LvVPGweJdIFY//I/72e4PvvW6vQGNmh+aBzgJ5z5U6FdHT4C8mw8luHFGSpwHXxbrFjjRP
 ymg46FROWaFQ==
WDCIronportException: Internal
Received: from us3v3d262.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.69])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Sep 2020 13:12:47 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <anup@brainfault.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mike Rapoport <rppt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFT PATCH v3 0/5] Unify NUMA implementation between ARM64 & RISC-V
Date:   Fri, 18 Sep 2020 13:11:35 -0700
Message-Id: <20200918201140.3172284-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series attempts to move the ARM64 numa implementation to common
code so that RISC-V can leverage that as well instead of reimplementing
it again.

RISC-V specific bits are based on initial work done by Greentime Hu [1] but
modified to reuse the common implementation to avoid duplication.

[1] https://lkml.org/lkml/2020/1/10/233

This series has been tested on qemu with numa enabled for both RISC-V & ARM64.
It would be great if somebody can test it on numa capable ARM64 hardware platforms.
This patch series doesn't modify the maintainers list for the common code (arch_numa)
as I am not sure if somebody from ARM64 community or Greg should take up the
maintainership. Ganapatrao was the original author of the arm64 version.
I would be happy to update that in the next revision once it is decided.

# numactl --hardware
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3
node 0 size: 486 MB
node 0 free: 470 MB
node 1 cpus: 4 5 6 7
node 1 size: 424 MB
node 1 free: 408 MB
node distances:
node   0   1 
  0:  10  20 
  1:  20  10 
# numactl -show
policy: default
preferred node: current
physcpubind: 0 1 2 3 4 5 6 7 
cpubind: 0 1 
nodebind: 0 1 
membind: 0 1 

For RISC-V, the following qemu series is a pre-requisite(already available in upstream)
to test the patches in Qemu and 2 socket OmniXtend FPGA.

https://patchwork.kernel.org/project/qemu-devel/list/?series=303313

The patches are also available at

https://github.com/atishp04/linux/tree/5.10_numa_unified_v3

There may be some minor conflicts with Mike's cleanup series [2] depending on the
order in which these two series are being accepted. I can rebase on top his series
if required.

[2] https://lkml.org/lkml/2020/8/18/754

Changes from v2->v3:
1. Added Acked-by/Reviewed-by tags.
2. Replaced asm/acpi.h with linux/acpi.h
3. Defined arch_acpi_numa_init as static.

Changes from v1->v2:
1. Replaced ARM64 specific compile time protection with ACPI specific ones.
2. Dropped common pcibus_to_node changes. Added required changes in RISC-V. 
3. Fixed few typos.

Atish Patra (4):
numa: Move numa implementation to common code
arm64, numa: Change the numa init functions name to be generic
riscv: Separate memory init from paging init
riscv: Add numa support for riscv64 platform

Greentime Hu (1):
riscv: Add support pte_protnone and pmd_protnone if
CONFIG_NUMA_BALANCING

arch/arm64/Kconfig                            |  1 +
arch/arm64/include/asm/numa.h                 | 45 +----------------
arch/arm64/kernel/acpi_numa.c                 | 13 -----
arch/arm64/mm/Makefile                        |  1 -
arch/arm64/mm/init.c                          |  4 +-
arch/riscv/Kconfig                            | 31 +++++++++++-
arch/riscv/include/asm/mmzone.h               | 13 +++++
arch/riscv/include/asm/numa.h                 |  8 +++
arch/riscv/include/asm/pci.h                  | 14 ++++++
arch/riscv/include/asm/pgtable.h              | 21 ++++++++
arch/riscv/kernel/setup.c                     | 11 ++++-
arch/riscv/kernel/smpboot.c                   | 12 ++++-
arch/riscv/mm/init.c                          | 10 +++-
drivers/base/Kconfig                          |  6 +++
drivers/base/Makefile                         |  1 +
.../mm/numa.c => drivers/base/arch_numa.c     | 31 ++++++++++--
include/asm-generic/numa.h                    | 49 +++++++++++++++++++
17 files changed, 201 insertions(+), 70 deletions(-)
create mode 100644 arch/riscv/include/asm/mmzone.h
create mode 100644 arch/riscv/include/asm/numa.h
rename arch/arm64/mm/numa.c => drivers/base/arch_numa.c (95%)
create mode 100644 include/asm-generic/numa.h

--
2.25.1

