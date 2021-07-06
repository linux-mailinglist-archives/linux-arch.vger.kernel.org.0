Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D501B3BC540
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 06:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhGFEXc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 00:23:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhGFEXc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 00:23:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0669261416;
        Tue,  6 Jul 2021 04:20:50 +0000 (UTC)
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
Subject: [PATCH 16/19] LoongArch: Add VDSO and VSYSCALL support
Date:   Tue,  6 Jul 2021 12:18:17 +0800
Message-Id: <20210706041820.1536502-17-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210706041820.1536502-1-chenhuacai@loongson.cn>
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch adds VDSO and VSYSCALL support (gettimeofday and its friends)
for LoongArch.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/vdso.h             |  50 +++
 arch/loongarch/include/asm/vdso/clocksource.h |   8 +
 .../loongarch/include/asm/vdso/gettimeofday.h | 101 ++++++
 arch/loongarch/include/asm/vdso/processor.h   |  14 +
 arch/loongarch/include/asm/vdso/vdso.h        |  42 +++
 arch/loongarch/include/asm/vdso/vsyscall.h    |  27 ++
 arch/loongarch/kernel/vdso.c                  | 132 ++++++++
 arch/loongarch/vdso/Makefile                  |  97 ++++++
 arch/loongarch/vdso/elf.S                     |  15 +
 arch/loongarch/vdso/genvdso.c                 | 311 ++++++++++++++++++
 arch/loongarch/vdso/genvdso.h                 | 122 +++++++
 arch/loongarch/vdso/sigreturn.S               |  24 ++
 arch/loongarch/vdso/vdso.lds.S                |  65 ++++
 arch/loongarch/vdso/vgettimeofday.c           |  26 ++
 14 files changed, 1034 insertions(+)
 create mode 100644 arch/loongarch/include/asm/vdso.h
 create mode 100644 arch/loongarch/include/asm/vdso/clocksource.h
 create mode 100644 arch/loongarch/include/asm/vdso/gettimeofday.h
 create mode 100644 arch/loongarch/include/asm/vdso/processor.h
 create mode 100644 arch/loongarch/include/asm/vdso/vdso.h
 create mode 100644 arch/loongarch/include/asm/vdso/vsyscall.h
 create mode 100644 arch/loongarch/kernel/vdso.c
 create mode 100644 arch/loongarch/vdso/Makefile
 create mode 100644 arch/loongarch/vdso/elf.S
 create mode 100644 arch/loongarch/vdso/genvdso.c
 create mode 100644 arch/loongarch/vdso/genvdso.h
 create mode 100644 arch/loongarch/vdso/sigreturn.S
 create mode 100644 arch/loongarch/vdso/vdso.lds.S
 create mode 100644 arch/loongarch/vdso/vgettimeofday.c

