Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1633BC53C
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 06:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhGFEWO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 00:22:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhGFEWN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 00:22:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C008560238;
        Tue,  6 Jul 2021 04:19:32 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 12/19] LoongArch: Add misc common routines
Date:   Tue,  6 Jul 2021 12:18:13 +0800
Message-Id: <20210706041820.1536502-13-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210706041820.1536502-1-chenhuacai@loongson.cn>
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds some misc common routines for LoongArch, including: asm-
offsets routines, arch_hweight, cmpxchg and futex functions, i/o memory
access functions, vga/frame-buffer functions, /proc/cpuinfo display, etc.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/arch_hweight.h |  36 ++
 arch/loongarch/include/asm/asm-offsets.h  |   5 +
 arch/loongarch/include/asm/cmpxchg.h      | 154 +++++++++
 arch/loongarch/include/asm/fb.h           |  23 ++
 arch/loongarch/include/asm/futex.h        | 107 ++++++
 arch/loongarch/include/asm/io.h           | 385 ++++++++++++++++++++++
 arch/loongarch/include/asm/vga.h          |  56 ++++
 arch/loongarch/include/uapi/asm/swab.h    |  52 +++
 arch/loongarch/kernel/asm-offsets.c       | 260 +++++++++++++++
 arch/loongarch/kernel/cmpxchg.c           | 100 ++++++
 arch/loongarch/kernel/io.c                |  94 ++++++
 arch/loongarch/kernel/proc.c              | 122 +++++++
 12 files changed, 1394 insertions(+)
 create mode 100644 arch/loongarch/include/asm/arch_hweight.h
 create mode 100644 arch/loongarch/include/asm/asm-offsets.h
 create mode 100644 arch/loongarch/include/asm/cmpxchg.h
 create mode 100644 arch/loongarch/include/asm/fb.h
 create mode 100644 arch/loongarch/include/asm/futex.h
 create mode 100644 arch/loongarch/include/asm/io.h
 create mode 100644 arch/loongarch/include/asm/vga.h
 create mode 100644 arch/loongarch/include/uapi/asm/swab.h
 create mode 100644 arch/loongarch/kernel/asm-offsets.c
 create mode 100644 arch/loongarch/kernel/cmpxchg.c
 create mode 100644 arch/loongarch/kernel/io.c
 create mode 100644 arch/loongarch/kernel/proc.c

