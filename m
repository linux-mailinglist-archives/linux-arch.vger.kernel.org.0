Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F3767574B
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 15:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjATOfT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 09:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjATOfR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 09:35:17 -0500
Received: from fx601.security-mail.net (smtpout140.security-mail.net [85.31.212.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC17479E9A
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 06:35:03 -0800 (PST)
Received: from localhost (fx601.security-mail.net [127.0.0.1])
        by fx601.security-mail.net (Postfix) with ESMTP id BDC6F34991B
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 15:20:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1674224449;
        bh=fw6xXMajXNjhx0jPLjaTVFvl+I1RBxPH9f2FQVoTEPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CXg63U8cHU2subSM4SlqKRMbOw+fdUD1Tqo5PXK4ZogMF6452Gh9QVEInt4FG8qug
         oZn+36xwinF+fAz2NoY7SzGTjjRYDmZBSKy8bnai9bmZcKG9edS1DxLgrWGckMpL4g
         bfUbm+JKD+AM0Jk6ZM+RXY0QM619HvTBOIs21GTw=
Received: from fx601 (fx601.security-mail.net [127.0.0.1]) by
 fx601.security-mail.net (Postfix) with ESMTP id 2FC7D349967; Fri, 20 Jan
 2023 15:20:48 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx601.security-mail.net (Postfix) with ESMTPS id 306C03497EB; Fri, 20 Jan
 2023 15:20:45 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id B864627E045F; Fri, 20 Jan 2023
 15:10:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 9CEA627E0454; Fri, 20 Jan 2023 15:10:36 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 7CE7-x7Qz5OQ; Fri, 20 Jan 2023 15:10:36 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 1B83627E044D; Fri, 20 Jan 2023
 15:10:36 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <13f7d.63caa33d.2a770.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 9CEA627E0454
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674223836;
 bh=YnkI4+XhgeX78k8Q76ZoPcPy7yxNCCbWh8zxK5y9348=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=kXXFp1pZMzHhPKFRYroM8/+PkRoYHECkiE7VI0nI/pcainE5mFvWs5yGxLS/FH72I
 QLBaLeM+ZIUYoh8/PgBah6cKyRj1t5TCW0flycsAXJljcKSjQjxt9DsZ0D4Hi0eSFd
 nitw2XqnaM5PMEVqFZnjDe+DcM3WsGZcWMCBSfJs=
From:   Yann Sionneau <ysionneau@kalray.eu>
To:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Yann Sionneau <ysionneau@kalray.eu>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Clement Leger <clement@clement-leger.fr>,
        Vincent Chardon <vincent.chardon@elsys-design.com>,
        Marc =?utf-8?b?UG91bGhpw6hz?= <dkm@kataplop.net>,
        Julian Vetter <jvetter@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Marius Gligor <mgligor@kalray.eu>,
        Jonathan Borne <jborne@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        Louis Morhet <lmorhet@kalray.eu>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        Guillaume Missonnier <gmissonnier@kalray.eu>,
        Alex Michon <amichon@kalray.eu>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <git@xen0n.name>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Bibo Mao <maobibo@loongson.cn>,
        Atish Patra <atishp@atishpatra.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Qi Liu <liuqi115@huawei.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-audit@redhat.com,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: [RFC PATCH v2 25/31] kvx: Add some library functions
Date:   Fri, 20 Jan 2023 15:09:56 +0100
Message-ID: <20230120141002.2442-26-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230120141002.2442-1-ysionneau@kalray.eu>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add some library functions for kvx, including: delay, memset,
memcpy, strlen, clear_page, copy_page, raw_copy_from/to_user,
asm_clear_user.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Co-developed-by: Marius Gligor <mgligor@kalray.eu>
Signed-off-by: Marius Gligor <mgligor@kalray.eu>
Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---

Notes:
    V1 -> V2: no changes

 arch/kvx/include/asm/string.h |  20 ++
 arch/kvx/kernel/kvx_ksyms.c   |   5 +
 arch/kvx/lib/clear_page.S     |  40 ++++
 arch/kvx/lib/copy_page.S      |  90 +++++++++
 arch/kvx/lib/delay.c          |  39 ++++
 arch/kvx/lib/memcpy.c         |  70 +++++++
 arch/kvx/lib/memset.S         | 351 ++++++++++++++++++++++++++++++++++
 arch/kvx/lib/strlen.S         | 122 ++++++++++++
 arch/kvx/lib/usercopy.S       |  90 +++++++++
 9 files changed, 827 insertions(+)
 create mode 100644 arch/kvx/include/asm/string.h
 create mode 100644 arch/kvx/lib/clear_page.S
 create mode 100644 arch/kvx/lib/copy_page.S
 create mode 100644 arch/kvx/lib/delay.c
 create mode 100644 arch/kvx/lib/memcpy.c
 create mode 100644 arch/kvx/lib/memset.S
 create mode 100644 arch/kvx/lib/strlen.S
 create mode 100644 arch/kvx/lib/usercopy.S

diff --git a/arch/kvx/include/asm/string.h b/arch/kvx/include/asm/string.h
new file mode 100644
index 000000000000..677c1393a5cd
--- /dev/null
+++ b/arch/kvx/include/asm/string.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Jules Maselbas
+ */
+
+#ifndef _ASM_KVX_STRING_H
+#define _ASM_KVX_STRING_H
+
+#define __HAVE_ARCH_MEMSET
+extern void *memset(void *s, int c, size_t n);
+
+#define __HAVE_ARCH_MEMCPY
+extern void *memcpy(void *dest, const void *src, size_t n);
+
+#define __HAVE_ARCH_STRLEN
+extern size_t strlen(const char *s);
+
+#endif	/* _ASM_KVX_STRING_H */
diff --git a/arch/kvx/kernel/kvx_ksyms.c b/arch/kvx/kernel/kvx_ksyms.c
index 18990aaf259f..678f81716dea 100644
--- a/arch/kvx/kernel/kvx_ksyms.c
+++ b/arch/kvx/kernel/kvx_ksyms.c
@@ -22,3 +22,8 @@ DECLARE_EXPORT(__umoddi3);
 DECLARE_EXPORT(__divdi3);
 DECLARE_EXPORT(__udivdi3);
 DECLARE_EXPORT(__multi3);
+
+DECLARE_EXPORT(clear_page);
+DECLARE_EXPORT(copy_page);
+DECLARE_EXPORT(memset);
+DECLARE_EXPORT(asm_clear_user);
diff --git a/arch/kvx/lib/clear_page.S b/arch/kvx/lib/clear_page.S
new file mode 100644
index 000000000000..364fe0663ca2
--- /dev/null
+++ b/arch/kvx/lib/clear_page.S
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Marius Gligor
+ *            Clement Leger
+ */
+
+#include <linux/linkage.h>
+#include <linux/export.h>
+#include <linux/const.h>
+
+#include <asm/cache.h>
+#include <asm/page.h>
+
+#define CLEAR_PAGE_LOOP_COUNT	(PAGE_SIZE / 32)
+
+/*
+ * Clear page @dest.
+ *
+ * Parameters:
+ *	r0 - dest page
+ */
+ENTRY(clear_page)
+	make $r1 = CLEAR_PAGE_LOOP_COUNT
+	;;
+	make $r4 = 0
+	make $r5 = 0
+	make $r6 = 0
+	make $r7 = 0
+	;;
+
+	loopdo $r1, clear_page_done
+		;;
+		so 0[$r0] = $r4r5r6r7
+		addd $r0 = $r0, 32
+		;;
+	clear_page_done:
+	ret
+	;;
+ENDPROC(clear_page)
diff --git a/arch/kvx/lib/copy_page.S b/arch/kvx/lib/copy_page.S
new file mode 100644
index 000000000000..4bb82d1c964c
--- /dev/null
+++ b/arch/kvx/lib/copy_page.S
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/linkage.h>
+#include <linux/const.h>
+
+#include <asm/page.h>
+
+/* We have 8 load/store octuple (32 bytes) per hardware loop */
+#define COPY_SIZE_PER_LOOP	(32 * 8)
+#define COPY_PAGE_LOOP_COUNT	(PAGE_SIZE / COPY_SIZE_PER_LOOP)
+
+/*
+ * Copy a page from src to dest (both are page aligned)
+ * In order to recover from smem latency, unroll the loop to trigger multiple
+ * onfly loads and avoid waiting too much for them to return.
+ * We use 8 * 32 load even though we could use more (up to 10 loads) to simplify
+ * the handling using a single hardware loop
+ *
+ * Parameters:
+ *	r0 - dest
+ *	r1 - src
+ */
+ENTRY(copy_page)
+	make $r2 = COPY_PAGE_LOOP_COUNT
+	make $r3 = 0
+	;;
+	loopdo $r2, copy_page_done
+		;;
+		/*
+		 * Load 8 * 32 bytes using uncached access to avoid hitting
+		 * the cache
+		 */
+		lo.xs $r32r33r34r35 = $r3[$r1]
+		/* Copy current copy index for store */
+		copyd $r2 = $r3
+		addd $r3 = $r3, 1
+		;;
+		lo.xs $r36r37r38r39 = $r3[$r1]
+		addd $r3 = $r3, 1
+		;;
+		lo.xs $r40r41r42r43 = $r3[$r1]
+		addd $r3 = $r3, 1
+		;;
+		lo.xs $r44r45r46r47 = $r3[$r1]
+		addd $r3 = $r3, 1
+		;;
+		lo.xs $r48r49r50r51 = $r3[$r1]
+		addd $r3 = $r3, 1
+		;;
+		lo.xs $r52r53r54r55 = $r3[$r1]
+		addd $r3 = $r3, 1
+		;;
+		lo.xs $r56r57r58r59 = $r3[$r1]
+		addd $r3 = $r3, 1
+		;;
+		lo.xs $r60r61r62r63 = $r3[$r1]
+		addd $r3 = $r3, 1
+		;;
+		/* And then store all of them */
+		so.xs $r2[$r0] = $r32r33r34r35
+		addd $r2 = $r2, 1
+		;;
+		so.xs $r2[$r0] = $r36r37r38r39
+		addd $r2 = $r2, 1
+		;;
+		so.xs $r2[$r0] = $r40r41r42r43
+		addd $r2 = $r2, 1
+		;;
+		so.xs $r2[$r0] = $r44r45r46r47
+		addd $r2 = $r2, 1
+		;;
+		so.xs $r2[$r0] = $r48r49r50r51
+		addd $r2 = $r2, 1
+		;;
+		so.xs $r2[$r0] = $r52r53r54r55
+		addd $r2 = $r2, 1
+		;;
+		so.xs $r2[$r0] = $r56r57r58r59
+		addd $r2 = $r2, 1
+		;;
+		so.xs $r2[$r0] = $r60r61r62r63
+		;;
+	copy_page_done:
+	ret
+	;;
+ENDPROC(copy_page)
diff --git a/arch/kvx/lib/delay.c b/arch/kvx/lib/delay.c
new file mode 100644
index 000000000000..11295eedc3f5
--- /dev/null
+++ b/arch/kvx/lib/delay.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/export.h>
+#include <linux/delay.h>
+
+#include <asm/param.h>
+#include <asm/timex.h>
+
+void __delay(unsigned long loops)
+{
+	cycles_t target_cycle = get_cycles() + loops;
+
+	while (get_cycles() < target_cycle);
+}
+EXPORT_SYMBOL(__delay);
+
+inline void __const_udelay(unsigned long xloops)
+{
+	u64 loops = (u64)xloops * (u64)loops_per_jiffy * HZ;
+
+	__delay(loops >> 32);
+}
+EXPORT_SYMBOL(__const_udelay);
+
+void __udelay(unsigned long usecs)
+{
+	__const_udelay(usecs * 0x10C7UL); /* 2**32 / 1000000 (rounded up) */
+}
+EXPORT_SYMBOL(__udelay);
+
+void __ndelay(unsigned long nsecs)
+{
+	__const_udelay(nsecs * 0x5UL); /* 2**32 / 1000000000 (rounded up) */
+}
+EXPORT_SYMBOL(__ndelay);
diff --git a/arch/kvx/lib/memcpy.c b/arch/kvx/lib/memcpy.c
new file mode 100644
index 000000000000..b81f746a80ee
--- /dev/null
+++ b/arch/kvx/lib/memcpy.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Yann Sionneau
+ */
+
+#include <linux/export.h>
+#include <linux/types.h>
+
+void *memcpy(void *dest, const void *src, size_t n)
+{
+	__uint128_t *tmp128_d = dest;
+	const __uint128_t *tmp128_s = src;
+	uint64_t *tmp64_d;
+	const uint64_t *tmp64_s;
+	uint32_t *tmp32_d;
+	const uint32_t *tmp32_s;
+	uint16_t *tmp16_d;
+	const uint16_t *tmp16_s;
+	uint8_t *tmp8_d;
+	const uint8_t *tmp8_s;
+
+	while (n >= 16) {
+		*tmp128_d = *tmp128_s;
+		tmp128_d++;
+		tmp128_s++;
+		n -= 16;
+	}
+
+	tmp64_d = (uint64_t *) tmp128_d;
+	tmp64_s = (uint64_t *) tmp128_s;
+	while (n >= 8) {
+		*tmp64_d = *tmp64_s;
+		tmp64_d++;
+		tmp64_s++;
+		n -= 8;
+	}
+
+	tmp32_d = (uint32_t *) tmp64_d;
+	tmp32_s = (uint32_t *) tmp64_s;
+	while (n >= 4) {
+		*tmp32_d = *tmp32_s;
+		tmp32_d++;
+		tmp32_s++;
+		n -= 4;
+	}
+
+	tmp16_d = (uint16_t *) tmp32_d;
+	tmp16_s = (uint16_t *) tmp32_s;
+	while (n >= 2) {
+		*tmp16_d = *tmp16_s;
+		tmp16_d++;
+		tmp16_s++;
+		n -= 2;
+	}
+
+	tmp8_d = (uint8_t *) tmp16_d;
+	tmp8_s = (uint8_t *) tmp16_s;
+	while (n >= 1) {
+		*tmp8_d = *tmp8_s;
+		tmp8_d++;
+		tmp8_s++;
+		n--;
+	}
+
+	return dest;
+}
+EXPORT_SYMBOL(memcpy);
+
diff --git a/arch/kvx/lib/memset.S b/arch/kvx/lib/memset.S
new file mode 100644
index 000000000000..9eebc28da2be
--- /dev/null
+++ b/arch/kvx/lib/memset.S
@@ -0,0 +1,351 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Marius Gligor
+ */
+
+#include <linux/linkage.h>
+
+#include <asm/cache.h>
+
+#define REPLICATE_BYTE_MASK	0x0101010101010101
+#define MIN_SIZE_FOR_ALIGN	128
+
+/*
+ * Optimized memset for kvx architecture
+ *
+ * In order to optimize memset on kvx, we can use various things:
+ * - conditionnal store which avoid branch penalty
+ * - store half/word/double/quad/octuple to store up to 16 bytes at a time
+ * - dzerol to zero a cacheline when the pattern is '0' (often the case)
+ * - hardware loop for steady cases.
+ *
+ * First, we assume that memset is mainly used for zeroing areas. In order
+ * to optimize this case, we consider it to be the fast path of the algorithm.
+ * In both cases (0 and non 0 pattern), we start by checking if the size is
+ * below a minimum size. If so, we skip the alignment part. Indeed, the kvx
+ * supports misalignment and the penalty for letting it do unaligned accesses is
+ * lower than trying to realigning us. So for small sizes, we don't even bother
+ * to realign. Minor difference is that in the memset with 0, we skip after the
+ * dzerol loop since dzerol must be cache-line aligned (no misalignment of
+ * course).
+ * Regarding the non 0 pattern memset, we use sbmm to replicate the pattern on
+ * all bits on a register in one call.
+ * Once alignment has been reached, we can do the hardware loop for both cases(
+ * store octuple/dzerol) in order to optimize throughput. Care must be taken to
+ * align hardware loops on at least 8 bytes for performances.
+ * Once the main loop has been done, we finish the copy by checking length to do
+ * the necessary calls to store remaining bytes.
+ *
+ * Pseudo code (applies for non 0 pattern):
+ *
+ * int memset(void *dest, char pattern, long length)
+ * {
+ * 	long dest_align = -((long) dest);
+ * 	long copy;
+ * 	long orig_dest = dest;
+ *
+ * 	uint64_t pattern = sbmm8(pattern, 0x0101010101010101);
+ * 	uint128_t pattern128 = pattern << 64 | pattern;
+ * 	uint256_t pattern128 = pattern128 << 128 | pattern128;
+ *
+ * 	// Keep only low bits
+ * 	dest_align &= 0x1F;
+ * 	length -= dest_align;
+ *
+ * 	// Byte align
+ * 	copy = align & (1 << 0);
+ * 	if (copy)
+ * 		*((u8 *) dest) = pattern;
+ * 	dest += copy;
+ * 	// Half align
+ * 	copy = align & (1 << 1);
+ * 	if (copy)
+ * 		*((u16 *) dest) = pattern;
+ * 	dest += copy;
+ * 	// Word align
+ * 	copy = align & (1 << 2);
+ * 	if (copy)
+ * 		*((u32 *) dest) = pattern;
+ * 	dest += copy;
+ * 	// Double align
+ * 	copy = align & (1 << 3);
+ * 	if (copy)
+ * 		*((u64 *) dest) = pattern;
+ * 	dest += copy;
+ * 	// Quad align
+ * 	copy = align & (1 << 4);
+ * 	if (copy)
+ * 		*((u128 *) dest) = pattern128;
+ * 	dest += copy;
+ *
+ * 	// We are now aligned on 256 bits
+ * 	loop_octuple_count = size >> 5;
+ * 	for (i = 0; i < loop_octuple_count; i++) {
+ * 		*((u256 *) dest) = pattern256;
+ * 		dest += 32;
+ * 	}
+ *
+ * 	if (length == 0)
+ * 		return orig_dest;
+ *
+ * 	// Copy remaining part
+ * 	remain = length & (1 << 4);
+ * 	if (copy)
+ * 		*((u128 *) dest) = pattern128;
+ * 	dest += remain;
+ * 	remain = length & (1 << 3);
+ * 	if (copy)
+ * 		*((u64 *) dest) = pattern;
+ * 	dest += remain;
+ * 	remain = length & (1 << 2);
+ * 	if (copy)
+ * 		*((u32 *) dest) = pattern;
+ * 	dest += remain;
+ * 	remain = length & (1 << 1);
+ * 	if (copy)
+ * 		*((u16 *) dest) = pattern;
+ * 	dest += remain;
+ * 	remain = length & (1 << 0);
+ * 	if (copy)
+ * 		*((u8 *) dest) = pattern;
+ * 	dest += remain;
+ *
+ * 	return orig_dest;
+ * }
+ */
+
+.text
+.align 16
+ENTRY(memset):
+	make $r32 = 0
+	make $r33 = 0
+	/* Check if length < KVX_DCACHE_LINE_SIZE */
+	compd.ltu $r7 = $r2, KVX_DCACHE_LINE_SIZE
+	/* Jump to generic memset if pattern is != 0 */
+	cb.dnez $r1? memset_non_0_pattern
+	;;
+	/* Preserve return value */
+	copyd $r3 = $r0
+	/* Invert address to compute size to copy to be aligned on 32 bytes */
+	negd $r5 = $r0
+	/* Remaining bytes for 16 bytes store (for alignment on 64 bytes) */
+	andd $r8 = $r2, (1 << 5)
+	copyq $r34r35 = $r32, $r33
+	/* Skip loopdo with dzerol if length < KVX_DCACHE_LINE_SIZE */
+	cb.dnez $r7? .Ldzerol_done
+	;;
+	/* Compute the size that will be copied to align on 64 bytes boundary */
+	andw $r6 = $r5, 0x3F
+	/* Check if address is aligned on 64 bytes */
+	andw $r9 = $r0, 0x3F
+	/* Alignment */
+	nop
+	;;
+	/* If address already aligned on 64 bytes, jump to dzerol loop */
+	cb.deqz $r9? .Laligned_64
+	/* Remove unaligned part from length */
+	sbfd $r2 = $r6, $r2
+	/* Check if we need to copy 1 byte */
+	andw $r4 = $r5, (1 << 0)
+	;;
+	/* If we are not aligned, store byte */
+	sb.dnez $r4? [$r0] = $r32
+	/* Check if we need to copy 2 bytes */
+	andw $r4 = $r5, (1 << 1)
+	/* Add potentially copied part for next store offset */
+	addd $r0 = $r0, $r4
+	;;
+	sh.dnez $r4? [$r0] = $r32
+	/* Check if we need to copy 4 bytes */
+	andw $r4 = $r5, (1 << 2)
+	addd $r0 = $r0, $r4
+	;;
+	sw.dnez $r4? [$r0] = $r32
+	/* Check if we need to copy 8 bytes */
+	andw $r4 = $r5, (1 << 3)
+	addd $r0 = $r0, $r4
+	;;
+	sd.dnez $r4? [$r0] = $r32
+	/* Check if we need to copy 16 bytes */
+	andw $r4 = $r5, (1 << 4)
+	addd $r0 = $r0, $r4
+	;;
+	sq.dnez $r4? [$r0] = $r32r33
+	/* Check if we need to copy 32 bytes */
+	andw $r4 = $r5, (1 << 5)
+	addd $r0 = $r0, $r4
+	;;
+	so.dnez $r4? [$r0] = $r32r33r34r35
+	addd $r0 = $r0, $r4
+	;;
+.Laligned_64:
+	/* Prepare amount of data for dzerol */
+	srld $r10 = $r2, 6
+	/* Size to be handled in loopdo */
+	andd $r4 = $r2, ~0x3F
+	make $r11 = 64
+	cb.deqz $r2? .Lmemset_done
+	;;
+	/* Remaining bytes for 16 bytes store */
+	andw $r8 = $r2, (1 << 5)
+	/* Skip dzerol if there are not enough data for 64 bytes store */
+	cb.deqz $r10? .Ldzerol_done
+	/* Update length to copy */
+	sbfd $r2 = $r4, $r2
+	;;
+	loopdo $r10, .Ldzerol_done
+		;;
+		so 0[$r0], $r32r33r34r35
+		;;
+		so 32[$r0], $r32r33r34r35
+		addd $r0 = $r0, $r11
+		;;
+	.Ldzerol_done:
+	/*
+	 * Now that we have handled every aligned bytes using 'dzerol', we can
+	 * handled the remainder of length using store by decrementing size
+	 * We also exploit the fact we are aligned to simply check remaining
+	 * size */
+	so.dnez $r8? [$r0] = $r32r33r34r35
+	addd $r0 = $r0, $r8
+	/* Remaining bytes for 16 bytes store */
+	andw $r8 = $r2, (1 << 4)
+	cb.deqz $r2? .Lmemset_done
+	;;
+	sq.dnez $r8? [$r0] = $r32r33
+	addd $r0 = $r0, $r8
+	/* Remaining bytes for 8 bytes store */
+	andw $r8 = $r2, (1 << 3)
+	;;
+	sd.dnez $r8? [$r0] = $r32
+	addd $r0 = $r0, $r8
+	/* Remaining bytes for 4 bytes store */
+	andw $r8 = $r2, (1 << 2)
+	;;
+	sw.dnez $r8? [$r0] = $r32
+	addd $r0 = $r0, $r8
+	/* Remaining bytes for 2 bytes store */
+	andw $r8 = $r2, (1 << 1)
+	;;
+	sh.dnez $r8? [$r0] = $r32
+	addd $r0 = $r0, $r8
+	;;
+	sb.odd $r2? [$r0] = $r32
+	/* Restore original value */
+	copyd $r0 = $r3
+	ret
+	;;
+
+.align 16
+memset_non_0_pattern:
+	/* Preserve return value */
+	copyd $r3 = $r0
+	/* Replicate the first pattern byte on all bytes */
+	sbmm8 $r32 = $r1, REPLICATE_BYTE_MASK
+	/* Check if length < MIN_SIZE_FOR_ALIGN */
+	compd.geu $r7 = $r2, MIN_SIZE_FOR_ALIGN
+	/* Invert address to compute size to copy to be aligned on 32 bytes */
+	negd $r5 = $r0
+	;;
+	/* Check if we are aligned on 32 bytes */
+	andw $r9 = $r0, 0x1F
+	/* Compute the size that will be copied to align on 32 bytes boundary */
+	andw $r6 = $r5, 0x1F
+	/*
+	 * If size < MIN_SIZE_FOR_ALIGN bits, directly go to so, it will be done
+	 * unaligned but that is still better that what we can do with sb
+	 */
+	cb.deqz $r7? .Laligned_32
+	;;
+	/* Remove unaligned part from length */
+	sbfd $r2 = $r6, $r2
+	/* If we are already aligned on 32 bytes, jump to main "so" loop */
+	cb.deqz $r9? .Laligned_32
+	/* Check if we need to copy 1 byte */
+	andw $r4 = $r5, (1 << 0)
+	;;
+	/* If we are not aligned, store byte */
+	sb.dnez $r4? [$r0] = $r32
+	/* Check if we need to copy 2 bytes */
+	andw $r4 = $r5, (1 << 1)
+	/* Add potentially copied part for next store offset */
+	addd $r0 = $r0, $r4
+	;;
+	sh.dnez $r4? [$r0] = $r32
+	/* Check if we need to copy 4 bytes */
+	andw $r4 = $r5, (1 << 2)
+	addd $r0 = $r0, $r4
+	;;
+	sw.dnez $r4? [$r0] = $r32
+	/* Check if we need to copy 8 bytes */
+	andw $r4 = $r5, (1 << 3)
+	addd $r0 = $r0, $r4
+	/* Copy second part of pattern for sq */
+	copyd $r33 = $r32
+	;;
+	sd.dnez $r4? [$r0] = $r32
+	/* Check if we need to copy 16 bytes */
+	andw $r4 = $r5, (1 << 4)
+	addd $r0 = $r0, $r4
+	;;
+	sq.dnez $r4? [$r0] = $r32r33
+	addd $r0 = $r0, $r4
+	;;
+.Laligned_32:
+	/* Copy second part of pattern for sq */
+	copyd $r33 = $r32
+	/* Prepare amount of data for 32 bytes store */
+	srld $r10 = $r2, 5
+	nop
+	nop
+	;;
+	copyq $r34r35 = $r32, $r33
+	/* Remaining bytes for 16 bytes store */
+	andw $r8 = $r2, (1 << 4)
+	make $r11 = 32
+	/* Check if there are enough data for 32 bytes store */
+	cb.deqz $r10? .Laligned_32_done
+	;;
+	loopdo $r10, .Laligned_32_done
+		;;
+		so 0[$r0] = $r32r33r34r35
+		addd $r0 = $r0, $r11
+		;;
+	.Laligned_32_done:
+	/*
+	 * Now that we have handled every aligned bytes using 'so', we can
+	 * handled the remainder of length using store by decrementing size
+	 * We also exploit the fact we are aligned to simply check remaining
+	 * size */
+	sq.dnez $r8? [$r0] = $r32r33
+	addd $r0 = $r0, $r8
+	/* Remaining bytes for 8 bytes store */
+	andw $r8 = $r2, (1 << 3)
+	cb.deqz $r2? .Lmemset_done
+	;;
+	sd.dnez $r8? [$r0] = $r32
+	addd $r0 = $r0, $r8
+	/* Remaining bytes for 4 bytes store */
+	andw $r8 = $r2, (1 << 2)
+	;;
+	sw.dnez $r8? [$r0] = $r32
+	addd $r0 = $r0, $r8
+	/* Remaining bytes for 2 bytes store */
+	andw $r8 = $r2, (1 << 1)
+	;;
+	sh.dnez $r8? [$r0] = $r32
+	addd $r0 = $r0, $r8
+	;;
+	sb.odd $r2? [$r0] = $r32
+	/* Restore original value */
+	copyd $r0 = $r3
+	ret
+	;;
+.Lmemset_done:
+	/* Restore original value */
+	copyd $r0 = $r3
+	ret
+	;;
+ENDPROC(memset)
diff --git a/arch/kvx/lib/strlen.S b/arch/kvx/lib/strlen.S
new file mode 100644
index 000000000000..8298402a7898
--- /dev/null
+++ b/arch/kvx/lib/strlen.S
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Jules Maselbas
+ */
+#include <linux/linkage.h>
+#include <asm/export.h>
+
+/*
+ *	kvx optimized strlen
+ *
+ *	This implementation of strlen only does aligned memory accesses.
+ *	Since we don't know the total length the idea is to do double word
+ *	load and stop on the first null byte found. As it's always safe to
+ *	read more up to a lower 8-bytes boundary.
+ *
+ *	This implementation of strlen uses a trick to detect if a double
+ *	word contains a null byte [1]:
+ *
+ *	> #define haszero(v) (((v) - 0x01010101UL) & ~(v) & 0x80808080UL)
+ *	> The sub-expression (v - 0x01010101UL), evaluates to a high bit set
+ *	> in any byte whenever the corresponding byte in v is zero or greater
+ *	> than 0x80. The sub-expression ~v & 0x80808080UL evaluates to high
+ *	> bits set in bytes where the byte of v doesn't have its high bit set
+ *	> (so the byte was less than 0x80). Finally, by ANDing these two sub-
+ *	> expressions the result is the high bits set where the bytes in v
+ *	> were zero, since the high bits set due to a value greater than 0x80
+ *	> in the first sub-expression are masked off by the second.
+ *
+ *	[1] http://graphics.stanford.edu/~seander/bithacks.html#ZeroInWord
+ *
+ *	A second trick is used to get the exact number of characters before
+ *	the first null byte in a double word:
+ *
+ *		clz(sbmmt(zero, 0x0102040810204080))
+ *
+ *	This trick uses the haszero result which maps null byte to 0x80 and
+ *	others value to 0x00. The idea is to count the number of consecutive
+ *	null byte in the double word (counting from less significant byte
+ *	to most significant byte). To do so, using the bit matrix transpose
+ *	will "pack" all high bit (0x80) to the most significant byte (MSB).
+ *	It is not possible to count the trailing zeros in this MSB, however
+ *	if a byte swap is done before the bit matrix transpose we still have
+ *	all the information in the MSB but now we can count the leading zeros.
+ *	The instruction sbmmt with the matrix 0x0102040810204080 does exactly
+ *	what we need a byte swap followed by a bit transpose.
+ *
+ *	A last trick is used to handle the first double word misalignment.
+ *	This is done by masking off the N lower bytes (excess read) with N
+ *	between 0 and 7. The mask is applied on haszero results and will
+ *	force the N lower bytes to be considered not null.
+ *
+ *	This is a C implementation of the algorithm described above:
+ *
+ *	size_t strlen(char *s) {
+ *		uint64_t *p    = (uint64_t *)((uintptr_t)s) & ~0x7;
+ *		uint64_t rem   = ((uintptr_t)s) % 8;
+ *		uint64_t low   = -0x0101010101010101;
+ *		uint64_t high  =  0x8080808080808080;
+ *		uint64_t dword, zero;
+ *		uint64_t msk, len;
+ *
+ *		dword = *p++;
+ *		zero  = (dword + low) & ~dword & high;
+ *		msk   = 0xffffffffffffffff << (rem * 8);
+ *		zero &= msk;
+ *
+ *		while (!zero) {
+ *			dword = *p++;
+ *			zero  = (dword + low) & ~dword & high;
+ *		}
+ *
+ *		zero = __builtin_kvx_sbmmt8(zero, 0x0102040810204080);
+ *		len = ((void *)p - (void *)s) - 8;
+ *		len += __builtin_kvx_clzd(zero);
+ *
+ *		return len;
+ *	}
+ */
+
+.text
+.align 16
+ENTRY(strlen)
+	andd  $r1 = $r0, ~0x7
+	andd  $r2 = $r0,  0x7
+	make $r10 = -0x0101010101010101
+	make $r11 =  0x8080808080808080
+	;;
+	ld $r4 = 0[$r1]
+	sllw $r2 = $r2, 3
+	make $r3 = 0xffffffffffffffff
+	;;
+	slld $r2 = $r3, $r2
+	addd $r5 = $r4, $r10
+	andnd $r6 = $r4, $r11
+	;;
+	andd $r6 = $r6, $r2
+	make $r3 = 0
+	;;
+.loop:
+	andd $r4 = $r5, $r6
+	addd $r1 = $r1, 0x8
+	;;
+	cb.dnez $r4? .end
+	ld.deqz $r4? $r4 = [$r1]
+	;;
+	addd $r5 = $r4, $r10
+	andnd $r6 = $r4, $r11
+	goto .loop
+	;;
+.end:
+	addd $r1 = $r1, -0x8
+	sbmmt8 $r4 = $r4, 0x0102040810204080
+	;;
+	clzd $r4 = $r4
+	sbfd $r1 = $r0, $r1
+	;;
+	addd $r0 = $r4, $r1
+	ret
+	;;
+ENDPROC(strlen)
+EXPORT_SYMBOL(strlen)
diff --git a/arch/kvx/lib/usercopy.S b/arch/kvx/lib/usercopy.S
new file mode 100644
index 000000000000..bc7e1a45e1c7
--- /dev/null
+++ b/arch/kvx/lib/usercopy.S
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+#include <linux/linkage.h>
+
+/**
+ * Copy from/to a user buffer
+ * r0 = to buffer
+ * r1 = from buffer
+ * r2 = size to copy
+ * This function can trapped when hitting a non-mapped page.
+ * It will trigger a trap NOMAPPING and the trap handler will interpret
+ * it and check if instruction pointer is inside __ex_table.
+ * The next step are described later !
+ */
+.text
+ENTRY(raw_copy_from_user)
+ENTRY(raw_copy_to_user)
+	/**
+	 * naive implementation byte per byte
+	 */
+	make $r33 = 0x0;
+	/* If size == 0, exit directly */
+	cb.deqz $r2? copy_exit
+	;;
+	loopdo $r2, copy_exit
+		;;
+0:		lbz $r34 = $r33[$r1]
+		;;
+1:		sb $r33[$r0] = $r34
+		addd $r33 = $r33, 1 /* Ptr increment */
+		addd $r2 = $r2, -1 /* Remaining bytes to copy */
+		;;
+	copy_exit:
+	copyd $r0 = $r2
+	ret
+	;;
+ENDPROC(raw_copy_to_user)
+ENDPROC(raw_copy_from_user)
+
+/**
+ * Exception table
+ * each entry correspond to the following:
+ * .dword trapping_addr, restore_addr
+ *
+ * On trap, the handler will try to locate if $spc is matching a
+ * trapping address in the exception table. If so, the restore addr
+ * will  be put in the return address of the trap handler, allowing
+ * to properly finish the copy and return only the bytes copied/cleared
+ */
+.pushsection __ex_table,"a"
+.balign 8
+.dword 0b, copy_exit
+.dword 1b, copy_exit
+.popsection
+
+/**
+ * Clear a user buffer
+ * r0 = buffer to clear
+ * r1 = size to clear
+ */
+.text
+ENTRY(asm_clear_user)
+	/**
+	 * naive implementation byte per byte
+	 */
+	make $r33 = 0x0;
+	make $r34 = 0x0;
+	/* If size == 0, exit directly */
+	cb.deqz $r1? clear_exit
+	;;
+	loopdo $r1, clear_exit
+		;;
+40:		sb $r33[$r0] = $r34
+		addd $r33 = $r33, 1 /* Ptr increment */
+		addd $r1 = $r1, -1 /* Remaining bytes to copy */
+		;;
+	clear_exit:
+	copyd $r0 = $r1
+	ret
+	;;
+ENDPROC(asm_clear_user)
+
+.pushsection __ex_table,"a"
+.balign 8
+.dword 40b, clear_exit
+.popsection
+
-- 
2.37.2





