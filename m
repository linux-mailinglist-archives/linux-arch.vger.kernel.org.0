Return-Path: <linux-arch+bounces-7445-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E42B98680F
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 23:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76E241C2180A
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 21:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5A915E5B5;
	Wed, 25 Sep 2024 21:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFMABg80"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FA715B992;
	Wed, 25 Sep 2024 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727298431; cv=none; b=V8qF3xvD0vs/pVH3sALoxXBCDgYAAEVjS5FtWHswKG7SZ6Ckg588AW3eJZCqiSwNanG/qaMPUPgDNGhSFX+evAP0FbQPyTmvCDi/SnGmm9E1wAnvbHGoup5SFytMGJY/ZWyQbc+98tEg+A7Azfjo/E50LQ0oxdL0OfKfVghxDKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727298431; c=relaxed/simple;
	bh=9WWq9eu7cuIVH7faIexy4b1QmBlJqq/TWxw3ZIHVjt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b0l00+G3IW9+qfZLkTKZQi4ptSZAGPUzp/OjbSQ7dpzN4dKD3rQutyIld+0du3wslfnReujCddSNB8fplRvLG4QCM5pysRaA9of7Iea3io0HAQovTVaKkrkaffO4DDeXS6M510PgiI5YX591VUPWLna/p1VIuNScv2DUnN4qa5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFMABg80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44A1C4CECF;
	Wed, 25 Sep 2024 21:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727298431;
	bh=9WWq9eu7cuIVH7faIexy4b1QmBlJqq/TWxw3ZIHVjt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RFMABg80UAzlZRGWyrqfIVrpC9pf+KZ7ccnvBYINSdZOE0vEoxMWceBAliZEcMTDW
	 RCpJv2VfcSBLoHeF7E0VDAWsrUKkSgwBOV+P/dVgyITQ122pl5kO5UEOgqjNQZdVfO
	 h4SNxxhIeb2DH76DzE4IlhLrg0T8UQo/j9VkVlXW+oUFymIn6rtT8GPYYlUEcZu7uZ
	 wqHhouBebch/JiLDf7+51e9ufJfgMu3DNhow/hM/VsMPDaC6oAMSQo6eXKF+wHEHKy
	 BbipYo1sQUC+mbsQHvc97qE69iXeCHgMwZE4eDvGEVZFYu6lq2naZhA8bXu43iX0nU
	 OKOKG0CyQpcrg==
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
Subject: [PATCH 4/5] asm-generic: use asm-generic/mman-common.h on parisc and alpha
Date: Wed, 25 Sep 2024 21:06:14 +0000
Message-Id: <20240925210615.2572360-5-arnd@kernel.org>
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

These two architectures each have their own set of MAP_* flags, like
powerpc, mips and others do. In addition, the msync() flags are also
different, here both define the same flags but in a different order.
Finally, alpha also has a custom MADV_DONTNEED flag for madvise.

Make the generic MADV_DONTNEED and MS_* definitions conditional on
them already being defined and then include the common header
header from both architectures, to remove the bulk of the contents.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/uapi/asm/mman.h     | 68 +++-----------------------
 arch/parisc/include/uapi/asm/mman.h    | 66 +------------------------
 include/uapi/asm-generic/mman-common.h |  5 ++
 3 files changed, 13 insertions(+), 126 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
index 1f1c03c047ce..fc8b74aa3f89 100644
--- a/arch/alpha/include/uapi/asm/mman.h
+++ b/arch/alpha/include/uapi/asm/mman.h
@@ -2,18 +2,6 @@
 #ifndef __ALPHA_MMAN_H__
 #define __ALPHA_MMAN_H__
 
-#define PROT_READ	0x1		/* page can be read */
-#define PROT_WRITE	0x2		/* page can be written */
-#define PROT_EXEC	0x4		/* page can be executed */
-#ifndef PROT_SEM /* different on mips and xtensa */
-#define PROT_SEM	0x8		/* page may be used for atomic ops */
-#endif
-/*			0x10		   reserved for arch-specific use */
-/*			0x20		   reserved for arch-specific use */
-#define PROT_NONE	0x0		/* page can not be accessed */
-#define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
-#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
-
 /* 0x01 - 0x03 are defined in linux/mman.h */
 #define MAP_TYPE	0x0f		/* Mask for type of mapping (OSF/1 is _wrong_) */
 #define MAP_FIXED	0x100		/* Interpret addr exactly */
