Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744F226770D
	for <lists+linux-arch@lfdr.de>; Sat, 12 Sep 2020 03:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgILBeq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Sep 2020 21:34:46 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:13347 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgILBep (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Sep 2020 21:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599874486; x=1631410486;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i2IoWykb7HuBzS5tSv/XkodyucYzXuuq1LC24xxJfzE=;
  b=MXYSmVSqFyQqh2s9bSwOob2T56JrY/AZRshAt6C5cGrgUMprFwXoPuC6
   ZUkRQjLLosrRGZynV2qMhCdiferwO2mz94zlGQSjwLDv6x5D91i4mE8P7
   JpC0WOnKv7DBNtE328Ls4Oamj2KvHI4ea95OZvzhaFzCeLNvRIzv6o/lL
   k65e54xESuWXS+vIs2CiJDn1sj3SVlnDucA8lPpkNgl1MqqJJKRkbiru9
   9VUItaszdnovs3DVENr9qH+YexlILBru5Ai69UCNx7odnB7c2bmmwjosx
   LEnCI6TQsoFA7zXHqmm8v48qjLdickhoEYfUQVWDmzchCdziUCWUcDucA
   Q==;
IronPort-SDR: llayjaIceSywu6qdGg9qiznT0rnktLQeCMPWrdeM95a3gzhyYFSkKy4Ucl12GG4AcHEDxEsmyv
 COoioRpzFb7dpEfPdV0qND/6FVq174UkkJ0SMHLt6DlO2ni/y1qpydtzeteAjb5OwE0NVdZxV0
 1dOYqtHQVSpypk4ZFiuK6os4weBGw8bTBI3pDj+e1twfbvPQOq0RV3jDXZRC5e8Q/9NX/66gUd
 uplBTKEOKa+7QOUqrVpUWGS9pxTFy98TKQ+Pc3jCixZem82mDH03lpZ1jcDoagUhxBC3uqYtAZ
 n8M=
X-IronPort-AV: E=Sophos;i="5.76,418,1592841600"; 
   d="scan'208";a="147177944"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2020 09:34:46 +0800
IronPort-SDR: HLQv8Uct4vn23nRbQfCpCiQqBw8MSu8MjmnXLxsXbH6AqQnFE1AyNMrkXm6yYApGGQGezxMp4k
 DEYvLw59ZORg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 18:21:59 -0700
IronPort-SDR: qY7VYxrseh/RhlJyz0RffEAYIQCptuw4PxQZLocbWF4FJBaQ1dwdimjIbbFKG27t6x/UoB0VY3
 Phe+TTHjGIXA==
WDCIronportException: Internal
Received: from unknown (HELO jedi-01.hgst.com) ([10.86.59.229])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 18:34:44 -0700
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
        Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jia He <justin.he@arm.com>, linux-arch@vger.kernel.org,
        linux-riscv@lists.infradead.org, Mike Rapoport <rppt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC/RFT PATCH v2 0/5] Unify NUMA implementation between ARM64 & RISC-V
Date:   Fri, 11 Sep 2020 18:34:36 -0700
Message-Id: <20200912013441.9730-1-atish.patra@wdc.com>
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

For RISC-V, the following qemu series is a pre-requisite(already available in upstream)
to test the patches in Qemu and 2 socket OmniXtend FPGA.

https://patchwork.kernel.org/project/qemu-devel/list/?series=303313

The patches are also available at

https://github.com/atishp04/linux/tree/5.10_numa_unified_v2

There may be some minor conflicts with Mike's cleanup series [2] depending on the
order in which these two series are being accepted. I can rebase on top his series
if required.

[2] https://lkml.org/lkml/2020/8/18/754

Atish Patra (4):
numa: Move numa implementation to common code
arm64, numa: Change the numa init function name to be generic
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
.../mm/numa.c => drivers/base/arch_numa.c     | 29 +++++++++--
include/asm-generic/numa.h                    | 49 +++++++++++++++++++
17 files changed, 200 insertions(+), 69 deletions(-)
create mode 100644 arch/riscv/include/asm/mmzone.h
create mode 100644 arch/riscv/include/asm/numa.h
rename arch/arm64/mm/numa.c => drivers/base/arch_numa.c (95%)
create mode 100644 include/asm-generic/numa.h

--
2.24.0

