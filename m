Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622B860C1DE
	for <lists+linux-arch@lfdr.de>; Tue, 25 Oct 2022 04:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbiJYCqH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Oct 2022 22:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiJYCqC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2022 22:46:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA361FCF9;
        Mon, 24 Oct 2022 19:45:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B88C61715;
        Tue, 25 Oct 2022 02:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED492C433C1;
        Tue, 25 Oct 2022 02:45:54 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>,
        Jun Yi <yijun@loongson.cn>
Subject: [PATCH V2 2/2] LoongArch: Use alternative to optimize libraries
Date:   Tue, 25 Oct 2022 10:43:26 +0800
Message-Id: <20221025024326.1593779-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221025024326.1593779-1-chenhuacai@loongson.cn>
References: <20221025024326.1593779-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use the alternative to optimize common libraries according whether CPU
has UAL (hardware unaligned access support) feature, including memset(),
memcopy(), memmove(), copy_user() and clear_user().

Signed-off-by: Jun Yi <yijun@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/string.h |   5 ++
 arch/loongarch/lib/Makefile         |   3 +-
 arch/loongarch/lib/clear_user.S     |  70 ++++++++++++++--
 arch/loongarch/lib/copy_user.S      |  91 +++++++++++++++++++--
 arch/loongarch/lib/memcpy.S         |  95 ++++++++++++++++++++++
 arch/loongarch/lib/memmove.S        | 121 ++++++++++++++++++++++++++++
 arch/loongarch/lib/memset.S         |  91 +++++++++++++++++++++
 7 files changed, 465 insertions(+), 11 deletions(-)
 create mode 100644 arch/loongarch/lib/memcpy.S
 create mode 100644 arch/loongarch/lib/memmove.S
 create mode 100644 arch/loongarch/lib/memset.S

diff --git a/arch/loongarch/include/asm/string.h b/arch/loongarch/include/asm/string.h
index b07e60ded957..7b29cc9c70aa 100644
--- a/arch/loongarch/include/asm/string.h
+++ b/arch/loongarch/include/asm/string.h
@@ -5,8 +5,13 @@
 #ifndef _ASM_STRING_H
 #define _ASM_STRING_H
 
+#define __HAVE_ARCH_MEMSET
 extern void *memset(void *__s, int __c, size_t __count);
+
+#define __HAVE_ARCH_MEMCPY
 extern void *memcpy(void *__to, __const__ void *__from, size_t __n);
+
+#define __HAVE_ARCH_MEMMOVE
 extern void *memmove(void *__dest, __const__ void *__src, size_t __n);
 
 #endif /* _ASM_STRING_H */
diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
index 867895530340..40bde632900f 100644
--- a/arch/loongarch/lib/Makefile
+++ b/arch/loongarch/lib/Makefile
@@ -3,4 +3,5 @@
 # Makefile for LoongArch-specific library files.
 #
 
-lib-y	+= delay.o clear_user.o copy_user.o dump_tlb.o unaligned.o
+lib-y	+= delay.o memset.o memcpy.o memmove.o \
+	   clear_user.o copy_user.o dump_tlb.o unaligned.o
diff --git a/arch/loongarch/lib/clear_user.S b/arch/loongarch/lib/clear_user.S
index 167823b21def..9462fbb211d3 100644
--- a/arch/loongarch/lib/clear_user.S
+++ b/arch/loongarch/lib/clear_user.S
@@ -3,25 +3,37 @@
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
 
+#include <asm/alternative-asm.h>
 #include <asm/asm.h>
 #include <asm/asmmacro.h>
 #include <asm/asm-extable.h>
+#include <asm/cpu.h>
 #include <asm/export.h>
 #include <asm/regdef.h>
 
-.irp to, 0
+.irp to, 0, 1, 2, 3, 4, 5, 6, 7
 .L_fixup_handle_\to\():
 	addi.d	a0, a1, (\to) * (-8)
 	jr	ra
 .endr
 
+SYM_FUNC_START(__clear_user)
+	/*
+	 * Some CPUs support hardware unaligned access
+	 */
+	ALTERNATIVE	"b __clear_user_generic",	\
+			"b __clear_user_fast", CPU_FEATURE_UAL
+SYM_FUNC_END(__clear_user)
+
+EXPORT_SYMBOL(__clear_user)
+
 /*
- * unsigned long __clear_user(void *addr, size_t size)
+ * unsigned long __clear_user_generic(void *addr, size_t size)
  *
  * a0: addr
  * a1: size
  */