diff --git a/arch/loongarch/include/asm/vdso.h b/arch/loongarch/include/asm/vdso.h
new file mode 100644
index 000000000000..d137ee9b217a
--- /dev/null
+++ b/arch/loongarch/include/asm/vdso.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#ifndef __ASM_VDSO_H
+#define __ASM_VDSO_H
+
+#include <linux/mm_types.h>
+#include <vdso/datapage.h>
+
+#include <asm/barrier.h>
+
+/**
+ * struct loongarch_vdso_image - Details of a VDSO image.
+ * @data: Pointer to VDSO image data (page-aligned).
+ * @size: Size of the VDSO image data (page-aligned).
+ * @off_sigreturn: Offset of the sigreturn() trampoline.
+ * @off_rt_sigreturn: Offset of the rt_sigreturn() trampoline.
+ * @mapping: Special mapping structure.
+ *
+ * This structure contains details of a VDSO image, including the image data
+ * and offsets of certain symbols required by the kernel. It is generated as
+ * part of the VDSO build process, aside from the mapping page array, which is
+ * populated at runtime.
+ */
+struct loongarch_vdso_image {
+	void *data;
+	unsigned long size;
+
+	unsigned long off_sigreturn;
+	unsigned long off_rt_sigreturn;
+
+	struct vm_special_mapping mapping;
+};
+
+/*
+ * The following structures are auto-generated as part of the build for each
+ * ABI by genvdso, see arch/loongarch/vdso/Makefile.
+ */
+
+extern struct loongarch_vdso_image vdso_image;
+
+union loongarch_vdso_data {
+	struct vdso_data data[CS_BASES];
+	u8 page[PAGE_SIZE];
+};
+
+#endif /* __ASM_VDSO_H */
diff --git a/arch/loongarch/include/asm/vdso/clocksource.h b/arch/loongarch/include/asm/vdso/clocksource.h
new file mode 100644
index 000000000000..13cd580d406d
--- /dev/null
+++ b/arch/loongarch/include/asm/vdso/clocksource.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __ASM_VDSOCLOCKSOURCE_H
+#define __ASM_VDSOCLOCKSOURCE_H
+
+#define VDSO_ARCH_CLOCKMODES	\
+	VDSO_CLOCKMODE_CPU
+
+#endif /* __ASM_VDSOCLOCKSOURCE_H */
diff --git a/arch/loongarch/include/asm/vdso/gettimeofday.h b/arch/loongarch/include/asm/vdso/gettimeofday.h
new file mode 100644
index 000000000000..d86bfd3a890e
--- /dev/null
+++ b/arch/loongarch/include/asm/vdso/gettimeofday.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef __ASM_VDSO_GETTIMEOFDAY_H
+#define __ASM_VDSO_GETTIMEOFDAY_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/vdso/vdso.h>
+#include <asm/clocksource.h>
+#include <asm/unistd.h>
+#include <asm/vdso.h>
+
+#define VDSO_HAS_CLOCK_GETRES		1
+
+static __always_inline long gettimeofday_fallback(
+				struct __kernel_old_timeval *_tv,
+				struct timezone *_tz)
+{
+	register struct __kernel_old_timeval *tv asm("a0") = _tv;
+	register struct timezone *tz asm("a1") = _tz;
+	register long nr asm("a7") = __NR_gettimeofday;
+	register long ret asm("v0");
+
+	asm volatile(
+	"       syscall 0\n"
+	: "=r" (ret)
+	: "r" (nr), "r" (tv), "r" (tz)
+	: "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7",
+	  "$t8", "memory");
+
+	return ret;
+}
+
+static __always_inline long clock_gettime_fallback(
+					clockid_t _clkid,
+					struct __kernel_timespec *_ts)
+{
+	register clockid_t clkid asm("a0") = _clkid;
+	register struct __kernel_timespec *ts asm("a1") = _ts;
+	register long nr asm("a7") = __NR_clock_gettime;
+	register long ret asm("v0");
+
+	asm volatile(
+	"       syscall 0\n"
+	: "=r" (ret)
+	: "r" (nr), "r" (clkid), "r" (ts)
+	: "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7",
+	  "$t8", "memory");
+
+	return ret;
+}
+
+static __always_inline int clock_getres_fallback(
+					clockid_t _clkid,
+					struct __kernel_timespec *_ts)
+{
+	register clockid_t clkid asm("a0") = _clkid;
+	register struct __kernel_timespec *ts asm("a1") = _ts;
+	register long nr asm("a7") = __NR_clock_getres;
+	register long ret asm("v0");
+
+	asm volatile(
+	"       syscall 0\n"
+	: "=r" (ret)
+	: "r" (nr), "r" (clkid), "r" (ts)
+	: "$t0", "$t1", "$t2", "$t3", "$t4", "$t5", "$t6", "$t7",
+	  "$t8", "memory");
+
+	return ret;
+}
+
+static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
+						 const struct vdso_data *vd)
+{
+	unsigned int count;
+
+	__asm__ __volatile__(
+	"	rdtime.d %0, $zero\n"
+	: "=r" (count));
+
+	return count;
+}
+
+static inline bool loongarch_vdso_hres_capable(void)
+{
+	return true;
+}
+#define __arch_vdso_hres_capable loongarch_vdso_hres_capable
+
+static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
+{
+	return get_vdso_data();
+}
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/loongarch/include/asm/vdso/processor.h b/arch/loongarch/include/asm/vdso/processor.h
new file mode 100644
index 000000000000..7fb46fd66512
--- /dev/null
+++ b/arch/loongarch/include/asm/vdso/processor.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#ifndef __ASM_VDSO_PROCESSOR_H
+#define __ASM_VDSO_PROCESSOR_H
+
+#ifndef __ASSEMBLY__
+
+#define cpu_relax()	barrier()
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_PROCESSOR_H */
diff --git a/arch/loongarch/include/asm/vdso/vdso.h b/arch/loongarch/include/asm/vdso/vdso.h
new file mode 100644
index 000000000000..873a983614ac
--- /dev/null
+++ b/arch/loongarch/include/asm/vdso/vdso.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#ifndef __ASSEMBLY__
+
+#include <asm/asm.h>
+#include <asm/page.h>
+#include <asm/vdso.h>
+
+static inline unsigned long get_vdso_base(void)
+{
+	unsigned long addr;
+
+	/*
+	 * Get the base load address of the VDSO. We have to avoid generating
+	 * relocations and references to the GOT because ld.so does not peform
+	 * relocations on the VDSO. We use the current offset from the VDSO base
+	 * and perform a PC-relative branch which gives the absolute address in
+	 * ra, and take the difference. The assembler chokes on
+	 * "li.w %0, _start - .", so embed the offset as a word and branch over
+	 * it.
+	 *
+	 */
+
+	__asm__(
+	" la.pcrel %0, _start\n"
+	: "=r" (addr)
+	:
+	:);
+
+	return addr;
+}
+
+static inline const struct vdso_data *get_vdso_data(void)
+{
+	return (const struct vdso_data *)(get_vdso_base() - PAGE_SIZE);
+}
+
+#endif /* __ASSEMBLY__ */
diff --git a/arch/loongarch/include/asm/vdso/vsyscall.h b/arch/loongarch/include/asm/vdso/vsyscall.h
new file mode 100644
index 000000000000..5de615383a22
--- /dev/null
+++ b/arch/loongarch/include/asm/vdso/vsyscall.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_VDSO_VSYSCALL_H
+#define __ASM_VDSO_VSYSCALL_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/timekeeper_internal.h>
+#include <vdso/datapage.h>
+
+extern struct vdso_data *vdso_data;
+
+/*
+ * Update the vDSO data page to keep in sync with kernel timekeeping.
+ */
+static __always_inline
+struct vdso_data *__loongarch_get_k_vdso_data(void)
+{
+	return vdso_data;
+}
+#define __arch_get_k_vdso_data __loongarch_get_k_vdso_data
+
+/* The asm-generic header needs to be included after the definitions above */
+#include <asm-generic/vdso/vsyscall.h>
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_VSYSCALL_H */
diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
new file mode 100644
index 000000000000..82635c3a4d74
--- /dev/null
+++ b/arch/loongarch/kernel/vdso.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#include <linux/binfmts.h>
+#include <linux/elf.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/random.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/timekeeper_internal.h>
+
+#include <asm/abi.h>
+#include <asm/page.h>
+#include <asm/vdso.h>
+#include <vdso/helpers.h>
+#include <vdso/vsyscall.h>
+
+/* Kernel-provided data used by the VDSO. */
+static union loongarch_vdso_data loongarch_vdso_data __page_aligned_data;
+struct vdso_data *vdso_data = loongarch_vdso_data.data;
+
+/*
+ * Mapping for the VDSO data pages. The real pages are mapped manually, as
+ * what we map and where within the area they are mapped is determined at
+ * runtime.
+ */
+static struct page *no_pages[] = { NULL };
+static struct vm_special_mapping vdso_vvar_mapping = {
+	.name = "[vvar]",
+	.pages = no_pages,
+};
+
+static void __init init_vdso_image(struct loongarch_vdso_image *image)
+{
+	unsigned long num_pages, i;
+	unsigned long data_pfn;
+
+	BUG_ON(!PAGE_ALIGNED(image->data));
+	BUG_ON(!PAGE_ALIGNED(image->size));
+
+	num_pages = image->size / PAGE_SIZE;
+
+	data_pfn = __phys_to_pfn(__pa_symbol(image->data));
+	for (i = 0; i < num_pages; i++)
+		image->mapping.pages[i] = pfn_to_page(data_pfn + i);
+}
+
+static int __init init_vdso(void)
+{
+	init_vdso_image(&vdso_image);
+	return 0;
+}
+subsys_initcall(init_vdso);
+
+static unsigned long vdso_base(void)
+{
+	unsigned long base;
+
+	if (current->flags & PF_RANDOMIZE) {
+		base += get_random_int() & (VDSO_RANDOMIZE_SIZE - 1);
+		base = PAGE_ALIGN(base);
+	}
+
+	return base;
+}
+
+int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+{
+	struct loongarch_vdso_image *image = current->thread.abi->vdso;
+	struct mm_struct *mm = current->mm;
+	unsigned long vvar_size, size, base, data_addr, vdso_addr;
+	struct vm_area_struct *vma;
+	int ret;
+
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+
+	/*
+	 * Determine total area size. This includes the VDSO data itself
+	 * and the data page.
+	 */
+	vvar_size = PAGE_SIZE;
+	size = vvar_size + image->size;
+
+	base = get_unmapped_area(NULL, vdso_base(), size, 0, 0);
+	if (IS_ERR_VALUE(base)) {
+		ret = base;
+		goto out;
+	}
+
+	data_addr = base;
+	vdso_addr = data_addr + PAGE_SIZE;
+
+	vma = _install_special_mapping(mm, base, vvar_size,
+				       VM_READ | VM_MAYREAD,
+				       &vdso_vvar_mapping);
+	if (IS_ERR(vma)) {
+		ret = PTR_ERR(vma);
+		goto out;
+	}
+
+	/* Map data page. */
+	ret = remap_pfn_range(vma, data_addr,
+			      virt_to_phys(vdso_data) >> PAGE_SHIFT,
+			      PAGE_SIZE, PAGE_READONLY);
+	if (ret)
+		goto out;
+
+	/* Map VDSO image. */
+	vma = _install_special_mapping(mm, vdso_addr, image->size,
+				       VM_READ | VM_EXEC |
+				       VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC,
+				       &image->mapping);
+	if (IS_ERR(vma)) {
+		ret = PTR_ERR(vma);
+		goto out;
+	}
+
+	mm->context.vdso = (void *)vdso_addr;
+	ret = 0;
+
+out:
+	mmap_write_unlock(mm);
+	return ret;
+}
diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
new file mode 100644
index 000000000000..99810605c6fa
--- /dev/null
+++ b/arch/loongarch/vdso/Makefile
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: GPL-2.0
+# Objects to go into the VDSO.
+
+# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
+# the inclusion of generic Makefile.
+ARCH_REL_TYPE_ABS := R_LARCH_32|R_LARCH_64|R_LARCH_JUMP_SLOT
+include $(srctree)/lib/vdso/Makefile
+
+obj-vdso-y := elf.o vgettimeofday.o sigreturn.o
+
+# Common compiler flags between ABIs.
+ccflags-vdso := \
+	$(filter -I%,$(KBUILD_CFLAGS)) \
+	$(filter -E%,$(KBUILD_CFLAGS)) \
+	$(filter -march=%,$(KBUILD_CFLAGS)) \
+	$(filter -m%-float,$(KBUILD_CFLAGS)) \
+	-D__VDSO__
+
+ifeq ($(cc-name),clang)
+ccflags-vdso += $(filter --target=%,$(KBUILD_CFLAGS))
+endif
+
+cflags-vdso := $(ccflags-vdso) \
+	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
+	-O2 -g -fno-strict-aliasing -fno-common -fno-builtin -G 0 \
+	-fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING \
+	$(call cc-option, -fno-asynchronous-unwind-tables) \
+	$(call cc-option, -fno-stack-protector)
+aflags-vdso := $(ccflags-vdso) \
+	-D__ASSEMBLY__ -Wa,-gdwarf-2
+
+ifneq ($(c-gettimeofday-y),)
+  CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
+endif
+
+# VDSO linker flags.
+ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
+	$(filter -E%,$(KBUILD_CFLAGS)) -nostdlib -shared \
+	--hash-style=sysv --build-id -T
+
+GCOV_PROFILE := n
+
+#
+# Shared build commands.
+#
+
+quiet_cmd_vdsold_and_vdso_check = LD      $@
+      cmd_vdsold_and_vdso_check = $(cmd_ld); $(cmd_vdso_check)
+
+quiet_cmd_vdsoas_o_S = AS       $@
+      cmd_vdsoas_o_S = $(CC) $(a_flags) -c -o $@ $<
+
+# Strip rule for the raw .so files
+$(obj)/%.so.raw: OBJCOPYFLAGS := -S
+$(obj)/%.so.raw: $(obj)/%.so.dbg.raw FORCE
+	$(call if_changed,objcopy)
+
+hostprogs := genvdso
+
+quiet_cmd_genvdso = GENVDSO $@
+define cmd_genvdso
+	$(foreach file,$(filter %.raw,$^),cp $(file) $(file:%.raw=%) &&) \
+	$(obj)/genvdso $(<:%.raw=%) $(<:%.dbg.raw=%) $@ $(VDSO_NAME)
+endef
+
+#
+# Build native VDSO.
+#
+
+native-abi := $(filter -mabi=%,$(KBUILD_CFLAGS))
+
+targets += $(obj-vdso-y)
+targets += vdso.lds
+targets += vdso.so.dbg.raw vdso.so.raw
+targets += vdso.so.dbg vdso.so
+targets += vdso-image.c
+
+obj-vdso := $(obj-vdso-y:%.o=$(obj)/%.o)
+
+$(obj-vdso): KBUILD_CFLAGS := $(cflags-vdso) $(native-abi)
+$(obj-vdso): KBUILD_AFLAGS := $(aflags-vdso) $(native-abi)
+
+$(obj)/vdso.lds: KBUILD_CPPFLAGS := $(ccflags-vdso) $(native-abi)
+
+$(obj)/vdso.so.dbg.raw: $(obj)/vdso.lds $(obj-vdso) FORCE
+	$(call if_changed,vdsold_and_vdso_check)
+
+$(obj)/vdso-image.c: $(obj)/vdso.so.dbg.raw $(obj)/vdso.so.raw \
+                     $(obj)/genvdso FORCE
+	$(call if_changed,genvdso)
+
+obj-y += vdso-image.o
+
+
+
+# FIXME: Need install rule for debug.
+# Needs to deal with dependency for generation of dbg by cmd_genvdso...
diff --git a/arch/loongarch/vdso/elf.S b/arch/loongarch/vdso/elf.S
new file mode 100644
index 000000000000..a6d50bf863ff
--- /dev/null
+++ b/arch/loongarch/vdso/elf.S
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#include <asm/vdso/vdso.h>
+
+#include <linux/elfnote.h>
+#include <linux/version.h>
+
+ELFNOTE_START(Linux, 0, "a")
+	.long LINUX_VERSION_CODE
+ELFNOTE_END
diff --git a/arch/loongarch/vdso/genvdso.c b/arch/loongarch/vdso/genvdso.c
new file mode 100644
index 000000000000..3a3d5f776a2f
--- /dev/null
+++ b/arch/loongarch/vdso/genvdso.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+/*
+ * This tool is used to generate the real VDSO images from the raw image. It
+ * first patches up the LoongArch ABI flags and GNU attributes sections defined in
+ * elf.S to have the correct name and type. It then generates a C source file
+ * to be compiled into the kernel containing the VDSO image data and a
+ * loongarch_vdso_image struct for it, including symbol offsets extracted from the
+ * image.
+ *
+ * We need to be passed both a stripped and unstripped VDSO image. The stripped
+ * image is compiled into the kernel, but we must also patch up the unstripped
+ * image's ABI flags sections so that it can be installed and used for
+ * debugging.
+ */
+
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+
+#include <byteswap.h>
+#include <elf.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <stdarg.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+/* Define these in case the system elf.h is not new enough to have them. */
+#ifndef EM_LOONGARCH
+#define EM_LOONGARCH 258
+#endif
+
+#ifndef EF_LARCH_ABI_LP32
+#define EF_LARCH_ABI_LP32		0x00000001	/* LP32 ABI.  */
+#endif
+
+#ifndef EF_LARCH_ABI_LPX32
+#define EF_LARCH_ABI_LPX32		0x00000002	/* LPX32 ABI  */
+#endif
+
+#ifndef EF_LARCH_ABI_LP64
+#define EF_LARCH_ABI_LP64		0x00000003	/* LP64 ABI  */
+#endif
+
+enum {
+	ABI_LP32  = (1 << 0),
+	ABI_LPX32 = (1 << 1),
+	ABI_LP64  = (1 << 2),
+
+	ABI_ALL = ABI_LP32 | ABI_LPX32 | ABI_LP64,
+};
+
+/* Symbols the kernel requires offsets for. */
+static struct {
+	const char *name;
+	const char *offset_name;
+	unsigned int abis;
+} vdso_symbols[] = {
+	{ "__vdso_rt_sigreturn", "off_rt_sigreturn", ABI_ALL },
+	{}
+};
+
+static const char *program_name;
+static const char *vdso_name;
+static unsigned char elf_class;
+static unsigned int elf_abi;
+static bool need_swap;
+static FILE *out_file;
+
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+# define HOST_ORDER		ELFDATA2LSB
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+# define HOST_ORDER		ELFDATA2MSB
+#endif
+
+#define BUILD_SWAP(bits)						\
+	static uint##bits##_t swap_uint##bits(uint##bits##_t val)	\
+	{								\
+		return need_swap ? bswap_##bits(val) : val;		\
+	}
+
+BUILD_SWAP(16)
+BUILD_SWAP(32)
+BUILD_SWAP(64)
+
+#define __FUNC(name, bits) name##bits
+#define _FUNC(name, bits) __FUNC(name, bits)
+#define FUNC(name) _FUNC(name, ELF_BITS)
+
+#define __ELF(x, bits) Elf##bits##_##x
+#define _ELF(x, bits) __ELF(x, bits)
+#define ELF(x) _ELF(x, ELF_BITS)
+
+/*
+ * Include genvdso.h twice with ELF_BITS defined differently to get functions
+ * for both ELF32 and ELF64.
+ */
+
+#define ELF_BITS 32
+#include "genvdso.h"
+#undef ELF_BITS
+
+#define ELF_BITS 64
+#include "genvdso.h"
+#undef ELF_BITS
+
+static void *map_vdso(const char *path, size_t *_size)
+{
+	int fd;
+	struct stat stat;
+	void *addr;
+	const Elf32_Ehdr *ehdr;
+
+	fd = open(path, O_RDWR);
+	if (fd < 0) {
+		fprintf(stderr, "%s: Failed to open '%s': %s\n", program_name,
+			path, strerror(errno));
+		return NULL;
+	}
+
+	if (fstat(fd, &stat) != 0) {
+		fprintf(stderr, "%s: Failed to stat '%s': %s\n", program_name,
+			path, strerror(errno));
+		return NULL;
+	}
+
+	addr = mmap(NULL, stat.st_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
+		    0);
+	if (addr == MAP_FAILED) {
+		fprintf(stderr, "%s: Failed to map '%s': %s\n", program_name,
+			path, strerror(errno));
+		return NULL;
+	}
+
+	/* ELF32/64 header formats are the same for the bits we're checking. */
+	ehdr = addr;
+
+	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG) != 0) {
+		fprintf(stderr, "%s: '%s' is not an ELF file\n", program_name,
+			path);
+		return NULL;
+	}
+
+	elf_class = ehdr->e_ident[EI_CLASS];
+	switch (elf_class) {
+	case ELFCLASS32:
+	case ELFCLASS64:
+		break;
+	default:
+		fprintf(stderr, "%s: '%s' has invalid ELF class\n",
+			program_name, path);
+		return NULL;
+	}
+
+	switch (ehdr->e_ident[EI_DATA]) {
+	case ELFDATA2LSB:
+	case ELFDATA2MSB:
+		need_swap = ehdr->e_ident[EI_DATA] != HOST_ORDER;
+		break;
+	default:
+		fprintf(stderr, "%s: '%s' has invalid ELF data order\n",
+			program_name, path);
+		return NULL;
+	}
+
+	if (swap_uint16(ehdr->e_machine) != EM_LOONGARCH) {
+		fprintf(stderr,
+			"%s: '%s' has invalid ELF machine (expected EM_LOONGARCH)\n",
+			program_name, path);
+		return NULL;
+	} else if (swap_uint16(ehdr->e_type) != ET_DYN) {
+		fprintf(stderr,
+			"%s: '%s' has invalid ELF type (expected ET_DYN)\n",
+			program_name, path);
+		return NULL;
+	}
+
+	*_size = stat.st_size;
+	return addr;
+}
+
+static bool patch_vdso(const char *path, void *vdso)
+{
+	if (elf_class == ELFCLASS64)
+		return patch_vdso64(path, vdso);
+	else
+		return patch_vdso32(path, vdso);
+}
+
+static bool get_symbols(const char *path, void *vdso)
+{
+	if (elf_class == ELFCLASS64)
+		return get_symbols64(path, vdso);
+	else
+		return get_symbols32(path, vdso);
+}
+
+int main(int argc, char **argv)
+{
+	const char *dbg_vdso_path, *vdso_path, *out_path;
+	void *dbg_vdso, *vdso;
+	size_t dbg_vdso_size, vdso_size, i;
+
+	program_name = argv[0];
+
+	if (argc < 4 || argc > 5) {
+		fprintf(stderr,
+			"Usage: %s <debug VDSO> <stripped VDSO> <output file> [<name>]\n",
+			program_name);
+		return EXIT_FAILURE;
+	}
+
+	dbg_vdso_path = argv[1];
+	vdso_path = argv[2];
+	out_path = argv[3];
+	vdso_name = (argc > 4) ? argv[4] : "";
+
+	dbg_vdso = map_vdso(dbg_vdso_path, &dbg_vdso_size);
+	if (!dbg_vdso)
+		return EXIT_FAILURE;
+
+	vdso = map_vdso(vdso_path, &vdso_size);
+	if (!vdso)
+		return EXIT_FAILURE;
+
+	/* Patch both the VDSOs' ABI flags sections. */
+	if (!patch_vdso(dbg_vdso_path, dbg_vdso))
+		return EXIT_FAILURE;
+	if (!patch_vdso(vdso_path, vdso))
+		return EXIT_FAILURE;
+
+	if (msync(dbg_vdso, dbg_vdso_size, MS_SYNC) != 0) {
+		fprintf(stderr, "%s: Failed to sync '%s': %s\n", program_name,
+			dbg_vdso_path, strerror(errno));
+		return EXIT_FAILURE;
+	} else if (msync(vdso, vdso_size, MS_SYNC) != 0) {
+		fprintf(stderr, "%s: Failed to sync '%s': %s\n", program_name,
+			vdso_path, strerror(errno));
+		return EXIT_FAILURE;
+	}
+
+	out_file = fopen(out_path, "w");
+	if (!out_file) {
+		fprintf(stderr, "%s: Failed to open '%s': %s\n", program_name,
+			out_path, strerror(errno));
+		return EXIT_FAILURE;
+	}
+
+	fprintf(out_file, "/* Automatically generated - do not edit */\n");
+	fprintf(out_file, "#include <linux/linkage.h>\n");
+	fprintf(out_file, "#include <linux/mm.h>\n");
+	fprintf(out_file, "#include <asm/vdso.h>\n");
+	fprintf(out_file, "static int vdso_mremap(\n");
+	fprintf(out_file, "	const struct vm_special_mapping *sm,\n");
+	fprintf(out_file, "	struct vm_area_struct *new_vma)\n");
+	fprintf(out_file, "{\n");
+	fprintf(out_file, "	unsigned long new_size =\n");
+	fprintf(out_file, "	new_vma->vm_end - new_vma->vm_start;\n");
+	fprintf(out_file, "	if (vdso_image.size != new_size)\n");
+	fprintf(out_file, "		return -EINVAL;\n");
+	fprintf(out_file, "	current->mm->context.vdso =\n");
+	fprintf(out_file, "	(void *)(new_vma->vm_start);\n");
+	fprintf(out_file, "	return 0;\n");
+	fprintf(out_file, "}\n");
+
+	/* Write out the stripped VDSO data. */
+	fprintf(out_file,
+		"static unsigned char vdso_data[PAGE_ALIGN(%zu)] __page_aligned_data = {\n\t",
+		vdso_size);
+	for (i = 0; i < vdso_size; i++) {
+		if (!(i % 10))
+			fprintf(out_file, "\n\t");
+		fprintf(out_file, "0x%02x, ", ((unsigned char *)vdso)[i]);
+	}
+	fprintf(out_file, "\n};\n");
+
+	/* Preallocate a page array. */
+	fprintf(out_file,
+		"static struct page *vdso_pages[PAGE_ALIGN(%zu) / PAGE_SIZE];\n",
+		vdso_size);
+
+	fprintf(out_file, "struct loongarch_vdso_image vdso_image%s%s = {\n",
+		(vdso_name[0]) ? "_" : "", vdso_name);
+	fprintf(out_file, "\t.data = vdso_data,\n");
+	fprintf(out_file, "\t.size = PAGE_ALIGN(%zu),\n", vdso_size);
+	fprintf(out_file, "\t.mapping = {\n");
+	fprintf(out_file, "\t\t.name = \"[vdso]\",\n");
+	fprintf(out_file, "\t\t.pages = vdso_pages,\n");
+	fprintf(out_file, "\t\t.mremap = vdso_mremap,\n");
+	fprintf(out_file, "\t},\n");
+
+	/* Calculate and write symbol offsets to <output file> */
+	if (!get_symbols(dbg_vdso_path, dbg_vdso)) {
+		unlink(out_path);
+		return EXIT_FAILURE;
+	}
+
+	fprintf(out_file, "};\n");
+
+	return EXIT_SUCCESS;
+}
diff --git a/arch/loongarch/vdso/genvdso.h b/arch/loongarch/vdso/genvdso.h
new file mode 100644
index 000000000000..4cc83e996607
--- /dev/null
+++ b/arch/loongarch/vdso/genvdso.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+static inline bool FUNC(patch_vdso)(const char *path, void *vdso)
+{
+	const ELF(Ehdr) *ehdr = vdso;
+	void *shdrs;
+	ELF(Shdr) *shdr;
+	uint16_t sh_count, sh_entsize, i;
+
+	shdrs = vdso + FUNC(swap_uint)(ehdr->e_shoff);
+	sh_count = swap_uint16(ehdr->e_shnum);
+	sh_entsize = swap_uint16(ehdr->e_shentsize);
+
+	shdr = shdrs + (sh_entsize * swap_uint16(ehdr->e_shstrndx));
+
+	for (i = 0; i < sh_count; i++) {
+		shdr = shdrs + (i * sh_entsize);
+
+		/*
+		 * Ensure there are no relocation sections - ld.so does not
+		 * relocate the VDSO so if there are relocations things will
+		 * break.
+		 */
+		switch (swap_uint32(shdr->sh_type)) {
+		case SHT_REL:
+		case SHT_RELA:
+			fprintf(stderr,
+				"%s: '%s' contains relocation sections\n",
+				program_name, path);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static inline bool FUNC(get_symbols)(const char *path, void *vdso)
+{
+	const ELF(Ehdr) *ehdr = vdso;
+	void *shdrs, *symtab;
+	ELF(Shdr) *shdr;
+	const ELF(Sym) *sym;
+	char *strtab, *name;
+	uint16_t sh_count, sh_entsize, st_count, st_entsize, i, j;
+	uint64_t offset;
+	uint32_t flags;
+
+	shdrs = vdso + FUNC(swap_uint)(ehdr->e_shoff);
+	sh_count = swap_uint16(ehdr->e_shnum);
+	sh_entsize = swap_uint16(ehdr->e_shentsize);
+
+	for (i = 0; i < sh_count; i++) {
+		shdr = shdrs + (i * sh_entsize);
+
+		if (swap_uint32(shdr->sh_type) == SHT_SYMTAB)
+			break;
+	}
+
+	if (i == sh_count) {
+		fprintf(stderr, "%s: '%s' has no symbol table\n", program_name,
+			path);
+		return false;
+	}
+
+	/* Get flags */
+	flags = swap_uint32(ehdr->e_flags);
+	switch (flags) {
+	case EF_LARCH_ABI_LP32:
+		elf_abi = ABI_LP32;
+		break;
+	case EF_LARCH_ABI_LPX32:
+		elf_abi = ABI_LPX32;
+		break;
+	case EF_LARCH_ABI_LP64:
+	default:
+		elf_abi = ABI_LP64;
+		break;
+	}
+
+	/* Get symbol table. */
+	symtab = vdso + FUNC(swap_uint)(shdr->sh_offset);
+	st_entsize = FUNC(swap_uint)(shdr->sh_entsize);
+	st_count = FUNC(swap_uint)(shdr->sh_size) / st_entsize;
+
+	/* Get string table. */
+	shdr = shdrs + (swap_uint32(shdr->sh_link) * sh_entsize);
+	strtab = vdso + FUNC(swap_uint)(shdr->sh_offset);
+
+	/* Write offsets for symbols needed by the kernel. */
+	for (i = 0; vdso_symbols[i].name; i++) {
+		if (!(vdso_symbols[i].abis & elf_abi))
+			continue;
+
+		for (j = 0; j < st_count; j++) {
+			sym = symtab + (j * st_entsize);
+			name = strtab + swap_uint32(sym->st_name);
+
+			if (!strcmp(name, vdso_symbols[i].name)) {
+				offset = FUNC(swap_uint)(sym->st_value);
+
+				fprintf(out_file,
+					"\t.%s = 0x%" PRIx64 ",\n",
+					vdso_symbols[i].offset_name, offset);
+				break;
+			}
+		}
+
+		if (j == st_count) {
+			fprintf(stderr,
+				"%s: '%s' is missing required symbol '%s'\n",
+				program_name, path, vdso_symbols[i].name);
+			return false;
+		}
+	}
+
+	return true;
+}
diff --git a/arch/loongarch/vdso/sigreturn.S b/arch/loongarch/vdso/sigreturn.S
new file mode 100644
index 000000000000..38ce55577510
--- /dev/null
+++ b/arch/loongarch/vdso/sigreturn.S
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+#include <asm/vdso/vdso.h>
+
+#include <linux/linkage.h>
+#include <uapi/asm/unistd.h>
+
+#include <asm/regdef.h>
+#include <asm/asm.h>
+
+	.section	.text
+	.cfi_sections	.debug_frame
+
+SYM_FUNC_START(__vdso_rt_sigreturn)
+
+	li.w	a7, __NR_rt_sigreturn
+	syscall	0
+
+SYM_FUNC_END(__vdso_rt_sigreturn)
diff --git a/arch/loongarch/vdso/vdso.lds.S b/arch/loongarch/vdso/vdso.lds.S
new file mode 100644
index 000000000000..57736ff67a4d
--- /dev/null
+++ b/arch/loongarch/vdso/vdso.lds.S
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+
+OUTPUT_FORMAT("elf64-loongarch", "elf64-loongarch", "elf64-loongarch")
+
+OUTPUT_ARCH(loongarch)
+
+SECTIONS
+{
+	PROVIDE(_start = .);
+	. = SIZEOF_HEADERS;
+
+	.hash		: { *(.hash) }			:text
+	.gnu.hash	: { *(.gnu.hash) }
+	.dynsym		: { *(.dynsym) }
+	.dynstr		: { *(.dynstr) }
+	.gnu.version	: { *(.gnu.version) }
+	.gnu.version_d	: { *(.gnu.version_d) }
+	.gnu.version_r	: { *(.gnu.version_r) }
+
+	.note		: { *(.note.*) }		:text :note
+
+	.text		: { *(.text*) }			:text
+	PROVIDE (__etext = .);
+	PROVIDE (_etext = .);
+	PROVIDE (etext = .);
+
+	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text :eh_frame_hdr
+	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
+
+	.dynamic	: { *(.dynamic) }		:text :dynamic
+
+	.rodata		: { *(.rodata*) }		:text
+
+	_end = .;
+	PROVIDE(end = .);
+
+	/DISCARD/	: {
+		*(.gnu.attributes)
+		*(.note.GNU-stack)
+		*(.data .data.* .gnu.linkonce.d.* .sdata*)
+		*(.bss .sbss .dynbss .dynsbss)
+	}
+}
+
+PHDRS
+{
+	text		PT_LOAD		FLAGS(5) FILEHDR PHDRS; /* PF_R|PF_X */
+	dynamic		PT_DYNAMIC	FLAGS(4);		/* PF_R */
+	note		PT_NOTE		FLAGS(4);		/* PF_R */
+	eh_frame_hdr	PT_GNU_EH_FRAME;
+}
+
+VERSION
+{
+	LINUX_2.6 {
+	global:
+		__vdso_clock_gettime;
+		__vdso_gettimeofday;
+	local: *;
+	};
+}
diff --git a/arch/loongarch/vdso/vgettimeofday.c b/arch/loongarch/vdso/vgettimeofday.c
new file mode 100644
index 000000000000..ba5d3cab7a5f
--- /dev/null
+++ b/arch/loongarch/vdso/vgettimeofday.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * LoongArch userspace implementations of gettimeofday() and similar.
+ *
+ * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
+ */
+#include <linux/time.h>
+#include <linux/types.h>
+
+int __vdso_clock_gettime(clockid_t clock,
+			 struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_gettime(clock, ts);
+}
+
+int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
+			struct timezone *tz)
+{
+	return __cvdso_gettimeofday(tv, tz);
+}
+
+int __vdso_clock_getres(clockid_t clock_id,
+			struct __kernel_timespec *res)
+{
+	return __cvdso_clock_getres(clock_id, res);
+}
-- 
2.27.0

