Return-Path: <linux-arch+bounces-6072-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3843949FE9
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2024 08:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3822869CD
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2024 06:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6F61B86C1;
	Wed,  7 Aug 2024 06:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5xaR0Xj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C951E1B582B;
	Wed,  7 Aug 2024 06:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723012893; cv=none; b=BJo4TpI17SYFqpfayRdevw0RYetMPTQHV04FgpNbleBVi232AuvhJ7nlAD0JSsja2HqZoisJZ8rpdbA6y4Z8LrOy9ltTbNHimxmxks85UuYgEWSn/o75FRQafp8OshGMYEYRhSERuZjcWU3uvBU6c7cu5f/pscY3e9hCQa9uSuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723012893; c=relaxed/simple;
	bh=ekzPfVl6JUXBDUwMJIaEPIWAIu+cM3hN3EuU2UBIi6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tEO62hp9lrQgoHBTixRhhPLg/07/HSAEQkR39bZJptMFB6RyQIdIwBdqIsq/P0Dcdn0NP33mDkSlXKdHSmrOQpqMAVr3umBCIHOCCZgvZDdLFwgUwYDo/Pbe8tTjevidshe2ol9nNu99ZsilTr4ims1oBjIc3oQFb8ohcoHiPis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5xaR0Xj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193B0C4AF0D;
	Wed,  7 Aug 2024 06:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723012892;
	bh=ekzPfVl6JUXBDUwMJIaEPIWAIu+cM3hN3EuU2UBIi6o=;
	h=From:To:Cc:Subject:Date:From;
	b=i5xaR0Xjor2iyXJoWhbLsEHW4Ku6O7Dd6qrMQxxgAcH1SccxyADo98ywIyKYJR8k9
	 20+CT+TDOLQkIBIRljAxLodviCKZwl+Tjenp8Hg3FsjwqIBASEEyw95p/MQ+Kwa2hD
	 K/AQ7X1PAebJFnM4ZxDy9NsAx0F2ogCshfQPPvnX/Fa4KCd61KHduvt9p379YSuu0a
	 mYVg94mMcw+cqkcJni+PXcYFeG3q4+/s0VzEK4gVBPePuOr+f4dfNyCaZ1tLCZcMXj
	 uAlKNXTwtIRegTPBFSA5vbMNarA8L2sX9d1Ll8e+UtX5cfDeF1FrCKLLF2u6OpbL9/
	 hbcfDeDq7zjIw==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Will Deacon <will@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	nvdimm@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v4 00/26] mm: introduce numa_memblks
Date: Wed,  7 Aug 2024 09:40:44 +0300
Message-ID: <20240807064110.1003856-1-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

Following the discussion about handling of CXL fixed memory windows on
arm64 [1] I decided to bite the bullet and move numa_memblks from x86 to
the generic code so they will be available on arm64/riscv and maybe on
loongarch sometime later.

While it could be possible to use memblock to describe CXL memory windows,
it currently lacks notion of unpopulated memory ranges and numa_memblks
does implement this.

Another reason to make numa_memblks generic is that both arch_numa (arm64
and riscv) and loongarch use trimmed copy of x86 code although there is no
fundamental reason why the same code cannot be used on all these platforms.
Having numa_memblks in mm/ will make it's interaction with ACPI and FDT
more consistent and I believe will reduce maintenance burden.

And with generic numa_memblks it is (almost) straightforward to enable NUMA
emulation on arm64 and riscv.

The first 9 commits in this series are cleanups that are not strictly
related to numa_memblks.
Commits 10-16 slightly reorder code in x86 to allow extracting numa_memblks
and NUMA emulation to the generic code.
Commits 17-19 actually move the code from arch/x86/ to mm/ and commits 20-22
does some aftermath cleanups.
Commit 23 updates of_numa_init() to return error of no NUMA nodes were
found in the device tree.
Commit 24 switches arch_numa to numa_memblks.
Commit 25 enables usage of phys_to_target_node() and
memory_add_physaddr_to_nid() with numa_memblks.
Commit 26 moves the description for numa=fake from x86 to admin-guide.

[1] https://lore.kernel.org/all/20240529171236.32002-1-Jonathan.Cameron@huawei.com/

v3: https://lore.kernel.org/all/20240801060826.559858-1-rppt@kernel.org
* update allocation of offline node, thanks Jonathan
* add comment about dependency of get_pfn_range_for_nid on
  memblock_set_node(), per Dan
* fix build errros with 32-bit phys_address_t reported by kbuild
* add Acked- and Reviewed-by, thanks Dan and David

v2: https://lore.kernel.org/all/20240723064156.4009477-1-rppt@kernel.org
* rebase on v6.11-rc1
* fix dummy_numa_init() in arch_numa, thanks Zi Yan
* update of_numa_init() to return error of no NUMA nodes were
* add Tested-by, thanks Zi Yan

v1: https://lore.kernel.org/all/20240716111346.3676969-1-rppt@kernel.org
* add cleanup for arch_alloc_nodedata and HAVE_ARCH_NODEDATA_EXTENSION
* add patch that moves description of numa=fake kernel parameter from
  x86 to admin-guide
* reduce rounding up of node_data allocations from PAGE_SIZE to
  SMP_CACHE_BYTES
* restore single allocation attempt of numa_distance
* fix several comments
* added review tags