@@ -43,62 +31,18 @@
 #define MCL_ONFAULT	32768		/* lock all pages that are faulted in */
 
 /*
- * Flags for mlock
- */
-#define MLOCK_ONFAULT	0x01		/* Lock pages in range after they are faulted in, do not prefault */
-
-/*
- * Flags for msync
+ * Flags for msync, order is different from all others
  */
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_SYNC		2		/* synchronous memory sync */
 #define MS_INVALIDATE	4		/* invalidate the caches */
 
-#define MADV_NORMAL	0		/* no further special treatment */
-#define MADV_RANDOM	1		/* expect random page references */
-#define MADV_SEQUENTIAL	2		/* expect sequential page references */
-#define MADV_WILLNEED	3		/* will need these pages */
-#define MADV_DONTNEED	6		/* don't need these pages */
+/*
+ * Flags for madvise, 1 through 3 are normal
+ */
 /* originally MADV_SPACEAVAIL 5 */
+#define MADV_DONTNEED	6		/* don't need these pages */
 
-/* common parameters: try to keep these consistent across architectures */
-#define MADV_FREE	8		/* free pages only if memory pressure */
-#define MADV_REMOVE	9		/* remove these pages & resources */
-#define MADV_DONTFORK	10		/* don't inherit across fork */
-#define MADV_DOFORK	11		/* do inherit across fork */
-
-#define MADV_MERGEABLE   12		/* KSM may merge identical pages */
-#define MADV_UNMERGEABLE 13		/* KSM may not merge identical pages */
-
-#define MADV_HUGEPAGE	14		/* Worth backing with hugepages */
-#define MADV_NOHUGEPAGE	15		/* Not worth backing with hugepages */
-
-#define MADV_DONTDUMP   16		/* Explicity exclude from the core dump,
-					   overrides the coredump filter bits */
-#define MADV_DODUMP	17		/* Clear the MADV_DONTDUMP flag */
-
-#define MADV_WIPEONFORK 18		/* Zero memory on fork, child only */
-#define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
-
-#define MADV_COLD	20		/* deactivate these pages */
-#define MADV_PAGEOUT	21		/* reclaim these pages */
-
-#define MADV_POPULATE_READ	22	/* populate (prefault) page tables readable */
-#define MADV_POPULATE_WRITE	23	/* populate (prefault) page tables writable */
-
-#define MADV_DONTNEED_LOCKED	24	/* like DONTNEED, but drop locked pages too */
-
-#define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
-
-#define MADV_HWPOISON	100		/* poison a page for testing */
-#define MADV_SOFT_OFFLINE 101		/* soft offline page for testing */
-
-/* compatibility flags */
-#define MAP_FILE	0
-
-#define PKEY_DISABLE_ACCESS	0x1
-#define PKEY_DISABLE_WRITE	0x2
-#define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
-				 PKEY_DISABLE_WRITE)
+#include <asm-generic/mman-common.h>
 
 #endif /* __ALPHA_MMAN_H__ */
diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
index 1cd5d816d4cf..3732950a5cd8 100644
--- a/arch/parisc/include/uapi/asm/mman.h
+++ b/arch/parisc/include/uapi/asm/mman.h
@@ -2,19 +2,6 @@
 #ifndef __PARISC_MMAN_H__
 #define __PARISC_MMAN_H__
 
-
-#define PROT_READ	0x1		/* page can be read */
-#define PROT_WRITE	0x2		/* page can be written */
-#define PROT_EXEC	0x4		/* page can be executed */
-#ifndef PROT_SEM /* different on mips and xtensa */
-#define PROT_SEM	0x8		/* page may be used for atomic ops */
-#endif
-/*			0x10		   reserved for arch-specific use */
-/*			0x20		   reserved for arch-specific use */
-#define PROT_NONE	0x0		/* page can not be accessed */
-#define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
-#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
-
 /* 0x01 - 0x03 are defined in linux/mman.h */
 #define MAP_TYPE	0x2b		/* Mask for type of mapping, includes bits 0x08 and 0x20 */
 #define MAP_FIXED	0x04		/* Interpret addr exactly */
