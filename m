Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B175A284337
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 02:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgJFAR5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Oct 2020 20:17:57 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:18352 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgJFAR5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Oct 2020 20:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601943476; x=1633479476;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QAwKU8lAOts2CUnPA+WBIUI5CpZVX/yVSp78aPQvNQI=;
  b=EDxSkxFnMiaP2QAJDRxq738IKUlrxi8GF8ixzN8ajONqHdLh3uPcEFCj
   Sd3VBPAAkYqq2LvX5RMqLyxbV0BasdUffOdfgViS9eZXyLoRQGCt9OjKs
   5SY+ouh2LZOwstz/CcrwXfpsxI9LrhJ73sR4Pr648hDrVDQzplVQAkelp
   AIfxfOlpCXzPi/Gxtrj0NF/r4WMSGK0V1bxO+IXK8E0m8cObciES+rork
   STJHYHAmBpi8vkvJ5H3j6izxZ0bEcJk9zU9ogRyDUXHK5x4DzOTx7Ydt2
   AWgevJ3NbTaNScKmme/AFSedXha+zE/uJ36AUR6ad8jieZlezqw5iPAd9
   g==;
IronPort-SDR: Mh2S0aqrPpRr76sU2XIuAOO/AHAyrWWm4PVVafGsxAHZwHozeDhBHRteAmB8uKwmmmrEs8EpCI
 S7FGK0Dapx2TmawPhCvf4bzKNYmc1lBdAxeoitVkEe4KutUUZ+bZc3WVWXVx4WEQ+BSrJxkKtt
 VCWg+F+YmLR78MOOQadcHOs8Qghlz2sAbiAsMMxpLOlBUEXVFybxh3UeHti47Wxpn63WX6dzwe
 NP7Pl1PRl8wTcYivAL3virhY8NprdzaWk8gn4y68BMpWtI9fwGlJM3afn65MBkQwwJbzeC8IFi
 oJ8=
X-IronPort-AV: E=Sophos;i="5.77,341,1596470400"; 
   d="scan'208";a="149023388"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2020 08:17:56 +0800
IronPort-SDR: CuOLyGCnNjyKViZWrZPzXqFgImQKvokKVllYPnPp/rsiSBArv7eIzmuhJeO6zcu1KPtLviTYAL
 b4zXC1CWvg/Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 17:03:48 -0700
IronPort-SDR: Neg4gQXFt16GausLnkBfK7NTrO7uOhLbWHdiEHDf+HDtgOth4FjfITodd3H2Qum9/EAwzsM5gp
 ULdHQ5pTY/EA==
WDCIronportException: Internal
Received: from b9f8262.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.253])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Oct 2020 17:17:55 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <anup@brainfault.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jia He <justin.he@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mike Rapoport <rppt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/5] Unify NUMA implementation between ARM64 & RISC-V
Date:   Mon,  5 Oct 2020 17:17:47 -0700
Message-Id: <20201006001752.248564-1-atish.patra@wdc.com>
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

The patches are also available at
https://github.com/atishp04/linux/tree/5.10_numa_unified_v4

For RISC-V, the following qemu series is a pre-requisite(already available in upstream)
https://patchwork.kernel.org/project/qemu-devel/list/?series=303313

Testing:
RISC-V:
Tested in Qemu and 2 socket OmniXtend FPGA.

ARM64:
2 socket kunpeng920 (4 nodes around 250G a node)
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

There may be some minor conflicts with Mike's cleanup series [2] depending on the
order in which these two series are being accepted. I can rebase on top his series
if required.

[2] https://lkml.org/lkml/2020/8/18/754

Changes from v3->v4:
1. Removed redundant duplicate header.
2. Added Reviewed-by tags.

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
.../mm/numa.c => drivers/base/arch_numa.c     | 30 ++++++++++--
include/asm-generic/numa.h                    | 49 +++++++++++++++++++
17 files changed, 199 insertions(+), 71 deletions(-)
create mode 100644 arch/riscv/include/asm/mmzone.h
create mode 100644 arch/riscv/include/asm/numa.h
rename arch/arm64/mm/numa.c => drivers/base/arch_numa.c (95%)
create mode 100644 include/asm-generic/numa.h

--
2.25.1

