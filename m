Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3ABB418F87
	for <lists+linux-arch@lfdr.de>; Mon, 27 Sep 2021 08:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbhI0G5S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Sep 2021 02:57:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233067AbhI0G5R (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Sep 2021 02:57:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B668F61041;
        Mon, 27 Sep 2021 06:55:35 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
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
Subject: [PATCH V4 20/22] LoongArch: Add multi-processor (SMP) support
Date:   Mon, 27 Sep 2021 14:42:57 +0800
Message-Id: <20210927064300.624279-21-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210927064300.624279-1-chenhuacai@loongson.cn>
References: <20210927064300.624279-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds multi-processor (SMP) support for LoongArch.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig                  |  43 +-
 arch/loongarch/include/asm/atomic.h     |   4 +
 arch/loongarch/include/asm/barrier.h    | 108 ++++
 arch/loongarch/include/asm/cmpxchg.h    |   1 +
 arch/loongarch/include/asm/futex.h      |   1 +
 arch/loongarch/include/asm/hardirq.h    |   2 +
 arch/loongarch/include/asm/irq.h        |   3 +
 arch/loongarch/include/asm/percpu.h     | 202 +++++++
 arch/loongarch/include/asm/pgtable.h    |  21 +
 arch/loongarch/include/asm/smp.h        | 118 ++++
 arch/loongarch/include/asm/stackframe.h |  21 +
 arch/loongarch/include/asm/tlbflush.h   |  22 +-
 arch/loongarch/include/asm/topology.h   |   7 +-
 arch/loongarch/kernel/Makefile          |   2 +
 arch/loongarch/kernel/acpi.c            |  70 ++-
 arch/loongarch/kernel/head.S            |  23 +
 arch/loongarch/kernel/irq.c             |  46 +-
 arch/loongarch/kernel/proc.c            |   5 +
 arch/loongarch/kernel/process.c         |   7 +
 arch/loongarch/kernel/reset.c           |  12 +
 arch/loongarch/kernel/setup.c           |  26 +
 arch/loongarch/kernel/smp.c             | 755 ++++++++++++++++++++++++
 arch/loongarch/kernel/topology.c        |  43 +-
 arch/loongarch/kernel/vmlinux.lds.S     |   3 +
 arch/loongarch/mm/tlbex.S               |  69 +++
 include/linux/cpuhotplug.h              |   1 +
 26 files changed, 1603 insertions(+), 12 deletions(-)
 create mode 100644 arch/loongarch/include/asm/smp.h
 create mode 100644 arch/loongarch/kernel/smp.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 69d4174a246a..45df6223ee9e 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -61,6 +61,7 @@ config LOONGARCH
 	select GENERIC_LIB_LSHRDI3
 	select GENERIC_LIB_UCMPDI2
 	select GENERIC_PCI_IOMAP
+	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GPIOLIB
 	select HANDLE_DOMAIN_IRQ
@@ -93,7 +94,7 @@ config LOONGARCH
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_TIF_NOHZ
-	select HAVE_VIRT_CPU_ACCOUNTING_GEN
+	select HAVE_VIRT_CPU_ACCOUNTING_GEN if !SMP
 	select IRQ_FORCED_THREADING
 	select IRQ_LOONGARCH_CPU
 	select MODULES_USE_ELF_REL if MODULES
@@ -262,6 +263,46 @@ config EFI
 	  resultant kernel should continue to boot on existing non-EFI
 	  platforms.
 
+config SMP
+	bool "Multi-Processing support"
+	help
+	  This enables support for systems with more than one CPU. If you have
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
+
+	  If you say N here, the kernel will run on uni- and multiprocessor
+	  machines, but will use only one CPU of a multiprocessor machine. If
+	  you say Y here, the kernel will run on many, but not all,
+	  uniprocessor machines. On a uniprocessor machine, the kernel
+	  will run faster if you say N here.
+
+	  People using multiprocessor machines who say Y here should also say
+	  Y to "Enhanced Real Time Clock Support", below.
+
+	  See also the SMP-HOWTO available at
+	  <http://www.tldp.org/docs.html#howto>.
+
+	  If you don't know what to do here, say N.
+
+config HOTPLUG_CPU
+	bool "Support for hot-pluggable CPUs"
+	depends on SMP
+	help
+	  Say Y here to allow turning CPUs off and on. CPUs can be
+	  controlled through /sys/devices/system/cpu.
+	  (Note: power management support will enable this option
+	    automatically on SMP systems. )
+	  Say N if you want to disable CPU hotplug.
+
+config NR_CPUS
+	int "Maximum number of CPUs (2-256)"
+	range 2 256
+	depends on SMP
+	default "16"
+	help
+	  This allows you to specify the maximum number of CPUs which this
+	  kernel will support.
+
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
 	range 14 64 if PAGE_SIZE_64KB
diff --git a/arch/loongarch/include/asm/atomic.h b/arch/loongarch/include/asm/atomic.h
index 091552d84aa0..afb5256e5d11 100644
--- a/arch/loongarch/include/asm/atomic.h
+++ b/arch/loongarch/include/asm/atomic.h
@@ -125,6 +125,7 @@ static inline int arch_atomic_sub_if_positive(int i, atomic_t *v)
 		"	sc.w	%1, %2					\n"
 		"	beq	$zero, %1, 1b				\n"
 		"2:							\n"
+		__WEAK_LLSC_MB
 		: "=&r" (result), "=&r" (temp),
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)
 		: "I" (-i));
@@ -137,6 +138,7 @@ static inline int arch_atomic_sub_if_positive(int i, atomic_t *v)
 		"	sc.w	%1, %2					\n"
 		"	beq	$zero, %1, 1b				\n"
 		"2:							\n"
+		__WEAK_LLSC_MB
 		: "=&r" (result), "=&r" (temp),
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)
 		: "r" (i));
@@ -263,6 +265,7 @@ static inline long arch_atomic64_sub_if_positive(long i, atomic64_t *v)
 		"	sc.d	%1, %2					\n"
 		"	beq	%1, $zero, 1b				\n"
 		"2:							\n"
+		__WEAK_LLSC_MB
 		: "=&r" (result), "=&r" (temp),
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)
 		: "I" (-i));
@@ -275,6 +278,7 @@ static inline long arch_atomic64_sub_if_positive(long i, atomic64_t *v)
 		"	sc.d	%1, %2					\n"
 		"	beq	%1, $zero, 1b				\n"
 		"2:							\n"
+		__WEAK_LLSC_MB
 		: "=&r" (result), "=&r" (temp),
 		  "+" GCC_OFF_SMALL_ASM() (v->counter)
 		: "r" (i));
diff --git a/arch/loongarch/include/asm/barrier.h b/arch/loongarch/include/asm/barrier.h
index 8ab8d8f15b88..55b7fd325cf3 100644
--- a/arch/loongarch/include/asm/barrier.h
+++ b/arch/loongarch/include/asm/barrier.h
@@ -20,6 +20,19 @@
 #define mb()		fast_mb()
 #define iob()		fast_iob()
 
+#define __smp_mb()	__asm__ __volatile__("dbar 0" : : : "memory")
+#define __smp_rmb()	__asm__ __volatile__("dbar 0" : : : "memory")
+#define __smp_wmb()	__asm__ __volatile__("dbar 0" : : : "memory")
+
+#ifdef CONFIG_SMP
+#define __WEAK_LLSC_MB		"	dbar 0  \n"
+#else
+#define __WEAK_LLSC_MB		"		\n"
+#endif
+
+#define __smp_mb__before_atomic()	barrier()
+#define __smp_mb__after_atomic()	barrier()
+
 /**
  * array_index_mask_nospec() - generate a ~0 mask when index < size, 0 otherwise
  * @index: array element index
@@ -48,6 +61,101 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 	return mask;
 }
 
+#define __smp_load_acquire(p)							\
+({										\
+	union { typeof(*p) __val; char __c[1]; } __u;				\
+	unsigned long __tmp = 0;							\
+	compiletime_assert_atomic_type(*p);					\
+	switch (sizeof(*p)) {							\
+	case 1:									\
+		*(__u8 *)__u.__c = *(volatile __u8 *)p;				\
+		__smp_mb();							\
+		break;								\
+	case 2:									\
+		*(__u16 *)__u.__c = *(volatile __u16 *)p;			\
+		__smp_mb();							\
+		break;								\
+	case 4:									\
+		__asm__ __volatile__(						\
+		"amor.w %[val], %[tmp], %[mem]	\n"				\
+		: [val] "=&r" (*(__u32 *)__u.__c)				\
+		: [mem] "ZB" (*(u32 *) p), [tmp] "r" (__tmp)			\
+		: "memory");							\
+		break;								\
+	case 8:									\
+		__asm__ __volatile__(						\
+		"amor.d %[val], %[tmp], %[mem]	\n"				\
+		: [val] "=&r" (*(__u64 *)__u.__c)				\
+		: [mem] "ZB" (*(u64 *) p), [tmp] "r" (__tmp)			\
+		: "memory");							\
+		break;								\
+	}									\
+	(typeof(*p))__u.__val;								\
+})
+
+#define __smp_store_release(p, v)						\
+do {										\
+	union { typeof(*p) __val; char __c[1]; } __u =				\
+		{ .__val = (__force typeof(*p)) (v) };				\
+	unsigned long __tmp;							\
+	compiletime_assert_atomic_type(*p);					\
+	switch (sizeof(*p)) {							\
+	case 1:									\
+		__smp_mb();							\
+		*(volatile __u8 *)p = *(__u8 *)__u.__c;				\
+		break;								\
+	case 2:									\
+		__smp_mb();							\
+		*(volatile __u16 *)p = *(__u16 *)__u.__c;			\
+		break;								\
+	case 4:									\
+		__asm__ __volatile__(						\
+		"amswap.w %[tmp], %[val], %[mem]	\n"			\
+		: [mem] "+ZB" (*(u32 *)p), [tmp] "=&r" (__tmp)			\
+		: [val] "r" (*(__u32 *)__u.__c)					\
+		: );								\
+		break;								\
+	case 8:									\
+		__asm__ __volatile__(						\
+		"amswap.d %[tmp], %[val], %[mem]	\n"			\
+		: [mem] "+ZB" (*(u64 *)p), [tmp] "=&r" (__tmp)			\
+		: [val] "r" (*(__u64 *)__u.__c)					\
+		: );								\
+		break;								\
+	}									\
+} while (0)
+
+#define __smp_store_mb(p, v)							\
+do {										\
+	union { typeof(p) __val; char __c[1]; } __u =				\
+		{ .__val = (__force typeof(p)) (v) };				\
+	unsigned long __tmp;							\
+	switch (sizeof(p)) {							\
+	case 1:									\
+		*(volatile __u8 *)&p = *(__u8 *)__u.__c;			\
+		__smp_mb();							\
+		break;								\
+	case 2:									\
+		*(volatile __u16 *)&p = *(__u16 *)__u.__c;			\
+		__smp_mb();							\
+		break;								\
+	case 4:									\
+		__asm__ __volatile__(						\
+		"amswap.w %[tmp], %[val], %[mem]	\n"			\
+		: [mem] "+ZB" (*(u32 *)&p), [tmp] "=&r" (__tmp)			\
+		: [val] "r" (*(__u32 *)__u.__c)					\
+		: );								\
+		break;								\
+	case 8:									\
+		__asm__ __volatile__(						\
+		"amswap.d %[tmp], %[val], %[mem]	\n"			\
+		: [mem] "+ZB" (*(u64 *)&p), [tmp] "=&r" (__tmp)			\
+		: [val] "r" (*(__u64 *)__u.__c)					\
+		: );								\
+		break;								\
+	}									\
+} while (0)
+
 #include <asm-generic/barrier.h>
 
 #endif /* __ASM_BARRIER_H */
