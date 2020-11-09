Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A47B2AC4C3
	for <lists+linux-arch@lfdr.de>; Mon,  9 Nov 2020 20:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgKITSW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Nov 2020 14:18:22 -0500
Received: from m12-13.163.com ([220.181.12.13]:35888 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbgKITSW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 9 Nov 2020 14:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=01wfZ
        opWShjdS+WHQHRwiK7fi3txZ5GN154Fz98Btoo=; b=NYITV6iBO6A/m/EDtha5x
        aagb31KatAWUnpsCsFv1AQH9buLnK9J9JABakFYF+qRvcoYZnJwpzb4jHIbrNHpq
        e5N68X0/wD8CaRosEZ+eWM3PGvdgk3SQDSD2hUsw8BLcqZBjfgEB7tnpeAUsjE2w
        NC6fky9pIbDntBHeBj3Wxs=
Received: from localhost.localdomain (unknown [120.229.59.65])
        by smtp9 (Coremail) with SMTP id DcCowAD3_UrslalfNcoUPw--.26179S4;
        Tue, 10 Nov 2020 03:18:11 +0800 (CST)
From:   zengzhaoxiu@163.com
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Subject: [PATCH 1/3] lib: Introduce copy_from_back()
Date:   Tue, 10 Nov 2020 03:16:01 +0800
Message-Id: <20201109191601.14053-1-zengzhaoxiu@163.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAD3_UrslalfNcoUPw--.26179S4
X-Coremail-Antispam: 1Uf129KBjvAXoWfCF4xur1ftF4DXFy3KFykZrb_yoW8Zw1rXo
        Z2qa1jkrs5ArW5GF1UJFy5tayUXF1vyFs7Aw43A3y5Ja47Aw47Jw18K398JF1UKFn2kFyx
        W3yS9r9rtFyfGFn7n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUcfMaUUUUU
X-Originating-IP: [120.229.59.65]
X-CM-SenderInfo: p2hqw6xkdr5xrx6rljoofrz/1tbiMALXgFWBvwlf2QAAsB
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

Copying the matched bytes from the back output buffer is the
key code of the LZ decompression algorithm which used by zlib, lzo, etc.

This patch introduce the optimized copy_from_back function.
The function will be used by later patches in this series.

Optimization for a specific architecture will be available in the future.

Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
---
 arch/alpha/include/asm/Kbuild        |   1 +
 arch/arc/include/asm/Kbuild          |   1 +
 arch/arm/include/asm/Kbuild          |   1 +
 arch/arm64/include/asm/Kbuild        |   1 +
 arch/c6x/include/asm/Kbuild          |   1 +
 arch/csky/include/asm/Kbuild         |   1 +
 arch/h8300/include/asm/Kbuild        |   1 +
 arch/hexagon/include/asm/Kbuild      |   1 +
 arch/ia64/include/asm/Kbuild         |   1 +
 arch/m68k/include/asm/Kbuild         |   1 +
 arch/microblaze/include/asm/Kbuild   |   1 +
 arch/mips/include/asm/Kbuild         |   1 +
 arch/nds32/include/asm/Kbuild        |   1 +
 arch/nios2/include/asm/Kbuild        |   1 +
 arch/openrisc/include/asm/Kbuild     |   1 +
 arch/parisc/include/asm/Kbuild       |   1 +
 arch/powerpc/include/asm/Kbuild      |   1 +
 arch/riscv/include/asm/Kbuild        |   1 +
 arch/s390/include/asm/Kbuild         |   1 +
 arch/sh/include/asm/Kbuild           |   1 +
 arch/sparc/include/asm/Kbuild        |   1 +
 arch/um/include/asm/Kbuild           |   1 +
 arch/x86/include/asm/Kbuild          |   1 +
 arch/xtensa/include/asm/Kbuild       |   1 +
 include/asm-generic/copy_from_back.h | 414 +++++++++++++++++++++++++++
 25 files changed, 438 insertions(+)
 create mode 100644 include/asm-generic/copy_from_back.h

diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
index 42911c8340c7..7f1c0b09242f 100644
--- a/arch/alpha/include/asm/Kbuild
+++ b/arch/alpha/include/asm/Kbuild
@@ -4,3 +4,4 @@ generated-y += syscall_table.h
 generic-y += export.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
+generic-y += copy_from_back.h
diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index 81f4edec0c2a..67b2ad7f7b84 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -5,3 +5,4 @@ generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += parport.h
 generic-y += user.h
+generic-y += copy_from_back.h
diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 383635b68763..b28f3af15f6f 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -5,6 +5,7 @@ generic-y += flat.h
 generic-y += local64.h
 generic-y += parport.h
 generic-y += seccomp.h
+generic-y += copy_from_back.h
 
 generated-y += mach-types.h
 generated-y += unistd-nr.h
diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index ff9cbb631212..40e07581cd5c 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -6,3 +6,4 @@ generic-y += qrwlock.h
 generic-y += qspinlock.h
 generic-y += set_memory.h
 generic-y += user.h
+generic-y += copy_from_back.h
diff --git a/arch/c6x/include/asm/Kbuild b/arch/c6x/include/asm/Kbuild
index a4ef93a1f7ae..eeb78379cbca 100644
--- a/arch/c6x/include/asm/Kbuild
+++ b/arch/c6x/include/asm/Kbuild
@@ -3,3 +3,4 @@ generic-y += extable.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += user.h
+generic-y += copy_from_back.h
diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index 64876e59e2ef..afc00f06fb0f 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -7,3 +7,4 @@ generic-y += qrwlock.h
 generic-y += seccomp.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
+generic-y += copy_from_back.h
diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index ddf04f32b546..0af133344643 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -6,3 +6,4 @@ generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += parport.h
 generic-y += spinlock.h
+generic-y += copy_from_back.h
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index 373964bb177e..8d8d5ae05a9a 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -4,3 +4,4 @@ generic-y += iomap.h
 generic-y += kvm_para.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
+generic-y += copy_from_back.h
diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
index f994c1daf9d4..5153c4ec4c43 100644
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -3,3 +3,4 @@ generated-y += syscall_table.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += vtime.h
+generic-y += copy_from_back.h
diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 1bff55aa2d54..79709aa82a5e 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -5,3 +5,4 @@ generic-y += kvm_para.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += spinlock.h
+generic-y += copy_from_back.h
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index 63bce836b9f1..7927f4262e58 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -8,3 +8,4 @@ generic-y += parport.h
 generic-y += syscalls.h
 generic-y += tlb.h
 generic-y += user.h
+generic-y += copy_from_back.h
diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 198b3bafdac9..cf8178c8418b 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -12,3 +12,4 @@ generic-y += parport.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
 generic-y += user.h
+generic-y += copy_from_back.h
diff --git a/arch/nds32/include/asm/Kbuild b/arch/nds32/include/asm/Kbuild
index ff1e94299317..5d48ef57698a 100644
--- a/arch/nds32/include/asm/Kbuild
+++ b/arch/nds32/include/asm/Kbuild
@@ -7,3 +7,4 @@ generic-y += kvm_para.h
 generic-y += local64.h
 generic-y += parport.h
 generic-y += user.h
+generic-y += copy_from_back.h
diff --git a/arch/nios2/include/asm/Kbuild b/arch/nios2/include/asm/Kbuild
index 7fe7437555fb..9f248e40a0ce 100644
--- a/arch/nios2/include/asm/Kbuild
+++ b/arch/nios2/include/asm/Kbuild
@@ -5,3 +5,4 @@ generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += spinlock.h
 generic-y += user.h
+generic-y += copy_from_back.h
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index ca5987e11053..4ea50a883a6c 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -7,3 +7,4 @@ generic-y += qspinlock.h
 generic-y += qrwlock_types.h
 generic-y += qrwlock.h
 generic-y += user.h
+generic-y += copy_from_back.h
diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
index e3ee5c0bfe80..6af8c43ad6d7 100644
--- a/arch/parisc/include/asm/Kbuild
+++ b/arch/parisc/include/asm/Kbuild
@@ -7,3 +7,4 @@ generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += seccomp.h
 generic-y += user.h
+generic-y += copy_from_back.h
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index 90cd5c53af66..2bdb5f937166 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -10,3 +10,4 @@ generic-y += mcs_spinlock.h
 generic-y += qrwlock.h
 generic-y += vtime.h
 generic-y += early_ioremap.h
+generic-y += copy_from_back.h
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 59dd7be55005..1ed1e433cd95 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -6,3 +6,4 @@ generic-y += kvm_para.h
 generic-y += local64.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
+generic-y += copy_from_back.h
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 319efa0e6d02..1043f4176c50 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -9,3 +9,4 @@ generic-y += export.h
 generic-y += kvm_types.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
+generic-y += copy_from_back.h
diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index 7435182ef846..798d1bc6620f 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -4,3 +4,4 @@ generic-y += kvm_para.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += parport.h
+generic-y += copy_from_back.h
diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index 5269a704801f..0c4e69c22b2e 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -8,3 +8,4 @@ generic-y += export.h
 generic-y += kvm_para.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
+generic-y += copy_from_back.h
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 1c63b260ecc4..c4a7f5dccfa3 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -26,3 +26,4 @@ generic-y += topology.h
 generic-y += trace_clock.h
 generic-y += word-at-a-time.h
 generic-y += kprobes.h
+generic-y += copy_from_back.h
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index b19ec8282d50..e10e5d95747d 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -10,3 +10,4 @@ generated-y += xen-hypercalls.h
 generic-y += early_ioremap.h
 generic-y += export.h
 generic-y += mcs_spinlock.h
+generic-y += copy_from_back.h
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index c59c42a1221a..36ea74ba5a70 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -9,3 +9,4 @@ generic-y += qrwlock.h
 generic-y += qspinlock.h
 generic-y += seccomp.h
 generic-y += user.h
+generic-y += copy_from_back.h
diff --git a/include/asm-generic/copy_from_back.h b/include/asm-generic/copy_from_back.h
new file mode 100644
index 000000000000..3786c947734e
--- /dev/null
+++ b/include/asm-generic/copy_from_back.h
@@ -0,0 +1,414 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __COPY_FROM_BACK_H
+#define __COPY_FROM_BACK_H
+
+#include <linux/types.h>
+
+#define FAST_COPY_SAFEGUARD_SIZE (sizeof(long) * 2 - 1)
+
+#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+
+/*
+ * The caller must ensure that the output buffer has enough space (len + FAST_COPY_SAFEGUARD_SIZE),
+ * so we can write 2 words per loop without overflowing the output buffer
+ */
+static __always_inline u8 *copy_from_back_fast(u8 *out, size_t dist, size_t len)
+{
+	u8 *end = out + len;
+
+	/* ensure the distance is larger than sizeof(long), so we can copy one word per step */
+	if (unlikely(dist < sizeof(long))) {
+#if BITS_PER_LONG == 32
+		/* extend the distance '1,2,3' to '4,4,6' */
+		out[0] = out[0 - dist];
+		out[1] = out[1 - dist];
+		out[2] = out[2 - dist];
+		out += sizeof(long) - 1;
+		if (out >= end)
+			return end;
+		dist = dist == 3 ? 6 : 4;
+#elif BITS_PER_LONG == 64
+		/* extend the distance '1,2,3,4,5,6,7' to '8,8,9,8,A,C,E' */
+		out[0] = out[0 - dist];
+		out[1] = out[1 - dist];
+		out[2] = out[2 - dist];
+		*(u32 *)(out + 3) = *(u32 *)(out - ((0x43213110 >> (dist * 4)) & 0xF));
+		out += sizeof(long) - 1;
+		if (out >= end)
+			return end;
+		dist = (0xECA89880 >> (dist * 4)) & 0xF;
+#else
+#error "Unknown BITS_PER_LONG"
+#endif
+	}
+
+	do {
+		*(unsigned long *)out = *(unsigned long *)(out - dist);
+		out += sizeof(long);
+		*(unsigned long *)out = *(unsigned long *)(out - dist);
+		out += sizeof(long);
+	} while (out < end);
+
+	return end;
+}
+
+static __always_inline u8 *copy_from_back(u8 *out, size_t dist, size_t len)
+{
+	if (len >= sizeof(long)) {
+		/* ensure the distance is larger than sizeof(long), so we can copy one word per step */
+		if (unlikely(dist < sizeof(long))) {
+#if BITS_PER_LONG == 32
+			/* extend the distance '1,2,3' to '4,4,6' */
+			out[0] = out[0 - dist];
+			out[1] = out[1 - dist];
+			out[2] = out[2 - dist];
+			out += sizeof(long) - 1;
+			len -= sizeof(long) - 1;
+			if (len < sizeof(long))
+				goto _last;
+			dist = dist == 3 ? 6 : 4;
+#elif BITS_PER_LONG == 64
+			/* extend the distance '1,2,3,4,5,6,7' to '8,8,9,8,A,C,E' */
+			out[0] = out[0 - dist];
+			out[1] = out[1 - dist];
+			out[2] = out[2 - dist];
+			*(u32 *)(out + 3) = *(u32 *)(out - ((0x43213110 >> (dist * 4)) & 0xF));
+			out += sizeof(long) - 1;
+			len -= sizeof(long) - 1;
+			if (len < sizeof(long))
+				goto _last;
+			dist = (0xECA89880 >> (dist * 4)) & 0xF;
+#else
+#error "Unknown BITS_PER_LONG"
+#endif
+		}
+
+		while (len >= sizeof(long) * 2) {
+			len -= sizeof(long) * 2;
+			*(unsigned long *)out = *(unsigned long *)(out - dist);
+			out += sizeof(long);
+			*(unsigned long *)out = *(unsigned long *)(out - dist);
+			out += sizeof(long);
+		}
+		if (len >= sizeof(long)) {
+			len -= sizeof(long);
+			*(unsigned long *)out = *(unsigned long *)(out - dist);
+			out += sizeof(long);
+		}
+		if (len) {
+			unsigned long val;
+
+			out += len;
+			val = *(unsigned long *)(out - sizeof(long) - dist);
+			*(unsigned long *)(out - sizeof(long)) = val;
+		}
+	} else {
+		*out = *(out - dist);
+		out++;
+		len--;
+_last:
+		if (len >= 2) {
+			if (dist == 1)
+				dist = 2;
+#if BITS_PER_LONG == 32
+			*(u16 *)out = *(u16 *)(out - dist);
+			out += 2;
+			len -= 2;
+#else
+			do {
+				*(u16 *)out = *(u16 *)(out - dist);
+				out += 2;
+				len -= 2;
+			} while (len >= 2);
+#endif
+		}
+		if (len) {
+			*out = *(out - dist);
+			out++;
+		}
+	}
+
+	return out;
+}
+
+#else /* CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS */
+
+#include <asm/unaligned.h>
+
+/*
+ * Endian independent macros for shifting bits
+ */
+#ifdef __BIG_ENDIAN
+# define LSPULL(x, n)	((x) << (n))
+# define LSPUSH(x, n)	((x) >> (n))
+# define LSMASK(n)		(~(~0UL >> (n)))
+# define LSFETCH(x, n)	((x) >> (BITS_PER_LONG - (n)))
+#else
+# define LSPULL(x, n)	((x) >> (n))
+# define LSPUSH(x, n)	((x) << (n))
+# define LSMASK(n)		((1UL << (n)) - 1)
+# define LSFETCH(x, n)	((x) & LSMASK(n))
+#endif
+
+/*
+ * The caller must ensure that the output buffer has enough space (len + FAST_COPY_SAFEGUARD_SIZE),
+ * so we can write 2 words per loop without overflowing the output buffer
+ */
+static __always_inline u8 *copy_from_back_fast(u8 *out, size_t dist, size_t len)
+{
+	u8 *end = out + len;
+	unsigned long val;
+	unsigned int n;
+
+	/* ensure the distance is larger than sizeof(long), so we can copy one word per step */
+	if (unlikely(dist < sizeof(long))) {
+#if BITS_PER_LONG == 32
+		/* extend the distance '1,2,3' to '4,4,6' */
+		out[0] = out[0 - dist];
+		out[1] = out[1 - dist];
+		out[2] = out[2 - dist];
+		out += sizeof(long) - 1;
+		if (out >= end)
+			return end;
+		dist = dist == 3 ? 6 : 4;
+#elif BITS_PER_LONG == 64
+		/* extend the distance '1,2,3,4,5,6,7' to '8,8,9,8,A,C,E' */
+		out[0] = out[0 - dist];
+		out[1] = out[1 - dist];
+		out[2] = out[2 - dist];
+		out[3] = out[3 - dist];
+		out[4] = out[4 - dist];
+		out[5] = out[5 - dist];
+		out[6] = out[6 - dist];
+		out += sizeof(long) - 1;
+		if (out >= end)
+			return end;
+		dist = (0xECA89880 >> (dist * 4)) & 0xF;
+#else
+#error "Unknown BITS_PER_LONG"
+#endif
+	}
+
+	/* align out addr */
+	n = (uintptr_t)out & (sizeof(long) - 1);
+	if (n) {
+		val = get_unaligned((unsigned long *)(out - dist));
+		put_unaligned(val, (unsigned long *)out);
+		out += sizeof(long);
+		if (out >= end)
+			return end;
+		out -= n;
+	}
+
+	n = dist & (sizeof(long) - 1);
+	if (n) {
+		const unsigned int shift_h = n * 8, shift_l = BITS_PER_LONG - shift_h;
+		unsigned long prev;
+
+		dist -= n;
+		prev = *(unsigned long *)(out - dist - sizeof(long));
+
+		do {
+			val = *(unsigned long *)(out - dist);
+			*(unsigned long *)out = LSPULL(prev, shift_l) | LSPUSH(val, shift_h);
+			out += sizeof(long);
+			prev = *(unsigned long *)(out - dist);
+			*(unsigned long *)out = LSPULL(val, shift_l) | LSPUSH(prev, shift_h);
+			out += sizeof(long);
+		} while (out < end);
+	} else {
+		do {
+			*(unsigned long *)out = *(unsigned long *)(out - dist);
+			out += sizeof(long);
+			*(unsigned long *)out = *(unsigned long *)(out - dist);
+			out += sizeof(long);
+		} while (out < end);
+	}
+
+	return end;
+}
+
+static __always_inline u8 *copy_from_back(u8 *out, size_t dist, size_t len)
+{
+	unsigned long val;
+	unsigned int n;
+
+	if (len >= sizeof(long)) {
+		/* ensure the distance is larger than sizeof(long), so we can copy one word per step */
+		if (unlikely(dist < sizeof(long))) {
+#if BITS_PER_LONG == 32
+			/* extend the distance '1,2,3' to '4,4,6' */
+			out[0] = out[0 - dist];
+			out[1] = out[1 - dist];
+			out[2] = out[2 - dist];
+			out += sizeof(long) - 1;
+			len -= sizeof(long) - 1;
+			if (len < sizeof(long))
+				goto _last;
+			dist = dist == 3 ? 6 : 4;
+#elif BITS_PER_LONG == 64
+			/* extend the distance '1,2,3,4,5,6,7' to '8,8,9,8,A,C,E' */
+			out[0] = out[0 - dist];
+			out[1] = out[1 - dist];
+			out[2] = out[2 - dist];
+			out[3] = out[3 - dist];
+			out[4] = out[4 - dist];
+			out[5] = out[5 - dist];
+			out[6] = out[6 - dist];
+			out += sizeof(long) - 1;
+			len -= sizeof(long) - 1;
+			if (len < sizeof(long))
+				goto _last;
+			dist = (0xECA89880 >> (dist * 4)) & 0xF;
+#else
+#error "Unknown BITS_PER_LONG"
+#endif
+		}
+
+		/* align out addr */
+		n = (uintptr_t)out & (sizeof(long) - 1);
+		if (n) {
+			val = get_unaligned((unsigned long *)(out - dist));
+			put_unaligned(val, (unsigned long *)out);
+			out += sizeof(long);
+			len -= sizeof(long);
+			if (len < sizeof(long)) {
+				if (len)
+					goto _last;
+				return out;
+			}
+			out -= n;
+			len += n;
+		}
+
+		n = dist & (sizeof(long) - 1);
+		if (n) {
+			const unsigned int shift_h = n * 8, shift_l = BITS_PER_LONG - shift_h;
+			unsigned long prev;
+
+			dist -= n;
+			prev = *(unsigned long *)(out - dist - sizeof(long));
+
+			while (len >= sizeof(long) * 2) {
+				len -= sizeof(long) * 2;
+				val = *(unsigned long *)(out - dist);
+				*(unsigned long *)out = LSPULL(prev, shift_l) | LSPUSH(val, shift_h);
+				out += sizeof(long);
+				prev = *(unsigned long *)(out - dist);
+				*(unsigned long *)out = LSPULL(val, shift_l) | LSPUSH(prev, shift_h);
+				out += sizeof(long);
+			}
+			if (len >= sizeof(long)) {
+				len -= sizeof(long);
+				val = *(unsigned long *)(out - dist);
+				*(unsigned long *)out = LSPULL(prev, shift_l) | LSPUSH(val, shift_h);
+				out += sizeof(long);
+				prev = val;
+			}
+			if (len) {
+				val = LSPULL(prev, shift_l);
+				if (len * 8 > shift_h) {
+					prev = *(unsigned long *)(out - dist);
+					val |= LSPUSH(prev, shift_h);
+				}
+				goto _part;
+			}
+		} else if (dist != sizeof(long)) {
+			while (len >= sizeof(long) * 2) {
+				len -= sizeof(long) * 2;
+				*(unsigned long *)out = *(unsigned long *)(out - dist);
+				out += sizeof(long);
+				*(unsigned long *)out = *(unsigned long *)(out - dist);
+				out += sizeof(long);
+			}
+			if (len >= sizeof(long)) {
+				len -= sizeof(long);
+				*(unsigned long *)out = *(unsigned long *)(out - dist);
+				out += sizeof(long);
+			}
+			if (len) {
+				val = *(unsigned long *)(out - dist);
+				goto _part;
+			}
+		} else {
+			val = *(unsigned long *)(out - sizeof(long));
+			while (len >= sizeof(long) * 2) {
+				len -= sizeof(long) * 2;
+				*(unsigned long *)out = val;
+				out += sizeof(long);
+				*(unsigned long *)out = val;
+				out += sizeof(long);
+			}
+			if (len >= sizeof(long)) {
+				len -= sizeof(long);
+				*(unsigned long *)out = val;
+				out += sizeof(long);
+			}
+			if (len) {
+_part:
+#if BITS_PER_LONG == 64
+				if (len & 4) {
+					*(u32 *)out = LSFETCH(val, 32);
+					out += 4;
+					val = LSPULL(val, 32);
+				}
+#endif
+				if (len & 2) {
+					*(u16 *)out = LSFETCH(val, 16);
+					out += 2;
+					val = LSPULL(val, 16);
+				}
+				if (len & 1)
+					*out++ = LSFETCH(val, 8);
+			}
+		}
+	} else {
+_last:
+		/* Align out addr */
+		if ((uintptr_t)out & 1) {
+			*out = *(out - dist);
+			out++;
+			len--;
+		}
+		if (len >= 2) {
+#if BITS_PER_LONG == 32
+			if (dist > 1)
+				*(u16 *)out = get_unaligned((u16 *)(out - dist));
+			else
+				*(u16 *)out = out[-1] | out[-1] << 8;
+			out += 2;
+			len -= 2;
+#else
+			if (dist > 2) {
+				do {
+					*(u16 *)out = get_unaligned((u16 *)(out - dist));
+					out += 2;
+					len -= 2;
+				} while (len >= 2);
+			} else {
+				val = dist == 2 ? *(u16 *)(out - 2) : (out[-1] | out[-1] << 8);
+				do {
+					*(u16 *)out = val;
+					out += 2;
+					len -= 2;
+				} while (len >= 2);
+			}
+#endif
+		}
+		if (len) {
+			*out = *(out - dist);
+			out++;
+		}
+	}
+
+	return out;
+}
+
+#undef LSPULL
+#undef LSPUSH
+#undef LSMASK
+#undef LSFETCH
+
+#endif /* CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS */
+
+#endif /* __COPY_FROM_BACK_H */
-- 
2.28.0


