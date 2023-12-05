Return-Path: <linux-arch+bounces-686-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768CB8044BD
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 03:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA892814A3
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 02:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB5E611E;
	Tue,  5 Dec 2023 02:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JSa9wSgY"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629B7183;
	Mon,  4 Dec 2023 18:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Ssumj8Ga0ODeYpoCztyRyOohgV6bExhFJeHjoXEJ+Bk=; b=JSa9wSgYC6qHTANuSw4rJ3cYDB
	VEpipY+WowKTenQpMASC6oMife6jMA3wmPdhOPwtLa4Ps7NSA/LdccXE5kKE/vqSvGI1bvQF1WgLq
	I+LoSWIzJmJdrbMtKhHWAcXuJeKv8oJbg/bbc8yfLkMANQCK99Kmj+l5DuIZm7wcneMfqmKsaFL7v
	x3MaBeICRKdnquaYa0DIIXzJhk9bHG+fJLB2JUVXhfZdwrJ8dm2XRSeqalJD+7gEW5/a7nSOGpysp
	cxBfiCBKvQ5L6BpW6U7yISnD6kDF3H8WII4XtHuHM+YnhYeO3Wxs0XF4PLz/KvYWDRxLvtHOXoNz0
	5pOfwhHw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAL6h-007926-14;
	Tue, 05 Dec 2023 02:24:19 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: gus Gusenleitner Klaus <gus@keba.com>,
	Al Viro <viro@ftp.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	lkml <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2 03/18] make net/checksum.h the sole user of asm/checksum.h
Date: Tue,  5 Dec 2023 02:23:56 +0000
Message-Id: <20231205022418.1703007-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231205022418.1703007-1-viro@zeniv.linux.org.uk>
References: <20231205022100.GB1674809@ZenIV>
 <20231205022418.1703007-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

