Return-Path: <linux-arch+bounces-10722-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F21DA5F655
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 14:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5753A7E3D
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 13:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A667267B6A;
	Thu, 13 Mar 2025 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBWKPm/h"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0590A7603F;
	Thu, 13 Mar 2025 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873823; cv=none; b=G8lrQ7b3wuR43h2LgsUMdAd/itIPaD6reYek4Zbt2Bxg25pF9gVXAL9k+yWJV5kkQY05UJMcqtraRz3X5BpHto08lnq0PS6fQh2hGOYh2We35Dbi6vElnOu2GBopT20e+7OO1EGacoNT8DMpu0WMHQlbCj9Q/+CayW7B6sX4DOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873823; c=relaxed/simple;
	bh=62myLVbZVVZFvzPE89he3yMa/a5QAFc2vHsMKxeLVb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GIB9bRAf2ZokgW7BIFb32QXwx91mCHg7tLYfrP9Jo0aXmCfmZaonSxHU+w6M8rvQZmfEt/WK00DM7JPIcPBdwNmxF6zz6+9RApC1doafFEB/GYIcYlTxUtbhSlC7pHwOjSrrg6OTnZBf6L1VLiC0V6P0ThVhIZzhNy5Lqj60ZU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBWKPm/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C704BC4CEEA;
	Thu, 13 Mar 2025 13:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873822;
	bh=62myLVbZVVZFvzPE89he3yMa/a5QAFc2vHsMKxeLVb8=;
	h=From:To:Cc:Subject:Date:From;
	b=aBWKPm/h37x/i5+4FCPzxXZYbNjC4QtR+6/uzYQ4j82YaZ0nkwcNlRiBhZ3s4R+Lr
	 UbF6tAw/GLOmZOSjCm3jrX37f1OqnkT6FdjX3Szfhc1wjS/Zyf835B0imLzLMqYjcF
	 W5cI3ghKtUKRswhAYc77+5GSp1YmJnwSpf+x4AqcOGMZBAqFa6QHJIit/O7bFjGzmZ
	 g/lU9Dt6wqDCDU2wFqrq4LXF68UvvU/ytVgt54uUuF2Vagcx8WobuHEk6mGKRWMGKp
	 aLWh5ch4M9p8CvWw5jWVVvEJFFmiQHZ9S4CLDqJpDLqZJs/1wj2uAhd2lAzYblfH7W
	 BgZb5J0KHNyow==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Guo Ren <guoren@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH v2 00/13] arch, mm: reduce code duplication in mem_init()
Date: Thu, 13 Mar 2025 15:49:50 +0200
Message-ID: <20250313135003.836600-1-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

Every architecture has implementation of mem_init() function and some
even more than one. All these release free memory to the buddy
allocator, most of them set high_memory to the end of directly
addressable memory and many of them set max_mapnr for FLATMEM case.

These patches pull the commonalities into the generic code and refactor
some of the mem_init() implementations so that many of them can be just
dropped.

v2 changes:
* don't use generic version for setting high_memory on architectures
  that use that varialble earlier than free_area_init()
* use memblock_alloc_or_panig() to allocate zero pages on MIPS and s390
* fix alignment in allocation of zero pages on s390
* add Acked-by

v1: https://lore.kernel.org/all/20250306185124.3147510-1-rppt@kernel.org

Mike Rapoport (Microsoft) (13):
  arm: mem_init: use memblock_phys_free() to free DMA memory on SA1111
  csky: move setup_initrd() to setup.c
  hexagon: move initialization of init_mm.context init to paging_init()
  MIPS: consolidate mem_init() for NUMA machines
  MIPS: make setup_zero_pages() use memblock
  nios2: move pr_debug() about memory start and end to setup_arch()
  s390: make setup_zero_pages() use memblock
  xtensa: split out printing of virtual memory layout to a function
  arch, mm: set max_mapnr when allocating memory map for FLATMEM
  arch, mm: set high_memory in free_area_init()
  arch, mm: streamline HIGHMEM freeing
  arch, mm: introduce arch_mm_preinit
  arch, mm: make releasing of memory to page allocator more explicit

 arch/alpha/mm/init.c               |  8 ----
 arch/arc/mm/init.c                 | 25 +----------
 arch/arm/mm/init.c                 | 43 +------------------
 arch/arm64/mm/init.c               | 12 +-----
 arch/csky/kernel/setup.c           | 43 +++++++++++++++++++
 arch/csky/mm/init.c                | 67 ------------------------------
 arch/hexagon/mm/init.c             | 32 ++------------
 arch/loongarch/kernel/numa.c       |  6 ---
 arch/loongarch/mm/init.c           |  8 ----
 arch/m68k/mm/init.c                |  2 -
 arch/microblaze/mm/init.c          | 25 -----------
 arch/mips/include/asm/mmzone.h     |  2 -
 arch/mips/loongson64/numa.c        |  7 ----
 arch/mips/mm/init.c                | 51 ++++-------------------
 arch/mips/sgi-ip27/ip27-memory.c   |  9 ----
 arch/nios2/kernel/setup.c          |  3 +-
 arch/nios2/mm/init.c               | 16 +------
 arch/openrisc/mm/init.c            |  6 ---
 arch/parisc/mm/init.c              |  4 --
 arch/powerpc/kernel/setup-common.c |  2 -
 arch/powerpc/mm/mem.c              | 18 +-------
 arch/riscv/mm/init.c               |  5 +--
 arch/s390/mm/init.c                | 20 +--------
 arch/sh/mm/init.c                  | 10 -----
 arch/sparc/mm/init_32.c            | 31 +-------------
 arch/sparc/mm/init_64.c            |  4 --
 arch/um/include/shared/mem_user.h  |  1 -
 arch/um/kernel/mem.c               |  9 ++--
 arch/um/kernel/physmem.c           | 12 ------
 arch/um/kernel/um_arch.c           |  2 -
 arch/x86/include/asm/highmem.h     |  3 --
 arch/x86/include/asm/numa.h        |  4 --
 arch/x86/include/asm/numa_32.h     | 13 ------
 arch/x86/kernel/setup.c            |  2 -
 arch/x86/mm/Makefile               |  2 -
 arch/x86/mm/highmem_32.c           | 34 ---------------
 arch/x86/mm/init_32.c              | 41 ++----------------
 arch/x86/mm/init_64.c              |  7 ++--
 arch/x86/mm/numa_32.c              |  3 --
 arch/xtensa/mm/init.c              | 66 +++++++----------------------
 include/asm-generic/memory_model.h |  5 ++-
 include/linux/memblock.h           |  1 -
 include/linux/mm.h                 | 13 +-----
 mm/internal.h                      |  3 +-
 mm/memblock.c                      |  3 +-
 mm/memory.c                        | 16 -------
 mm/mm_init.c                       | 65 +++++++++++++++++++++++++----
 mm/nommu.c                         |  6 ---
 48 files changed, 158 insertions(+), 612 deletions(-)
 delete mode 100644 arch/x86/include/asm/numa_32.h
 delete mode 100644 arch/x86/mm/highmem_32.c


base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
-- 
2.47.2