diff --git a/arch/loongarch/include/asm/arch_hweight.h b/arch/loongarch/include/asm/arch_hweight.h
new file mode 100644
index 000000000000..e790af4e6ee8
--- /dev/null
+++ b/arch/loongarch/include/asm/arch_hweight.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_ARCH_HWEIGHT_H
+#define _ASM_ARCH_HWEIGHT_H
+
+#ifdef ARCH_HAS_USABLE_BUILTIN_POPCOUNT
+
+#include <asm/types.h>
+
+static inline unsigned int __arch_hweight32(unsigned int w)
+{
+	return __builtin_popcount(w);
+}
+
+static inline unsigned int __arch_hweight16(unsigned int w)
+{
+	return __builtin_popcount(w & 0xffff);
+}
+
+static inline unsigned int __arch_hweight8(unsigned int w)
+{
+	return __builtin_popcount(w & 0xff);
+}
+
+static inline unsigned long __arch_hweight64(__u64 w)
+{
+	return __builtin_popcountll(w);
+}
+
+#else
+#include <asm-generic/bitops/arch_hweight.h>
+#endif
+
+#endif /* _ASM_ARCH_HWEIGHT_H */
diff --git a/arch/loongarch/include/asm/asm-offsets.h b/arch/loongarch/include/asm/asm-offsets.h
new file mode 100644
index 000000000000..cf9ab9d12183
--- /dev/null
+++ b/arch/loongarch/include/asm/asm-offsets.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <generated/asm-offsets.h>
diff --git a/arch/loongarch/include/asm/cmpxchg.h b/arch/loongarch/include/asm/cmpxchg.h
new file mode 100644
index 000000000000..a8adaacc73cc
--- /dev/null
+++ b/arch/loongarch/include/asm/cmpxchg.h
@@ -0,0 +1,154 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef __ASM_CMPXCHG_H
+#define __ASM_CMPXCHG_H
+
+#include <linux/bug.h>
+#include <asm/compiler.h>
+
+/*
+ * These functions doesn't exist, so if they are called you'll either:
+ *
+ * - Get an error at compile-time due to __compiletime_error, if supported by
+ *   your compiler.
+ *
+ * or:
+ *
+ * - Get an error at link-time due to the call to the missing function.
+ */
+extern unsigned long __cmpxchg_called_with_bad_pointer(void)
+	__compiletime_error("Bad argument size for cmpxchg");
+extern unsigned long __xchg_called_with_bad_pointer(void)
+	__compiletime_error("Bad argument size for xchg");
+
+#define __xchg_asm(amswap_db, m, val)		\
+({						\
+		__typeof(val) __ret;		\
+						\
+		__asm__ __volatile__ (		\
+		" "amswap_db" %1, %z2, %0 \n"	\
+		: "+ZB" (*m), "=&r" (__ret)	\
+		: "Jr" (val)			\
+		: "memory");			\
+						\
+		__ret;				\
+})
+
+extern unsigned long __xchg_small(volatile void *ptr, unsigned long val,
+				  unsigned int size);
+
+static inline unsigned long __xchg(volatile void *ptr, unsigned long x,
+				   int size)
+{
+	switch (size) {
+	case 1:
+	case 2:
+		return __xchg_small(ptr, x, size);
+
+	case 4:
+		return __xchg_asm("amswap_db.w", (volatile u32 *)ptr, (u32)x);
+
+	case 8:
+		if (!IS_ENABLED(CONFIG_64BIT))
+			return __xchg_called_with_bad_pointer();
+
+		return __xchg_asm("amswap_db.d", (volatile u64 *)ptr, (u64)x);
+
+	default:
+		return __xchg_called_with_bad_pointer();
+	}
+}
+
+#define arch_xchg(ptr, x)							\
+({									\
+	__typeof__(*(ptr)) __res;					\
+									\
+	__res = (__typeof__(*(ptr)))					\
+		__xchg((ptr), (unsigned long)(x), sizeof(*(ptr)));	\
+									\
+	__res;								\
+})
+
+#define __cmpxchg_asm(ld, st, m, old, new)				\
+({									\
+	__typeof(old) __ret;						\
+									\
+	__asm__ __volatile__(						\
+	"1:	" ld "	%0, %2		# __cmpxchg_asm \n"		\
+	"	bne	%0, %z3, 2f			\n"		\
+	"	or	$t0, %z4, $zero			\n"		\
+	"	" st "	$t0, %1				\n"		\
+	"	beq	$zero, $t0, 1b			\n"		\
+	"2:						\n"		\
+	: "=&r" (__ret), "=ZB"(*m)					\
+	: "ZB"(*m), "Jr" (old), "Jr" (new)				\
+	: "t0", "memory");						\
+									\
+	__ret;								\
+})
+
+extern unsigned long __cmpxchg_small(volatile void *ptr, unsigned long old,
+				     unsigned long new, unsigned int size);
+
+static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
+				      unsigned long new, unsigned int size)
+{
+	switch (size) {
+	case 1:
+	case 2:
+		return __cmpxchg_small(ptr, old, new, size);
+
+	case 4:
+		return __cmpxchg_asm("ll.w", "sc.w", (volatile u32 *)ptr,
+				     (u32)old, new);
+
+	case 8:
+		/* lld/scd are only available for LoongArch64 */
+		if (!IS_ENABLED(CONFIG_64BIT))
+			return __cmpxchg_called_with_bad_pointer();
+
+		return __cmpxchg_asm("ll.d", "sc.d", (volatile u64 *)ptr,
+				     (u64)old, new);
+
+	default:
+		return __cmpxchg_called_with_bad_pointer();
+	}
+}
+
+#define arch_cmpxchg_local(ptr, old, new)					\
+	((__typeof__(*(ptr)))						\
+		__cmpxchg((ptr),					\
+			  (unsigned long)(__typeof__(*(ptr)))(old),	\
+			  (unsigned long)(__typeof__(*(ptr)))(new),	\
+			  sizeof(*(ptr))))
+
+#define arch_cmpxchg(ptr, old, new)						\
+({									\
+	__typeof__(*(ptr)) __res;					\
+									\
+	__res = arch_cmpxchg_local((ptr), (old), (new));			\
+									\
+	__res;								\
+})
+
+#ifdef CONFIG_64BIT
+#define arch_cmpxchg64_local(ptr, o, n)					\
+  ({									\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
+	arch_cmpxchg_local((ptr), (o), (n));					\
+  })
+
+#define arch_cmpxchg64(ptr, o, n)						\
+  ({									\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
+	arch_cmpxchg((ptr), (o), (n));					\
+  })
+#else
+#include <asm-generic/cmpxchg-local.h>
+#define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
+#define arch_cmpxchg64(ptr, o, n) arch_cmpxchg64_local((ptr), (o), (n))
+#endif
+
+#endif /* __ASM_CMPXCHG_H */
diff --git a/arch/loongarch/include/asm/fb.h b/arch/loongarch/include/asm/fb.h
new file mode 100644
index 000000000000..b29566fb2b1b
--- /dev/null
+++ b/arch/loongarch/include/asm/fb.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_FB_H_
+#define _ASM_FB_H_
+
+#include <linux/fb.h>
+#include <linux/fs.h>
+#include <asm/page.h>
+
+static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
+				unsigned long off)
+{
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+}
+
+static inline int fb_is_primary_device(struct fb_info *info)
+{
+	return 0;
+}
+
+#endif /* _ASM_FB_H_ */
diff --git a/arch/loongarch/include/asm/futex.h b/arch/loongarch/include/asm/futex.h
new file mode 100644
index 000000000000..6512feb041d1
--- /dev/null
+++ b/arch/loongarch/include/asm/futex.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_FUTEX_H
+#define _ASM_FUTEX_H
+
+#include <linux/futex.h>
+#include <linux/uaccess.h>
+#include <asm/barrier.h>
+#include <asm/compiler.h>
+#include <asm/errno.h>
+
+#define __futex_atomic_op(insn, ret, oldval, uaddr, oparg)		\
+{									\
+	__asm__ __volatile__(						\
+	"1:	ll.w	%1, %4 # __futex_atomic_op\n"		\
+	"	" insn	"				\n"	\
+	"2:	sc.w	$t0, %2				\n"	\
+	"	beq	$t0, $zero, 1b			\n"	\
+	"3:						\n"	\
+	"	.section .fixup,\"ax\"			\n"	\
+	"4:	li.w	%0, %6				\n"	\
+	"	b	3b				\n"	\
+	"	.previous				\n"	\
+	"	.section __ex_table,\"a\"		\n"	\
+	"	"__UA_ADDR "\t1b, 4b			\n"	\
+	"	"__UA_ADDR "\t2b, 4b			\n"	\
+	"	.previous				\n"	\
+	: "=r" (ret), "=&r" (oldval),				\
+	  "=ZC" (*uaddr)					\
+	: "0" (0), "ZC" (*uaddr), "Jr" (oparg),			\
+	  "i" (-EFAULT)						\
+	: "memory", "t0");					\
+}
+
+static inline int
+arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
+{
+	int oldval = 0, ret = 0;
+
+	pagefault_disable();
+
+	switch (op) {
+	case FUTEX_OP_SET:
+		__futex_atomic_op("move $t0, %z5", ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ADD:
+		__futex_atomic_op("add.w $t0, %1, %z5", ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_OR:
+		__futex_atomic_op("or	$t0, %1, %z5", ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ANDN:
+		__futex_atomic_op("and	$t0, %1, %z5", ret, oldval, uaddr, ~oparg);
+		break;
+	case FUTEX_OP_XOR:
+		__futex_atomic_op("xor	$t0, %1, %z5", ret, oldval, uaddr, oparg);
+		break;
+	default:
+		ret = -ENOSYS;
+	}
+
+	pagefault_enable();
+
+	if (!ret)
+		*oval = oldval;
+
+	return ret;
+}
+
+static inline int
+futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr, u32 oldval, u32 newval)
+{
+	int ret = 0;
+	u32 val = 0;
+
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
+
+	__asm__ __volatile__(
+	"# futex_atomic_cmpxchg_inatomic			\n"
+	"1:	ll.w	%1, %3					\n"
+	"	bne	%1, %z4, 3f				\n"
+	"	or	$t0, %z5, $zero				\n"
+	"2:	sc.w	$t0, %2					\n"
+	"	beq	$zero, $t0, 1b				\n"
+	"3:							\n"
+	"	.section .fixup,\"ax\"				\n"
+	"4:	li.d	%0, %6					\n"
+	"	b	3b					\n"
+	"	.previous					\n"
+	"	.section __ex_table,\"a\"			\n"
+	"	"__UA_ADDR "\t1b, 4b				\n"
+	"	"__UA_ADDR "\t2b, 4b				\n"
+	"	.previous					\n"
+	: "+r" (ret), "=&r" (val), "=" GCC_OFF_SMALL_ASM() (*uaddr)
+	: GCC_OFF_SMALL_ASM() (*uaddr), "Jr" (oldval), "Jr" (newval),
+	  "i" (-EFAULT)
+	: "memory", "t0");
+
+	*uval = val;
+
+	return ret;
+}
+
+#endif /* _ASM_FUTEX_H */
diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm/io.h
new file mode 100644
index 000000000000..8fa7c99db370
--- /dev/null
+++ b/arch/loongarch/include/asm/io.h
@@ -0,0 +1,385 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_IO_H
+#define _ASM_IO_H
+
+#define ARCH_HAS_IOREMAP_WC
+
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+#include <asm/addrspace.h>
+#include <asm/bug.h>
+#include <asm/byteorder.h>
+#include <asm/cpu.h>
+#include <asm-generic/iomap.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/string.h>
+
+#define ioswabb(a, x)		(x)
+#define ioswabw(a, x)		(x)
+#define ioswabl(a, x)		(x)
+#define ioswabq(a, x)		(x)
+#define __mem_ioswabb(a, x)	(x)
+#define __mem_ioswabw(a, x)	(x)
+#define __mem_ioswabl(a, x)	(x)
+#define __mem_ioswabq(a, x)	(x)
+#define __raw_ioswabb(a, x)	(x)
+#define __raw_ioswabw(a, x)	(x)
+#define __raw_ioswabl(a, x)	(x)
+#define __raw_ioswabq(a, x)	(x)
+
+#define IO_SPACE_LIMIT 0xffff
+
+/*
+ * On LoongArch I/O ports are memory mapped, so we access them using normal
+ * load/store instructions. loongarch_io_port_base is the virtual address to
+ * which all ports are being mapped.  For sake of efficiency some code
+ * assumes that this is an address that can be loaded with a single lui
+ * instruction, so the lower 16 bits must be zero. Should be true on any
+ * sane architecture; generic code does not use this assumption.
+ */
+extern unsigned long loongarch_io_port_base;
+
+static inline void set_io_port_base(unsigned long base)
+{
+	loongarch_io_port_base = base;
+}
+
+/*
+ * Provide the necessary definitions for generic iomap. We make use of
+ * loongarch_io_port_base for iomap(), but we don't reserve any low addresses
+ * for use with I/O ports.
+ */
+
+#define HAVE_ARCH_PIO_SIZE
+#define PIO_OFFSET	loongarch_io_port_base
+#define PIO_MASK	IO_SPACE_LIMIT
+#define PIO_RESERVED	0x0UL
+
+/*
+ * ISA I/O bus memory addresses are 1:1 with the physical address.
+ */
+static inline unsigned long isa_virt_to_bus(volatile void *address)
+{
+	return virt_to_phys(address);
+}
+
+static inline void *isa_bus_to_virt(unsigned long address)
+{
+	return phys_to_virt(address);
+}
+
+/*
+ * However PCI ones are not necessarily 1:1 and therefore these interfaces
+ * are forbidden in portable PCI drivers.
+ *
+ * Allow them for x86 for legacy drivers, though.
+ */
+#define virt_to_bus virt_to_phys
+#define bus_to_virt phys_to_virt
+
+/*
+ * Change "struct page" to physical address.
+ */
+#define page_to_phys(page)	((dma_addr_t)page_to_pfn(page) << PAGE_SHIFT)
+
+extern void __init __iomem *early_ioremap(u64 phys_addr, unsigned long size);
+extern void __init early_iounmap(void __iomem *addr, unsigned long size);
+
+#define early_memremap early_ioremap
+#define early_memunmap early_iounmap
+
+static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
+	unsigned long prot_val)
+{
+	/* This only works for !HIGHMEM currently */
+	return (void __iomem *)(unsigned long)(IO_BASE + offset);
+}
+
+/*
+ * ioremap     -   map bus memory into CPU space
+ * @offset:    bus address of the memory
+ * @size:      size of the resource to map
+ *
+ * ioremap performs a platform specific sequence of operations to
+ * make bus memory CPU accessible via the readb/readw/readl/writeb/
+ * writew/writel functions and the other mmio helpers. The returned
+ * address is not guaranteed to be usable directly as a virtual
+ * address.
+ */
+#define ioremap(offset, size)					\
+	ioremap_prot((offset), (size), _CACHE_SUC)
+#define ioremap_uc ioremap
+
+/*
+ * ioremap_cache -	map bus memory into CPU space
+ * @offset:	    bus address of the memory
+ * @size:	    size of the resource to map
+ *
+ * ioremap_cache performs a platform specific sequence of operations to
+ * make bus memory CPU accessible via the readb/readw/readl/writeb/
+ * writew/writel functions and the other mmio helpers. The returned
+ * address is not guaranteed to be usable directly as a virtual
+ * address.
+ *
+ * This version of ioremap ensures that the memory is marked cachable by
+ * the CPU.  Also enables full write-combining.	 Useful for some
+ * memory-like regions on I/O busses.
+ */
+#define ioremap_cache(offset, size)				\
+	ioremap_prot((offset), (size), _CACHE_CC)
+
+/*
+ * ioremap_wc     -   map bus memory into CPU space
+ * @offset:    bus address of the memory
+ * @size:      size of the resource to map
+ *
+ * ioremap_wc performs a platform specific sequence of operations to
+ * make bus memory CPU accessible via the readb/readw/readl/writeb/
+ * writew/writel functions and the other mmio helpers. The returned
+ * address is not guaranteed to be usable directly as a virtual
+ * address.
+ *
+ * This version of ioremap ensures that the memory is marked uncachable
+ * but accelerated by means of write-combining feature. It is specifically
+ * useful for PCIe prefetchable windows, which may vastly improve a
+ * communications performance. If it was determined on boot stage, what
+ * CPU CCA doesn't support WUC, the method shall fall-back to the
+ * _CACHE_SUC option (see cpu_probe() method).
+ */
+#define ioremap_wc(offset, size)				\
+	ioremap_prot((offset), (size), boot_cpu_data.writecombine)
+
+static inline void iounmap(const volatile void __iomem *addr)
+{
+}
+
+#define io_reorder_wmb()		wmb()
+
+#define __BUILD_MEMORY_SINGLE(pfx, bwlq, type)				\
+									\
+static inline void pfx##write##bwlq(type val,				\
+				    volatile void __iomem *mem)		\
+{									\
+	volatile type *__mem;						\
+	type __val;							\
+									\
+	io_reorder_wmb();						\
+									\
+	__mem = (void *)(unsigned long)(mem);				\
+									\
+	__val = pfx##ioswab##bwlq(__mem, val);				\
+									\
+	if (sizeof(type) != sizeof(u64) || sizeof(u64) == sizeof(long)) \
+		*__mem = __val;						\
+	else								\
+		BUG();							\
+}									\
+									\
+static inline type pfx##read##bwlq(const volatile void __iomem *mem)	\
+{									\
+	volatile type *__mem;						\
+	type __val;							\
+									\
+	__mem = (void *)(unsigned long)(mem);				\
+									\
+	if (sizeof(type) != sizeof(u64) || sizeof(u64) == sizeof(long)) \
+		__val = *__mem;						\
+	else {								\
+		__val = 0;						\
+		BUG();							\
+	}								\
+									\
+	/* prevent prefetching of coherent DMA data prematurely */	\
+	rmb();								\
+	return pfx##ioswab##bwlq(__mem, __val);				\
+}
+
+#define __BUILD_IOPORT_SINGLE(pfx, bwlq, type, p)			\
+									\
+static inline void pfx##out##bwlq##p(type val, unsigned long port)	\
+{									\
+	volatile type *__addr;						\
+	type __val;							\
+									\
+	io_reorder_wmb();						\
+									\
+	__addr = (void *)(loongarch_io_port_base + port);		\
+									\
+	__val = pfx##ioswab##bwlq(__addr, val);				\
+									\
+	/* Really, we want this to be atomic */				\
+	BUILD_BUG_ON(sizeof(type) > sizeof(unsigned long));		\
+									\
+	*__addr = __val;						\
+}									\
+									\
+static inline type pfx##in##bwlq##p(unsigned long port)			\
+{									\
+	volatile type *__addr;						\
+	type __val;							\
+									\
+	__addr = (void *)(loongarch_io_port_base + port);		\
+									\
+	BUILD_BUG_ON(sizeof(type) > sizeof(unsigned long));		\
+									\
+	__val = *__addr;						\
+									\
+	/* prevent prefetching of coherent DMA data prematurely */	\
+	rmb();								\
+	return pfx##ioswab##bwlq(__addr, __val);			\
+}
+
+#define __BUILD_MEMORY_PFX(bus, bwlq, type)				\
+									\
+__BUILD_MEMORY_SINGLE(bus, bwlq, type)
+
+#define BUILDIO_MEM(bwlq, type)						\
+									\
+__BUILD_MEMORY_PFX(__raw_, bwlq, type)					\
+__BUILD_MEMORY_PFX(, bwlq, type)					\
+__BUILD_MEMORY_PFX(__mem_, bwlq, type)					\
+
+BUILDIO_MEM(b, u8)
+BUILDIO_MEM(w, u16)
+BUILDIO_MEM(l, u32)
+BUILDIO_MEM(q, u64)
+
+#define __BUILD_IOPORT_PFX(bus, bwlq, type)				\
+	__BUILD_IOPORT_SINGLE(bus, bwlq, type,)				\
+	__BUILD_IOPORT_SINGLE(bus, bwlq, type, _p)
+
+#define BUILDIO_IOPORT(bwlq, type)					\
+	__BUILD_IOPORT_PFX(, bwlq, type)				\
+	__BUILD_IOPORT_PFX(__mem_, bwlq, type)
+
+BUILDIO_IOPORT(b, u8)
+BUILDIO_IOPORT(w, u16)
+BUILDIO_IOPORT(l, u32)
+#ifdef CONFIG_64BIT
+BUILDIO_IOPORT(q, u64)
+#endif
+
+#define readb_relaxed			readb
+#define readw_relaxed			readw
+#define readl_relaxed			readl
+#define readq_relaxed			readq
+
+#define writeb_relaxed			writeb
+#define writew_relaxed			writew
+#define writel_relaxed			writel
+#define writeq_relaxed			writeq
+
+#define readb_be(addr)							\
+	__raw_readb((__force unsigned *)(addr))
+#define readw_be(addr)							\
+	be16_to_cpu(__raw_readw((__force unsigned *)(addr)))
+#define readl_be(addr)							\
+	be32_to_cpu(__raw_readl((__force unsigned *)(addr)))
+#define readq_be(addr)							\
+	be64_to_cpu(__raw_readq((__force unsigned *)(addr)))
+
+#define writeb_be(val, addr)						\
+	__raw_writeb((val), (__force unsigned *)(addr))
+#define writew_be(val, addr)						\
+	__raw_writew(cpu_to_be16((val)), (__force unsigned *)(addr))
+#define writel_be(val, addr)						\
+	__raw_writel(cpu_to_be32((val)), (__force unsigned *)(addr))
+#define writeq_be(val, addr)						\
+	__raw_writeq(cpu_to_be64((val)), (__force unsigned *)(addr))
+
+/*
+ * Some code tests for these symbols
+ */
+#define readq				readq
+#define writeq				writeq
+
+#define __BUILD_MEMORY_STRING(bwlq, type)				\
+									\
+static inline void writes##bwlq(volatile void __iomem *mem,		\
+				const void *addr, unsigned int count)	\
+{									\
+	const volatile type *__addr = addr;				\
+									\
+	while (count--) {						\
+		__mem_write##bwlq(*__addr, mem);			\
+		__addr++;						\
+	}								\
+}									\
+									\
+static inline void reads##bwlq(volatile void __iomem *mem, void *addr,	\
+			       unsigned int count)			\
+{									\
+	volatile type *__addr = addr;					\
+									\
+	while (count--) {						\
+		*__addr = __mem_read##bwlq(mem);			\
+		__addr++;						\
+	}								\
+}
+
+#define __BUILD_IOPORT_STRING(bwlq, type)				\
+									\
+static inline void outs##bwlq(unsigned long port, const void *addr,	\
+			      unsigned int count)			\
+{									\
+	const volatile type *__addr = addr;				\
+									\
+	while (count--) {						\
+		__mem_out##bwlq(*__addr, port);				\
+		__addr++;						\
+	}								\
+}									\
+									\
+static inline void ins##bwlq(unsigned long port, void *addr,		\
+			     unsigned int count)			\
+{									\
+	volatile type *__addr = addr;					\
+									\
+	while (count--) {						\
+		*__addr = __mem_in##bwlq(port);				\
+		__addr++;						\
+	}								\
+}
+
+#define BUILDSTRING(bwlq, type)						\
+									\
+__BUILD_MEMORY_STRING(bwlq, type)					\
+__BUILD_IOPORT_STRING(bwlq, type)
+
+BUILDSTRING(b, u8)
+BUILDSTRING(w, u16)
+BUILDSTRING(l, u32)
+#ifdef CONFIG_64BIT
+BUILDSTRING(q, u64)
+#endif
+
+#define mmiowb() asm volatile ("dbar 0" ::: "memory")
+
+/*
+ * String version of I/O memory access operations.
+ */
+extern void __memset_io(volatile void __iomem *dst, int c, size_t count);
+extern void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count);
+extern void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count);
+#define memset_io(c, v, l)     __memset_io((c), (v), (l))
+#define memcpy_fromio(a, c, l) __memcpy_fromio((a), (c), (l))
+#define memcpy_toio(c, a, l)   __memcpy_toio((c), (a), (l))
+
+/*
+ * Convert a physical pointer to a virtual kernel pointer for /dev/mem
+ * access
+ */
+#define xlate_dev_mem_ptr(p)	__va(p)
+
+/*
+ * Convert a virtual cached pointer to an uncached pointer
+ */
+#define xlate_dev_kmem_ptr(p)	p
+
+#endif /* _ASM_IO_H */
diff --git a/arch/loongarch/include/asm/vga.h b/arch/loongarch/include/asm/vga.h
new file mode 100644
index 000000000000..eef95f2f837a
--- /dev/null
+++ b/arch/loongarch/include/asm/vga.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Access to VGA videoram
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_VGA_H
+#define _ASM_VGA_H
+
+#include <linux/string.h>
+#include <asm/addrspace.h>
+#include <asm/byteorder.h>
+
+/*
+ *	On the PC, we can just recalculate addresses and then
+ *	access the videoram directly without any black magic.
+ */
+
+#define VGA_MAP_MEM(x, s)	TO_UNCAC(0x10000000L + (unsigned long)(x))
+
+#define vga_readb(x)	(*(x))
+#define vga_writeb(x, y)	(*(y) = (x))
+
+#define VT_BUF_HAVE_RW
+/*
+ *  These are only needed for supporting VGA or MDA text mode, which use little
+ *  endian byte ordering.
+ *  In other cases, we can optimize by using native byte ordering and
+ *  <linux/vt_buffer.h> has already done the right job for us.
+ */
+
+#undef scr_writew
+#undef scr_readw
+
+static inline void scr_writew(u16 val, volatile u16 *addr)
+{
+	*addr = cpu_to_le16(val);
+}
+
+static inline u16 scr_readw(volatile const u16 *addr)
+{
+	return le16_to_cpu(*addr);
+}
+
+static inline void scr_memsetw(u16 *s, u16 v, unsigned int count)
+{
+	memset16(s, cpu_to_le16(v), count / 2);
+}
+
+#define scr_memcpyw(d, s, c) memcpy(d, s, c)
+#define scr_memmovew(d, s, c) memmove(d, s, c)
+#define VT_BUF_HAVE_MEMCPYW
+#define VT_BUF_HAVE_MEMMOVEW
+#define VT_BUF_HAVE_MEMSETW
+
+#endif /* _ASM_VGA_H */
diff --git a/arch/loongarch/include/uapi/asm/swab.h b/arch/loongarch/include/uapi/asm/swab.h
new file mode 100644
index 000000000000..48db78a5f474
--- /dev/null
+++ b/arch/loongarch/include/uapi/asm/swab.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Authors: Jun Yi <yijun@loongson.cn>
+ *          Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_SWAB_H
+#define _ASM_SWAB_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+#define __SWAB_64_THRU_32__
+
+static inline __attribute_const__ __u16 __arch_swab16(__u16 x)
+{
+	__asm__(
+	"	revb.2h	%0, %1			\n"
+	: "=r" (x)
+	: "r" (x));
+
+	return x;
+}
+#define __arch_swab16 __arch_swab16
+
+static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
+{
+	__asm__(
+	"	revb.2h	%0, %1			\n"
+	"	rotri.w	%0, %0, 16		\n"
+	: "=r" (x)
+	: "r" (x));
+
+	return x;
+}
+#define __arch_swab32 __arch_swab32
+
+#ifdef __loongarch64
+static inline __attribute_const__ __u64 __arch_swab64(__u64 x)
+{
+	__asm__(
+	"	revb.4h	%0, %1			\n"
+	"	revh.d	%0, %0			\n"
+	: "=r" (x)
+	: "r" (x));
+
+	return x;
+}
+#define __arch_swab64 __arch_swab64
+#endif /* __loongarch64 */
+#endif /* _ASM_SWAB_H */
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
new file mode 100644
index 000000000000..b4efe336616b
--- /dev/null
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * asm-offsets.c: Calculate pt_regs and task_struct offsets.
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/compat.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/kbuild.h>
+#include <linux/suspend.h>
+#include <asm/cpu-info.h>
+#include <asm/ptrace.h>
+#include <asm/processor.h>
+
+void output_ptreg_defines(void)
+{
+	COMMENT("LoongArch pt_regs offsets.");
+	OFFSET(PT_R0, pt_regs, regs[0]);
+	OFFSET(PT_R1, pt_regs, regs[1]);
+	OFFSET(PT_R2, pt_regs, regs[2]);
+	OFFSET(PT_R3, pt_regs, regs[3]);
+	OFFSET(PT_R4, pt_regs, regs[4]);
+	OFFSET(PT_R5, pt_regs, regs[5]);
+	OFFSET(PT_R6, pt_regs, regs[6]);
+	OFFSET(PT_R7, pt_regs, regs[7]);
+	OFFSET(PT_R8, pt_regs, regs[8]);
+	OFFSET(PT_R9, pt_regs, regs[9]);
+	OFFSET(PT_R10, pt_regs, regs[10]);
+	OFFSET(PT_R11, pt_regs, regs[11]);
+	OFFSET(PT_R12, pt_regs, regs[12]);
+	OFFSET(PT_R13, pt_regs, regs[13]);
+	OFFSET(PT_R14, pt_regs, regs[14]);
+	OFFSET(PT_R15, pt_regs, regs[15]);
+	OFFSET(PT_R16, pt_regs, regs[16]);
+	OFFSET(PT_R17, pt_regs, regs[17]);
+	OFFSET(PT_R18, pt_regs, regs[18]);
+	OFFSET(PT_R19, pt_regs, regs[19]);
+	OFFSET(PT_R20, pt_regs, regs[20]);
+	OFFSET(PT_R21, pt_regs, regs[21]);
+	OFFSET(PT_R22, pt_regs, regs[22]);
+	OFFSET(PT_R23, pt_regs, regs[23]);
+	OFFSET(PT_R24, pt_regs, regs[24]);
+	OFFSET(PT_R25, pt_regs, regs[25]);
+	OFFSET(PT_R26, pt_regs, regs[26]);
+	OFFSET(PT_R27, pt_regs, regs[27]);
+	OFFSET(PT_R28, pt_regs, regs[28]);
+	OFFSET(PT_R29, pt_regs, regs[29]);
+	OFFSET(PT_R30, pt_regs, regs[30]);
+	OFFSET(PT_R31, pt_regs, regs[31]);
+	OFFSET(PT_CRMD, pt_regs, csr_crmd);
+	OFFSET(PT_PRMD, pt_regs, csr_prmd);
+	OFFSET(PT_EUEN, pt_regs, csr_euen);
+	OFFSET(PT_ECFG, pt_regs, csr_ecfg);
+	OFFSET(PT_ESTAT, pt_regs, csr_estat);
+	OFFSET(PT_EPC, pt_regs, csr_epc);
+	OFFSET(PT_BVADDR, pt_regs, csr_badvaddr);
+	OFFSET(PT_ORIG_A0, pt_regs, orig_a0);
+	DEFINE(PT_SIZE, sizeof(struct pt_regs));
+	BLANK();
+}
+
+void output_task_defines(void)
+{
+	COMMENT("LoongArch task_struct offsets.");
+	OFFSET(TASK_STATE, task_struct, __state);
+	OFFSET(TASK_THREAD_INFO, task_struct, stack);
+	OFFSET(TASK_FLAGS, task_struct, flags);
+	OFFSET(TASK_MM, task_struct, mm);
+	OFFSET(TASK_PID, task_struct, pid);
+	DEFINE(TASK_STRUCT_SIZE, sizeof(struct task_struct));
+	BLANK();
+}
+
+void output_thread_info_defines(void)
+{
+	COMMENT("LoongArch thread_info offsets.");
+	OFFSET(TI_TASK, thread_info, task);
+	OFFSET(TI_FLAGS, thread_info, flags);
+	OFFSET(TI_TP_VALUE, thread_info, tp_value);
+	OFFSET(TI_CPU, thread_info, cpu);
+	OFFSET(TI_PRE_COUNT, thread_info, preempt_count);
+	OFFSET(TI_REGS, thread_info, regs);
+	DEFINE(_THREAD_SIZE, THREAD_SIZE);
+	DEFINE(_THREAD_MASK, THREAD_MASK);
+	DEFINE(_IRQ_STACK_SIZE, IRQ_STACK_SIZE);
+	DEFINE(_IRQ_STACK_START, IRQ_STACK_START);
+	BLANK();
+}
+
+void output_thread_defines(void)
+{
+	COMMENT("LoongArch specific thread_struct offsets.");
+	OFFSET(THREAD_REG01, task_struct, thread.reg01);
+	OFFSET(THREAD_REG03, task_struct, thread.reg03);
+	OFFSET(THREAD_REG22, task_struct, thread.reg22);
+	OFFSET(THREAD_REG23, task_struct, thread.reg23);
+	OFFSET(THREAD_REG24, task_struct, thread.reg24);
+	OFFSET(THREAD_REG25, task_struct, thread.reg25);
+	OFFSET(THREAD_REG26, task_struct, thread.reg26);
+	OFFSET(THREAD_REG27, task_struct, thread.reg27);
+	OFFSET(THREAD_REG28, task_struct, thread.reg28);
+	OFFSET(THREAD_REG29, task_struct, thread.reg29);
+	OFFSET(THREAD_REG30, task_struct, thread.reg30);
+	OFFSET(THREAD_REG31, task_struct, thread.reg31);
+	OFFSET(THREAD_CSRCRMD, task_struct,
+	       thread.csr_crmd);
+	OFFSET(THREAD_CSRPRMD, task_struct,
+	       thread.csr_prmd);
+	OFFSET(THREAD_CSREUEN, task_struct,
+	       thread.csr_euen);
+	OFFSET(THREAD_CSRECFG, task_struct,
+	       thread.csr_ecfg);
+
+	OFFSET(THREAD_SCR0, task_struct, thread.scr0);
+	OFFSET(THREAD_SCR1, task_struct, thread.scr1);
+	OFFSET(THREAD_SCR2, task_struct, thread.scr2);
+	OFFSET(THREAD_SCR3, task_struct, thread.scr3);
+
+	OFFSET(THREAD_EFLAG, task_struct, thread.eflag);
+
+	OFFSET(THREAD_FPU, task_struct, thread.fpu);
+
+	OFFSET(THREAD_BVADDR, task_struct, \
+	       thread.csr_badvaddr);
+	OFFSET(THREAD_BUADDR, task_struct, \
+	       thread.csr_baduaddr);
+	OFFSET(THREAD_ECODE, task_struct, \
+	       thread.error_code);
+	OFFSET(THREAD_TRAPNO, task_struct, thread.trap_nr);
+	BLANK();
+}
+
+void output_thread_fpu_defines(void)
+{
+	OFFSET(THREAD_FPR0, loongarch_fpu, fpr[0]);
+	OFFSET(THREAD_FPR1, loongarch_fpu, fpr[1]);
+	OFFSET(THREAD_FPR2, loongarch_fpu, fpr[2]);
+	OFFSET(THREAD_FPR3, loongarch_fpu, fpr[3]);
+	OFFSET(THREAD_FPR4, loongarch_fpu, fpr[4]);
+	OFFSET(THREAD_FPR5, loongarch_fpu, fpr[5]);
+	OFFSET(THREAD_FPR6, loongarch_fpu, fpr[6]);
+	OFFSET(THREAD_FPR7, loongarch_fpu, fpr[7]);
+	OFFSET(THREAD_FPR8, loongarch_fpu, fpr[8]);
+	OFFSET(THREAD_FPR9, loongarch_fpu, fpr[9]);
+	OFFSET(THREAD_FPR10, loongarch_fpu, fpr[10]);
+	OFFSET(THREAD_FPR11, loongarch_fpu, fpr[11]);
+	OFFSET(THREAD_FPR12, loongarch_fpu, fpr[12]);
+	OFFSET(THREAD_FPR13, loongarch_fpu, fpr[13]);
+	OFFSET(THREAD_FPR14, loongarch_fpu, fpr[14]);
+	OFFSET(THREAD_FPR15, loongarch_fpu, fpr[15]);
+	OFFSET(THREAD_FPR16, loongarch_fpu, fpr[16]);
+	OFFSET(THREAD_FPR17, loongarch_fpu, fpr[17]);
+	OFFSET(THREAD_FPR18, loongarch_fpu, fpr[18]);
+	OFFSET(THREAD_FPR19, loongarch_fpu, fpr[19]);
+	OFFSET(THREAD_FPR20, loongarch_fpu, fpr[20]);
+	OFFSET(THREAD_FPR21, loongarch_fpu, fpr[21]);
+	OFFSET(THREAD_FPR22, loongarch_fpu, fpr[22]);
+	OFFSET(THREAD_FPR23, loongarch_fpu, fpr[23]);
+	OFFSET(THREAD_FPR24, loongarch_fpu, fpr[24]);
+	OFFSET(THREAD_FPR25, loongarch_fpu, fpr[25]);
+	OFFSET(THREAD_FPR26, loongarch_fpu, fpr[26]);
+	OFFSET(THREAD_FPR27, loongarch_fpu, fpr[27]);
+	OFFSET(THREAD_FPR28, loongarch_fpu, fpr[28]);
+	OFFSET(THREAD_FPR29, loongarch_fpu, fpr[29]);
+	OFFSET(THREAD_FPR30, loongarch_fpu, fpr[30]);
+	OFFSET(THREAD_FPR31, loongarch_fpu, fpr[31]);
+
+	OFFSET(THREAD_FCSR, loongarch_fpu, fcsr);
+	OFFSET(THREAD_FCC,  loongarch_fpu, fcc);
+	OFFSET(THREAD_VCSR, loongarch_fpu, vcsr);
+	BLANK();
+}
+
+void output_mm_defines(void)
+{
+	COMMENT("Size of struct page");
+	DEFINE(STRUCT_PAGE_SIZE, sizeof(struct page));
+	BLANK();
+	COMMENT("Linux mm_struct offsets.");
+	OFFSET(MM_USERS, mm_struct, mm_users);
+	OFFSET(MM_PGD, mm_struct, pgd);
+	OFFSET(MM_CONTEXT, mm_struct, context);
+	BLANK();
+	DEFINE(_PGD_T_SIZE, sizeof(pgd_t));
+	DEFINE(_PMD_T_SIZE, sizeof(pmd_t));
+	DEFINE(_PTE_T_SIZE, sizeof(pte_t));
+	BLANK();
+	DEFINE(_PGD_T_LOG2, PGD_T_LOG2);
+#ifndef __PAGETABLE_PMD_FOLDED
+	DEFINE(_PMD_T_LOG2, PMD_T_LOG2);
+#endif
+	DEFINE(_PTE_T_LOG2, PTE_T_LOG2);
+	BLANK();
+	DEFINE(_PGD_ORDER, PGD_ORDER);
+#ifndef __PAGETABLE_PMD_FOLDED
+	DEFINE(_PMD_ORDER, PMD_ORDER);
+#endif
+	DEFINE(_PTE_ORDER, PTE_ORDER);
+	BLANK();
+	DEFINE(_PMD_SHIFT, PMD_SHIFT);
+	DEFINE(_PGDIR_SHIFT, PGDIR_SHIFT);
+	BLANK();
+	DEFINE(_PTRS_PER_PGD, PTRS_PER_PGD);
+	DEFINE(_PTRS_PER_PMD, PTRS_PER_PMD);
+	DEFINE(_PTRS_PER_PTE, PTRS_PER_PTE);
+	BLANK();
+	DEFINE(_PAGE_SHIFT, PAGE_SHIFT);
+	DEFINE(_PAGE_SIZE, PAGE_SIZE);
+	BLANK();
+}
+
+#ifdef CONFIG_64BIT
+void output_sc_defines(void)
+{
+	COMMENT("Linux sigcontext offsets.");
+	OFFSET(SC_REGS, sigcontext, sc_regs);
+	OFFSET(SC_PC, sigcontext, sc_pc);
+	OFFSET(SC_FPC_CSR, sigcontext, sc_fcsr);
+	BLANK();
+}
+#endif
+
+void output_signal_defined(void)
+{
+	COMMENT("Linux signal numbers.");
+	DEFINE(_SIGHUP, SIGHUP);
+	DEFINE(_SIGINT, SIGINT);
+	DEFINE(_SIGQUIT, SIGQUIT);
+	DEFINE(_SIGILL, SIGILL);
+	DEFINE(_SIGTRAP, SIGTRAP);
+	DEFINE(_SIGIOT, SIGIOT);
+	DEFINE(_SIGABRT, SIGABRT);
+	DEFINE(_SIGFPE, SIGFPE);
+	DEFINE(_SIGKILL, SIGKILL);
+	DEFINE(_SIGBUS, SIGBUS);
+	DEFINE(_SIGSEGV, SIGSEGV);
+	DEFINE(_SIGSYS, SIGSYS);
+	DEFINE(_SIGPIPE, SIGPIPE);
+	DEFINE(_SIGALRM, SIGALRM);
+	DEFINE(_SIGTERM, SIGTERM);
+	DEFINE(_SIGUSR1, SIGUSR1);
+	DEFINE(_SIGUSR2, SIGUSR2);
+	DEFINE(_SIGCHLD, SIGCHLD);
+	DEFINE(_SIGPWR, SIGPWR);
+	DEFINE(_SIGWINCH, SIGWINCH);
+	DEFINE(_SIGURG, SIGURG);
+	DEFINE(_SIGIO, SIGIO);
+	DEFINE(_SIGSTOP, SIGSTOP);
+	DEFINE(_SIGTSTP, SIGTSTP);
+	DEFINE(_SIGCONT, SIGCONT);
+	DEFINE(_SIGTTIN, SIGTTIN);
+	DEFINE(_SIGTTOU, SIGTTOU);
+	DEFINE(_SIGVTALRM, SIGVTALRM);
+	DEFINE(_SIGPROF, SIGPROF);
+	DEFINE(_SIGXCPU, SIGXCPU);
+	DEFINE(_SIGXFSZ, SIGXFSZ);
+	BLANK();
+}
diff --git a/arch/loongarch/kernel/cmpxchg.c b/arch/loongarch/kernel/cmpxchg.c
new file mode 100644
index 000000000000..30f9f1ee4f0a
--- /dev/null
+++ b/arch/loongarch/kernel/cmpxchg.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#include <linux/bitops.h>
+#include <asm/cmpxchg.h>
+
+unsigned long __xchg_small(volatile void *ptr, unsigned long val, unsigned int size)
+{
+	u32 old32, new32, load32, mask;
+	volatile u32 *ptr32;
+	unsigned int shift;
+
+	/* Check that ptr is naturally aligned */
+	WARN_ON((unsigned long)ptr & (size - 1));
+
+	/* Mask value to the correct size. */
+	mask = GENMASK((size * BITS_PER_BYTE) - 1, 0);
+	val &= mask;
+
+	/*
+	 * Calculate a shift & mask that correspond to the value we wish to
+	 * exchange within the naturally aligned 4 byte integerthat includes
+	 * it.
+	 */
+	shift = (unsigned long)ptr & 0x3;
+	shift *= BITS_PER_BYTE;
+	mask <<= shift;
+
+	/*
+	 * Calculate a pointer to the naturally aligned 4 byte integer that
+	 * includes our byte of interest, and load its value.
+	 */
+	ptr32 = (volatile u32 *)((unsigned long)ptr & ~0x3);
+	load32 = *ptr32;
+
+	do {
+		old32 = load32;
+		new32 = (load32 & ~mask) | (val << shift);
+		load32 = arch_cmpxchg(ptr32, old32, new32);
+	} while (load32 != old32);
+
+	return (load32 & mask) >> shift;
+}
+
+unsigned long __cmpxchg_small(volatile void *ptr, unsigned long old,
+			      unsigned long new, unsigned int size)
+{
+	u32 mask, old32, new32, load32, load;
+	volatile u32 *ptr32;
+	unsigned int shift;
+
+	/* Check that ptr is naturally aligned */
+	WARN_ON((unsigned long)ptr & (size - 1));
+
+	/* Mask inputs to the correct size. */
+	mask = GENMASK((size * BITS_PER_BYTE) - 1, 0);
+	old &= mask;
+	new &= mask;
+
+	/*
+	 * Calculate a shift & mask that correspond to the value we wish to
+	 * compare & exchange within the naturally aligned 4 byte integer
+	 * that includes it.
+	 */
+	shift = (unsigned long)ptr & 0x3;
+	shift *= BITS_PER_BYTE;
+	mask <<= shift;
+
+	/*
+	 * Calculate a pointer to the naturally aligned 4 byte integer that
+	 * includes our byte of interest, and load its value.
+	 */
+	ptr32 = (volatile u32 *)((unsigned long)ptr & ~0x3);
+	load32 = *ptr32;
+
+	while (true) {
+		/*
+		 * Ensure the byte we want to exchange matches the expected
+		 * old value, and if not then bail.
+		 */
+		load = (load32 & mask) >> shift;
+		if (load != old)
+			return load;
+
+		/*
+		 * Calculate the old & new values of the naturally aligned
+		 * 4 byte integer that include the byte we want to exchange.
+		 * Attempt to exchange the old value for the new value, and
+		 * return if we succeed.
+		 */
+		old32 = (load32 & ~mask) | (old << shift);
+		new32 = (load32 & ~mask) | (new << shift);
+		load32 = arch_cmpxchg(ptr32, old32, new32);
+		if (load32 == old32)
+			return old;
+	}
+}
diff --git a/arch/loongarch/kernel/io.c b/arch/loongarch/kernel/io.c
new file mode 100644
index 000000000000..7d5ef9e0ae8f
--- /dev/null
+++ b/arch/loongarch/kernel/io.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/export.h>
+#include <linux/types.h>
+#include <linux/io.h>
+
+/*
+ * Copy data from IO memory space to "real" memory space.
+ */
+void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
+{
+	while (count && !IS_ALIGNED((unsigned long)from, 8)) {
+		*(u8 *)to = __raw_readb(from);
+		from++;
+		to++;
+		count--;
+	}
+
+	while (count >= 8) {
+		*(u64 *)to = __raw_readq(from);
+		from += 8;
+		to += 8;
+		count -= 8;
+	}
+
+	while (count) {
+		*(u8 *)to = __raw_readb(from);
+		from++;
+		to++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(__memcpy_fromio);
+
+/*
+ * Copy data from "real" memory space to IO memory space.
+ */
+void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
+{
+	while (count && !IS_ALIGNED((unsigned long)to, 8)) {
+		__raw_writeb(*(u8 *)from, to);
+		from++;
+		to++;
+		count--;
+	}
+
+	while (count >= 8) {
+		__raw_writeq(*(u64 *)from, to);
+		from += 8;
+		to += 8;
+		count -= 8;
+	}
+
+	while (count) {
+		__raw_writeb(*(u8 *)from, to);
+		from++;
+		to++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(__memcpy_toio);
+
+/*
+ * "memset" on IO memory space.
+ */
+void __memset_io(volatile void __iomem *dst, int c, size_t count)
+{
+	u64 qc = (u8)c;
+
+	qc |= qc << 8;
+	qc |= qc << 16;
+	qc |= qc << 32;
+
+	while (count && !IS_ALIGNED((unsigned long)dst, 8)) {
+		__raw_writeb(c, dst);
+		dst++;
+		count--;
+	}
+
+	while (count >= 8) {
+		__raw_writeq(qc, dst);
+		dst += 8;
+		count -= 8;
+	}
+
+	while (count) {
+		__raw_writeb(c, dst);
+		dst++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(__memset_io);
diff --git a/arch/loongarch/kernel/proc.c b/arch/loongarch/kernel/proc.c
new file mode 100644
index 000000000000..14e8fff4321e
--- /dev/null
+++ b/arch/loongarch/kernel/proc.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/seq_file.h>
+#include <asm/bootinfo.h>
+#include <asm/cpu.h>
+#include <asm/cpu-features.h>
+#include <asm/idle.h>
+#include <asm/processor.h>
+#include <asm/time.h>
+
+/*
+ * No lock; only written during early bootup by CPU 0.
+ */
+static RAW_NOTIFIER_HEAD(proc_cpuinfo_chain);
+
+int __ref register_proc_cpuinfo_notifier(struct notifier_block *nb)
+{
+	return raw_notifier_chain_register(&proc_cpuinfo_chain, nb);
+}
+
+int proc_cpuinfo_notifier_call_chain(unsigned long val, void *v)
+{
+	return raw_notifier_call_chain(&proc_cpuinfo_chain, val, v);
+}
+
+static int show_cpuinfo(struct seq_file *m, void *v)
+{
+	unsigned long n = (unsigned long) v - 1;
+	unsigned int version = cpu_data[n].processor_id & 0xff;
+	unsigned int fp_version = cpu_data[n].fpu_vers;
+	struct proc_cpuinfo_notifier_args proc_cpuinfo_notifier_args;
+
+	/*
+	 * For the first processor also print the system type
+	 */
+	if (n == 0)
+		seq_printf(m, "system type\t\t: %s\n", get_system_type());
+
+	seq_printf(m, "processor\t\t: %ld\n", n);
+	seq_printf(m, "package\t\t\t: %d\n", cpu_data[n].package);
+	seq_printf(m, "core\t\t\t: %d\n", cpu_core(&cpu_data[n]));
+	seq_printf(m, "cpu family\t\t: %s\n", __cpu_family[n]);
+	seq_printf(m, "model name\t\t: %s\n", __cpu_full_name[n]);
+	seq_printf(m, "CPU Revision\t\t: 0x%02x\n", version);
+	seq_printf(m, "FPU Revision\t\t: 0x%02x\n", fp_version);
+	seq_printf(m, "CPU MHz\t\t\t: %llu.%02llu\n",
+		      cpu_clock_freq / 1000000, (cpu_clock_freq / 10000) % 100);
+	seq_printf(m, "BogoMIPS\t\t: %llu.%02llu\n",
+		      (cpu_data[n].udelay_val * cpu_clock_freq / const_clock_freq) / (500000/HZ),
+		      ((cpu_data[n].udelay_val * cpu_clock_freq / const_clock_freq) / (5000/HZ)) % 100);
+	seq_printf(m, "TLB entries\t\t: %d\n", cpu_data[n].tlbsize);
+	seq_printf(m, "Address sizes\t\t: %d bits physical, %d bits virtual\n",
+		      cpu_pabits + 1, cpu_vabits + 1);
+
+	seq_printf(m, "isa\t\t\t:");
+	if (cpu_has_loongarch32)
+		seq_printf(m, "%s", " loongarch32");
+	if (cpu_has_loongarch64)
+		seq_printf(m, "%s", " loongarch64");
+	seq_printf(m, "\n");
+
+	seq_printf(m, "features\t\t:");
+	if (cpu_has_cpucfg)	seq_printf(m, "%s", " cpucfg");
+	if (cpu_has_lam)	seq_printf(m, "%s", " lam");
+	if (cpu_has_ual)	seq_printf(m, "%s", " ual");
+	if (cpu_has_fpu)	seq_printf(m, "%s", " fpu");
+	if (cpu_has_lsx)	seq_printf(m, "%s", " lsx");
+	if (cpu_has_lasx)	seq_printf(m, "%s", " lasx");
+	if (cpu_has_complex)	seq_printf(m, "%s", " complex");
+	if (cpu_has_crypto)	seq_printf(m, "%s", " crypto");
+	if (cpu_has_lvz)	seq_printf(m, "%s", " lvz");
+	if (cpu_has_lbt_x86)	seq_printf(m, "%s", " lbt_x86");
+	if (cpu_has_lbt_arm)	seq_printf(m, "%s", " lbt_arm");
+	if (cpu_has_lbt_mips)	seq_printf(m, "%s", " lbt_mips");
+	seq_printf(m, "\n");
+
+	seq_printf(m, "hardware watchpoint\t: %s",
+		      cpu_has_watch ? "yes, " : "no\n");
+	if (cpu_has_watch) {
+		seq_printf(m, "iwatch count: %d, dwatch count: %d\n",
+		      cpu_data[n].watch_ireg_count, cpu_data[n].watch_dreg_count);
+	}
+
+	proc_cpuinfo_notifier_args.m = m;
+	proc_cpuinfo_notifier_args.n = n;
+
+	raw_notifier_call_chain(&proc_cpuinfo_chain, 0,
+				&proc_cpuinfo_notifier_args);
+
+	seq_printf(m, "\n");
+
+	return 0;
+}
+
+static void *c_start(struct seq_file *m, loff_t *pos)
+{
+	unsigned long i = *pos;
+
+	return i < NR_CPUS ? (void *)(i + 1) : NULL;
+}
+
+static void *c_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	++*pos;
+	return c_start(m, pos);
+}
+
+static void c_stop(struct seq_file *m, void *v)
+{
+}
+
+const struct seq_operations cpuinfo_op = {
+	.start	= c_start,
+	.next	= c_next,
+	.stop	= c_stop,
+	.show	= show_cpuinfo,
+};
-- 
2.27.0

diff --git a/arch/loongarch/include/asm/cmpxchg.h b/arch/loongarch/include/asm/cmpxchg.h
index 97356f984e6e..77a21dc6def1 100644
--- a/arch/loongarch/include/asm/cmpxchg.h
+++ b/arch/loongarch/include/asm/cmpxchg.h
@@ -6,6 +6,7 @@
 #define __ASM_CMPXCHG_H
 
 #include <linux/bug.h>
+#include <asm/barrier.h>
 #include <asm/compiler.h>
 
 /*
