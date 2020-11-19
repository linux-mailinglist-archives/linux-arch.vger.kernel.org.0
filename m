Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98A52B8916
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 01:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgKSAih (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Nov 2020 19:38:37 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:49086 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgKSAih (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Nov 2020 19:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605746316; x=1637282316;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ff0Sftjg7u8VcDfJoP3445LCpQ0dbvEgLQGePuE2VOU=;
  b=a1aGayxmzj7JPq8DdOy7gRKVsNcAzZ3n5bvRgSnZJy8VFABhLrcAhwr8
   5i0WPmbHJMYvFI5HCpbKVwRdyNb0z12S1XFDOzayTNpxNUowUw8bgf9Ne
   O6ubmt7b0zGf/ynVLTsbvfJKF5T1rx9L3wpvQn1gLLc+xop6PVehm0pkO
   50FvwQF6mNaqRTnfaXFIQ80t2NrJ7jBn1j0WOQ60cwKFC15xmIvHdVc2k
   QnFET4x7VBTG5ZhczqQlM7MFbRcFSVtvR49a3M9c9EsOh6/6E2E2eiftT
   LaVBuUmiMfNGr+0RMVoeoaLzo8JWbodmqRKcALzd3kbZ8kcx26Ge1Gc6r
   w==;
IronPort-SDR: WmLSw/f6DcqlZ3T77+9sE7DK+N51b0snwmMnvWr51erZu8GjL90bltLwxmy5XpX1jo1Cf39yOC
 zH+moQEsk/XdxetebyoHOk2TXVLgHATNAqAx4T/JCh0KOC18mXXigeBRJTJRWhdQh2tz10QY0O
 +kLHjDnuEZ/qnwLNuajz4pTknnUQEP9aqVHpgr2bY7cRUl2Wn9Ozlh7IxNtPkRD0qTKWkffhia
 RLo9t71vkCIOLkO/CeDOTQuq1pWlaX2KUdc69IL8eNuSaF3TO1/wQdO3YgzxeOBnbImMxDbjsN
 v5U=
X-IronPort-AV: E=Sophos;i="5.77,488,1596470400"; 
   d="scan'208";a="262974322"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Nov 2020 08:38:35 +0800
IronPort-SDR: 95flkWwifur+Cn4hFq2OMEpFkdidgRRviELxWljV38s66if8CgrnbAtHmAt2CatQETE9pkzxhj
 beuE2O2nuS/o4iAEgwQv2K/NxLv4bnp+OIDDPXBa2/+/MgjY0ANcYr95Ye7kpuy0RvrhfvGtXR
 mwIlcyu/q7sNeEEcP8sCAB1fuWsUadW/ssWru5b9tSnwzpZt7yCHeGD5cSvHz1sDMpTdwRQ4+6
 jdZJjwvv6bBA2fctwqvIwd1ym0GuvpkLqBSrdj4i93gP62m7ONj0rOQjAVy6ohjX8JJ302b1BR
 sBxN5XowKSFevEN4ZxFrAmPs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 16:23:06 -0800
IronPort-SDR: t17QL4+3OacEm2ugsmhqCxFoCnuFeTaxOirT7uSgyxkksAzXqLXJiw2XBchqbwxpvy63lYrxEH
 XY82WWOGufFiCJDIX6Fh0sx8yrBdd2xfE7DZwY4g4Br/78QxYopWm5SEaleC+hO/OdOllBuBgf
 p+b3TUI3ygnlI6D0wHHh+enTpXPfkAkvHrrMg7y/SoJyvCJ9w9S0ZrC09PC3+DW8spf9HqSRaB
 1fX0vR3tpzf/LZR1/oDv+7wzztovDBUzxjShYlBwMLakAwjrO1mmkl0wJXre6XDVD8nwgdnQCM
 GKs=
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.61.71])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Nov 2020 16:38:34 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>,
        Zhengyuan Liu <liuzhengyuan@tj.kylinos.cn>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 0/5] Unify NUMA implementation between ARM64 & RISC-V
Date:   Wed, 18 Nov 2020 16:38:24 -0800
Message-Id: <20201119003829.1282810-1-atish.patra@wdc.com>
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
https://github.com/atishp04/linux/tree/5.11_numa_unified_v5

For RISC-V, the following qemu series is a pre-requisite(already available in upstream)
https://patchwork.kernel.org/project/qemu-devel/list/?series=303313

Testing:
RISC-V:
Tested in Qemu and 2 socket OmniXtend FPGA.

ARM64:
2 socket kunpeng920 (4 nodes around 250G a node)
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Changes from v4->v5:
1. Added by Acked-by & Reviewed-by tags.
2. Swapped patch 1 & 2 in v4 version.

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
arm64, numa: Change the numa init functions name to be generic
numa: Move numa implementation to common code
riscv: Separate memory init from paging init
riscv: Add numa support for riscv64 platform

Greentime Hu (1):
riscv: Add support pte_protnone and pmd_protnone if
CONFIG_NUMA_BALANCING

arch/arm64/Kconfig                            |  1 +
arch/arm64/include/asm/numa.h                 | 48 +----------------
arch/arm64/kernel/acpi_numa.c                 | 12 -----
arch/arm64/mm/Makefile                        |  1 -
arch/arm64/mm/init.c                          |  4 +-
arch/riscv/Kconfig                            | 31 ++++++++++-
arch/riscv/include/asm/mmzone.h               | 13 +++++
arch/riscv/include/asm/numa.h                 |  8 +++
arch/riscv/include/asm/pci.h                  | 14 +++++
arch/riscv/include/asm/pgtable.h              | 21 ++++++++
arch/riscv/kernel/setup.c                     | 11 +++-
arch/riscv/kernel/smpboot.c                   | 12 ++++-
arch/riscv/mm/init.c                          | 10 +++-
drivers/base/Kconfig                          |  6 +++
drivers/base/Makefile                         |  1 +
.../mm/numa.c => drivers/base/arch_numa.c     | 27 ++++++++--
include/asm-generic/numa.h                    | 52 +++++++++++++++++++
17 files changed, 200 insertions(+), 72 deletions(-)
create mode 100644 arch/riscv/include/asm/mmzone.h
create mode 100644 arch/riscv/include/asm/numa.h
rename arch/arm64/mm/numa.c => drivers/base/arch_numa.c (96%)
create mode 100644 include/asm-generic/numa.h

--
2.25.1

