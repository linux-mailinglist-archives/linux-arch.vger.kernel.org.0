Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B3D244F98
	for <lists+linux-arch@lfdr.de>; Fri, 14 Aug 2020 23:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgHNVs3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Aug 2020 17:48:29 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:25018 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgHNVs3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Aug 2020 17:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597441709; x=1628977709;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cVOIibxYR9Eik4Y9Pl2EwMku9T0o7D2+6lin3phBclo=;
  b=FG5nEySERNmFp5kwAvGMVTTNp7ZpYZp1rgelmKtvfAfV1OoVmhN+TDfY
   XzLTbEb+rFiR25Uu6Rug4ICVz3IV3NQcWswyPTPQCfzZyFeth/crxBP7r
   ZaBaXDWGFq28NUtDLyiwKyfHssgTRIyHcRrUnbxn15aELvQrg634m+2si
   7cRGpOekgdMeJ2HyKSnPoBkkcyvs3fMJotOVAotsx5yZryQxfQ+Hhj+dt
   2FD56hnVS4ax7yZA4Lqs94qw1OcbrgS5sIa+ISXhkm1i5o/V5jEipYT3/
   2924s6SHuXy0IwQl/iAb7HCwJuT7P4i3w+9Hv5L/xrK29givVd1owaERx
   Q==;
IronPort-SDR: uaz3AsPiibnzMG4lKNuSzTpq85/u2UmElbIusb4i6FuntW1/zy5wECdAYMu23X2YIK7YBUWZYu
 gIx2S1/zuboJVRCr6u+ZSu7GSV9M/8gtXs+aJj18vTqmSCav+2RdFQUXjbXKZ8mheR6cDt7APR
 HhyOq98/drVjyzsXGbZnpsRBICOEMtqm5+aWhmXgSxcltFewtI+8G71wREmCUXT0LWfKB8zYTN
 m/EgRie9ynIVkcrruSIc1YwjvdNSZINrCLcKpMAl+LZoR6px3cBRr4OXN5xioYBNY8/lKWdssc
 5zk=
X-IronPort-AV: E=Sophos;i="5.76,313,1592841600"; 
   d="scan'208";a="146217638"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Aug 2020 05:48:29 +0800
IronPort-SDR: tb0HLr7vkTm0qkspYnA/OUpPeNPTXSliIXl2JnpgkxyCYHjwBA1hRO/hBRlYPRJemq8ATNEo54
 aoGBLcEjZFfg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 14:35:33 -0700
IronPort-SDR: l9oujh1ogNiL8KZfFqy7fwqsIfsdi8s8QR8PSME3DgGt+iLSNGkjDoL5CfDo85ewnW9Idf7xdE
 o8npwh7E+v9w==
WDCIronportException: Internal
Received: from cnf006060.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.56])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Aug 2020 14:48:26 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <Anup.Patel@wdc.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        Ganapatrao Kulkarni <gkulkarni@cavium.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC/RFT PATCH 0/6] Unify NUMA implementation between ARM64 & RISC-V
Date:   Fri, 14 Aug 2020 14:47:19 -0700
Message-Id: <20200814214725.28818-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
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

For RISC-V, the following qemu series is a pre-requisite to test the patches in Qemu.

https://patchwork.kernel.org/project/qemu-devel/list/?series=303313

The patches are also available at

https://github.com/atishp04/linux/tree/5.10_numa_unified

There may be some minor conflicts with Mike's cleanup series [2] depending on the
order in which these two series are being accepted. I can rebase on top his series
if required.

[2] https://lkml.org/lkml/2020/7/28/39

Atish Patra (5):
numa: Move numa implementation to common code
arm64, numa: Change the numa init function name to be generic
arm64, numa: Move pcibus_to_node definition to generic numa code
riscv: Separate memory init from paging init
riscv: Add numa support for riscv64 platform

Greentime Hu (1):
riscv: Add support pte_protnone and pmd_protnone if
CONFIG_NUMA_BALANCING

arch/arm64/Kconfig                            |  1 +
arch/arm64/include/asm/numa.h                 | 45 +---------------
arch/arm64/kernel/pci.c                       | 10 ----
arch/arm64/mm/Makefile                        |  1 -
arch/arm64/mm/init.c                          |  4 +-
arch/riscv/Kconfig                            | 31 ++++++++++-
arch/riscv/include/asm/mmzone.h               | 13 +++++
arch/riscv/include/asm/numa.h                 |  8 +++
arch/riscv/include/asm/pci.h                  | 10 ++++
arch/riscv/include/asm/pgtable.h              | 21 ++++++++
arch/riscv/kernel/setup.c                     | 12 ++++-
arch/riscv/kernel/smpboot.c                   | 12 ++++-
arch/riscv/mm/init.c                          | 10 +++-
drivers/base/Kconfig                          |  6 +++
drivers/base/Makefile                         |  1 +
.../mm/numa.c => drivers/base/arch_numa.c     | 19 ++++++-
include/asm-generic/numa.h                    | 51 +++++++++++++++++++
17 files changed, 190 insertions(+), 65 deletions(-)
create mode 100644 arch/riscv/include/asm/mmzone.h
create mode 100644 arch/riscv/include/asm/numa.h
rename arch/arm64/mm/numa.c => drivers/base/arch_numa.c (97%)
create mode 100644 include/asm-generic/numa.h

--
2.24.0

