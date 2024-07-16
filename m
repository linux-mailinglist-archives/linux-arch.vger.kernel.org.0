Return-Path: <linux-arch+bounces-5405-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A139324AE
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2024 13:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9441C20BE0
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2024 11:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A131990CF;
	Tue, 16 Jul 2024 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0VhN6dJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969EB196C7C;
	Tue, 16 Jul 2024 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721128446; cv=none; b=PGmDqMMbtRy9CAWz7D1zktLqh1NaOcCne1iZTw5GPB/+LfyMPhMWyB0wW6640ARlSHo97dYKk4i4+YVbkI+wuABOVJj0vE5nFdAwOBy6AB2kwGDNTMKmMG76ehF1ec+RDuLV3AXkQ8u9Xb3H9s6+1Aodp0jlTAEAeg7fV9H1DAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721128446; c=relaxed/simple;
	bh=if+tcTirPJEjQZ9+hNu3pbhZeoosE+eYDqBL2iUCmhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rHy1+azpywQVftRFwwIaCKDX/5CtPveQ5O7R0NTs8TBe4J5CRr5eXXGb7qbbJSDcKL1ulgHrcaPPCMSIr7sArLtLSbJNFHHdT+3Kcuyk4R/GN5i3YA0wMHlizmy/ZhAZU8VIKqISD5UhBNfYEfdB3evuspQWQ7OySAM0i1nKDBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0VhN6dJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C31C116B1;
	Tue, 16 Jul 2024 11:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721128446;
	bh=if+tcTirPJEjQZ9+hNu3pbhZeoosE+eYDqBL2iUCmhY=;
	h=From:To:Cc:Subject:Date:From;
	b=X0VhN6dJqtR1KjO/1/PYElok6T5zjLlAKyzAypL4irsN/XbVAZy4V4Ko34zh46mCO
	 InPiqKaVQ28tbxcwQ4aVimRVIlcIG7FVByt+0X2HkmQfxKOSXpmdUg7tVXXoPVH3O7
	 BbMLzCEmNdPLheUOe2MVcpjILhanEbMxkyz6KTiQZpDiolKr6j+cpBRJ2wk7C/sjqQ
	 hk60jD7l8cR3gBkksbgwjOCoU9d6TY2/m3y2t9kHZ617IrSe3LuiYwKTxaVw+SfXFM
	 /XDwcDu/Py0vDadDsPVCXJ0VUNSQL7zgFwuHdJEjuK5Diy7HEvAJBTt1a5YVs8Sy7X
	 kjipDXq1Ftupw==
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH 00/17] mm: introduce numa_memblks
Date: Tue, 16 Jul 2024 14:13:29 +0300
Message-ID: <20240716111346.3676969-1-rppt@kernel.org>
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

The first 5 commits in this series are cleanups that are not strictly
related to numa_memblks.

Commits 6-11 slightly reorder code in x86 to allow extracting numa_memblks
and NUMA emulation to the generic code.

Commits 12-14 actually move the code from arch/x86/ to mm/ and commit 15
does some aftermath cleanups.

Commit 16 switches arch_numa to numa_memblks.

Commit 17 enables usage of phys_to_target_node() and
memory_add_physaddr_to_nid() with numa_memblks.

[1] https://lore.kernel.org/all/20240529171236.32002-1-Jonathan.Cameron@huawei.com/

Mike Rapoport (Microsoft) (17):
  mm: move kernel/numa.c to mm/
  MIPS: sgi-ip27: make NODE_DATA() the same as on all other
    architectures
  MIPS: loongson64: rename __node_data to node_data
  arch, mm: move definition of node_data to generic code
  arch, mm: pull out allocation of NODE_DATA to generic code
  x86/numa: simplify numa_distance allocation
  x86/numa: move FAKE_NODE_* defines to numa_emu
  x86/numa_emu: simplify allocation of phys_dist
  x86/numa_emu: split __apicid_to_node update to a helper function
  x86/numa_emu: use a helper function to get MAX_DMA32_PFN
  x86/numa: numa_{add,remove}_cpu: make cpu parameter unsigned
  mm: introduce numa_memblks
  mm: move numa_distance and related code from x86 to numa_memblks
  mm: introduce numa_emulation
  mm: make numa_memblks more self-contained
  arch_numa: switch over to numa_memblks
  mm: make range-to-target_node lookup facility a part of numa_memblks

 arch/arm64/include/asm/Kbuild                 |   1 +
 arch/arm64/include/asm/mmzone.h               |  13 -
 arch/arm64/include/asm/topology.h             |   1 +
 arch/loongarch/include/asm/Kbuild             |   1 +
 arch/loongarch/include/asm/mmzone.h           |  16 -
 arch/loongarch/include/asm/topology.h         |   1 +
 arch/loongarch/kernel/numa.c                  |  21 -
 arch/mips/include/asm/mach-ip27/mmzone.h      |   1 -
 .../mips/include/asm/mach-loongson64/mmzone.h |   4 -
 arch/mips/loongson64/numa.c                   |  20 +-
 arch/mips/sgi-ip27/ip27-memory.c              |   2 +-
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
 arch/x86/include/asm/numa.h                   |  24 +-
 arch/x86/include/asm/sparsemem.h              |   9 -
 arch/x86/mm/Makefile                          |   1 -
 arch/x86/mm/amdtopology.c                     |   1 +
 arch/x86/mm/numa.c                            | 618 +-----------------
 arch/x86/mm/numa_internal.h                   |  24 -
 drivers/acpi/numa/srat.c                      |   1 +
 drivers/base/Kconfig                          |   1 +
 drivers/base/arch_numa.c                      | 223 ++-----
 drivers/cxl/Kconfig                           |   2 +-
 drivers/dax/Kconfig                           |   2 +-
 drivers/of/of_numa.c                          |   1 +
 include/asm-generic/mmzone.h                  |   5 +
 include/asm-generic/numa.h                    |   6 +-
 include/linux/numa.h                          |   5 +
 include/linux/numa_memblks.h                  |  58 ++
 kernel/Makefile                               |   1 -
 kernel/numa.c                                 |  26 -
 mm/Kconfig                                    |  11 +
 mm/Makefile                                   |   3 +
 mm/numa.c                                     |  57 ++
 {arch/x86/mm => mm}/numa_emulation.c          |  42 +-
 mm/numa_memblks.c                             | 565 ++++++++++++++++
 52 files changed, 847 insertions(+), 1070 deletions(-)
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


base-commit: 22a40d14b572deb80c0648557f4bd502d7e83826
-- 
2.43.0