-SYM_FUNC_START(__clear_user)
+SYM_FUNC_START(__clear_user_generic)
 	beqz	a1, 2f
 
 1:	st.b	zero, a0, 0
@@ -33,6 +45,54 @@ SYM_FUNC_START(__clear_user)
 	jr	ra
 
 	_asm_extable 1, .L_fixup_handle_0
-SYM_FUNC_END(__clear_user)
+SYM_FUNC_END(__clear_user_generic)
 
-EXPORT_SYMBOL(__clear_user)
+/*
+ * unsigned long __clear_user_fast(void *addr, unsigned long size)
+ *
+ * a0: addr
+ * a1: size
+ */
+SYM_FUNC_START(__clear_user_fast)
+	beqz	a1, 10f
+
+	ori	a2, zero, 64
+	blt	a1, a2, 9f
+
+	/* set 64 bytes at a time */
+1:	st.d	zero, a0, 0
+2:	st.d	zero, a0, 8
+3:	st.d	zero, a0, 16
+4:	st.d	zero, a0, 24
+5:	st.d	zero, a0, 32
+6:	st.d	zero, a0, 40
+7:	st.d	zero, a0, 48
+8:	st.d	zero, a0, 56
+
+	addi.d	a0, a0, 64
+	addi.d	a1, a1, -64
+	bge	a1, a2, 1b
+
+	beqz	a1, 10f
+
+	/* set the remaining bytes */
+9:	st.b	zero, a0, 0
+	addi.d	a0, a0, 1
+	addi.d	a1, a1, -1
+	bgt	a1, zero, 9b
+
+	/* return */
+10:	move	a0, a1
+	jr	ra
+
+	/* fixup and ex_table */
+	_asm_extable 1b, .L_fixup_handle_0
+	_asm_extable 2b, .L_fixup_handle_1
+	_asm_extable 3b, .L_fixup_handle_2
+	_asm_extable 4b, .L_fixup_handle_3
+	_asm_extable 5b, .L_fixup_handle_4
+	_asm_extable 6b, .L_fixup_handle_5
+	_asm_extable 7b, .L_fixup_handle_6
+	_asm_extable 8b, .L_fixup_handle_7
+	_asm_extable 9b, .L_fixup_handle_0
+SYM_FUNC_END(__clear_user_fast)
diff --git a/arch/loongarch/lib/copy_user.S b/arch/loongarch/lib/copy_user.S
index 5d7bfa8d53d2..bcc01d453767 100644
--- a/arch/loongarch/lib/copy_user.S
+++ b/arch/loongarch/lib/copy_user.S
@@ -3,26 +3,38 @@
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
 
+#include <asm/alternative-asm.h>
 #include <asm/asm.h>
 #include <asm/asmmacro.h>
 #include <asm/asm-extable.h>
+#include <asm/cpu.h>
 #include <asm/export.h>
 #include <asm/regdef.h>
 
-.irp to, 0
+.irp to, 0, 1, 2, 3, 4, 5, 6, 7
 .L_fixup_handle_\to\():
 	addi.d	a0, a2, (\to) * (-8)
 	jr	ra
 .endr
 
+SYM_FUNC_START(__copy_user)
+	/*
+	 * Some CPUs support hardware unaligned access
+	 */
+	ALTERNATIVE	"b __copy_user_generic",	\
+			"b __copy_user_fast", CPU_FEATURE_UAL
+SYM_FUNC_END(__copy_user)
+
+EXPORT_SYMBOL(__copy_user)
+
 /*
- * unsigned long __copy_user(void *to, const void *from, size_t n)
+ * unsigned long __copy_user_generic(void *to, const void *from, size_t n)
  *
  * a0: to
  * a1: from
  * a2: n
  */
-SYM_FUNC_START(__copy_user)
+SYM_FUNC_START(__copy_user_generic)
 	beqz	a2, 3f
 
 1:	ld.b	t0, a1, 0
@@ -37,6 +49,75 @@ SYM_FUNC_START(__copy_user)
 
 	_asm_extable 1, .L_fixup_handle_0
 	_asm_extable 2, .L_fixup_handle_0
-SYM_FUNC_END(__copy_user)
+SYM_FUNC_END(__copy_user_generic)
 
