Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34424DE8C2
	for <lists+linux-arch@lfdr.de>; Sat, 19 Mar 2022 15:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243290AbiCSOoV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Mar 2022 10:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243318AbiCSOoS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Mar 2022 10:44:18 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB6D25ECA0;
        Sat, 19 Mar 2022 07:42:47 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso12788412pjb.0;
        Sat, 19 Mar 2022 07:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BnvxKtcxua6ET21Wu4RYGi88E19MVLNMoiSko413f50=;
        b=CljDZafP6W9Vk9bqWADAyVlQNoByKWKSfs59RpNq9ZtGH2MXS3cJr2eNU4Bl6rYV9C
         n2Fn8yRbOhseSmEoO+HecvhttvMiv9dM7MTB3SFoB4Cr/YOpVPXjGuMTm4i/M/IFs+9d
         BD1dbon8UG0s84permUubrckJwkRF87muIs6/zYMWbvW7fTz0/wwzAFRzzxAamTdbLay
         Fryv8AwQ3SNjqu9UMcWMJEsy2V1vt0+cMvy+yFOZ+HJsWjWbUTMV45Tu28SIfp0ci/ER
         WFWhlpXzO45GxPKclBc7eE9Tbkildn9NUezMF3soUYLWXUM+RtKvzeQ/k2ApBEgRbWJz
         9kZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=BnvxKtcxua6ET21Wu4RYGi88E19MVLNMoiSko413f50=;
        b=zaKWm19Uqr8Jw5lzvoxfmVknBhiDI5PH7Zw/jzto9N+5YxNdSmXc9Mv3EvQcGWFnap
         d5eOeXMKPx955r+/6ltDRmRC+qQbLnvOSsZ9YANYgSsWClaXYP7HNCjtxj9GXgLgMbY2
         ibM5VQKi1JV5/T0TzZ9ZJmZuQ6VeqYIhKZwsVS0QLDS4RnTuM50sCc0gCdlNtn8e/4E2
         shJgyzIPwKvD/n/ZjzK73Uqu2QNq5D75XvQNI0ZHa6nJDwTkukQrn4gqez9TKqRW9K9C
         Smx6bjyyTGSXShpzJrXkYbJpLMl5I1nTSNH1rXh5C9U1FeTCRK82PbBphyttG2c8IyrH
         TZFQ==
X-Gm-Message-State: AOAM5319eOZW5ZTzAo3KG2kKg8rDdSmlhO1GhpDmjSPQYnPImfwWQfAt
        YnHOiZptOX5hATQBLWyx9Dc=
X-Google-Smtp-Source: ABdhPJxopp99BC9gE4IBZMYCydSDGuDQ/fDvPr0FpuVttGSHwYhO2ITGJxWX98ZVSJUKnlTR/R+eeQ==
X-Received: by 2002:a17:903:32c3:b0:152:c1b:e840 with SMTP id i3-20020a17090332c300b001520c1be840mr4494602plr.40.1647700967160;
        Sat, 19 Mar 2022 07:42:47 -0700 (PDT)
Received: from localhost.localdomain ([50.7.60.25])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090aa00c00b001bc6f1baaaesm14546829pjp.39.2022.03.19.07.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 07:42:46 -0700 (PDT)
Sender: Huacai Chen <chenhuacai@gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
X-Google-Original-From: Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V8 17/22] LoongArch: Add some library functions
Date:   Sat, 19 Mar 2022 22:38:12 +0800
Message-Id: <20220319143817.1026708-10-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220319143817.1026708-1-chenhuacai@loongson.cn>
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
 <20220319143817.1026708-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds some library functions for LoongArch, including: delay,
memset, memcpy, memmove, copy_user, strncpy_user, strnlen_user and tlb
dump functions.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/delay.h  |  26 +++++++
 arch/loongarch/include/asm/string.h |  17 +++++
 arch/loongarch/lib/clear_user.S     |  43 +++++++++++
 arch/loongarch/lib/copy_user.S      |  47 ++++++++++++
 arch/loongarch/lib/delay.c          |  43 +++++++++++
 arch/loongarch/lib/dump_tlb.c       | 111 ++++++++++++++++++++++++++++
 arch/loongarch/lib/memcpy.S         |  32 ++++++++
 arch/loongarch/lib/memmove.S        |  45 +++++++++++
 arch/loongarch/lib/memset.S         |  30 ++++++++
 9 files changed, 394 insertions(+)
 create mode 100644 arch/loongarch/include/asm/delay.h
 create mode 100644 arch/loongarch/include/asm/string.h
 create mode 100644 arch/loongarch/lib/clear_user.S
 create mode 100644 arch/loongarch/lib/copy_user.S
 create mode 100644 arch/loongarch/lib/delay.c
 create mode 100644 arch/loongarch/lib/dump_tlb.c
 create mode 100644 arch/loongarch/lib/memcpy.S
 create mode 100644 arch/loongarch/lib/memmove.S
 create mode 100644 arch/loongarch/lib/memset.S