diff --git a/arch/loongarch/include/asm/cmpxchg.h b/arch/loongarch/include/asm/cmpxchg.h
index 13ee1b62dc12..76d601091c1d 100644
--- a/arch/loongarch/include/asm/cmpxchg.h
+++ b/arch/loongarch/include/asm/cmpxchg.h
@@ -67,6 +67,7 @@ static inline unsigned long __xchg(volatile void *ptr, unsigned long x,
 	"	" st "	$t0, %1				\n"		\
 	"	beq	$zero, $t0, 1b			\n"		\
 	"2:						\n"		\
+	__WEAK_LLSC_MB							\
 	: "=&r" (__ret), "=ZB"(*m)					\
 	: "ZB"(*m), "Jr" (old), "Jr" (new)				\
 	: "t0", "memory");						\
diff --git a/arch/loongarch/include/asm/futex.h b/arch/loongarch/include/asm/futex.h
index 6512feb041d1..22ddd3f7114b 100644
--- a/arch/loongarch/include/asm/futex.h
+++ b/arch/loongarch/include/asm/futex.h
@@ -86,6 +86,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr, u32 oldval, u32 newv
 	"2:	sc.w	$t0, %2					\n"
 	"	beq	$zero, $t0, 1b				\n"
 	"3:							\n"
+	__WEAK_LLSC_MB
 	"	.section .fixup,\"ax\"				\n"
 	"4:	li.d	%0, %6					\n"
 	"	b	3b					\n"
diff --git a/arch/loongarch/include/asm/hardirq.h b/arch/loongarch/include/asm/hardirq.h
index ccde14a45f67..d50298147a02 100644
--- a/arch/loongarch/include/asm/hardirq.h
+++ b/arch/loongarch/include/asm/hardirq.h
@@ -21,4 +21,6 @@ typedef struct {
 
 DECLARE_PER_CPU_ALIGNED(irq_cpustat_t, irq_stat);
 
+#define __ARCH_IRQ_STAT
+
 #endif /* _ASM_HARDIRQ_H */
diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index 4c0843952ee2..061c56857fbf 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -120,6 +120,9 @@ extern struct irq_domain *liointc_domain;
 extern struct irq_domain *pch_msi_domain[MAX_IO_PICS];
 extern struct irq_domain *pch_pic_domain[MAX_IO_PICS];
 
+extern void fixup_irqs(void);
+extern irqreturn_t loongson3_ipi_interrupt(int irq, void *dev);
+
 #include <asm-generic/irq.h>
 
 #endif /* _ASM_IRQ_H */
diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/include/asm/percpu.h
index ea5979872485..572f468fbb8a 100644
--- a/arch/loongarch/include/asm/percpu.h
+++ b/arch/loongarch/include/asm/percpu.h
@@ -5,6 +5,8 @@
 #ifndef __ASM_PERCPU_H
 #define __ASM_PERCPU_H
 
+#include <asm/cmpxchg.h>
+
 /* Use r21 for fast access */
 register unsigned long __my_cpu_offset __asm__("$r21");
 
@@ -15,6 +17,206 @@ static inline void set_my_cpu_offset(unsigned long off)
 }
 #define __my_cpu_offset __my_cpu_offset
 
+#define PERCPU_OP(op, asm_op, c_op)					\
+static inline unsigned long __percpu_##op(void *ptr,			\
+			unsigned long val, int size)			\
+{									\
+	unsigned long ret;						\
+									\
+	switch (size) {							\
+	case 4:								\
+		__asm__ __volatile__(					\
+		"am"#asm_op".w"	" %[ret], %[val], %[ptr]	\n"		\
+		: [ret] "=&r" (ret), [ptr] "+ZB"(*(u32 *)ptr)		\
+		: [val] "r" (val));					\
+		break;							\
+	case 8:								\
+		__asm__ __volatile__(					\
+		"am"#asm_op".d" " %[ret], %[val], %[ptr]	\n"		\
+		: [ret] "=&r" (ret), [ptr] "+ZB"(*(u64 *)ptr)		\
+		: [val] "r" (val));					\
+		break;							\
+	default:							\
+		ret = 0;						\
+		BUILD_BUG();						\
+	}								\
+									\
+	return ret c_op val;						\
+}
+
+PERCPU_OP(add, add, +)
+PERCPU_OP(and, and, &)
+PERCPU_OP(or, or, |)
+#undef PERCPU_OP
+
+static inline unsigned long __percpu_read(void *ptr, int size)
+{
+	unsigned long ret;
+
+	switch (size) {
+	case 1:
+		__asm__ __volatile__ ("ldx.b %[ret], $r21, %[ptr]	\n"
+		: [ret] "=&r"(ret)
+		: [ptr] "r"(ptr)
+		:);
+		break;
+	case 2:
+		__asm__ __volatile__ ("ldx.h %[ret], $r21, %[ptr]	\n"
+		: [ret] "=&r"(ret)
+		: [ptr] "r"(ptr)
+		:);
+		break;
+	case 4:
+		__asm__ __volatile__ ("ldx.w %[ret], $r21, %[ptr]	\n"
+		: [ret] "=&r"(ret)
+		: [ptr] "r"(ptr)
+		:);
+		break;
+	case 8:
+		__asm__ __volatile__ ("ldx.d %[ret], $r21, %[ptr]	\n"
+		: [ret] "=&r"(ret)
+		: [ptr] "r"(ptr)
+		:);
+		break;
+	default:
+		ret = 0;
+		BUILD_BUG();
+	}
+
+	return ret;
+}
+
+static inline void __percpu_write(void *ptr, unsigned long val, int size)
+{
+	switch (size) {
+	case 1:
+		__asm__ __volatile__("stx.b %[val], $r21, %[ptr]	\n"
+		:
+		: [val] "r" (val), [ptr] "r" (ptr)
+		: "memory");
+		break;
+	case 2:
+		__asm__ __volatile__("stx.h %[val], $r21, %[ptr]	\n"
+		:
+		: [val] "r" (val), [ptr] "r" (ptr)
+		: "memory");
+		break;
+	case 4:
+		__asm__ __volatile__("stx.w %[val], $r21, %[ptr]	\n"
+		:
+		: [val] "r" (val), [ptr] "r" (ptr)
+		: "memory");
+		break;
+	case 8:
+		__asm__ __volatile__("stx.d %[val], $r21, %[ptr]	\n"
+		:
+		: [val] "r" (val), [ptr] "r" (ptr)
+		: "memory");
+		break;
+	default:
+		BUILD_BUG();
+	}
+}
+
+static inline unsigned long __percpu_xchg(void *ptr, unsigned long val,
+						int size)
+{
+	switch (size) {
+	case 1:
+	case 2:
+		return __xchg_small((volatile void *)ptr, val, size);
+
+	case 4:
+		return __xchg_asm("amswap.w", (volatile u32 *)ptr, (u32)val);
+
+	case 8:
+		return __xchg_asm("amswap.d", (volatile u64 *)ptr, (u64)val);
+
+	default:
+		BUILD_BUG();
+	}
+
+	return 0;
+}
+
+/* this_cpu_cmpxchg */
+#define _protect_cmpxchg_local(pcp, o, n)			\
+({								\
+	typeof(*raw_cpu_ptr(&(pcp))) __ret;			\
+	preempt_disable();					\
+	__ret = cmpxchg_local(raw_cpu_ptr(&(pcp)), o, n);	\
+	preempt_enable();					\
+	__ret;							\
+})
+
+#define _percpu_read(pcp)						\
+({									\
+	typeof(pcp) __retval;						\
+	__retval = (typeof(pcp))__percpu_read(&(pcp), sizeof(pcp));	\
+	__retval;							\
+})
+
+#define _percpu_write(pcp, val)						\
+do {									\
+	__percpu_write(&(pcp), (unsigned long)(val), sizeof(pcp));	\
+} while (0)								\
+
+#define _pcp_protect(operation, pcp, val)			\
+({								\
+	typeof(pcp) __retval;					\
+	preempt_disable();					\
+	__retval = (typeof(pcp))operation(raw_cpu_ptr(&(pcp)),	\
+					  (val), sizeof(pcp));	\
+	preempt_enable();					\
+	__retval;						\
+})
+
+#define _percpu_add(pcp, val) \
+	_pcp_protect(__percpu_add, pcp, val)
+
+#define _percpu_add_return(pcp, val) _percpu_add(pcp, val)
+
+#define _percpu_and(pcp, val) \
+	_pcp_protect(__percpu_and, pcp, val)
+
+#define _percpu_or(pcp, val) \
+	_pcp_protect(__percpu_or, pcp, val)
+
+#define _percpu_xchg(pcp, val) ((typeof(pcp)) \
+	_pcp_protect(__percpu_xchg, pcp, (unsigned long)(val)))
+
+#define this_cpu_add_4(pcp, val) _percpu_add(pcp, val)
+#define this_cpu_add_8(pcp, val) _percpu_add(pcp, val)
+
+#define this_cpu_add_return_4(pcp, val) _percpu_add_return(pcp, val)
+#define this_cpu_add_return_8(pcp, val) _percpu_add_return(pcp, val)
+
+#define this_cpu_and_4(pcp, val) _percpu_and(pcp, val)
+#define this_cpu_and_8(pcp, val) _percpu_and(pcp, val)
+
+#define this_cpu_or_4(pcp, val) _percpu_or(pcp, val)
+#define this_cpu_or_8(pcp, val) _percpu_or(pcp, val)
+
+#define this_cpu_read_1(pcp) _percpu_read(pcp)
+#define this_cpu_read_2(pcp) _percpu_read(pcp)
+#define this_cpu_read_4(pcp) _percpu_read(pcp)
+#define this_cpu_read_8(pcp) _percpu_read(pcp)
+
+#define this_cpu_write_1(pcp, val) _percpu_write(pcp, val)
+#define this_cpu_write_2(pcp, val) _percpu_write(pcp, val)
+#define this_cpu_write_4(pcp, val) _percpu_write(pcp, val)
+#define this_cpu_write_8(pcp, val) _percpu_write(pcp, val)
+
+#define this_cpu_xchg_1(pcp, val) _percpu_xchg(pcp, val)
+#define this_cpu_xchg_2(pcp, val) _percpu_xchg(pcp, val)
+#define this_cpu_xchg_4(pcp, val) _percpu_xchg(pcp, val)
+#define this_cpu_xchg_8(pcp, val) _percpu_xchg(pcp, val)
+
+#define this_cpu_cmpxchg_1(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
+#define this_cpu_cmpxchg_2(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
+#define this_cpu_cmpxchg_4(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
+#define this_cpu_cmpxchg_8(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
+
 #include <asm-generic/percpu.h>
 
 #endif /* __ASM_PERCPU_H */
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index af0cea63b28d..3e86538d79cb 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -298,8 +298,29 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 		 * Make sure the buddy is global too (if it's !none,
 		 * it better already be global)
 		 */
