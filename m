Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F585059C5
	for <lists+linux-arch@lfdr.de>; Mon, 18 Apr 2022 16:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345136AbiDRO27 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Apr 2022 10:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343846AbiDRO0L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Apr 2022 10:26:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E36552E5F;
        Mon, 18 Apr 2022 06:22:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE86560FE4;
        Mon, 18 Apr 2022 13:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10188C385A1;
        Mon, 18 Apr 2022 13:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650288137;
        bh=fQ9k+lVCiU8YgftgVoJnd7lIPLzQ9u70bVRn6Lhqf4U=;
        h=From:To:Cc:Subject:Date:From;
        b=LlN/AkbFu4zaKaqy151gpcUYwvJ6OFNAJU0kalyeuVBw7vEIEX3nsQ3H02WxVbon6
         FQKoAc7X+bzob43ShtfJcOCJQR1pG2LyqJnjgSB1rooIqajOl9DXy97/AL8LZOWxjM
         fQVgXStEomKtNcc9bysZ1tBU4cLNhOVflmE0tENznLUJZ5FfgGRDItUvXaGvFuwFu8
         zmFMhTdo9zQFgFjLz1+Qp6G0nA74w4KhlPtVVa5pJ4go+PwW9dCT93mzaUAIlUoXBO
         NEOwwA2E7AtuyHv/V7wphTPL5AGMmzyVU1G9OoCh4n77E2bN7EitUYr8le13zRkg9F
         DWTs14dbQDlFA==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Matteo Croce <mcroce@microsoft.com>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V3] csky: Add C based string functions
Date:   Mon, 18 Apr 2022 21:22:02 +0800
Message-Id: <20220418132202.2387760-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Try to access RAM with the largest bit width possible, but without
doing unaligned accesses.

A further improvement could be to use multiple read and writes as the
assembly version was trying to do.

Tested on a BeagleV Starlight with a SiFive U74 core, where the
improvement is noticeable.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
Co-developed-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
Changes in V3:
 - Fixup conflict Kconfig name

Changes in V2:
 - Fixup compile warning with __weak definition
---
 arch/csky/Kconfig          |   8 +
 arch/csky/abiv1/Makefile   |   2 -
 arch/csky/abiv1/memcpy.S   | 347 -------------------------------------
 arch/csky/abiv1/strksyms.c |   6 -
 arch/csky/abiv2/Makefile   |   2 +
 arch/csky/abiv2/strksyms.c |   4 +-
 arch/csky/lib/Makefile     |   3 +
 arch/csky/lib/string.c     | 134 ++++++++++++++
 8 files changed, 150 insertions(+), 356 deletions(-)
 delete mode 100644 arch/csky/abiv1/memcpy.S
 delete mode 100644 arch/csky/abiv1/strksyms.c
 create mode 100644 arch/csky/lib/string.c

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 75ef86605d69..21d72b078eef 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -320,6 +320,14 @@ config HOTPLUG_CPU
 	  controlled through /sys/devices/system/cpu/cpu1/hotplug/target.
 
 	  Say N if you want to disable CPU hotplug.
+
+config HAVE_EFFICIENT_UNALIGNED_STRING_OPS
+	bool "Enable EFFICIENT_UNALIGNED_STRING_OPS for abiv2"
+	depends on CPU_CK807 || CPU_CK810 || CPU_CK860
+	help
+	  Say Y here to enable EFFICIENT_UNALIGNED_STRING_OPS. Some CPU models could
+	  deal with unaligned access by hardware.
+
 endmenu
 
 source "arch/csky/Kconfig.platforms"
diff --git a/arch/csky/abiv1/Makefile b/arch/csky/abiv1/Makefile
index 601ce3b2fb85..a4b2ade0fc67 100644
--- a/arch/csky/abiv1/Makefile
+++ b/arch/csky/abiv1/Makefile
@@ -4,5 +4,3 @@ obj-y					+= bswapdi.o
 obj-y					+= bswapsi.o
 obj-y					+= cacheflush.o
 obj-y					+= mmap.o