-EXPORT_SYMBOL(__copy_user)
+/*
+ * unsigned long __copy_user_fast(void *to, const void *from, unsigned long n)
+ *
+ * a0: to
+ * a1: from
+ * a2: n
+ */
+SYM_FUNC_START(__copy_user_fast)
+	beqz	a2, 19f
+
+	ori	a3, zero, 64
+	blt	a2, a3, 17f
+
+	/* copy 64 bytes at a time */
+1:	ld.d	t0, a1, 0
+2:	ld.d	t1, a1, 8
+3:	ld.d	t2, a1, 16
+4:	ld.d	t3, a1, 24
+5:	ld.d	t4, a1, 32
+6:	ld.d	t5, a1, 40
+7:	ld.d	t6, a1, 48
+8:	ld.d	t7, a1, 56
+9:	st.d	t0, a0, 0
+10:	st.d	t1, a0, 8
+11:	st.d	t2, a0, 16
+12:	st.d	t3, a0, 24
+13:	st.d	t4, a0, 32
+14:	st.d	t5, a0, 40
+15:	st.d	t6, a0, 48
+16:	st.d	t7, a0, 56
+
+	addi.d	a0, a0, 64
+	addi.d	a1, a1, 64
+	addi.d	a2, a2, -64
+	bge	a2, a3, 1b
+
+	beqz	a2, 19f
+
+	/* copy the remaining bytes */
+17:	ld.b	t0, a1, 0
+18:	st.b	t0, a0, 0
+	addi.d	a0, a0, 1
+	addi.d	a1, a1, 1
+	addi.d	a2, a2, -1
+	bgt	a2, zero, 17b
+
+	/* return */
+19:	move	a0, a2
+	jr	ra
+
+	/* fixup and ex_table */
+	_asm_extable 1b, .L_fixup_handle_0
+	_asm_extable 2b, .L_fixup_handle_1
+	_asm_extable 3b, .L_fixup_handle_2
+	_asm_extable 4b, .L_fixup_handle_3
+	_asm_extable 5b, .L_fixup_handle_4
+	_asm_extable 6b, .L_fixup_handle_5
+	_asm_extable 7b, .L_fixup_handle_6
+	_asm_extable 8b, .L_fixup_handle_7
+	_asm_extable 9b, .L_fixup_handle_0
+	_asm_extable 10b, .L_fixup_handle_1
+	_asm_extable 11b, .L_fixup_handle_2
+	_asm_extable 12b, .L_fixup_handle_3
+	_asm_extable 13b, .L_fixup_handle_4
+	_asm_extable 14b, .L_fixup_handle_5
+	_asm_extable 15b, .L_fixup_handle_6
+	_asm_extable 16b, .L_fixup_handle_7
+	_asm_extable 17b, .L_fixup_handle_0
+	_asm_extable 18b, .L_fixup_handle_0
+SYM_FUNC_END(__copy_user_fast)
diff --git a/arch/loongarch/lib/memcpy.S b/arch/loongarch/lib/memcpy.S
new file mode 100644
index 000000000000..7c07d595ee89
--- /dev/null
+++ b/arch/loongarch/lib/memcpy.S
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#include <asm/alternative-asm.h>
+#include <asm/asm.h>
+#include <asm/asmmacro.h>
+#include <asm/cpu.h>
+#include <asm/export.h>
+#include <asm/regdef.h>
+
+SYM_FUNC_START(memcpy)
+	/*
+	 * Some CPUs support hardware unaligned access
+	 */
+	ALTERNATIVE	"b __memcpy_generic", \
+			"b __memcpy_fast", CPU_FEATURE_UAL
+SYM_FUNC_END(memcpy)
+
+EXPORT_SYMBOL(memcpy)
+
+/*
+ * void *__memcpy_generic(void *dst, const void *src, size_t n)
+ *
+ * a0: dst
+ * a1: src
+ * a2: n
+ */
+SYM_FUNC_START(__memcpy_generic)
+	move	a3, a0
+	beqz	a2, 2f
+
+1:	ld.b	t0, a1, 0
+	st.b	t0, a0, 0
+	addi.d	a0, a0, 1
+	addi.d	a1, a1, 1
+	addi.d	a2, a2, -1
+	bgt	a2, zero, 1b
+
+2:	move	a0, a3
+	jr	ra
+SYM_FUNC_END(__memcpy_generic)
+
+/*
+ * void *__memcpy_fast(void *dst, const void *src, size_t n)
+ *
+ * a0: dst
+ * a1: src
+ * a2: n
+ */
+SYM_FUNC_START(__memcpy_fast)
+	move	a3, a0
+	beqz	a2, 3f
+
+	ori	a4, zero, 64
+	blt	a2, a4, 2f
+
+	/* copy 64 bytes at a time */
+1:	ld.d	t0, a1, 0
+	ld.d	t1, a1, 8
+	ld.d	t2, a1, 16
+	ld.d	t3, a1, 24
+	ld.d	t4, a1, 32
+	ld.d	t5, a1, 40
+	ld.d	t6, a1, 48
+	ld.d	t7, a1, 56
+	st.d	t0, a0, 0
+	st.d	t1, a0, 8
+	st.d	t2, a0, 16
+	st.d	t3, a0, 24
+	st.d	t4, a0, 32
+	st.d	t5, a0, 40
+	st.d	t6, a0, 48
+	st.d	t7, a0, 56
+
+	addi.d	a0, a0, 64
+	addi.d	a1, a1, 64
+	addi.d	a2, a2, -64
+	bge	a2, a4, 1b
+
+	beqz	a2, 3f
+
+	/* copy the remaining bytes */
+2:	ld.b	t0, a1, 0
+	st.b	t0, a0, 0
+	addi.d	a0, a0, 1
+	addi.d	a1, a1, 1
+	addi.d	a2, a2, -1
+	bgt	a2, zero, 2b
+
+	/* return */
+3:	move	a0, a3
+	jr	ra
+SYM_FUNC_END(__memcpy_fast)
diff --git a/arch/loongarch/lib/memmove.S b/arch/loongarch/lib/memmove.S
new file mode 100644
index 000000000000..6ffdb46da78f
--- /dev/null
+++ b/arch/loongarch/lib/memmove.S
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#include <asm/alternative-asm.h>
+#include <asm/asm.h>
+#include <asm/asmmacro.h>
+#include <asm/cpu.h>
+#include <asm/export.h>
+#include <asm/regdef.h>
+
+SYM_FUNC_START(memmove)
+	blt	a0, a1, 1f	/* dst < src, memcpy */
+	blt	a1, a0, 3f	/* src < dst, rmemcpy */
+	jr	ra		/* dst == src, return */
+
+	/* if (src - dst) < 64, copy 1 byte at a time */
+1:	ori	a3, zero, 64
+	sub.d	t0, a1, a0
+	blt	t0, a3, 2f
+	b	memcpy
+2:	b	__memcpy_generic
+
+	/* if (dst - src) < 64, copy 1 byte at a time */
+3:	ori	a3, zero, 64
+	sub.d	t0, a0, a1
+	blt	t0, a3, 4f
+	b	rmemcpy
+4:	b	__rmemcpy_generic
+SYM_FUNC_END(memmove)
+
+EXPORT_SYMBOL(memmove)
+
+SYM_FUNC_START(rmemcpy)
+	/*
+	 * Some CPUs support hardware unaligned access
+	 */
+	ALTERNATIVE	"b __rmemcpy_generic", \
+			"b __rmemcpy_fast", CPU_FEATURE_UAL
+SYM_FUNC_END(rmemcpy)
+
+/*
+ * void *__rmemcpy_generic(void *dst, const void *src, size_t n)
+ *
+ * a0: dst
+ * a1: src
+ * a2: n
+ */
+SYM_FUNC_START(__rmemcpy_generic)
+	move	a3, a0
+	beqz	a2, 2f
+
+	add.d	a0, a0, a2
+	add.d	a1, a1, a2
+
+1:	ld.b	t0, a1, -1
+	st.b	t0, a0, -1
+	addi.d	a0, a0, -1
+	addi.d	a1, a1, -1
+	addi.d	a2, a2, -1
+	bgt	a2, zero, 1b
+
+2:	move	a0, a3
+	jr	ra
+SYM_FUNC_END(__rmemcpy_generic)
+
+/*
+ * void *__rmemcpy_fast(void *dst, const void *src, size_t n)
+ *
+ * a0: dst
+ * a1: src
+ * a2: n
+ */
+SYM_FUNC_START(__rmemcpy_fast)
+	move	a3, a0
+	beqz	a2, 3f
+
+	add.d	a0, a0, a2
+	add.d	a1, a1, a2
+
+	ori	a4, zero, 64
+	blt	a2, a4, 2f
+
+	/* copy 64 bytes at a time */
+1:	ld.d	t0, a1, -8
+	ld.d	t1, a1, -16
+	ld.d	t2, a1, -24
+	ld.d	t3, a1, -32
+	ld.d	t4, a1, -40
+	ld.d	t5, a1, -48
+	ld.d	t6, a1, -56
+	ld.d	t7, a1, -64
+	st.d	t0, a0, -8
+	st.d	t1, a0, -16
+	st.d	t2, a0, -24
+	st.d	t3, a0, -32
+	st.d	t4, a0, -40
+	st.d	t5, a0, -48
+	st.d	t6, a0, -56
+	st.d	t7, a0, -64
+
+	addi.d	a0, a0, -64
+	addi.d	a1, a1, -64
+	addi.d	a2, a2, -64
+	bge	a2, a4, 1b
+
+	beqz	a2, 3f
+
+	/* copy the remaining bytes */
+2:	ld.b	t0, a1, -1
+	st.b	t0, a0, -1
+	addi.d	a0, a0, -1
+	addi.d	a1, a1, -1
+	addi.d	a2, a2, -1
+	bgt	a2, zero, 2b
+
+	/* return */
+3:	move	a0, a3
+	jr	ra
+SYM_FUNC_END(__rmemcpy_fast)
diff --git a/arch/loongarch/lib/memset.S b/arch/loongarch/lib/memset.S
new file mode 100644
index 000000000000..e7cb4ea3747d
--- /dev/null
+++ b/arch/loongarch/lib/memset.S
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#include <asm/alternative-asm.h>
+#include <asm/asm.h>
+#include <asm/asmmacro.h>
+#include <asm/cpu.h>
+#include <asm/export.h>
+#include <asm/regdef.h>
+
+.macro fill_to_64 r0
+	bstrins.d \r0, \r0, 15, 8
+	bstrins.d \r0, \r0, 31, 16
+	bstrins.d \r0, \r0, 63, 32
+.endm
+
+SYM_FUNC_START(memset)
+	/*
+	 * Some CPUs support hardware unaligned access
+	 */
+	ALTERNATIVE	"b __memset_generic", \
+			"b __memset_fast", CPU_FEATURE_UAL
+SYM_FUNC_END(memset)
+
+EXPORT_SYMBOL(memset)
+
+/*
+ * void *__memset_generic(void *s, int c, size_t n)
+ *
+ * a0: s
+ * a1: c
+ * a2: n
+ */
+SYM_FUNC_START(__memset_generic)
+	move	a3, a0
+	beqz	a2, 2f
+
+1:	st.b	a1, a0, 0
+	addi.d	a0, a0, 1
+	addi.d	a2, a2, -1
+	bgt	a2, zero, 1b
+
+2:	move	a0, a3
+	jr	ra
+SYM_FUNC_END(__memset_generic)
+
+/*
+ * void *__memset_fast(void *s, int c, size_t n)
+ *
+ * a0: s
+ * a1: c
+ * a2: n
+ */
+SYM_FUNC_START(__memset_fast)
+	move	a3, a0
+	beqz	a2, 3f
+
+	ori	a4, zero, 64
+	blt	a2, a4, 2f
+
+	/* fill a1 to 64 bits */
+	fill_to_64 a1
+
+	/* set 64 bytes at a time */
+1:	st.d	a1, a0, 0
+	st.d	a1, a0, 8
+	st.d	a1, a0, 16
+	st.d	a1, a0, 24
+	st.d	a1, a0, 32
+	st.d	a1, a0, 40
+	st.d	a1, a0, 48
+	st.d	a1, a0, 56
+
+	addi.d	a0, a0, 64
+	addi.d	a2, a2, -64
+	bge	a2, a4, 1b
+
+	beqz	a2, 3f
+
+	/* set the remaining bytes */
+2:	st.b	a1, a0, 0
+	addi.d	a0, a0, 1
+	addi.d	a2, a2, -1
+	bgt	a2, zero, 2b
+
+	/* return */
+3:	move	a0, a3
+	jr	ra
+SYM_FUNC_END(__memset_fast)
-- 
2.31.1