@@ -43,61 +30,12 @@
 #define MCL_ONFAULT	4		/* lock all pages that are faulted in */
 
 /*
- * Flags for mlock
- */
-#define MLOCK_ONFAULT	0x01		/* Lock pages in range after they are faulted in, do not prefault */
-
-/*
- * Flags for msync
+ * Flags for msync, order is different from all others
  */
 #define MS_SYNC		1		/* synchronous memory sync */
 #define MS_ASYNC	2		/* sync memory asynchronously */
 #define MS_INVALIDATE	4		/* invalidate the caches */
 
-#define MADV_NORMAL	0		/* no further special treatment */
-#define MADV_RANDOM	1		/* expect random page references */
-#define MADV_SEQUENTIAL	2		/* expect sequential page references */
-#define MADV_WILLNEED	3		/* will need these pages */
-#define MADV_DONTNEED	4		/* don't need these pages */
-
-/* common parameters: try to keep these consistent across architectures */
-#define MADV_FREE	8		/* free pages only if memory pressure */
-#define MADV_REMOVE	9		/* remove these pages & resources */
-#define MADV_DONTFORK	10		/* don't inherit across fork */
-#define MADV_DOFORK	11		/* do inherit across fork */
-
-#define MADV_MERGEABLE   12		/* KSM may merge identical pages */
-#define MADV_UNMERGEABLE 13		/* KSM may not merge identical pages */
-
-#define MADV_HUGEPAGE	14		/* Worth backing with hugepages */
-#define MADV_NOHUGEPAGE	15		/* Not worth backing with hugepages */
-
-#define MADV_DONTDUMP   16		/* Explicity exclude from the core dump,
-					   overrides the coredump filter bits */
-#define MADV_DODUMP	17		/* Clear the MADV_DONTDUMP flag */
-
-#define MADV_WIPEONFORK 18		/* Zero memory on fork, child only */
-#define MADV_KEEPONFORK 19		/* Undo MADV_WIPEONFORK */
-
-#define MADV_COLD	20		/* deactivate these pages */
-#define MADV_PAGEOUT	21		/* reclaim these pages */
-
-#define MADV_POPULATE_READ	22	/* populate (prefault) page tables readable */
-#define MADV_POPULATE_WRITE	23	/* populate (prefault) page tables writable */
-
-#define MADV_DONTNEED_LOCKED	24	/* like DONTNEED, but drop locked pages too */
-
-#define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
-
-#define MADV_HWPOISON	100		/* poison a page for testing */
-#define MADV_SOFT_OFFLINE 101		/* soft offline page for testing */
-
-/* compatibility flags */
-#define MAP_FILE	0
-
-#define PKEY_DISABLE_ACCESS	0x1
-#define PKEY_DISABLE_WRITE	0x2
-#define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
-				 PKEY_DISABLE_WRITE)
+#include <asm-generic/mman-common.h>
 
 #endif /* __PARISC_MMAN_H__ */
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 2911dd14ef2a..81a14ed99197 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -27,15 +27,20 @@
 /*
  * Flags for msync
  */
+#ifndef MS_ASYNC /* different order on alpha and parisc */
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
 #define MS_SYNC		4		/* synchronous memory sync */
+#endif
 
 #define MADV_NORMAL	0		/* no further special treatment */
 #define MADV_RANDOM	1		/* expect random page references */
 #define MADV_SEQUENTIAL	2		/* expect sequential page references */
 #define MADV_WILLNEED	3		/* will need these pages */
+/* 4 through 6 are different on alpha */
+#ifndef MADV_DONTNEED
 #define MADV_DONTNEED	4		/* don't need these pages */
+#endif
 
 /* common parameters: try to keep these consistent across architectures */
 #define MADV_FREE	8		/* free pages only if memory pressure */
-- 
2.39.2