+#ifdef CONFIG_SMP
+		/*
+		 * For SMP, multiple CPUs can race, so we need to do
+		 * this atomically.
+		 */
+		unsigned long page_global = _PAGE_GLOBAL;
+		unsigned long tmp;
+
+		__asm__ __volatile__ (
+		"1:"	__LL	"%[tmp], %[buddy]		\n"
+		"	bnez	%[tmp], 2f			\n"
+		"	 or	%[tmp], %[tmp], %[global]	\n"
+			__SC	"%[tmp], %[buddy]		\n"
+		"	beqz	%[tmp], 1b			\n"
+		"	nop					\n"
+		"2:						\n"
+		__WEAK_LLSC_MB
+		: [buddy] "+m" (buddy->pte), [tmp] "=&r" (tmp)
+		: [global] "r" (page_global));
+#else /* !CONFIG_SMP */
 		if (pte_none(*buddy))
 			pte_val(*buddy) = pte_val(*buddy) | _PAGE_GLOBAL;
+#endif /* CONFIG_SMP */
 	}
 }
 
diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/asm/smp.h
new file mode 100644
index 000000000000..710117bcb2e1
--- /dev/null
+++ b/arch/loongarch/include/asm/smp.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef __ASM_SMP_H
+#define __ASM_SMP_H
+
+#include <linux/atomic.h>
+#include <linux/bitops.h>
+#include <linux/linkage.h>
+#include <linux/smp.h>
+#include <linux/threads.h>
+#include <linux/cpumask.h>
+
+void loongson3_smp_setup(void);
+void loongson3_prepare_cpus(unsigned int max_cpus);
+void loongson3_boot_secondary(int cpu, struct task_struct *idle);
+void loongson3_init_secondary(void);
+void loongson3_smp_finish(void);
+void loongson3_send_ipi_single(int cpu, unsigned int action);
+void loongson3_send_ipi_mask(const struct cpumask *mask, unsigned int action);
+#ifdef CONFIG_HOTPLUG_CPU
+int loongson3_cpu_disable(void);
+void loongson3_cpu_die(unsigned int cpu);
+#endif
+
+#ifdef CONFIG_SMP
+
+static inline void plat_smp_setup(void)
+{
+	loongson3_smp_setup();
+}
+
+#else /* !CONFIG_SMP */
+
+static inline void plat_smp_setup(void) { }
+
+#endif /* !CONFIG_SMP */
+
+extern int smp_num_siblings;
+extern int num_processors;
+extern int disabled_cpus;
+extern cpumask_t cpu_sibling_map[];
+extern cpumask_t cpu_core_map[];
+extern cpumask_t cpu_foreign_map[];
+
+static inline int raw_smp_processor_id(void)
+{
+#if defined(__VDSO__)
+	extern int vdso_smp_processor_id(void)
+		__compiletime_error("VDSO should not call smp_processor_id()");
+	return vdso_smp_processor_id();
+#else
+	return current_thread_info()->cpu;
+#endif
+}
+#define raw_smp_processor_id raw_smp_processor_id
+
+/* Map from cpu id to sequential logical cpu number.  This will only
+ * not be idempotent when cpus failed to come on-line.	*/
+extern int __cpu_number_map[NR_CPUS];
+#define cpu_number_map(cpu)  __cpu_number_map[cpu]
+
+/* The reverse map from sequential logical cpu number to cpu id.  */
+extern int __cpu_logical_map[NR_CPUS];
+#define cpu_logical_map(cpu)  __cpu_logical_map[cpu]
+
+#define cpu_physical_id(cpu)	cpu_logical_map(cpu)
+
+#define SMP_BOOT_CPU		0x1
+#define SMP_RESCHEDULE		0x2
+#define SMP_CALL_FUNCTION	0x4
+
+extern asmlinkage void smpboot_entry(void);
+
+extern void calculate_cpu_foreign_map(void);
+
+/*
+ * Generate IPI list text
+ */
+extern void show_ipi_list(struct seq_file *p, int prec);
+
+/*
+ * This function sends a 'reschedule' IPI to another CPU.
+ * it goes straight through and wastes no time serializing
+ * anything. Worst case is that we lose a reschedule ...
+ */
+static inline void smp_send_reschedule(int cpu)
+{
+	loongson3_send_ipi_single(cpu, SMP_RESCHEDULE);
+}
+
+static inline void arch_send_call_function_single_ipi(int cpu)
+{
+	loongson3_send_ipi_single(cpu, SMP_CALL_FUNCTION);
+}
+
+static inline void arch_send_call_function_ipi_mask(const struct cpumask *mask)
+{
+	loongson3_send_ipi_mask(mask, SMP_CALL_FUNCTION);
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+static inline int __cpu_disable(void)
+{
+	return loongson3_cpu_disable();
+}
+
+static inline void __cpu_die(unsigned int cpu)
+{
+	loongson3_cpu_die(cpu);
+}
+
+extern void play_dead(void);
+#endif
+
+#endif /* __ASM_SMP_H */
diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
index 157211a5e786..5bcb2fc1c50f 100644
--- a/arch/loongarch/include/asm/stackframe.h
+++ b/arch/loongarch/include/asm/stackframe.h
@@ -76,8 +76,12 @@
  * kernelsp array for it. It stores the current sp in t0 and loads the
  * new value in sp.
  */
+#ifdef CONFIG_SMP
+	/* SMP variation */
 	.macro	get_saved_sp docfi=0
+	csrrd	t0, PERCPU_BASE_KS
 	la.abs	t1, kernelsp
+	LONG_ADDU	t1, t1, t0
 	move	t0, sp
 	.if \docfi
 	.cfi_register sp, t0
@@ -87,8 +91,25 @@
 
 	.macro	set_saved_sp stackp temp temp2
 	la.abs	\temp, kernelsp
+	LONG_ADDU	\temp, \temp, x0
 	LONG_S	\stackp, \temp, 0
 	.endm
+#else /* !CONFIG_SMP */
+	/* Uniprocessor variation */
+	.macro	get_saved_sp docfi=0
+	la.abs	t1, kernelsp
+	move	t0, sp
+	.if \docfi
+	.cfi_register sp, t0
+	.endif
+	LONG_L	sp, t1, 0
+	.endm
+
+	.macro	set_saved_sp stackp temp temp2
+	la.abs	\temp, kernelsp
+	LONG_S	\stackp, \temp, 0
+	.endm
+#endif
 
 	.macro	SAVE_SOME docfi=0
 	csrrd	t1, LOONGARCH_CSR_PRMD
diff --git a/arch/loongarch/include/asm/tlbflush.h b/arch/loongarch/include/asm/tlbflush.h
index a5672367d966..32862e53b845 100644
--- a/arch/loongarch/include/asm/tlbflush.h
+++ b/arch/loongarch/include/asm/tlbflush.h
@@ -18,14 +18,22 @@
  */
 extern void local_flush_tlb_all(void);
 extern void local_flush_tlb_mm(struct mm_struct *mm);
-extern void local_flush_tlb_range(struct vm_area_struct *vma,
-	unsigned long start, unsigned long end);
-extern void local_flush_tlb_kernel_range(unsigned long start,
-	unsigned long end);
-extern void local_flush_tlb_page(struct vm_area_struct *vma,
-	unsigned long page);
+extern void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start, unsigned long end);
+extern void local_flush_tlb_kernel_range(unsigned long start, unsigned long end);
+extern void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page);
 extern void local_flush_tlb_one(unsigned long vaddr);
 