-obj-y					+= memcpy.o
-obj-y					+= strksyms.o
diff --git a/arch/csky/abiv1/memcpy.S b/arch/csky/abiv1/memcpy.S
deleted file mode 100644
index 5078eb5169fa..000000000000
--- a/arch/csky/abiv1/memcpy.S
+++ /dev/null
@@ -1,347 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
-
-#include <linux/linkage.h>
-
-.macro	GET_FRONT_BITS rx y
-#ifdef	__cskyLE__
-	lsri	\rx, \y
-#else
-	lsli	\rx, \y
-#endif
-.endm
-
-.macro	GET_AFTER_BITS rx y
-#ifdef	__cskyLE__
-	lsli	\rx, \y
-#else
-	lsri	\rx, \y
-#endif
-.endm
-
-/* void *memcpy(void *dest, const void *src, size_t n); */
-ENTRY(memcpy)
-	mov	r7, r2
-	cmplti	r4, 4
-	bt	.L_copy_by_byte
-	mov	r6, r2
-	andi	r6, 3
-	cmpnei	r6, 0
-	jbt	.L_dest_not_aligned
-	mov	r6, r3
-	andi	r6, 3
-	cmpnei	r6, 0
-	jbt	.L_dest_aligned_but_src_not_aligned
-.L0:
-	cmplti	r4, 16
-	jbt	.L_aligned_and_len_less_16bytes
-	subi	sp, 8
-	stw	r8, (sp, 0)
-.L_aligned_and_len_larger_16bytes:
-	ldw	r1, (r3, 0)
-	ldw	r5, (r3, 4)
-	ldw	r8, (r3, 8)
-	stw	r1, (r7, 0)
-	ldw	r1, (r3, 12)
-	stw	r5, (r7, 4)
-	stw	r8, (r7, 8)
-	stw	r1, (r7, 12)
-	subi	r4, 16
-	addi	r3, 16
-	addi	r7, 16
-	cmplti	r4, 16
-	jbf	.L_aligned_and_len_larger_16bytes
-	ldw	r8, (sp, 0)
-	addi	sp, 8
-	cmpnei	r4, 0
-	jbf	.L_return
-
-.L_aligned_and_len_less_16bytes:
-	cmplti	r4, 4
-	bt	.L_copy_by_byte
-.L1:
-	ldw	r1, (r3, 0)
-	stw	r1, (r7, 0)
-	subi	r4, 4
-	addi	r3, 4
-	addi	r7, 4
-	cmplti	r4, 4
-	jbf	.L1
-	br	.L_copy_by_byte
-
-.L_return:
-	rts
-
-.L_copy_by_byte:                      /* len less than 4 bytes */
-	cmpnei	r4, 0
-	jbf	.L_return
-.L4:
-	ldb	r1, (r3, 0)
-	stb	r1, (r7, 0)
-	addi	r3, 1
-	addi	r7, 1
-	decne	r4
-	jbt	.L4
-	rts
-
-/*
- * If dest is not aligned, just copying some bytes makes the dest align.
- * Afther that, we judge whether the src is aligned.
- */
-.L_dest_not_aligned:
-	mov	r5, r3
-	rsub	r5, r5, r7
-	abs	r5, r5
-	cmplt	r5, r4
-	bt	.L_copy_by_byte
-	mov	r5, r7
-	sub	r5, r3
-	cmphs	r5, r4
-	bf	.L_copy_by_byte
-	mov	r5, r6
-.L5:
-	ldb	r1, (r3, 0)              /* makes the dest align. */
-	stb	r1, (r7, 0)
-	addi	r5, 1
-	subi	r4, 1
-	addi	r3, 1
-	addi	r7, 1
-	cmpnei	r5, 4
-	jbt	.L5
-	cmplti	r4, 4
-	jbt	.L_copy_by_byte
-	mov	r6, r3                   /* judge whether the src is aligned. */
-	andi	r6, 3
-	cmpnei	r6, 0
-	jbf	.L0
-
-/* Judge the number of misaligned, 1, 2, 3? */
-.L_dest_aligned_but_src_not_aligned:
-	mov	r5, r3
-	rsub	r5, r5, r7
-	abs	r5, r5
-	cmplt	r5, r4
-	bt	.L_copy_by_byte
-	bclri	r3, 0
-	bclri	r3, 1
-	ldw	r1, (r3, 0)
-	addi	r3, 4
-	cmpnei	r6, 2
-	bf	.L_dest_aligned_but_src_not_aligned_2bytes
-	cmpnei	r6, 3
-	bf	.L_dest_aligned_but_src_not_aligned_3bytes
-
-.L_dest_aligned_but_src_not_aligned_1byte:
-	mov	r5, r7
-	sub	r5, r3
-	cmphs	r5, r4
-	bf	.L_copy_by_byte
-	cmplti	r4, 16
-	bf	.L11
-.L10:                                     /* If the len is less than 16 bytes */
-	GET_FRONT_BITS r1 8
-	mov	r5, r1
-	ldw	r6, (r3, 0)
-	mov	r1, r6
-	GET_AFTER_BITS r6 24
-	or	r5, r6
-	stw	r5, (r7, 0)
-	subi	r4, 4
-	addi	r3, 4
-	addi	r7, 4
-	cmplti	r4, 4
-	bf	.L10
-	subi	r3, 3
-	br	.L_copy_by_byte
-.L11:
-	subi	sp, 16
-	stw	r8, (sp, 0)
-	stw	r9, (sp, 4)
-	stw	r10, (sp, 8)
-	stw	r11, (sp, 12)
-.L12:
-	ldw	r5, (r3, 0)
-	ldw	r11, (r3, 4)
-	ldw	r8, (r3, 8)
-	ldw	r9, (r3, 12)
-
-	GET_FRONT_BITS r1 8               /* little or big endian? */
-	mov	r10, r5
-	GET_AFTER_BITS r5 24
-	or	r5, r1
-
-	GET_FRONT_BITS r10 8
-	mov	r1, r11
-	GET_AFTER_BITS r11 24
-	or	r11, r10
-
-	GET_FRONT_BITS r1 8
-	mov	r10, r8
-	GET_AFTER_BITS r8 24
-	or	r8, r1
-
-	GET_FRONT_BITS r10 8
-	mov	r1, r9
-	GET_AFTER_BITS r9 24
-	or	r9, r10
-
-	stw	r5, (r7, 0)
-	stw	r11, (r7, 4)
-	stw	r8, (r7, 8)
-	stw	r9, (r7, 12)
-	subi	r4, 16
-	addi	r3, 16
-	addi	r7, 16
-	cmplti	r4, 16
-	jbf	.L12
-	ldw	r8, (sp, 0)
-	ldw	r9, (sp, 4)
-	ldw	r10, (sp, 8)
-	ldw	r11, (sp, 12)
-	addi	sp , 16
-	cmplti	r4, 4
-	bf	.L10
-	subi	r3, 3
-	br	.L_copy_by_byte
-
-.L_dest_aligned_but_src_not_aligned_2bytes:
-	cmplti	r4, 16
-	bf	.L21
-.L20:
-	GET_FRONT_BITS r1 16
-	mov	r5, r1
-	ldw	r6, (r3, 0)
-	mov	r1, r6
-	GET_AFTER_BITS r6 16
-	or	r5, r6
-	stw	r5, (r7, 0)
-	subi	r4, 4
-	addi	r3, 4
-	addi	r7, 4
-	cmplti	r4, 4
-	bf	.L20
-	subi	r3, 2
-	br	.L_copy_by_byte
-	rts
-
-.L21:	/* n > 16 */
-	subi 	sp, 16
-	stw	r8, (sp, 0)
-	stw	r9, (sp, 4)
-	stw	r10, (sp, 8)
-	stw	r11, (sp, 12)
-
-.L22:
-	ldw	r5, (r3, 0)
-	ldw	r11, (r3, 4)
-	ldw	r8, (r3, 8)
-	ldw	r9, (r3, 12)
-
-	GET_FRONT_BITS r1 16
-	mov	r10, r5
-	GET_AFTER_BITS r5 16
-	or	r5, r1
-
-	GET_FRONT_BITS r10 16
-	mov	r1, r11
-	GET_AFTER_BITS r11 16
-	or	r11, r10
-
-	GET_FRONT_BITS r1 16
-	mov	r10, r8
-	GET_AFTER_BITS r8 16
-	or	r8, r1
-
-	GET_FRONT_BITS r10 16
-	mov	r1, r9
-	GET_AFTER_BITS r9 16
-	or	r9, r10
-
-	stw	r5, (r7, 0)
-	stw	r11, (r7, 4)
-	stw	r8, (r7, 8)
-	stw	r9, (r7, 12)
-	subi	r4, 16
-	addi	r3, 16
-	addi	r7, 16
-	cmplti	r4, 16
-	jbf	.L22
-	ldw	r8, (sp, 0)
-	ldw	r9, (sp, 4)
-	ldw	r10, (sp, 8)
-	ldw	r11, (sp, 12)
-	addi	sp, 16
-	cmplti	r4, 4
-	bf	.L20
-	subi	r3, 2
-	br	.L_copy_by_byte
-
-
-.L_dest_aligned_but_src_not_aligned_3bytes:
-	cmplti	r4, 16
-	bf	.L31
-.L30:
-	GET_FRONT_BITS r1 24
-	mov	r5, r1
-	ldw	r6, (r3, 0)
-	mov	r1, r6
-	GET_AFTER_BITS r6 8
-	or	r5, r6
-	stw	r5, (r7, 0)
-	subi	r4, 4
-	addi	r3, 4
-	addi	r7, 4
-	cmplti	r4, 4
-	bf	.L30
-	subi	r3, 1
-	br	.L_copy_by_byte
-.L31:
-	subi	sp, 16
-	stw	r8, (sp, 0)
-	stw	r9, (sp, 4)
-	stw	r10, (sp, 8)
-	stw	r11, (sp, 12)
-.L32:
-	ldw	r5, (r3, 0)
-	ldw	r11, (r3, 4)
-	ldw	r8, (r3, 8)
-	ldw	r9, (r3, 12)
-
-	GET_FRONT_BITS r1 24
-	mov	r10, r5
-	GET_AFTER_BITS r5 8
-	or	r5, r1
-
-	GET_FRONT_BITS r10 24
-	mov	r1, r11
-	GET_AFTER_BITS r11 8
-	or	r11, r10
-
-	GET_FRONT_BITS r1 24
-	mov	r10, r8
-	GET_AFTER_BITS r8 8
-	or	r8, r1
-
-	GET_FRONT_BITS r10 24
-	mov	r1, r9
-	GET_AFTER_BITS r9 8
-	or	r9, r10
-
-	stw	r5, (r7, 0)
-	stw	r11, (r7, 4)
-	stw	r8, (r7, 8)
-	stw	r9, (r7, 12)
-	subi	r4, 16
-	addi	r3, 16
-	addi	r7, 16
-	cmplti	r4, 16
-	jbf	.L32
-	ldw	r8, (sp, 0)
-	ldw	r9, (sp, 4)
-	ldw	r10, (sp, 8)
-	ldw	r11, (sp, 12)
-	addi	sp, 16
-	cmplti	r4, 4
-	bf	.L30
-	subi	r3, 1
-	br	.L_copy_by_byte
diff --git a/arch/csky/abiv1/strksyms.c b/arch/csky/abiv1/strksyms.c
deleted file mode 100644
index c7ccbb27e8d7..000000000000
--- a/arch/csky/abiv1/strksyms.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
-
-#include <linux/module.h>
-
-EXPORT_SYMBOL(memcpy);
diff --git a/arch/csky/abiv2/Makefile b/arch/csky/abiv2/Makefile
index c561efa5533c..ea8005fe01a8 100644
--- a/arch/csky/abiv2/Makefile
+++ b/arch/csky/abiv2/Makefile
@@ -2,9 +2,11 @@
 obj-y				+= cacheflush.o
 obj-$(CONFIG_CPU_HAS_FPU)	+= fpu.o
 obj-y				+= memcmp.o
