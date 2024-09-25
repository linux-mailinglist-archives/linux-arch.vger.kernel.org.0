Return-Path: <linux-arch+bounces-7443-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E18986801
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 23:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0949B1F216D7
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 21:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47622158553;
	Wed, 25 Sep 2024 21:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRpxihM2"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186F6158524;
	Wed, 25 Sep 2024 21:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727298417; cv=none; b=r5xNDCl0apffiCV8rGgGDik9WB9f0AUov2iq4tGFgLWgVXqD6t4aF8XLXN7OTv11M5RHHij5QoXm04upzfj4LAZjcfoFIsYWwcTCwf997A+uduNVp4BSZa+XrRhnpOllChubWZD+qDhWMJq99pwHG0FoepH9hNirLXV1HFN6tYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727298417; c=relaxed/simple;
	bh=aDTBkkmG/d5Qp4dQ7xLc1aEeqRGIp1tx3y3paI2l9us=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QzaJvpR2rCBicsNG/o+W81j21xgCcqk0Ia9pKgde0TsdVGAgetaq8CIBY6K/1g5dFP/KDeGUIyGw1k44/ss9qZlzDjGrzNS1dD0C9l2tcV2cfp1PkQeRrInNQ1PGqZ1Bb0b3mQR3ggP+/liZ15RBY6IHh8Hp0OUC8xCi4td4VcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRpxihM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E531C4CED0;
	Wed, 25 Sep 2024 21:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727298417;
	bh=aDTBkkmG/d5Qp4dQ7xLc1aEeqRGIp1tx3y3paI2l9us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CRpxihM2e75tM0Bh7zwLgE2iWB1Q2C6WpoDxjva8iJOMC6oBQya5HroXk55JEfyL6
	 LhjXW/qeEZjcui5rJxrOXW/tJdtmU5D2uxIw05LxKdH12WAJXUQPIdWZx6zFsptgmp
	 9joJA1ZZdNbpONn+zIm4gbqFyJdy0QZIFDugku4mPLkjRJ25aOdb+/1/nuVpPb4jSK
	 AGPijvaPFQ2Md/TDhVdXCRs4LeLobDmZpuYYLQsHtn19s+mGW9Dy41pZhjWzY8BlhR
	 TOovGap+DgQ3DclxvFnyhOOd29bwhFogwsWqcvNyjLBk8WZgYvncO9pF0QaPo4U+On
	 6ud7LUq7AR7ZA==
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
Subject: [PATCH 2/5] asm-generic: move MAP_* flags from mman-common.h to mman.h
Date: Wed, 25 Sep 2024 21:06:12 +0000
Message-Id: <20240925210615.2572360-3-arnd@kernel.org>
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

powerpc and sparc include asm-generic/mman-common.h to get the MAP_* flags
0x008000 through 0x4000000, but those flags are all different on alpha,
mips, parisc and xtensa.

Add duplicate definitions for these along with the MAP_* flags for 0x100
through 0x4000 that are already different on powerpc and sparc, as a
preparation for actually sharing mman-common.h with all architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/include/uapi/asm/mman.h   | 16 ++++++++++++++++
 arch/sparc/include/uapi/asm/mman.h     | 15 +++++++++++++++
 include/uapi/asm-generic/mman-common.h | 16 ----------------
 include/uapi/asm-generic/mman.h        | 21 +++++++++++++++++++++
 include/uapi/linux/mman.h              |  5 +++++
 5 files changed, 57 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/mman.h b/arch/powerpc/include/uapi/asm/mman.h
index c0c737215b00..d57b347c37fe 100644
--- a/arch/powerpc/include/uapi/asm/mman.h
+++ b/arch/powerpc/include/uapi/asm/mman.h
@@ -13,6 +13,11 @@
 
 #define PROT_SAO	0x10		/* Strong Access Ordering */
 
+/* 0x01 - 0x03 are defined in linux/mman.h */
+#define MAP_TYPE	0x0f		/* Mask for type of mapping */
+#define MAP_FIXED	0x10		/* Interpret addr exactly */
+#define MAP_ANONYMOUS	0x20		/* don't use a file */
+
 #define MAP_RENAME      MAP_ANONYMOUS   /* In SunOS terminology */
 #define MAP_NORESERVE   0x40            /* don't reserve swap pages */
 #define MAP_LOCKED	0x80
@@ -21,6 +26,17 @@
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 
+#define MAP_POPULATE		0x008000	/* populate (prefault) pagetables */
+#define MAP_NONBLOCK		0x010000	/* do not block on IO */
+#define MAP_STACK		0x020000	/* give out an address that is best suited for process/thread stacks */
+#define MAP_HUGETLB		0x040000	/* create a huge page mapping */
+#define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
+#define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
+
+#define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
+					 * uninitialized */
+
+
 
 #define MCL_CURRENT     0x2000          /* lock all currently mapped pages */
 #define MCL_FUTURE      0x4000          /* lock all additions to address space */
