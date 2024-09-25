Return-Path: <linux-arch+bounces-7446-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE821986818
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 23:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807DD285206
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 21:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABF517D378;
	Wed, 25 Sep 2024 21:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqUeN44x"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1953117CA19;
	Wed, 25 Sep 2024 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727298439; cv=none; b=nBS/nO/X89/aU1Ko5lX+biC/big0sRQPycnYQ2NUrPgfNmEnbSp/DjX2M1+bxtaYJ8Kj9LKmTSGVhxgcfatBvhCiT8ndhSmAH4QVa2pEFusBjkpnQQ/8sMTQDj9f/vqGRcmRA1p1Uf9yvR1Pumg4AMbmHxHQti5WibGlrFXSGoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727298439; c=relaxed/simple;
	bh=ODTKCHXxIZE3eYSHvfpmzYWSeBfhCgyCnxo8sL2fUHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YEQ+D/HCZCKPiLT1yFnug4ix259hkY/FR9TiTnuel0p213KxE2YvA22sJf/NfFi05AlX/xOSoHh9tmwybIQZScWaMHMjJFvMCoQXC6jn3GkrQ2n1myfPgWE1GN1a7+bLEVdRZXqyf9he81ESY48R/7xI7dd+Xjy4R9dwz/0S9Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqUeN44x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93BAC4CEC3;
	Wed, 25 Sep 2024 21:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727298438;
	bh=ODTKCHXxIZE3eYSHvfpmzYWSeBfhCgyCnxo8sL2fUHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UqUeN44x2CyaBUPaNDkT98k6QN3VewzS7CUSKeQCD7Er05TZWE0qz2tzTPJ5xFD/o
	 SZdsfPJBUcVK4dRlnz8/NqnIbj/TOm7FASPiv+Zps96TFrJjYpEVq4XxK0nqdTGty8
	 cVz2cOJxhyz6vRclrGlh3FDM1KAMq5JWGh1Z3LYFBAgcqBisNYyEg6kxvm+G+h1/34
	 AKFLgqXcNy+hn1N/9l0tNjYChvvNXi0fQ3/AHQvp7aGYCZu8vedTaYrNErzVdPI0aH
	 yTvTayfqA+sFZUYQ+NLii51HXTvqMUHW975iSPHKFjGcwkF95HyatEteJJwpOUEYZt
	 xQwPkqnb9dgXw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Helge Deller <deller@gmx.de>,
	Kees Cook <kees@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arch@vger.kernel.org
Subject: [PATCH 5/5] [RFC] mm: Remove MAP_UNINITIALIZED support
Date: Wed, 25 Sep 2024 21:06:15 +0000
Message-Id: <20240925210615.2572360-6-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240925210615.2572360-1-arnd@kernel.org>
References: <20240925210615.2572360-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

MAP_UNINITIALIZED was added back in 2009 for NOMMU kernels, specifically
for blackfin, which is long gone. MAP_HUGE_SHIFT/MAP_HUGE_MASK were
added in 2012 for architectures supporting hugepages, which at the time
did not overlap with the ones supporting NOMMU.

Adding the macro under an #ifdef was obviously a mistake, which
Christoph Hellwig tried to address by making it unconditionally defined
to 0x4000000 as part of the series to support RISC-V NOMMU kernels. At
this point linux/mman.h contained two conflicting definitions for bit 26,
though the two are still mutually exclusive at runtime in all supported
configurations.

According to the commit 854e9ed09ded ("mm: support madvise(MADV_FREE)")
description, it was previously used internally by facebook, which
would have resulted in MAP_HUGE_1MB turning into MAP_HUGE_2MB
with MAP_UNINITIALIZED enabled, and every other page size implying
MAP_UNINITIALIZED. I assume there are no remaining out of tree users
on MMU-enabled kernels today.

I do not see any sensible way to redefine the macros for the ABI in
a way avoids breaking something. The only ideas so far are:

 - do nothing, try to document the bug, hope for the best

 - remove the kernel implementation and redefine MAP_UNINITIALIZED to
   zero in the header to silently turn it off for everyone. There are
   few NOMMU users left, and the ones that do use NOMMU usually turn
   off MMAP_ALLOW_UNINITIALIZED, as it still has the potential to cause
   bugs and even security issues on systems with a memory protection
   unit.

 - remove both the implementation and the macro to force a build
   failure for anyone trying to use the feature. This way we can
   see who complains and whether we need to put it back in some
   form or change the userspace sources to no longer pass the flag.

Implement the third option here for the sake of discussion.