+ifeq ($(CONFIG_HAVE_EFFICIENT_UNALIGNED_STRING_OPS), y)
 obj-y				+= memcpy.o
 obj-y				+= memmove.o
 obj-y				+= memset.o
+endif
 obj-y				+= strcmp.o
 obj-y				+= strcpy.o
 obj-y				+= strlen.o
diff --git a/arch/csky/abiv2/strksyms.c b/arch/csky/abiv2/strksyms.c
index 06da723d8202..8d1fd28c6cf9 100644
--- a/arch/csky/abiv2/strksyms.c
+++ b/arch/csky/abiv2/strksyms.c
@@ -3,10 +3,12 @@
 
 #include <linux/module.h>
 
+#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_STRING_OPS
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(memcmp);
 EXPORT_SYMBOL(memmove);
+#endif
+EXPORT_SYMBOL(memcmp);
 EXPORT_SYMBOL(strcmp);
 EXPORT_SYMBOL(strcpy);
 EXPORT_SYMBOL(strlen);
diff --git a/arch/csky/lib/Makefile b/arch/csky/lib/Makefile
index 7fbdbb2c4d12..d0ce6e2d7ab2 100644
--- a/arch/csky/lib/Makefile
+++ b/arch/csky/lib/Makefile
@@ -1,3 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 lib-y  := usercopy.o delay.o
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
+ifneq ($(CONFIG_HAVE_EFFICIENT_UNALIGNED_STRING_OPS), y)
+lib-y  += string.o
+endif
diff --git a/arch/csky/lib/string.c b/arch/csky/lib/string.c
new file mode 100644
index 000000000000..d65626fcaeac
--- /dev/null
+++ b/arch/csky/lib/string.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * String functions optimized for hardware which doesn't
+ * handle unaligned memory accesses efficiently.
+ *
+ * Copyright (C) 2021 Matteo Croce
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+
+/* Minimum size for a word copy to be convenient */
+#define BYTES_LONG	sizeof(long)
+#define WORD_MASK	(BYTES_LONG - 1)
+#define MIN_THRESHOLD	(BYTES_LONG * 2)
+
+/* convenience union to avoid cast between different pointer types */
+union types {
+	u8 *as_u8;
+	unsigned long *as_ulong;
+	uintptr_t as_uptr;
+};
+
+union const_types {
+	const u8 *as_u8;
+	unsigned long *as_ulong;
+	uintptr_t as_uptr;
+};
+
+void *memcpy(void *dest, const void *src, size_t count)
+{
+	union const_types s = { .as_u8 = src };
+	union types d = { .as_u8 = dest };
+	int distance = 0;
+
+	if (count < MIN_THRESHOLD)
+		goto copy_remainder;
+
+	/* Copy a byte at time until destination is aligned. */
+	for (; d.as_uptr & WORD_MASK; count--)
+		*d.as_u8++ = *s.as_u8++;
+
+	distance = s.as_uptr & WORD_MASK;
+
+	if (distance) {
+		unsigned long last, next;
+
+		/*
+		 * s is distance bytes ahead of d, and d just reached
+		 * the alignment boundary. Move s backward to word align it
+		 * and shift data to compensate for distance, in order to do
+		 * word-by-word copy.
+		 */
+		s.as_u8 -= distance;
+
+		next = s.as_ulong[0];
+		for (; count >= BYTES_LONG; count -= BYTES_LONG) {
+			last = next;
+			next = s.as_ulong[1];
+
+			d.as_ulong[0] = last >> (distance * 8) |
+				next << ((BYTES_LONG - distance) * 8);
+
+			d.as_ulong++;
+			s.as_ulong++;
+		}
+
+		/* Restore s with the original offset. */
+		s.as_u8 += distance;
+	} else {
+		/*
+		 * If the source and dest lower bits are the same, do a simple
+		 * 32/64 bit wide copy.
+		 */
+		for (; count >= BYTES_LONG; count -= BYTES_LONG)
+			*d.as_ulong++ = *s.as_ulong++;
+	}
+
+copy_remainder:
+	while (count--)
+		*d.as_u8++ = *s.as_u8++;
+
+	return dest;
+}
+EXPORT_SYMBOL(memcpy);
+
+/*
+ * Simply check if the buffer overlaps an call memcpy() in case,
+ * otherwise do a simple one byte at time backward copy.
+ */
+void *memmove(void *dest, const void *src, size_t count)
+{
+	if (dest < src || src + count <= dest)
+		return memcpy(dest, src, count);
+
+	if (dest > src) {
+		const char *s = src + count;
+		char *tmp = dest + count;
+
+		while (count--)
+			*--tmp = *--s;
+	}
+	return dest;
+}
+EXPORT_SYMBOL(memmove);
+
+void *memset(void *s, int c, size_t count)
+{
+	union types dest = { .as_u8 = s };
+
+	if (count >= MIN_THRESHOLD) {
+		unsigned long cu = (unsigned long)c;
+
+		/* Compose an ulong with 'c' repeated 4/8 times */
+		cu |= cu << 8;
+		cu |= cu << 16;
+		/* Suppress warning on 32 bit machines */
+		cu |= (cu << 16) << 16;
+
+		for (; count && dest.as_uptr & WORD_MASK; count--)
+			*dest.as_u8++ = c;
+
+		/* Copy using the largest size allowed */
+		for (; count >= BYTES_LONG; count -= BYTES_LONG)
+			*dest.as_ulong++ = cu;
+	}
+
+	/* copy the remainder */
+	while (count--)
+		*dest.as_u8++ = c;
+
+	return s;
+}
+EXPORT_SYMBOL(memset);
-- 
2.25.1