+#ifdef CONFIG_SMP
+
+extern void flush_tlb_all(void);
+extern void flush_tlb_mm(struct mm_struct *);
+extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long, unsigned long);
+extern void flush_tlb_kernel_range(unsigned long, unsigned long);
+extern void flush_tlb_page(struct vm_area_struct *, unsigned long);
+extern void flush_tlb_one(unsigned long vaddr);
+
+#else /* CONFIG_SMP */
+
 #define flush_tlb_all()			local_flush_tlb_all()
 #define flush_tlb_mm(mm)		local_flush_tlb_mm(mm)
 #define flush_tlb_range(vma, vmaddr, end)	local_flush_tlb_range(vma, vmaddr, end)
@@ -33,4 +41,6 @@ extern void local_flush_tlb_one(unsigned long vaddr);
 #define flush_tlb_page(vma, page)	local_flush_tlb_page(vma, page)
 #define flush_tlb_one(vaddr)		local_flush_tlb_one(vaddr)
 
+#endif /* CONFIG_SMP */
+
 #endif /* __ASM_TLBFLUSH_H */
diff --git a/arch/loongarch/include/asm/topology.h b/arch/loongarch/include/asm/topology.h
index bf39f3911424..bc541a723f8a 100644
--- a/arch/loongarch/include/asm/topology.h
+++ b/arch/loongarch/include/asm/topology.h
@@ -7,7 +7,12 @@
 
 #include <linux/smp.h>
 
-#define cpu_logical_map(cpu)  0
+#ifdef CONFIG_SMP
+#define topology_physical_package_id(cpu)	(cpu_data[cpu].package)
+#define topology_core_id(cpu)			(cpu_core(&cpu_data[cpu]))
+#define topology_core_cpumask(cpu)		(&cpu_core_map[cpu])
+#define topology_sibling_cpumask(cpu)		(&cpu_sibling_map[cpu])
+#endif
 
 #include <asm-generic/topology.h>
 
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 9af33727664d..9d5cb652bfc0 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -19,4 +19,6 @@ obj-$(CONFIG_MODULES)		+= module.o
 
 obj-$(CONFIG_PROC_FS)		+= proc.o
 
+obj-$(CONFIG_SMP)		+= smp.o
+
 CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index 3f77c937e9ad..5ca7ffe9adcc 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -125,6 +125,35 @@ void __init acpi_boot_table_init(void)
 	}
 }
 
+static int set_processor_mask(u32 id, u32 flags)
+{
+
+	int cpu, cpuid = id;
+
+	if (num_processors >= nr_cpu_ids) {
+		pr_warn("acpi: nr_cpus/possible_cpus limit of %i reached."
+			" processor 0x%x ignored.\n", nr_cpu_ids, cpuid);
+
+		return -ENODEV;
+
+	}
+	if (cpuid == loongson_sysconf.boot_cpu_id)
+		cpu = 0;
+	else
+		cpu = cpumask_next_zero(-1, cpu_present_mask);
+
+	if (flags & ACPI_MADT_ENABLED) {
+		num_processors++;
+		set_cpu_possible(cpu, true);
+		set_cpu_present(cpu, true);
+		__cpu_number_map[cpuid] = cpu;
+		__cpu_logical_map[cpu] = cpuid;
+	} else
+		disabled_cpus++;
+
+	return cpu;
+}
+
 static int __init
 acpi_parse_cpuintc(union acpi_subtable_headers *header, const unsigned long end)
 {
@@ -135,6 +164,7 @@ acpi_parse_cpuintc(union acpi_subtable_headers *header, const unsigned long end)
 		return -EINVAL;
 
 	acpi_table_print_madt_entry(&header->common);
+	set_processor_mask(processor->core_id, processor->flags);
 
 	return 0;
 }
@@ -236,7 +266,12 @@ acpi_parse_pch_lpc(union acpi_subtable_headers *header, const unsigned long end)
 
 static void __init acpi_process_madt(void)
 {
-	int error;
+	int i, error;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		__cpu_number_map[i] = -1;
+		__cpu_logical_map[i] = -1;
+	}
 
 	/* Parse MADT CPUINTC entries */
 	error = acpi_table_parse_madt(ACPI_MADT_TYPE_CORE_PIC, acpi_parse_cpuintc, MAX_CORE_PIC);
@@ -322,3 +357,36 @@ void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
 {
 	memblock_mark_nomap(addr, size);
 }
+
+#ifdef CONFIG_ACPI_HOTPLUG_CPU
+
+#include <acpi/processor.h>
+
+int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id, int *pcpu)
+{
+	int cpu;
+
+	cpu = set_processor_mask(physid, ACPI_MADT_ENABLED);
+	if (cpu < 0) {
+		pr_info(PREFIX "Unable to map lapic to logical cpu number\n");
+		return cpu;
+	}
+
+	*pcpu = cpu;
+
+	return 0;
+}
+EXPORT_SYMBOL(acpi_map_cpu);
+
+int acpi_unmap_cpu(int cpu)
+{
+	set_cpu_present(cpu, false);
+	num_processors--;
+
+	pr_info("cpu%d hot remove!\n", cpu);
+
+	return 0;
+}
+EXPORT_SYMBOL(acpi_unmap_cpu);
+
+#endif /* CONFIG_ACPI_HOTPLUG_CPU */
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index 53e02fb0559d..56e929778267 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -69,4 +69,27 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
 
 SYM_CODE_END(kernel_entry)
 
+#ifdef CONFIG_SMP
+
+/*
+ * SMP slave cpus entry point.	Board specific code for bootstrap calls this
+ * function after setting up the stack and tp registers.
+ */
+SYM_CODE_START(smpboot_entry)
+	li.d		t0, CSR_DMW0_INIT	# UC, PLV0
+	csrwr		t0, LOONGARCH_CSR_DMWIN0
+	li.d		t0, CSR_DMW1_INIT	# CA, PLV0
+	csrwr		t0, LOONGARCH_CSR_DMWIN1
+	li.w		t0, 0xb0		# PLV=0, IE=0, PG=1
+	csrwr		t0, LOONGARCH_CSR_CRMD
+	li.w		t0, 0x04		# PLV=0, PIE=1, PWE=0
+	csrwr		t0, LOONGARCH_CSR_PRMD
+	li.w		t0, 0x00		# FPE=0, SXE=0, ASXE=0, BTE=0
+	csrwr		t0, LOONGARCH_CSR_EUEN
+
+	bl		start_secondary
+SYM_CODE_END(smpboot_entry)
+
+#endif /* CONFIG_SMP */
+
 SYM_ENTRY(kernel_entry_end, SYM_L_GLOBAL, SYM_A_NONE)
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index c5de109957b1..cfe21c128450 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -54,6 +54,41 @@ int find_pch_pic(u32 gsi)
 	return -1;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static void handle_irq_affinity(void)
+{
+	struct irq_desc *desc;
+	struct irq_chip *chip;
+	unsigned int irq;
+	unsigned long flags;
+	struct cpumask *affinity;
+
+	for_each_active_irq(irq) {
+		desc = irq_to_desc(irq);
+		if (!desc)
+			continue;
+
+		raw_spin_lock_irqsave(&desc->lock, flags);
+
+		affinity = desc->irq_data.common->affinity;
+		if (!cpumask_intersects(affinity, cpu_online_mask))
+			cpumask_copy(affinity, cpu_online_mask);
+
+		chip = irq_data_get_irq_chip(&desc->irq_data);
+		if (chip && chip->irq_set_affinity)
+			chip->irq_set_affinity(&desc->irq_data, desc->irq_data.common->affinity, true);
+		raw_spin_unlock_irqrestore(&desc->lock, flags);
+	}
+}
+
+void fixup_irqs(void)
+{
+	handle_irq_affinity();
+	irq_cpu_offline();
+	clear_csr_ecfg(ECFG0_IM);
+}
+#endif
+
 /*
  * 'what should we do if we get a hw irq event on an illegal vector'.
  * each architecture has to answer this themselves.
@@ -72,6 +107,7 @@ asmlinkage void spurious_interrupt(void)
 
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
+	show_ipi_list(p, prec);
 	seq_printf(p, "%*s: %10u\n", prec, "ERR", atomic_read(&irq_err_count));
 	return 0;
 }
@@ -107,13 +143,21 @@ void __init setup_IRQ(void)
 
 void __init init_IRQ(void)
 {
-	int i;
+	int i, r, ipi_irq;
+	static int ipi_dummy_dev;
 	unsigned int order = get_order(IRQ_STACK_SIZE);
 
 	clear_csr_ecfg(ECFG0_IM);
 	clear_csr_estat(ESTATF_IP);
 
 	setup_IRQ();
+#ifdef CONFIG_SMP
+	ipi_irq = get_ipi_irq();
+	irq_set_percpu_devid(ipi_irq);
+	r = request_percpu_irq(ipi_irq, loongson3_ipi_interrupt, "IPI", &ipi_dummy_dev);
+	if (r < 0)
+		panic("IPI IRQ request failed\n");
+#endif
 
 	for (i = 0; i < NR_IRQS; i++)
 		irq_set_noprobe(i);
diff --git a/arch/loongarch/kernel/proc.c b/arch/loongarch/kernel/proc.c
index 503fc6e4b96e..5bab1cc83fa3 100644
--- a/arch/loongarch/kernel/proc.c
+++ b/arch/loongarch/kernel/proc.c
@@ -35,6 +35,11 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	unsigned int fp_version = cpu_data[n].fpu_vers;
 	struct proc_cpuinfo_notifier_args proc_cpuinfo_notifier_args;
 
+#ifdef CONFIG_SMP
+	if (!cpu_online(n))
+		return 0;
+#endif
+
 	/*
 	 * For the first processor also print the system type
 	 */
diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index 66ad1276553f..1d0b886228a4 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -53,6 +53,13 @@
 unsigned long boot_option_idle_override = IDLE_NO_OVERRIDE;
 EXPORT_SYMBOL(boot_option_idle_override);
 
+#ifdef CONFIG_HOTPLUG_CPU
+void arch_cpu_idle_dead(void)
+{
+	play_dead();
+}
+#endif
+
 asmlinkage void ret_from_fork(void);
 asmlinkage void ret_from_kernel_thread(void);
 
diff --git a/arch/loongarch/kernel/reset.c b/arch/loongarch/kernel/reset.c
index b140c2aa2c5a..e26e322a83c5 100644
--- a/arch/loongarch/kernel/reset.c
+++ b/arch/loongarch/kernel/reset.c
@@ -65,16 +65,28 @@ EXPORT_SYMBOL(pm_power_off);
 
 void machine_halt(void)
 {
+#ifdef CONFIG_SMP
+	preempt_disable();
+	smp_send_stop();
+#endif
 	default_halt();
 }
 
 void machine_power_off(void)
 {
+#ifdef CONFIG_SMP
+	preempt_disable();
+	smp_send_stop();
+#endif
 	pm_power_off();
 }
 
 void machine_restart(char *command)
 {
+#ifdef CONFIG_SMP
+	preempt_disable();
+	smp_send_stop();
+#endif
 	do_kernel_restart(command);
 	pm_restart();
 }
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 7ec32959b36c..3ad6dc1dc565 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -39,6 +39,7 @@
 #include <asm/pgalloc.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
+#include <asm/smp.h>
 #include <asm/time.h>
 
 #define SMBIOS_BIOSSIZE_OFFSET		0x09
@@ -436,6 +437,29 @@ void __init platform_init(void)
 	efi_runtime_init();
 }
 