Link: https://git.uclibc.org/uClibc/commit/libc/stdlib/malloc/malloc.c?id=00673f93826bf1f
Link: https://lore.kernel.org/lkml/20190610221621.10938-4-hch@lst.de/
Link: https://lore.kernel.org/lkml/1352157848-29473-1-git-send-email-andi@firstfloor.org/
Link: https://lore.kernel.org/lkml/1448865583-2446-2-git-send-email-minchan@kernel.org/
Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: Greg Ungerer <gerg@linux-m68k.org>
Cc: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/admin-guide/mm/nommu-mmap.rst | 10 ++--------
 arch/alpha/include/uapi/asm/mman.h          |  2 --
 arch/mips/include/uapi/asm/mman.h           |  2 --
 arch/parisc/include/uapi/asm/mman.h         |  2 --
 arch/powerpc/include/uapi/asm/mman.h        |  5 -----
 arch/sh/configs/rsk7264_defconfig           |  1 -
 arch/sparc/include/uapi/asm/mman.h          |  3 ---
 arch/xtensa/include/uapi/asm/mman.h         |  3 ---
 fs/binfmt_elf_fdpic.c                       |  3 +--
 include/linux/mman.h                        |  4 ----
 include/uapi/asm-generic/mman.h             |  4 ----
 mm/Kconfig                                  | 22 ---------------------
 mm/nommu.c                                  |  4 +---
 13 files changed, 4 insertions(+), 61 deletions(-)

diff --git a/Documentation/admin-guide/mm/nommu-mmap.rst b/Documentation/admin-guide/mm/nommu-mmap.rst
index 530fed08de2c..9434c2fa99ae 100644
--- a/Documentation/admin-guide/mm/nommu-mmap.rst
+++ b/Documentation/admin-guide/mm/nommu-mmap.rst
@@ -135,14 +135,8 @@ Further notes on no-MMU MMAP
      significant delays during a userspace malloc() as the C library does an
      anonymous mapping and the kernel then does a memset for the entire map.
 