All other users (all in arch/* by now) can pull net/checksum.h

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/include/asm/asm-prototypes.h   | 2 +-
 arch/arm/kernel/armksyms.c                | 2 +-
 arch/microblaze/kernel/microblaze_ksyms.c | 2 +-
 arch/mips/include/asm/asm-prototypes.h    | 2 +-
 arch/openrisc/kernel/or32_ksyms.c         | 2 +-
 arch/powerpc/include/asm/asm-prototypes.h | 2 +-
 arch/powerpc/lib/checksum_wrappers.c      | 2 +-
 arch/s390/kernel/ipl.c                    | 2 +-
 arch/s390/kernel/os_info.c                | 2 +-
 arch/sh/kernel/sh_ksyms_32.c              | 2 +-
 arch/sparc/include/asm/asm-prototypes.h   | 2 +-
 arch/x86/include/asm/asm-prototypes.h     | 2 +-
 arch/x86/lib/csum-partial_64.c            | 2 +-
 arch/x86/lib/csum-wrappers_64.c           | 2 +-
 arch/xtensa/include/asm/asm-prototypes.h  | 2 +-
 15 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/alpha/include/asm/asm-prototypes.h b/arch/alpha/include/asm/asm-prototypes.h
index c8ae46fc2e74..5bedc308be3c 100644
--- a/arch/alpha/include/asm/asm-prototypes.h
+++ b/arch/alpha/include/asm/asm-prototypes.h
@@ -1,10 +1,10 @@
 #include <linux/spinlock.h>
 
-#include <asm/checksum.h>
 #include <asm/console.h>
 #include <asm/page.h>
 #include <asm/string.h>
 #include <linux/uaccess.h>
+#include <net/checksum.h>
 
 #include <asm-generic/asm-prototypes.h>
 
diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index 82e96ac83684..d076a5c8556f 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -14,7 +14,7 @@
 #include <linux/io.h>
 #include <linux/arm-smccc.h>
 
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <asm/ftrace.h>
 
 /*
diff --git a/arch/microblaze/kernel/microblaze_ksyms.c b/arch/microblaze/kernel/microblaze_ksyms.c
index c892e173ec99..e5858b15cd37 100644
--- a/arch/microblaze/kernel/microblaze_ksyms.c
+++ b/arch/microblaze/kernel/microblaze_ksyms.c
@@ -10,7 +10,7 @@
 #include <linux/in6.h>
 #include <linux/syscalls.h>
 
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <asm/cacheflush.h>
 #include <linux/io.h>
 #include <asm/page.h>
diff --git a/arch/mips/include/asm/asm-prototypes.h b/arch/mips/include/asm/asm-prototypes.h
index 8e8fc38b0941..44fd0c30fd73 100644
--- a/arch/mips/include/asm/asm-prototypes.h
+++ b/arch/mips/include/asm/asm-prototypes.h
@@ -1,11 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/checksum.h>
 #include <asm/page.h>
 #include <asm/fpu.h>
 #include <asm-generic/asm-prototypes.h>
 #include <linux/uaccess.h>
 #include <asm/ftrace.h>
 #include <asm/mmu_context.h>
+#include <net/checksum.h>
 
 extern void clear_page_cpu(void *page);
 extern void copy_page_cpu(void *to, void *from);
diff --git a/arch/openrisc/kernel/or32_ksyms.c b/arch/openrisc/kernel/or32_ksyms.c
index 212e5f85004c..a56dea4411ab 100644
--- a/arch/openrisc/kernel/or32_ksyms.c
+++ b/arch/openrisc/kernel/or32_ksyms.c
@@ -22,7 +22,7 @@
 
 #include <asm/processor.h>
 #include <linux/uaccess.h>
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <asm/io.h>
 #include <asm/hardirq.h>
 #include <asm/delay.h>
diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 274bce76f5da..c283183e5a81 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -11,7 +11,7 @@
 
 #include <linux/threads.h>
 #include <asm/cacheflush.h>
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <linux/uaccess.h>
 #include <asm/epapr_hcalls.h>
 #include <asm/dcr.h>
diff --git a/arch/powerpc/lib/checksum_wrappers.c b/arch/powerpc/lib/checksum_wrappers.c
index 1a14c8780278..6df0fd24482e 100644
--- a/arch/powerpc/lib/checksum_wrappers.c
+++ b/arch/powerpc/lib/checksum_wrappers.c
@@ -8,8 +8,8 @@
 #include <linux/export.h>
 #include <linux/compiler.h>
 #include <linux/types.h>
-#include <asm/checksum.h>
 #include <linux/uaccess.h>
+#include <net/checksum.h>
 
 __wsum csum_and_copy_from_user(const void __user *src, void *dst,
 			       int len)
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index cc364fce6aa9..0a2d11a22c37 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -28,7 +28,7 @@
 #include <asm/cpcmd.h>
 #include <asm/ebcdic.h>
 #include <asm/sclp.h>
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <asm/debug.h>
 #include <asm/abs_lowcore.h>
 #include <asm/os_info.h>
diff --git a/arch/s390/kernel/os_info.c b/arch/s390/kernel/os_info.c
index 6e1824141b29..44447e3fef84 100644
--- a/arch/s390/kernel/os_info.c
+++ b/arch/s390/kernel/os_info.c
@@ -12,7 +12,7 @@
 #include <linux/crash_dump.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <asm/abs_lowcore.h>
 #include <asm/os_info.h>
 #include <asm/maccess.h>
diff --git a/arch/sh/kernel/sh_ksyms_32.c b/arch/sh/kernel/sh_ksyms_32.c
index 5858936cb431..ce9d5547ac74 100644
--- a/arch/sh/kernel/sh_ksyms_32.c
+++ b/arch/sh/kernel/sh_ksyms_32.c
@@ -4,7 +4,7 @@
 #include <linux/uaccess.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <asm/sections.h>
 
 EXPORT_SYMBOL(memchr);
diff --git a/arch/sparc/include/asm/asm-prototypes.h b/arch/sparc/include/asm/asm-prototypes.h
index 4987c735ff56..e15661bf8b36 100644
--- a/arch/sparc/include/asm/asm-prototypes.h
+++ b/arch/sparc/include/asm/asm-prototypes.h
@@ -4,7 +4,7 @@
  */
 
 #include <asm/xor.h>
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <asm/trap_block.h>
 #include <linux/uaccess.h>
 #include <asm/atomic.h>
diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index b1a98fa38828..655e25745349 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -4,7 +4,7 @@
 #include <linux/pgtable.h>
 #include <asm/string.h>
 #include <asm/page.h>
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <asm/mce.h>
 
 #include <asm-generic/asm-prototypes.h>
diff --git a/arch/x86/lib/csum-partial_64.c b/arch/x86/lib/csum-partial_64.c
index cea25ca8b8cf..5e877592a7b3 100644
--- a/arch/x86/lib/csum-partial_64.c
+++ b/arch/x86/lib/csum-partial_64.c
@@ -8,7 +8,7 @@
 
 #include <linux/compiler.h>
 #include <linux/export.h>
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <asm/word-at-a-time.h>
 
 static inline unsigned short from32to16(unsigned a)
diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_64.c
index f4df4d241526..03251664462a 100644
--- a/arch/x86/lib/csum-wrappers_64.c
+++ b/arch/x86/lib/csum-wrappers_64.c
@@ -4,9 +4,9 @@
  *
  * Wrappers of assembly checksum functions for x86-64.
  */
-#include <asm/checksum.h>
 #include <linux/export.h>
 #include <linux/uaccess.h>
+#include <net/checksum.h>
 #include <asm/smap.h>
 
 /**
diff --git a/arch/xtensa/include/asm/asm-prototypes.h b/arch/xtensa/include/asm/asm-prototypes.h
index b0da61812b85..b01b8170fafb 100644
--- a/arch/xtensa/include/asm/asm-prototypes.h
+++ b/arch/xtensa/include/asm/asm-prototypes.h
@@ -3,7 +3,7 @@
 #define __ASM_PROTOTYPES_H
 
 #include <asm/cacheflush.h>
-#include <asm/checksum.h>
+#include <net/checksum.h>
 #include <asm/ftrace.h>
 #include <asm/page.h>
 #include <asm/string.h>
-- 
2.39.2