+#ifdef CONFIG_SMP
+static void __init prefill_possible_map(void)
+{
+	int i, possible;
+
+	possible = num_processors + disabled_cpus;
+	if (possible > nr_cpu_ids)
+		possible = nr_cpu_ids;
+
+	pr_info("SMP: Allowing %d CPUs, %d hotplug CPUs\n",
+			possible, max((possible - num_processors), 0));
+
+	for (i = 0; i < possible; i++)
+		set_cpu_possible(i, true);
+	for (; i < NR_CPUS; i++)
+		set_cpu_possible(i, false);
+
+	nr_cpu_ids = possible;
+}
+#else
+static inline void prefill_possible_map(void) {}
+#endif
+
 void __init setup_arch(char **cmdline_p)
 {
 	cpu_probe();
@@ -452,6 +476,8 @@ void __init setup_arch(char **cmdline_p)
 	arch_mem_init(cmdline_p);
 
 	resource_init();
+	plat_smp_setup();
+	prefill_possible_map();
 
 	paging_init();
 }
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
new file mode 100644
index 000000000000..3ecdf7e9ba7c
--- /dev/null
+++ b/arch/loongarch/kernel/smp.c
@@ -0,0 +1,755 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ *
+ * Derived from MIPS:
+ * Copyright (C) 2000, 2001 Kanoj Sarcar
+ * Copyright (C) 2000, 2001 Ralf Baechle
+ * Copyright (C) 2000, 2001 Silicon Graphics, Inc.
+ * Copyright (C) 2000, 2001, 2003 Broadcom Corporation
+ */
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/seq_file.h>
+#include <linux/smp.h>
+#include <linux/threads.h>
+#include <linux/export.h>
+#include <linux/time.h>
+#include <linux/tracepoint.h>
+#include <linux/sched/hotplug.h>
+#include <linux/sched/task_stack.h>
+
+#include <asm/cpu.h>
+#include <asm/idle.h>
+#include <asm/loongson.h>
+#include <asm/mmu_context.h>
+#include <asm/processor.h>
+#include <asm/setup.h>
+#include <asm/time.h>
+
+int __cpu_number_map[NR_CPUS];   /* Map physical to logical */
+EXPORT_SYMBOL(__cpu_number_map);
+
+int __cpu_logical_map[NR_CPUS];		/* Map logical to physical */
+EXPORT_SYMBOL(__cpu_logical_map);
+
+/* Number of threads (siblings) per CPU core */
+int smp_num_siblings = 1;
+EXPORT_SYMBOL(smp_num_siblings);
+
+/* Representing the threads (siblings) of each logical CPU */
+cpumask_t cpu_sibling_map[NR_CPUS] __read_mostly;
+EXPORT_SYMBOL(cpu_sibling_map);
+
+/* Representing the core map of multi-core chips of each logical CPU */
+cpumask_t cpu_core_map[NR_CPUS] __read_mostly;
+EXPORT_SYMBOL(cpu_core_map);
+
+static DECLARE_COMPLETION(cpu_starting);
+static DECLARE_COMPLETION(cpu_running);
+
+/*
+ * A logcal cpu mask containing only one VPE per core to
+ * reduce the number of IPIs on large MT systems.
+ */
+cpumask_t cpu_foreign_map[NR_CPUS] __read_mostly;
+EXPORT_SYMBOL(cpu_foreign_map);
+
+/* representing cpus for which sibling maps can be computed */
+static cpumask_t cpu_sibling_setup_map;
+
+/* representing cpus for which core maps can be computed */
+static cpumask_t cpu_core_setup_map;
+
+static DEFINE_PER_CPU(int, cpu_state);
+DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
+EXPORT_PER_CPU_SYMBOL(irq_stat);
+
+enum ipi_msg_type {
+	IPI_RESCHEDULE,
+	IPI_CALL_FUNCTION,
+};
+
+static const char *ipi_types[NR_IPI] __tracepoint_string = {
+	[IPI_RESCHEDULE] = "Rescheduling interrupts",
+	[IPI_CALL_FUNCTION] = "Call Function interrupts",
+};
+
+void show_ipi_list(struct seq_file *p, int prec)
+{
+	unsigned int cpu, i;
+
+	for (i = 0; i < NR_IPI; i++) {
+		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i, prec >= 4 ? " " : "");
+		for_each_online_cpu(cpu)
+			seq_printf(p, "%10u ", per_cpu(irq_stat, cpu).ipi_irqs[i]);
+		seq_printf(p, " LoongArch  %d  %s\n", i + 1, ipi_types[i]);
+	}
+}
+
+/* Send mailbox buffer via Mail_Send */
+static void csr_mail_send(uint64_t data, int cpu, int mailbox)
+{
+	uint64_t val;
+
+	/* Send high 32 bits */
+	val = IOCSR_MBUF_SEND_BLOCKING;
+	val |= (IOCSR_MBUF_SEND_BOX_HI(mailbox) << IOCSR_MBUF_SEND_BOX_SHIFT);
+	val |= (cpu << IOCSR_MBUF_SEND_CPU_SHIFT);
+	val |= (data & IOCSR_MBUF_SEND_H32_MASK);
+	iocsr_writeq(val, LOONGARCH_IOCSR_MBUF_SEND);
+
+	/* Send low 32 bits */
+	val = IOCSR_MBUF_SEND_BLOCKING;
+	val |= (IOCSR_MBUF_SEND_BOX_LO(mailbox) << IOCSR_MBUF_SEND_BOX_SHIFT);
+	val |= (cpu << IOCSR_MBUF_SEND_CPU_SHIFT);
+	val |= (data << IOCSR_MBUF_SEND_BUF_SHIFT);
+	iocsr_writeq(val, LOONGARCH_IOCSR_MBUF_SEND);
+};
+
+static u32 ipi_read_clear(int cpu)
+{
+	u32 action;
+
+	/* Load the ipi register to figure out what we're supposed to do */
+	action = iocsr_readl(LOONGARCH_IOCSR_IPI_STATUS);
+	/* Clear the ipi register to clear the interrupt */
+	iocsr_writel(action, LOONGARCH_IOCSR_IPI_CLEAR);
+	smp_mb();
+
+	return action;
+}
+
+static void ipi_write_action(int cpu, u32 action)
+{
+	unsigned int irq = 0;
+
+	while ((irq = ffs(action))) {
+		uint32_t val = IOCSR_IPI_SEND_BLOCKING;
+
+		val |= (irq - 1);
+		val |= (cpu << IOCSR_IPI_SEND_CPU_SHIFT);
+		iocsr_writel(val, LOONGARCH_IOCSR_IPI_SEND);
+		action &= ~BIT(irq - 1);
+	}
+}
+
+void loongson3_send_ipi_single(int cpu, unsigned int action)
+{
+	ipi_write_action(cpu_logical_map(cpu), (u32)action);
+}
+
+void loongson3_send_ipi_mask(const struct cpumask *mask, unsigned int action)
+{
+	unsigned int i;
+
+	for_each_cpu(i, mask)
+		ipi_write_action(cpu_logical_map(i), (u32)action);
+}
+
+irqreturn_t loongson3_ipi_interrupt(int irq, void *dev)
+{
+	unsigned int action;
+	unsigned int cpu = smp_processor_id();
+
+	action = ipi_read_clear(cpu_logical_map(cpu));
+
+	if (action & SMP_RESCHEDULE) {
+		scheduler_ipi();
+		per_cpu(irq_stat, cpu).ipi_irqs[IPI_RESCHEDULE]++;
+	}
+
+	if (action & SMP_CALL_FUNCTION) {
+		generic_smp_call_function_interrupt();
+		per_cpu(irq_stat, cpu).ipi_irqs[IPI_CALL_FUNCTION]++;
+	}
+
+	return IRQ_HANDLED;
+}
+
+void __init loongson3_smp_setup(void)
+{
+	cpu_set_core(&cpu_data[0],
+		     cpu_logical_map(0) % loongson_sysconf.cores_per_package);
+	cpu_set_cluster(&cpu_data[0],
+		     cpu_logical_map(0) / loongson_sysconf.cores_per_package);
+	cpu_data[0].package = cpu_logical_map(0) / loongson_sysconf.cores_per_package;
+
+	iocsr_writel(0xffffffff, LOONGARCH_IOCSR_IPI_EN);
+	pr_info("Detected %i available CPU(s)\n", loongson_sysconf.nr_cpus);
+}
+
+void __init loongson3_prepare_cpus(unsigned int max_cpus)
+{
+	int i = 0;
+
+	for (i = 0; i < loongson_sysconf.nr_cpus; i++) {
+		set_cpu_present(i, true);
+		csr_mail_send(0, __cpu_logical_map[i], 0);
+	}
+
+	per_cpu(cpu_state, smp_processor_id()) = CPU_ONLINE;
+}
+
+/*
+ * Setup the PC, SP, and TP of a secondary processor and start it running!
+ */
+void loongson3_boot_secondary(int cpu, struct task_struct *idle)
+{
+	unsigned long startargs[4];
+
+	pr_info("Booting CPU#%d...\n", cpu);
+
+	/* startargs[] are initial PC, SP and TP for secondary CPU */
+	startargs[0] = (unsigned long)&smpboot_entry;
+	startargs[1] = (unsigned long)__KSTK_TOS(idle);
+	startargs[2] = (unsigned long)task_thread_info(idle);
+	startargs[3] = 0;
+
+	csr_mail_send(startargs[3], cpu_logical_map(cpu), 3);
+	csr_mail_send(startargs[2], cpu_logical_map(cpu), 2);
+	csr_mail_send(startargs[1], cpu_logical_map(cpu), 1);
+	csr_mail_send(startargs[0], cpu_logical_map(cpu), 0);
+
+	pr_debug("CPU#%d, func_pc=%lx, sp=%lx, tp=%lx\n",
+			cpu, startargs[0], startargs[1], startargs[2]);
+	loongson3_send_ipi_single(cpu, SMP_BOOT_CPU);
+}
+
+/*
+ * SMP init and finish on secondary CPUs
+ */
+void loongson3_init_secondary(void)
+{
+	unsigned int cpu = smp_processor_id();
+	unsigned int imask = ECFGF_IP0 | ECFGF_IP1 | ECFGF_IP2 |
+			     ECFGF_IPI | ECFGF_PMC | ECFGF_TIMER;
+
+	change_csr_ecfg(ECFG0_IM, imask);
+
+	iocsr_writel(0xffffffff, LOONGARCH_IOCSR_IPI_EN);
+
+	per_cpu(cpu_state, cpu) = CPU_ONLINE;
+	cpu_set_core(&cpu_data[cpu],
+		     cpu_logical_map(cpu) % loongson_sysconf.cores_per_package);
+	cpu_set_cluster(&cpu_data[cpu],
+		     cpu_logical_map(cpu) / loongson_sysconf.cores_per_package);
+	cpu_data[cpu].package =
+		     cpu_logical_map(cpu) / loongson_sysconf.cores_per_package;
+}
+
+void loongson3_smp_finish(void)
+{
+	local_irq_enable();
+	iocsr_writeq(0, LOONGARCH_IOCSR_MBUF0);
+	pr_info("CPU#%d finished\n", smp_processor_id());
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+
+static bool io_master(int cpu)
+{
+	int i, node, master;
+
+	if (cpu == 0)
+		return true;
+
+	for (i = 1; i < loongson_sysconf.nr_io_pics; i++) {
+		node = eiointc_get_node(i);
+		master = cpumask_first(cpumask_of_node(node));
+		if (cpu == master)
+			return true;
+	}
+
+	return false;
+}
+
+int loongson3_cpu_disable(void)
+{
+	unsigned long flags;
+	unsigned int cpu = smp_processor_id();
+
+	if (io_master(cpu))
+		return -EBUSY;
+
+	set_cpu_online(cpu, false);
+	calculate_cpu_foreign_map();
+	local_irq_save(flags);
+	fixup_irqs();
+	local_irq_restore(flags);
+	local_flush_tlb_all();
+
+	return 0;
+}
+
+void loongson3_cpu_die(unsigned int cpu)
+{
+	while (per_cpu(cpu_state, cpu) != CPU_DEAD)
+		cpu_relax();
+
+	mb();
+}
+
+/*
+ * The target CPU should go to XKPRANGE (uncached area) and flush
+ * ICache/DCache/VCache before the control CPU can safely disable its clock.
+ */
+static void loongson3_play_dead(int *state_addr)
+{
+	register int val;
+	register void *addr;
+	register void (*init_fn)(void);
+
+	__asm__ __volatile__(
+		"   li.d %[addr], 0x8000000000000000\n"
+		"1: cacop 0x8, %[addr], 0           \n" /* flush ICache */
+		"   cacop 0x8, %[addr], 1           \n"
+		"   cacop 0x8, %[addr], 2           \n"
+		"   cacop 0x8, %[addr], 3           \n"
+		"   cacop 0x9, %[addr], 0           \n" /* flush DCache */
+		"   cacop 0x9, %[addr], 1           \n"
+		"   cacop 0x9, %[addr], 2           \n"
+		"   cacop 0x9, %[addr], 3           \n"
+		"   addi.w %[sets], %[sets], -1     \n"
+		"   addi.d %[addr], %[addr], 0x40   \n"
+		"   bnez %[sets], 1b                \n"
+		"   li.d %[addr], 0x8000000000000000\n"
+		"2: cacop 0xa, %[addr], 0           \n" /* flush VCache */
+		"   cacop 0xa, %[addr], 1           \n"
+		"   cacop 0xa, %[addr], 2           \n"
+		"   cacop 0xa, %[addr], 3           \n"
+		"   cacop 0xa, %[addr], 4           \n"
+		"   cacop 0xa, %[addr], 5           \n"
+		"   cacop 0xa, %[addr], 6           \n"
+		"   cacop 0xa, %[addr], 7           \n"
+		"   cacop 0xa, %[addr], 8           \n"
+		"   cacop 0xa, %[addr], 9           \n"
+		"   cacop 0xa, %[addr], 10          \n"
+		"   cacop 0xa, %[addr], 11          \n"
+		"   cacop 0xa, %[addr], 12          \n"
+		"   cacop 0xa, %[addr], 13          \n"
+		"   cacop 0xa, %[addr], 14          \n"
+		"   cacop 0xa, %[addr], 15          \n"
+		"   addi.w %[vsets], %[vsets], -1   \n"
+		"   addi.d %[addr], %[addr], 0x40   \n"
+		"   bnez   %[vsets], 2b             \n"
+		"   li.w   %[val], 0x7              \n" /* *state_addr = CPU_DEAD; */
+		"   st.w   %[val], %[state_addr], 0 \n"
+		"   dbar 0                          \n"
+		"   cacop 0x11, %[state_addr], 0    \n" /* flush entry of *state_addr */
+		: [addr] "=&r" (addr), [val] "=&r" (val)
+		: [state_addr] "r" (state_addr),
+		  [sets] "r" (cpu_data[smp_processor_id()].dcache.sets),
+		  [vsets] "r" (cpu_data[smp_processor_id()].vcache.sets));
+
+	local_irq_enable();
+	change_csr_ecfg(ECFG0_IM, ECFGF_IPI);
+
+	__asm__ __volatile__(
+		"   idle      0			    \n"
+		"   li.w      $t0, 0x1030	    \n"
+		"   iocsrrd.d $tp, $t0		    \n" /* get TP via mailbox */
+		"   li.w      $t0, 0x1028	    \n"
+		"   iocsrrd.d $sp, $t0		    \n" /* get SP via mailbox */
+		"   li.w      $t0, 0x1020	    \n"
+		"   iocsrrd.d %[init_fn], $t0	    \n" /* get PC via mailbox */
+		: [init_fn] "=&r" (init_fn)
+		: /* No Input */
+		: "a0");
+
+	init_fn();
+	unreachable();
+}
+
+void play_dead(void)
+{
+	int *state_addr;
+	unsigned int cpu = smp_processor_id();
+	void (*play_dead_uncached)(int *s);
+
+	idle_task_exit();
+	play_dead_uncached = (void *)TO_UNCAC(__pa((unsigned long)loongson3_play_dead));
+	state_addr = &per_cpu(cpu_state, cpu);
+	mb();
+	play_dead_uncached(state_addr);
+}
+
+static int loongson3_enable_clock(unsigned int cpu)
+{
+	uint64_t core_id = cpu_core(&cpu_data[cpu]);
+	uint64_t package_id = cpu_data[cpu].package;
+
+	LOONGSON_FREQCTRL(package_id) |= 1 << (core_id * 4 + 3);
+
+	return 0;
+}
+
+static int loongson3_disable_clock(unsigned int cpu)
+{
+	uint64_t core_id = cpu_core(&cpu_data[cpu]);
+	uint64_t package_id = cpu_data[cpu].package;
+
+	LOONGSON_FREQCTRL(package_id) &= ~(1 << (core_id * 4 + 3));
+
+	return 0;
+}
+
+static int register_loongson3_notifier(void)
+{
+	return cpuhp_setup_state_nocalls(CPUHP_LOONGARCH_SOC_PREPARE,
+					 "loongarch/loongson:prepare",
+					 loongson3_enable_clock,
+					 loongson3_disable_clock);
+}
+early_initcall(register_loongson3_notifier);
+
+#endif
+
+/*
+ * Power management
+ */
+#ifdef CONFIG_PM
+
+static int loongson3_ipi_suspend(void)
+{
+	return 0;
+}
+
+static void loongson3_ipi_resume(void)
+{
+	iocsr_writel(0xffffffff, LOONGARCH_IOCSR_IPI_EN);
+}
+
+static struct syscore_ops loongson3_ipi_syscore_ops = {
+	.resume         = loongson3_ipi_resume,
+	.suspend        = loongson3_ipi_suspend,
+};
+
+/*
+ * Enable boot cpu ipi before enabling nonboot cpus
+ * during syscore_resume.
+ */
+static int __init ipi_pm_init(void)
+{
+	register_syscore_ops(&loongson3_ipi_syscore_ops);
+	return 0;
+}
+
+core_initcall(ipi_pm_init);
+#endif
+
+static inline void set_cpu_sibling_map(int cpu)
+{
+	int i;
+
+	cpumask_set_cpu(cpu, &cpu_sibling_setup_map);
+
+	if (smp_num_siblings <= 1)
+		cpumask_set_cpu(cpu, &cpu_sibling_map[cpu]);
+	else {
+		for_each_cpu(i, &cpu_sibling_setup_map) {
+			if (cpus_are_siblings(cpu, i)) {
+				cpumask_set_cpu(i, &cpu_sibling_map[cpu]);
+				cpumask_set_cpu(cpu, &cpu_sibling_map[i]);
+			}
+		}
+	}
+}
+
+static inline void set_cpu_core_map(int cpu)
+{
+	int i;
+
+	cpumask_set_cpu(cpu, &cpu_core_setup_map);
+
+	for_each_cpu(i, &cpu_core_setup_map) {
+		if (cpu_data[cpu].package == cpu_data[i].package) {
+			cpumask_set_cpu(i, &cpu_core_map[cpu]);
+			cpumask_set_cpu(cpu, &cpu_core_map[i]);
+		}
+	}
+}
+
+/*
+ * Calculate a new cpu_foreign_map mask whenever a
+ * new cpu appears or disappears.
+ */
+void calculate_cpu_foreign_map(void)
+{
+	int i, k, core_present;
+	cpumask_t temp_foreign_map;
+
+	/* Re-calculate the mask */
+	cpumask_clear(&temp_foreign_map);
+	for_each_online_cpu(i) {
+		core_present = 0;
+		for_each_cpu(k, &temp_foreign_map)
+			if (cpus_are_siblings(i, k))
+				core_present = 1;
+		if (!core_present)
+			cpumask_set_cpu(i, &temp_foreign_map);
+	}
+
+	for_each_online_cpu(i)
+		cpumask_andnot(&cpu_foreign_map[i],
+			       &temp_foreign_map, &cpu_sibling_map[i]);
+}
+
+/* Preload SMP state for boot cpu */
+void smp_prepare_boot_cpu(void)
+{
+	unsigned int cpu;
+
+	set_cpu_possible(0, true);
+	set_cpu_online(0, true);
+	set_my_cpu_offset(per_cpu_offset(0));
+
+	for_each_possible_cpu(cpu)
+		set_cpu_numa_node(cpu, 0);
+}
+
+/* called from main before smp_init() */
+void __init smp_prepare_cpus(unsigned int max_cpus)
+{
+	init_new_context(current, &init_mm);
+	current_thread_info()->cpu = 0;
+	loongson3_prepare_cpus(max_cpus);
+	set_cpu_sibling_map(0);
+	set_cpu_core_map(0);
+	calculate_cpu_foreign_map();
+#ifndef CONFIG_HOTPLUG_CPU
+	init_cpu_present(cpu_possible_mask);
+#endif
+}
+
+int __cpu_up(unsigned int cpu, struct task_struct *tidle)
+{
+
+	loongson3_boot_secondary(cpu, tidle);
+
+	/* Wait for CPU to start and be ready to sync counters */
+	if (!wait_for_completion_timeout(&cpu_starting,
+					 msecs_to_jiffies(1000))) {
+		pr_crit("CPU%u: failed to start\n", cpu);
+		return -EIO;
+	}
+
+	/* Wait for CPU to finish startup & mark itself online before return */
+	wait_for_completion(&cpu_running);
+
+	return 0;
+}
+
+/*
+ * First C code run on the secondary CPUs after being started up by
+ * the master.
+ */
+asmlinkage void start_secondary(void)
+{
+	unsigned int cpu;
+
+	sync_counter();
+	cpu = smp_processor_id();
+	set_my_cpu_offset(per_cpu_offset(cpu));
+
+	cpu_probe();
+	constant_clockevent_init();
+	loongson3_init_secondary();
+
+	notify_cpu_starting(cpu);
+
+	/* Notify boot CPU that we're starting */
+	complete(&cpu_starting);
+
+	/* The CPU is running, now mark it online */
+	set_cpu_online(cpu, true);
+
+	set_cpu_sibling_map(cpu);
+	set_cpu_core_map(cpu);
+
+	calculate_cpu_foreign_map();
+
+	/*
+	 * Notify boot CPU that we're up & online and it can safely return
+	 * from __cpu_up()
+	 */
+	complete(&cpu_running);
+
+	/*
+	 * irq will be enabled in loongson3_smp_finish(), enabling it too
+	 * early is dangerous.
+	 */
+	WARN_ON_ONCE(!irqs_disabled());
+	loongson3_smp_finish();
+
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
+}
+
+void __init smp_cpus_done(unsigned int max_cpus)
+{
+}
+
+static void stop_this_cpu(void *dummy)
+{
+	set_cpu_online(smp_processor_id(), false);
+	calculate_cpu_foreign_map();
+	local_irq_disable();
+	while (true);
+}
+
+void smp_send_stop(void)
+{
+	smp_call_function(stop_this_cpu, NULL, 0);
+}
+
+int setup_profiling_timer(unsigned int multiplier)
+{
+	return 0;
+}
+
+static void flush_tlb_all_ipi(void *info)
+{
+	local_flush_tlb_all();
+}
+
+void flush_tlb_all(void)
+{
+	on_each_cpu(flush_tlb_all_ipi, NULL, 1);
+}
+
+static void flush_tlb_mm_ipi(void *mm)
+{
+	local_flush_tlb_mm((struct mm_struct *)mm);
+}
+
+void flush_tlb_mm(struct mm_struct *mm)
+{
+	preempt_disable();
+
+	if ((atomic_read(&mm->mm_users) != 1) || (current->mm != mm)) {
+		on_each_cpu_mask(mm_cpumask(mm), flush_tlb_mm_ipi, mm, 1);
+	} else {
+		unsigned int cpu;
+
+		for_each_online_cpu(cpu) {
+			if (cpu != smp_processor_id() && cpu_context(cpu, mm))
+				cpu_context(cpu, mm) = 0;
+		}
+		local_flush_tlb_mm(mm);
+	}
+
+	preempt_enable();
+}
+
+struct flush_tlb_data {
+	struct vm_area_struct *vma;
+	unsigned long addr1;
+	unsigned long addr2;
+};
+
+static void flush_tlb_range_ipi(void *info)
+{
+	struct flush_tlb_data *fd = info;
+
+	local_flush_tlb_range(fd->vma, fd->addr1, fd->addr2);
+}
+
+void flush_tlb_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
+{
+	struct mm_struct *mm = vma->vm_mm;
+
+	preempt_disable();
+	if ((atomic_read(&mm->mm_users) != 1) || (current->mm != mm)) {
+		struct flush_tlb_data fd = {
+			.vma = vma,
+			.addr1 = start,
+			.addr2 = end,
+		};
+
+		on_each_cpu_mask(mm_cpumask(mm), flush_tlb_range_ipi, &fd, 1);
+	} else {
+		unsigned int cpu;
+		int exec = vma->vm_flags & VM_EXEC;
+
+		for_each_online_cpu(cpu) {
+			/*
+			 * flush_cache_range() will only fully flush icache if
+			 * the VMA is executable, otherwise we must invalidate
+			 * ASID without it appearing to has_valid_asid() as if
+			 * mm has been completely unused by that CPU.
+			 */
+			if (cpu != smp_processor_id() && cpu_context(cpu, mm))
+				cpu_context(cpu, mm) = !exec;
+		}
+		local_flush_tlb_range(vma, start, end);
+	}
+	preempt_enable();
+}
+
+static void flush_tlb_kernel_range_ipi(void *info)
+{
+	struct flush_tlb_data *fd = info;
+
+	local_flush_tlb_kernel_range(fd->addr1, fd->addr2);
+}
+
+void flush_tlb_kernel_range(unsigned long start, unsigned long end)
+{
+	struct flush_tlb_data fd = {
+		.addr1 = start,
+		.addr2 = end,
+	};
+
+	on_each_cpu(flush_tlb_kernel_range_ipi, &fd, 1);
+}
+
+static void flush_tlb_page_ipi(void *info)
+{
+	struct flush_tlb_data *fd = info;
+
+	local_flush_tlb_page(fd->vma, fd->addr1);
+}
+
+void flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
+{
+	preempt_disable();
+	if ((atomic_read(&vma->vm_mm->mm_users) != 1) || (current->mm != vma->vm_mm)) {
+		struct flush_tlb_data fd = {
+			.vma = vma,
+			.addr1 = page,
+		};
+
+		on_each_cpu_mask(mm_cpumask(vma->vm_mm), flush_tlb_page_ipi, &fd, 1);
+	} else {
+		unsigned int cpu;
+
+		for_each_online_cpu(cpu) {
+			/*
+			 * flush_cache_page() only does partial flushes, so
+			 * invalidate ASID without it appearing to
+			 * has_valid_asid() as if mm has been completely unused
+			 * by that CPU.
+			 */
+			if (cpu != smp_processor_id() && cpu_context(cpu, vma->vm_mm))
+				cpu_context(cpu, vma->vm_mm) = 1;
+		}
+		local_flush_tlb_page(vma, page);
+	}
+	preempt_enable();
+}
+EXPORT_SYMBOL(flush_tlb_page);
+
+static void flush_tlb_one_ipi(void *info)
+{
+	unsigned long vaddr = (unsigned long) info;
+
+	local_flush_tlb_one(vaddr);
+}
+
+void flush_tlb_one(unsigned long vaddr)
+{
+	on_each_cpu(flush_tlb_one_ipi, (void *)vaddr, 1);
+}
+EXPORT_SYMBOL(flush_tlb_one);
diff --git a/arch/loongarch/kernel/topology.c b/arch/loongarch/kernel/topology.c
index 3b2cbb95875b..ab1a75c0b5a6 100644
--- a/arch/loongarch/kernel/topology.c
+++ b/arch/loongarch/kernel/topology.c
@@ -1,13 +1,52 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/cpu.h>
+#include <linux/cpumask.h>
 #include <linux/init.h>
+#include <linux/node.h>
+#include <linux/nodemask.h>
 #include <linux/percpu.h>
 
-static struct cpu cpu_device;
+static DEFINE_PER_CPU(struct cpu, cpu_devices);
+
+#ifdef CONFIG_HOTPLUG_CPU
+int arch_register_cpu(int cpu)
+{
+	int ret;
+	struct cpu *c = &per_cpu(cpu_devices, cpu);
+
+	c->hotpluggable = 1;
+	ret = register_cpu(c, cpu);
+	if (ret < 0)
+		pr_warn("register_cpu %d failed (%d)\n", cpu, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL(arch_register_cpu);
+
+void arch_unregister_cpu(int cpu)
+{
+	struct cpu *c = &per_cpu(cpu_devices, cpu);
+
+	c->hotpluggable = 0;
+	unregister_cpu(c);
+}
+EXPORT_SYMBOL(arch_unregister_cpu);
+#endif
 
 static int __init topology_init(void)
 {
-	return register_cpu(&cpu_device, 0);
+	int i, ret;
+
+	for_each_present_cpu(i) {
+		struct cpu *c = &per_cpu(cpu_devices, i);
+
+		c->hotpluggable = !!i;
+		ret = register_cpu(c, i);
+		if (ret < 0)
+			pr_warn("topology_init: register_cpu %d failed (%d)\n", i, ret);
+	}
+
+	return 0;
 }
 
 subsys_initcall(topology_init);
diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
index 3ae212100de5..9a919f512d06 100644
--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -70,6 +70,9 @@ SECTIONS
 	.exit.data : {
 		EXIT_DATA
 	}
+#ifdef CONFIG_SMP
+	PERCPU_SECTION(1 << CONFIG_L1_CACHE_SHIFT)
+#endif
 
 	/*
 	 * Align to 64K in attempt to eliminate holes before the
diff --git a/arch/loongarch/mm/tlbex.S b/arch/loongarch/mm/tlbex.S
index 7073949fe072..47675d880785 100644
--- a/arch/loongarch/mm/tlbex.S
+++ b/arch/loongarch/mm/tlbex.S
@@ -81,7 +81,14 @@ vmalloc_done_load:
 	slli.d	t0, t0, _PTE_T_LOG2
 	add.d	t1, ra, t0
 
+#ifdef CONFIG_SMP
+smp_pgtable_change_load:
+#endif
+#ifdef CONFIG_SMP
+	ll.d	t0, t1, 0
+#else
 	ld.d	t0, t1, 0
+#endif
 	tlbsrch
 
 	srli.d	ra, t0, _PAGE_PRESENT_SHIFT
@@ -89,7 +96,12 @@ vmalloc_done_load:
 	beq	ra, $r0, nopage_tlb_load
 
 	ori	t0, t0, _PAGE_VALID
+#ifdef CONFIG_SMP
+	sc.d	t0, t1, 0
+	beq	t0, $r0, smp_pgtable_change_load
+#else
 	st.d	t0, t1, 0
+#endif
 	ori	t1, t1, 8
 	xori	t1, t1, 8
 	ld.d	t0, t1, 0
@@ -113,14 +125,24 @@ vmalloc_load:
 	 * spots a huge page.
 	 */
 tlb_huge_update_load:
+#ifdef CONFIG_SMP
+	ll.d	t0, t1, 0
+#else
 	ld.d	t0, t1, 0
+#endif
 	srli.d	ra, t0, _PAGE_PRESENT_SHIFT
 	andi	ra, ra, 1
 	beq	ra, $r0, nopage_tlb_load
 	tlbsrch
 
 	ori	t0, t0, _PAGE_VALID
+#ifdef CONFIG_SMP
+	sc.d	t0, t1, 0
+	beq	t0, $r0, tlb_huge_update_load
+	ld.d	t0, t1, 0
+#else
 	st.d	t0, t1, 0
+#endif
 	addu16i.d	t1, $r0, -(CSR_TLBIDX_EHINV >> 16)
 	addi.d	ra, t1, 0
 	csrxchg	ra, t1, LOONGARCH_CSR_TLBIDX
@@ -166,6 +188,7 @@ tlb_huge_update_load:
 	csrxchg		t1, t0, LOONGARCH_CSR_TLBIDX
 
 nopage_tlb_load:
+	dbar	0
 	csrrd	ra, EXCEPTION_KS2
 	la.abs	t0, tlb_do_page_fault_0
 	jirl	$r0, t0, 0
@@ -222,7 +245,14 @@ vmalloc_done_store:
 	slli.d	t0, t0, _PTE_T_LOG2
 	add.d	t1, ra, t0
 
+#ifdef CONFIG_SMP
+smp_pgtable_change_store:
+#endif
+#ifdef CONFIG_SMP
+	ll.d	t0, t1, 0
+#else
 	ld.d	t0, t1, 0
+#endif
 	tlbsrch
 
 	srli.d	ra, t0, _PAGE_PRESENT_SHIFT
@@ -231,7 +261,12 @@ vmalloc_done_store:
 	bne	ra, $r0, nopage_tlb_store
 
 	ori	t0, t0, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
+#ifdef CONFIG_SMP
+	sc.d	t0, t1, 0
+	beq	t0, $r0, smp_pgtable_change_store
+#else
 	st.d	t0, t1, 0
+#endif
 
 	ori	t1, t1, 8
 	xori	t1, t1, 8
@@ -256,7 +291,11 @@ vmalloc_store:
 	 * spots a huge page.
 	 */
 tlb_huge_update_store:
+#ifdef CONFIG_SMP
+	ll.d	t0, t1, 0
+#else
 	ld.d	t0, t1, 0
+#endif
 	srli.d	ra, t0, _PAGE_PRESENT_SHIFT
 	andi	ra, ra, ((_PAGE_PRESENT | _PAGE_WRITE) >> _PAGE_PRESENT_SHIFT)
 	xori	ra, ra, ((_PAGE_PRESENT | _PAGE_WRITE) >> _PAGE_PRESENT_SHIFT)
@@ -265,7 +304,13 @@ tlb_huge_update_store:
 	tlbsrch
 	ori	t0, t0, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
 
+#ifdef CONFIG_SMP
+	sc.d	t0, t1, 0
+	beq	t0, $r0, tlb_huge_update_store
+	ld.d	t0, t1, 0
+#else
 	st.d	t0, t1, 0
+#endif
 	addu16i.d	t1, $r0, -(CSR_TLBIDX_EHINV >> 16)
 	addi.d	ra, t1, 0
 	csrxchg	ra, t1, LOONGARCH_CSR_TLBIDX
@@ -311,6 +356,7 @@ tlb_huge_update_store:
 	csrxchg		t1, t0, LOONGARCH_CSR_TLBIDX
 
 nopage_tlb_store:
+	dbar	0
 	csrrd	ra, EXCEPTION_KS2
 	la.abs	t0, tlb_do_page_fault_1
 	jirl	$r0, t0, 0
@@ -366,7 +412,14 @@ vmalloc_done_modify:
 	slli.d	t0, t0, _PTE_T_LOG2
 	add.d	t1, ra, t0
 
+#ifdef CONFIG_SMP
+smp_pgtable_change_modify:
+#endif
+#ifdef CONFIG_SMP
+	ll.d	t0, t1, 0
+#else
 	ld.d	t0, t1, 0
+#endif
 	tlbsrch
 
 	srli.d	ra, t0, _PAGE_WRITE_SHIFT
@@ -374,7 +427,12 @@ vmalloc_done_modify:
 	beq	ra, $r0, nopage_tlb_modify
 
 	ori	t0, t0, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
+#ifdef CONFIG_SMP
+	sc.d	t0, t1, 0
+	beq	t0, $r0, smp_pgtable_change_modify
+#else
 	st.d	t0, t1, 0
+#endif
 	ori	t1, t1, 8
 	xori	t1, t1, 8
 	ld.d	t0, t1, 0
@@ -398,7 +456,11 @@ vmalloc_modify:
 	 * build_tlbchange_handler_head spots a huge page.
 	 */
 tlb_huge_update_modify:
+#ifdef CONFIG_SMP
+	ll.d	t0, t1, 0
+#else
 	ld.d	t0, t1, 0
+#endif
 
 	srli.d	ra, t0, _PAGE_WRITE_SHIFT
 	andi	ra, ra, 1
@@ -407,7 +469,13 @@ tlb_huge_update_modify:
 	tlbsrch
 	ori	t0, t0, (_PAGE_VALID | _PAGE_DIRTY | _PAGE_MODIFIED)
 
+#ifdef CONFIG_SMP
+	sc.d	t0, t1, 0
+	beq	t0, $r0, tlb_huge_update_modify
+	ld.d	t0, t1, 0
+#else
 	st.d	t0, t1, 0
+#endif
 	/*
 	 * A huge PTE describes an area the size of the
 	 * configured huge page size. This is twice the
@@ -447,6 +515,7 @@ tlb_huge_update_modify:
 	csrxchg	t1, t0, LOONGARCH_CSR_TLBIDX
 
 nopage_tlb_modify:
+	dbar	0
 	csrrd	ra, EXCEPTION_KS2
 	la.abs	t0, tlb_do_page_fault_1
 	jirl	$r0, t0, 0
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 541d02f05352..0624995cba9d 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -126,6 +126,7 @@ enum cpuhp_state {
 	CPUHP_ZCOMP_PREPARE,
 	CPUHP_TIMERS_PREPARE,
 	CPUHP_MIPS_SOC_PREPARE,
+	CPUHP_LOONGARCH_SOC_PREPARE,
 	CPUHP_BP_PREPARE_DYN,
 	CPUHP_BP_PREPARE_DYN_END		= CPUHP_BP_PREPARE_DYN + 20,
 	CPUHP_BRINGUP_CPU,
-- 
2.27.0