Mike Rapoport (Microsoft) (26):
  mm: move kernel/numa.c to mm/
  MIPS: sgi-ip27: make NODE_DATA() the same as on all other architectures
  MIPS: sgi-ip27: ensure node_possible_map only contains valid nodes
  MIPS: sgi-ip27: drop HAVE_ARCH_NODEDATA_EXTENSION
  MIPS: loongson64: rename __node_data to node_data
  MIPS: loongson64: drop HAVE_ARCH_NODEDATA_EXTENSION
  arch, mm: move definition of node_data to generic code
  mm: drop CONFIG_HAVE_ARCH_NODEDATA_EXTENSION
  arch, mm: pull out allocation of NODE_DATA to generic code
  x86/numa: simplify numa_distance allocation
  x86/numa: use get_pfn_range_for_nid to verify that node spans memory
  x86/numa: move FAKE_NODE_* defines to numa_emu
  x86/numa_emu: simplify allocation of phys_dist
  x86/numa_emu: split __apicid_to_node update to a helper function
  x86/numa_emu: use a helper function to get MAX_DMA32_PFN
  x86/numa: numa_{add,remove}_cpu: make cpu parameter unsigned
  mm: introduce numa_memblks
  mm: move numa_distance and related code from x86 to numa_memblks
  mm: introduce numa_emulation
  mm: numa_memblks: introduce numa_memblks_init
  mm: numa_memblks: make several functions and variables static
  mm: numa_memblks: use memblock_{start,end}_of_DRAM() when sanitizing
    meminfo
  of, numa: return -EINVAL when no numa-node-id is found
  arch_numa: switch over to numa_memblks
  mm: make range-to-target_node lookup facility a part of numa_memblks
  docs: move numa=fake description to kernel-parameters.txt

 .../admin-guide/kernel-parameters.txt         |  15 +
 .../arch/x86/x86_64/boot-options.rst          |  12 -
 arch/arm64/include/asm/Kbuild                 |   1 +
 arch/arm64/include/asm/mmzone.h               |  13 -
 arch/arm64/include/asm/topology.h             |   1 +
 arch/loongarch/include/asm/Kbuild             |   1 +
 arch/loongarch/include/asm/mmzone.h           |  16 -
 arch/loongarch/include/asm/topology.h         |   1 +
 arch/loongarch/kernel/numa.c                  |  21 -
 arch/mips/Kconfig                             |   5 -
 arch/mips/include/asm/mach-ip27/mmzone.h      |   1 -
 .../mips/include/asm/mach-loongson64/mmzone.h |   4 -
 arch/mips/loongson64/numa.c                   |  28 +-
 arch/mips/sgi-ip27/ip27-memory.c              |  12 +-
 arch/mips/sgi-ip27/ip27-smp.c                 |   2 +
 arch/powerpc/include/asm/mmzone.h             |   6 -
 arch/powerpc/mm/numa.c                        |  26 +-
 arch/riscv/include/asm/Kbuild                 |   1 +
 arch/riscv/include/asm/mmzone.h               |  13 -
 arch/riscv/include/asm/topology.h             |   4 +
 arch/s390/include/asm/Kbuild                  |   1 +
 arch/s390/include/asm/mmzone.h                |  17 -
 arch/s390/kernel/numa.c                       |   3 -
 arch/sh/include/asm/mmzone.h                  |   3 -
 arch/sh/mm/init.c                             |   7 +-
 arch/sh/mm/numa.c                             |   3 -
 arch/sparc/include/asm/mmzone.h               |   4 -
 arch/sparc/mm/init_64.c                       |  11 +-
 arch/x86/Kconfig                              |   9 +-
 arch/x86/include/asm/Kbuild                   |   1 +
 arch/x86/include/asm/mmzone.h                 |   6 -
 arch/x86/include/asm/mmzone_32.h              |  17 -
 arch/x86/include/asm/mmzone_64.h              |  18 -
 arch/x86/include/asm/numa.h                   |  26 +-
 arch/x86/include/asm/sparsemem.h              |   9 -
 arch/x86/mm/Makefile                          |   1 -
 arch/x86/mm/amdtopology.c                     |   1 +
 arch/x86/mm/numa.c                            | 622 +-----------------
 arch/x86/mm/numa_internal.h                   |  24 -
 drivers/acpi/numa/srat.c                      |   1 +
 drivers/base/Kconfig                          |   1 +
 drivers/base/arch_numa.c                      | 224 ++-----
 drivers/cxl/Kconfig                           |   2 +-
 drivers/dax/Kconfig                           |   2 +-
 drivers/of/of_numa.c                          |   5 +-
 include/asm-generic/mmzone.h                  |   5 +
 include/asm-generic/numa.h                    |   6 +-
 include/linux/memory_hotplug.h                |  48 --
 include/linux/numa.h                          |   8 +
 include/linux/numa_memblks.h                  |  58 ++
 kernel/Makefile                               |   1 -
 kernel/numa.c                                 |  26 -
 mm/Kconfig                                    |  11 +
 mm/Makefile                                   |   3 +
 mm/mm_init.c                                  |  10 +-
 mm/numa.c                                     |  69 ++
 {arch/x86/mm => mm}/numa_emulation.c          |  42 +-
 mm/numa_memblks.c                             | 571 ++++++++++++++++
 58 files changed, 893 insertions(+), 1166 deletions(-)
 delete mode 100644 arch/arm64/include/asm/mmzone.h
 delete mode 100644 arch/loongarch/include/asm/mmzone.h
 delete mode 100644 arch/riscv/include/asm/mmzone.h
 delete mode 100644 arch/s390/include/asm/mmzone.h
 delete mode 100644 arch/x86/include/asm/mmzone.h
 delete mode 100644 arch/x86/include/asm/mmzone_32.h
 delete mode 100644 arch/x86/include/asm/mmzone_64.h
 create mode 100644 include/asm-generic/mmzone.h
 create mode 100644 include/linux/numa_memblks.h
 delete mode 100644 kernel/numa.c
 create mode 100644 mm/numa.c
 rename {arch/x86/mm => mm}/numa_emulation.c (94%)
 create mode 100644 mm/numa_memblks.c


base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
-- 
2.43.0