diff --git a/arch/loongarch/include/asm/delay.h b/arch/loongarch/include/asm/delay.h
new file mode 100644
index 000000000000..016b3aca65cb
--- /dev/null
+++ b/arch/loongarch/include/asm/delay.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_DELAY_H
+#define _ASM_DELAY_H
+
+#include <linux/param.h>
+
+extern void __delay(unsigned long loops);
+extern void __ndelay(unsigned long ns);
+extern void __udelay(unsigned long us);
+
+#define ndelay(ns) __ndelay(ns)
+#define udelay(us) __udelay(us)
+
+/* make sure "usecs *= ..." in udelay do not overflow. */
+#if HZ >= 1000
+#define MAX_UDELAY_MS	1
+#elif HZ <= 200
+#define MAX_UDELAY_MS	5
+#else
+#define MAX_UDELAY_MS	(1000 / HZ)
+#endif
+
+#endif /* _ASM_DELAY_H */
diff --git a/arch/loongarch/include/asm/string.h b/arch/loongarch/include/asm/string.h
new file mode 100644
index 000000000000..7b29cc9c70aa
--- /dev/null
+++ b/arch/loongarch/include/asm/string.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_STRING_H
+#define _ASM_STRING_H
+
+#define __HAVE_ARCH_MEMSET
+extern void *memset(void *__s, int __c, size_t __count);
+
+#define __HAVE_ARCH_MEMCPY
+extern void *memcpy(void *__to, __const__ void *__from, size_t __n);
+
+#define __HAVE_ARCH_MEMMOVE
+extern void *memmove(void *__dest, __const__ void *__src, size_t __n);
+
+#endif /* _ASM_STRING_H */
diff --git a/arch/loongarch/lib/clear_user.S b/arch/loongarch/lib/clear_user.S
new file mode 100644
index 000000000000..b8168d22ac80
--- /dev/null
+++ b/arch/loongarch/lib/clear_user.S
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#include <asm/asm.h>
+#include <asm/asmmacro.h>
+#include <asm/export.h>
+#include <asm/regdef.h>
+
+.macro fixup_ex from, to, offset, fix
+.if \fix
+	.section .fixup, "ax"
+\to:	addi.d	v0, a1, \offset
+	jr	ra
+	.previous
+.endif
+	.section __ex_table, "a"
+	PTR	\from\()b, \to\()b
+	.previous
+.endm
+
+/*
+ * unsigned long __clear_user(void *addr, size_t size)
+ *
+ * a0: addr
+ * a1: size
+ */
+SYM_FUNC_START(__clear_user)
+	beqz	a1, 2f
+
+1:	st.b	zero, a0, 0
+	addi.d	a0, a0, 1
+	addi.d	a1, a1, -1
+	bgt	a1, zero, 1b
+
+2:	move	v0, a1
+	jr	ra
+
+	fixup_ex 1, 3, 0, 1
+SYM_FUNC_END(__clear_user)
+
+EXPORT_SYMBOL(__clear_user)
diff --git a/arch/loongarch/lib/copy_user.S b/arch/loongarch/lib/copy_user.S
new file mode 100644
index 000000000000..43ed26304954
--- /dev/null
+++ b/arch/loongarch/lib/copy_user.S
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#include <asm/asm.h>
+#include <asm/asmmacro.h>
+#include <asm/export.h>
+#include <asm/regdef.h>
+
+.macro fixup_ex from, to, offset, fix
+.if \fix
+	.section .fixup, "ax"
+\to:	addi.d	v0, a2, \offset
+	jr	ra
+	.previous
+.endif
+	.section __ex_table, "a"
+	PTR	\from\()b, \to\()b
+	.previous
+.endm
+
+/*
+ * unsigned long __copy_user(void *to, const void *from, size_t n)
+ *
+ * a0: to
+ * a1: from
+ * a2: n
+ */
+SYM_FUNC_START(__copy_user)
+	beqz	a2, 3f
+
+1:	ld.b	t0, a1, 0
+2:	st.b	t0, a0, 0
+	addi.d	a0, a0, 1
+	addi.d	a1, a1, 1
+	addi.d	a2, a2, -1
+	bgt	a2, zero, 1b
+
+3:	move	v0, a2
+	jr	ra
+
+	fixup_ex 1, 4, 0, 1
+	fixup_ex 2, 4, 0, 0
+SYM_FUNC_END(__copy_user)
+
+EXPORT_SYMBOL(__copy_user)
diff --git a/arch/loongarch/lib/delay.c b/arch/loongarch/lib/delay.c
new file mode 100644
index 000000000000..5d856694fcfe
--- /dev/null
+++ b/arch/loongarch/lib/delay.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#include <linux/delay.h>
+#include <linux/export.h>
+#include <linux/smp.h>
+#include <linux/timex.h>
+
+#include <asm/compiler.h>
+#include <asm/processor.h>
+
+void __delay(unsigned long cycles)
+{
+	u64 t0 = get_cycles();
+
+	while ((unsigned long)(get_cycles() - t0) < cycles)
+		cpu_relax();
+}
+EXPORT_SYMBOL(__delay);
+
+/*
+ * Division by multiplication: you don't have to worry about
+ * loss of precision.
+ *
+ * Use only for very small delays ( < 1 msec).	Should probably use a
+ * lookup table, really, as the multiplications take much too long with
+ * short delays.  This is a "reasonable" implementation, though (and the
+ * first constant multiplications gets optimized away if the delay is
+ * a constant)
+ */
+
+void __udelay(unsigned long us)
+{
+	__delay((us * 0x000010c7ull * HZ * lpj_fine) >> 32);
+}
+EXPORT_SYMBOL(__udelay);
+
+void __ndelay(unsigned long ns)
+{
+	__delay((ns * 0x00000005ull * HZ * lpj_fine) >> 32);
+}
+EXPORT_SYMBOL(__ndelay);
diff --git a/arch/loongarch/lib/dump_tlb.c b/arch/loongarch/lib/dump_tlb.c
new file mode 100644
index 000000000000..b6c6b401390a
--- /dev/null
+++ b/arch/loongarch/lib/dump_tlb.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ *
+ * Derived from MIPS:
+ * Copyright (C) 1994, 1995 by Waldorf Electronics, written by Ralf Baechle.
+ * Copyright (C) 1999 by Silicon Graphics, Inc.
+ */
+#include <linux/kernel.h>
+#include <linux/mm.h>
+
+#include <asm/loongarch.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/tlb.h>
+
+void dump_tlb_regs(void)
+{
+	const int field = 2 * sizeof(unsigned long);
+
+	pr_info("Index    : %0x\n", read_csr_tlbidx());
+	pr_info("PageSize : %0x\n", read_csr_pagesize());
+	pr_info("EntryHi  : %0*lx\n", field, read_csr_entryhi());
+	pr_info("EntryLo0 : %0*lx\n", field, read_csr_entrylo0());
+	pr_info("EntryLo1 : %0*lx\n", field, read_csr_entrylo1());
+}
+
+static void dump_tlb(int first, int last)
+{
+	unsigned long s_entryhi, entryhi, asid;
+	unsigned long long entrylo0, entrylo1, pa;
+	unsigned int index;
+	unsigned int s_index, s_asid;
+	unsigned int pagesize, c0, c1, i;
+	unsigned long asidmask = cpu_asid_mask(&current_cpu_data);
+	int pwidth = 11;
+	int vwidth = 11;
+	int asidwidth = DIV_ROUND_UP(ilog2(asidmask) + 1, 4);
+
+	s_entryhi = read_csr_entryhi();
+	s_index = read_csr_tlbidx();
+	s_asid = read_csr_asid();
+
+	for (i = first; i <= last; i++) {
+		write_csr_index(i);
+		tlb_read();
+		pagesize = read_csr_pagesize();
+		entryhi	 = read_csr_entryhi();
+		entrylo0 = read_csr_entrylo0();
+		entrylo1 = read_csr_entrylo1();
+		index = read_csr_tlbidx();
+		asid = read_csr_asid();
+
+		/* EHINV bit marks entire entry as invalid */
+		if (index & CSR_TLBIDX_EHINV)
+			continue;
+		/*
+		 * ASID takes effect in absence of G (global) bit.
+		 */
+		if (!((entrylo0 | entrylo1) & ENTRYLO_G) &&
+		    asid != s_asid)
+			continue;
+
+		/*
+		 * Only print entries in use
+		 */
+		pr_info("Index: %2d pgsize=%x ", i, (1 << pagesize));
+
+		c0 = (entrylo0 & ENTRYLO_C) >> ENTRYLO_C_SHIFT;
+		c1 = (entrylo1 & ENTRYLO_C) >> ENTRYLO_C_SHIFT;
+
+		pr_cont("va=%0*lx asid=%0*lx",
+			vwidth, (entryhi & ~0x1fffUL), asidwidth, asid & asidmask);
+
+		/* NR/NX are in awkward places, so mask them off separately */
+		pa = entrylo0 & ~(ENTRYLO_NR | ENTRYLO_NX);
+		pa = pa & PAGE_MASK;
+		pr_cont("\n\t[");
+		pr_cont("ri=%d xi=%d ",
+			(entrylo0 & ENTRYLO_NR) ? 1 : 0,
+			(entrylo0 & ENTRYLO_NX) ? 1 : 0);
+		pr_cont("pa=%0*llx c=%d d=%d v=%d g=%d plv=%lld] [",
+			pwidth, pa, c0,
+			(entrylo0 & ENTRYLO_D) ? 1 : 0,
+			(entrylo0 & ENTRYLO_V) ? 1 : 0,
+			(entrylo0 & ENTRYLO_G) ? 1 : 0,
+			(entrylo0 & ENTRYLO_PLV) >> ENTRYLO_PLV_SHIFT);
+		/* NR/NX are in awkward places, so mask them off separately */
+		pa = entrylo1 & ~(ENTRYLO_NR | ENTRYLO_NX);
+		pa = pa & PAGE_MASK;
+		pr_cont("ri=%d xi=%d ",
+			(entrylo1 & ENTRYLO_NR) ? 1 : 0,
+			(entrylo1 & ENTRYLO_NX) ? 1 : 0);
+		pr_cont("pa=%0*llx c=%d d=%d v=%d g=%d plv=%lld]\n",
+			pwidth, pa, c1,
+			(entrylo1 & ENTRYLO_D) ? 1 : 0,
+			(entrylo1 & ENTRYLO_V) ? 1 : 0,
+			(entrylo1 & ENTRYLO_G) ? 1 : 0,
+			(entrylo1 & ENTRYLO_PLV) >> ENTRYLO_PLV_SHIFT);
+	}
+	pr_info("\n");
+
+	write_csr_entryhi(s_entryhi);
+	write_csr_tlbidx(s_index);
+	write_csr_asid(s_asid);
+}
+
+void dump_tlb_all(void)
+{
+	dump_tlb(0, current_cpu_data.tlbsize - 1);
+}
diff --git a/arch/loongarch/lib/memcpy.S b/arch/loongarch/lib/memcpy.S
new file mode 100644
index 000000000000..d53f1148d26b
--- /dev/null
+++ b/arch/loongarch/lib/memcpy.S
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#include <asm/asmmacro.h>
+#include <asm/export.h>
+#include <asm/regdef.h>
+
+/*
+ * void *memcpy(void *dst, const void *src, size_t n)
+ *
+ * a0: dst
+ * a1: src
+ * a2: n
+ */
+SYM_FUNC_START(memcpy)
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
+2:	move	v0, a3
+	jr	ra
+SYM_FUNC_END(memcpy)
+
+EXPORT_SYMBOL(memcpy)
diff --git a/arch/loongarch/lib/memmove.S b/arch/loongarch/lib/memmove.S
new file mode 100644
index 000000000000..18907d83a83b
--- /dev/null
+++ b/arch/loongarch/lib/memmove.S
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#include <asm/asmmacro.h>
+#include <asm/export.h>
+#include <asm/regdef.h>
+
+/*
+ * void *rmemcpy(void *dst, const void *src, size_t n)
+ *
+ * a0: dst
+ * a1: src
+ * a2: n
+ */
+SYM_FUNC_START(rmemcpy)
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
+2:	move	v0, a3
+	jr	ra
+SYM_FUNC_END(rmemcpy)
+
+SYM_FUNC_START(memmove)
+	blt	a0, a1, 1f	/* dst < src, memcpy */
+	blt	a1, a0, 2f	/* src < dst, rmemcpy */
+	jr	ra		/* dst == src, return */
+
+1:	b	memcpy
+
+2:	b	rmemcpy
+SYM_FUNC_END(memmove)
+
+EXPORT_SYMBOL(memmove)
diff --git a/arch/loongarch/lib/memset.S b/arch/loongarch/lib/memset.S
new file mode 100644
index 000000000000..3fc3e7da5263
--- /dev/null
+++ b/arch/loongarch/lib/memset.S
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#include <asm/asmmacro.h>
+#include <asm/export.h>
+#include <asm/regdef.h>
+
+/*
+ * void *memset(void *s, int c, size_t n)
+ *
+ * a0: s
+ * a1: c
+ * a2: n
+ */
+SYM_FUNC_START(memset)
+	move	a3, a0
+	beqz	a2, 2f
+
+1:	st.b	a1, a0, 0
+	addi.d	a0, a0, 1
+	addi.d	a2, a2, -1
+	bgt	a2, zero, 1b
+
+2:	move	v0, a3
+	jr	ra
+SYM_FUNC_END(memset)
+
+EXPORT_SYMBOL(memset)
-- 
2.27.0