-     However, for memory that isn't required to be precleared - such as that
-     returned by malloc() - mmap() can take a MAP_UNINITIALIZED flag to
-     indicate to the kernel that it shouldn't bother clearing the memory before
-     returning it.  Note that CONFIG_MMAP_ALLOW_UNINITIALIZED must be enabled
-     to permit this, otherwise the flag will be ignored.
-
-     uClibc uses this to speed up malloc(), and the ELF-FDPIC binfmt uses this
-     to allocate the brk and stack region.
+     Previously, Linux also supported a MAP_UNINITIALIZED flag to allocate
+     memory without clearing it, this is no longer support.
 
  (#) A list of all the private copy and anonymous mappings on the system is
      visible through /proc/maps in no-MMU mode.
diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
index fc8b74aa3f89..1099b17a4003 100644
--- a/arch/alpha/include/uapi/asm/mman.h
+++ b/arch/alpha/include/uapi/asm/mman.h
@@ -21,8 +21,6 @@
 /* MAP_SYNC not supported */
 #define MAP_FIXED_NOREPLACE	0x200000/* MAP_FIXED which doesn't unmap underlying mapping */
 
-/* MAP_UNINITIALIZED not supported */
-
 /*
  * Flags for mlockall
  */
diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
index 6deb62db90de..9463c9071268 100644
--- a/arch/mips/include/uapi/asm/mman.h
+++ b/arch/mips/include/uapi/asm/mman.h
@@ -31,8 +31,6 @@
 /* MAP_SYNC not supported */
 #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
 
-/* MAP_UNINITIALIZED not supported */
-
 /*
  * Flags for mlockall
  */
diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
index 3732950a5cd8..8d7f3a8912b3 100644
--- a/arch/parisc/include/uapi/asm/mman.h
+++ b/arch/parisc/include/uapi/asm/mman.h
@@ -20,8 +20,6 @@
 /* MAP_SYNC not supported */
 #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
 
-/* MAP_UNINITIALIZED not supported */
-
 /*
  * Flags for mlockall
  */
diff --git a/arch/powerpc/include/uapi/asm/mman.h b/arch/powerpc/include/uapi/asm/mman.h
index d57b347c37fe..48c734b4d201 100644
--- a/arch/powerpc/include/uapi/asm/mman.h
+++ b/arch/powerpc/include/uapi/asm/mman.h
@@ -33,11 +33,6 @@
 #define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
 #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
 
-#define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
-					 * uninitialized */
-
-
-
 #define MCL_CURRENT     0x2000          /* lock all currently mapped pages */
 #define MCL_FUTURE      0x4000          /* lock all additions to address space */
 #define MCL_ONFAULT	0x8000		/* lock all pages that are faulted in */
diff --git a/arch/sh/configs/rsk7264_defconfig b/arch/sh/configs/rsk7264_defconfig
index e4ef259425c4..86421e2fec10 100644
--- a/arch/sh/configs/rsk7264_defconfig
+++ b/arch/sh/configs/rsk7264_defconfig
@@ -12,7 +12,6 @@ CONFIG_KALLSYMS_ALL=y
 CONFIG_EXPERT=y
 CONFIG_PERF_COUNTERS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
-CONFIG_MMAP_ALLOW_UNINITIALIZED=y
 CONFIG_PROFILING=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
diff --git a/arch/sparc/include/uapi/asm/mman.h b/arch/sparc/include/uapi/asm/mman.h
index afb86698cdb1..e05ac492f9a8 100644
--- a/arch/sparc/include/uapi/asm/mman.h
+++ b/arch/sparc/include/uapi/asm/mman.h
@@ -30,9 +30,6 @@
 #define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
 #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
 
-#define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
-					 * uninitialized */
-
 #define MCL_CURRENT     0x2000          /* lock all currently mapped pages */
 #define MCL_FUTURE      0x4000          /* lock all additions to address space */
 #define MCL_ONFAULT	0x8000		/* lock all pages that are faulted in */
diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
index e713b8dc8587..6fdf9f3e587a 100644
--- a/arch/xtensa/include/uapi/asm/mman.h
+++ b/arch/xtensa/include/uapi/asm/mman.h
@@ -36,9 +36,6 @@
 /* MAP_SYNC not supported */
 #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
 
-#define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
-					 * uninitialized */
-
 /*
  * Flags for mlockall
  */
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 4fe5bb9f1b1f..82ba92d28ddf 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -418,8 +418,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 
 	current->mm->start_brk = vm_mmap(NULL, 0, stack_size, stack_prot,
 					 MAP_PRIVATE | MAP_ANONYMOUS |
-					 MAP_UNINITIALIZED | MAP_GROWSDOWN,
-					 0);
+					 MAP_GROWSDOWN, 0);
 
 	if (IS_ERR_VALUE(current->mm->start_brk)) {
 		retval = current->mm->start_brk;
diff --git a/include/linux/mman.h b/include/linux/mman.h
index bcb201ab7a41..f606b2264cc0 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -24,9 +24,6 @@
 #ifndef MAP_HUGE_1GB
 #define MAP_HUGE_1GB 0
 #endif
-#ifndef MAP_UNINITIALIZED
-#define MAP_UNINITIALIZED 0
-#endif
 #ifndef MAP_SYNC
 #define MAP_SYNC 0
 #endif
@@ -44,7 +41,6 @@
 		| MAP_ANONYMOUS \
 		| MAP_DENYWRITE \
 		| MAP_EXECUTABLE \
-		| MAP_UNINITIALIZED \
 		| MAP_GROWSDOWN \
 		| MAP_LOCKED \
 		| MAP_NORESERVE \
diff --git a/include/uapi/asm-generic/mman.h b/include/uapi/asm-generic/mman.h
index f26f9b4c03e1..541be26ad947 100644
--- a/include/uapi/asm-generic/mman.h
+++ b/include/uapi/asm-generic/mman.h
@@ -27,10 +27,6 @@
 #define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
 #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
 
-#define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
-					 * uninitialized */
-
-
 /*
  * Bits [26:31] are reserved, see asm-generic/hugetlb_encode.h
  * for MAP_HUGETLB usage
diff --git a/mm/Kconfig b/mm/Kconfig
index 09aebca1cae3..7326820ba200 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -381,28 +381,6 @@ config COMPAT_BRK
 
 	  On non-ancient distros (post-2000 ones) N is usually a safe choice.
 
-config MMAP_ALLOW_UNINITIALIZED
-	bool "Allow mmapped anonymous memory to be uninitialized"
-	depends on EXPERT && !MMU
-	default n
-	help
-	  Normally, and according to the Linux spec, anonymous memory obtained
-	  from mmap() has its contents cleared before it is passed to
-	  userspace.  Enabling this config option allows you to request that
-	  mmap() skip that if it is given an MAP_UNINITIALIZED flag, thus
-	  providing a huge performance boost.  If this option is not enabled,
-	  then the flag will be ignored.
-
-	  This is taken advantage of by uClibc's malloc(), and also by
-	  ELF-FDPIC binfmt's brk and stack allocator.
-
-	  Because of the obvious security issues, this option should only be
-	  enabled on embedded devices where you control what is run in
-	  userspace.  Since that isn't generally a problem on no-MMU systems,
-	  it is normally safe to say Y here.
-
-	  See Documentation/admin-guide/mm/nommu-mmap.rst for more information.
-
 config SELECT_MEMORY_MODEL
 	def_bool y
 	depends on ARCH_SELECT_MEMORY_MODEL
diff --git a/mm/nommu.c b/mm/nommu.c
index 385b0c15add8..793fa7303065 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1172,9 +1172,7 @@ unsigned long do_mmap(struct file *file,
 	add_nommu_region(region);
 
 	/* clear anonymous mappings that don't ask for uninitialized data */
-	if (!vma->vm_file &&
-	    (!IS_ENABLED(CONFIG_MMAP_ALLOW_UNINITIALIZED) ||
-	     !(flags & MAP_UNINITIALIZED)))
+	if (!vma->vm_file)
 		memset((void *)region->vm_start, 0,
 		       region->vm_end - region->vm_start);
 
-- 
2.39.2