diff --git a/arch/sparc/include/uapi/asm/mman.h b/arch/sparc/include/uapi/asm/mman.h
index cec9f4109687..afb86698cdb1 100644
--- a/arch/sparc/include/uapi/asm/mman.h
+++ b/arch/sparc/include/uapi/asm/mman.h
@@ -8,6 +8,11 @@
 
 #define PROT_ADI	0x10		/* ADI enabled */
 
+/* 0x01 - 0x03 are defined in linux/mman.h */
+#define MAP_TYPE	0x0f		/* Mask for type of mapping */
+#define MAP_FIXED	0x10		/* Interpret addr exactly */
+#define MAP_ANONYMOUS	0x20		/* don't use a file */
+
 #define MAP_RENAME      MAP_ANONYMOUS   /* In SunOS terminology */
 #define MAP_NORESERVE   0x40            /* don't reserve swap pages */
 #define MAP_INHERIT     0x80            /* SunOS doesn't do this, but... */
@@ -18,6 +23,16 @@
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 
+#define MAP_POPULATE		0x008000	/* populate (prefault) pagetables */
+#define MAP_NONBLOCK		0x010000	/* do not block on IO */
+#define MAP_STACK		0x020000	/* give out an address that is best suited for process/thread stacks */
+#define MAP_HUGETLB		0x040000	/* create a huge page mapping */
+#define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
+#define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
+
+#define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
+					 * uninitialized */
+
 #define MCL_CURRENT     0x2000          /* lock all currently mapped pages */
 #define MCL_FUTURE      0x4000          /* lock all additions to address space */
 #define MCL_ONFAULT	0x8000		/* lock all pages that are faulted in */
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 792ad5599d9c..8d66d2dabaa8 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -17,22 +17,6 @@
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
 
-/* 0x01 - 0x03 are defined in linux/mman.h */
-#define MAP_TYPE	0x0f		/* Mask for type of mapping */
-#define MAP_FIXED	0x10		/* Interpret addr exactly */
-#define MAP_ANONYMOUS	0x20		/* don't use a file */
-
-/* 0x0100 - 0x4000 flags are defined in asm-generic/mman.h */
-#define MAP_POPULATE		0x008000	/* populate (prefault) pagetables */
-#define MAP_NONBLOCK		0x010000	/* do not block on IO */
-#define MAP_STACK		0x020000	/* give out an address that is best suited for process/thread stacks */
-#define MAP_HUGETLB		0x040000	/* create a huge page mapping */
-#define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
-#define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
-
-#define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
-					 * uninitialized */
-
 /*
  * Flags for mlock
  */
diff --git a/include/uapi/asm-generic/mman.h b/include/uapi/asm-generic/mman.h
index 57e8195d0b53..f26f9b4c03e1 100644
--- a/include/uapi/asm-generic/mman.h
+++ b/include/uapi/asm-generic/mman.h
@@ -4,12 +4,33 @@
 
 #include <asm-generic/mman-common.h>
 
+/*
+ * 0x01 - 0x03 are defined in linux/mman.h
+ * 0x04 - 0x200000 are architecture specific
+ * 0x200000 - 0x2000000 are available for common assignments in linux/mman.h
+ * 0x4000000 - 0x80000000 are used for hugepage encodings
+ */
+#define MAP_TYPE	0x0f		/* Mask for type of mapping */
+#define MAP_FIXED	0x10		/* Interpret addr exactly */
+#define MAP_ANONYMOUS	0x20		/* don't use a file */
+
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 
+#define MAP_POPULATE		0x008000	/* populate (prefault) pagetables */
+#define MAP_NONBLOCK		0x010000	/* do not block on IO */
+#define MAP_STACK		0x020000	/* give out an address that is best suited for process/thread stacks */
+#define MAP_HUGETLB		0x040000	/* create a huge page mapping */
+#define MAP_SYNC		0x080000 /* perform synchronous page faults for the mapping */
+#define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
+
+#define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
+					 * uninitialized */
+
+
 /*
  * Bits [26:31] are reserved, see asm-generic/hugetlb_encode.h
  * for MAP_HUGETLB usage
diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index e89d00528f2f..b70cb06dd7ef 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -18,6 +18,11 @@
 #define MAP_PRIVATE	0x02		/* Changes are private */
 #define MAP_SHARED_VALIDATE 0x03	/* share + validate extension flags */
 #define MAP_DROPPABLE	0x08		/* Zero memory under memory pressure. */
+/*
+ * 0x10 through 0x200000 are used for architecture specific definitions
+ * in asm/mman.h, numbers 0x400000 through 0x2000000 are currently
+ * available on all architectures.
+ */
 
 /*
  * Huge page size encoding when MAP_HUGETLB is specified, and a huge page
-- 
2.39.2


