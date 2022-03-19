Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74364DE8CA
	for <lists+linux-arch@lfdr.de>; Sat, 19 Mar 2022 15:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243307AbiCSOpL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Mar 2022 10:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243333AbiCSOpJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Mar 2022 10:45:09 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1E9197AE9;
        Sat, 19 Mar 2022 07:43:44 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id m22so9668998pja.0;
        Sat, 19 Mar 2022 07:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iv5jGVHSI1jyFY+y8CUCoE/jBfDlSnpvFq90rNj3FJ0=;
        b=nlwryNESOqOMPU4Y4azRrA084H39ltsjNruz69Ox/YX+fmOF1ymXq8QQBz8UvuFTkG
         TnARFzfzMfTpycKRFniptr476BpPYv/MXxh4ExhcmPis2hE9r5lzgpfKC2J3+y3Ll7t6
         FubPSGxCE+IE4PB2yx8ITQi+lMDxjAgDTRS93OHSaiXlOYM+ykWvtaO0fHlYICTDgklV
         yQ4mxvkHZxROVPU06ml1HZGGMOZFgLnD7UYGgi2/Up5V8GImcfSqYiWmolMbszGbcOUG
         JaEsjMYDdPDDKVck9Xp/G+KRDmAwmeR9PPBCOhgkV5Q0xXQTWAukBuQnQQlgKlSjtb85
         jTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=iv5jGVHSI1jyFY+y8CUCoE/jBfDlSnpvFq90rNj3FJ0=;
        b=Cksc/5JUlfZC1peiUvA5ZPa9Ug2agOoyPWlWfY+pvMZ+glWpmTOEW7D4iOxT9lbmaX
         k0AANLssg1V1+IwiqPxRVBtbqpfLnTzRDLk/qyZyWAc9YLYYOW2o4WBqV4Xkq1OB3Kud
         eK+ps+RB10bHLOKSERDaqeq/KhWqwye/R5Y3gAfXPMn6jy/johdjmx9vXAi2jLv8GGu8
         ACSeIybBLcQUIoIrxaFzqlQhBr/yHW+P7EoZwgvJzWi50JeJimbLbs4IjmDmOqwi0wyT
         UAgHfLPE7CaYebNktqaEmpghjd825ULfOAYG+CHzExlW07GWUz1e/nA5ISpP5/rfMfPG
         XlMw==
X-Gm-Message-State: AOAM530GdSn/Ds8SzHBNFwD3SS+0mcY3noiT5KF224bNAkqbvHZ2dhEc
        TmxSe8E3szPbu1fXqKquvNQ=
X-Google-Smtp-Source: ABdhPJza+zDw4E6+g9SwMc1hnYE5oxgbtYQCsv5Afdf30+/I1z7PsHv57ODY0eCORofAFTvvMiDjIw==
X-Received: by 2002:a17:902:ce8a:b0:154:361b:48d1 with SMTP id f10-20020a170902ce8a00b00154361b48d1mr1795273plg.72.1647701023874;
        Sat, 19 Mar 2022 07:43:43 -0700 (PDT)
Received: from localhost.localdomain ([50.7.60.25])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090aa00c00b001bc6f1baaaesm14546829pjp.39.2022.03.19.07.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 07:43:43 -0700 (PDT)
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
Subject: [PATCH V8 19/22] LoongArch: Add VDSO and VSYSCALL support
Date:   Sat, 19 Mar 2022 22:38:14 +0800
Message-Id: <20220319143817.1026708-12-chenhuacai@loongson.cn>
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

This patch adds VDSO and VSYSCALL support (gettimeofday and its friends)
for LoongArch.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Makefile                       |   2 +
 arch/loongarch/include/asm/vdso.h             |  38 +++++
 arch/loongarch/include/asm/vdso/clocksource.h |   8 +
 .../loongarch/include/asm/vdso/gettimeofday.h |  99 +++++++++++++
 arch/loongarch/include/asm/vdso/processor.h   |  14 ++
 arch/loongarch/include/asm/vdso/vdso.h        |  30 ++++
 arch/loongarch/include/asm/vdso/vsyscall.h    |  27 ++++
 arch/loongarch/kernel/vdso.c                  | 138 ++++++++++++++++++
 arch/loongarch/vdso/Makefile                  |  96 ++++++++++++
 arch/loongarch/vdso/elf.S                     |  15 ++
 arch/loongarch/vdso/gen_vdso_offsets.sh       |  13 ++
 arch/loongarch/vdso/sigreturn.S               |  24 +++
 arch/loongarch/vdso/vdso.S                    |  22 +++
 arch/loongarch/vdso/vdso.lds.S                |  72 +++++++++
 arch/loongarch/vdso/vgettimeofday.c           |  25 ++++
 15 files changed, 623 insertions(+)
 create mode 100644 arch/loongarch/include/asm/vdso.h
 create mode 100644 arch/loongarch/include/asm/vdso/clocksource.h
 create mode 100644 arch/loongarch/include/asm/vdso/gettimeofday.h
 create mode 100644 arch/loongarch/include/asm/vdso/processor.h
 create mode 100644 arch/loongarch/include/asm/vdso/vdso.h
 create mode 100644 arch/loongarch/include/asm/vdso/vsyscall.h
 create mode 100644 arch/loongarch/kernel/vdso.c
 create mode 100644 arch/loongarch/vdso/Makefile
 create mode 100644 arch/loongarch/vdso/elf.S
 create mode 100755 arch/loongarch/vdso/gen_vdso_offsets.sh
 create mode 100644 arch/loongarch/vdso/sigreturn.S
 create mode 100644 arch/loongarch/vdso/vdso.S
 create mode 100644 arch/loongarch/vdso/vdso.lds.S
 create mode 100644 arch/loongarch/vdso/vgettimeofday.c

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 404c6ee366eb..93ad21cef166 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -76,9 +76,11 @@ head-y := arch/loongarch/kernel/head.o
 
 libs-y += arch/loongarch/lib/
 
+ifeq ($(KBUILD_EXTMOD),)
 prepare: vdso_prepare
 vdso_prepare: prepare0
 	$(Q)$(MAKE) $(build)=arch/loongarch/vdso include/generated/vdso-offsets.h
+endif
 
 PHONY += vdso_install
 vdso_install:
diff --git a/arch/loongarch/include/asm/vdso.h b/arch/loongarch/include/asm/vdso.h
new file mode 100644
index 000000000000..996bddae12dc
--- /dev/null
+++ b/arch/loongarch/include/asm/vdso.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
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
+ * struct loongarch_vdso_info - Details of a VDSO image.
+ * @vdso: Pointer to VDSO image (page-aligned).
+ * @size: Size of the VDSO image (page-aligned).
+ * @off_rt_sigreturn: Offset of the rt_sigreturn() trampoline.
+ * @code_mapping: Special mapping structure for vdso code.
+ * @code_mapping: Special mapping structure for vdso data.
+ *
+ * This structure contains details of a VDSO image, including the image data
+ * and offsets of certain symbols required by the kernel. It is generated as
+ * part of the VDSO build process, aside from the mapping page array, which is
+ * populated at runtime.
+ */
+struct loongarch_vdso_info {
+	void *vdso;
+	unsigned long size;
+	unsigned long offset_sigreturn;
+	struct vm_special_mapping code_mapping;
+	struct vm_special_mapping data_mapping;
+};
+
+extern struct loongarch_vdso_info vdso_info;
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
index 000000000000..5fc5a746b1c4
--- /dev/null
+++ b/arch/loongarch/include/asm/vdso/gettimeofday.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+#ifndef __ASM_VDSO_GETTIMEOFDAY_H
+#define __ASM_VDSO_GETTIMEOFDAY_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/unistd.h>
+#include <asm/vdso/vdso.h>
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
index 000000000000..ef5770b343a0
--- /dev/null
+++ b/arch/loongarch/include/asm/vdso/processor.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
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
index 000000000000..5a01643a65b3
--- /dev/null
+++ b/arch/loongarch/include/asm/vdso/vdso.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#ifndef __ASSEMBLY__
+
+#include <asm/asm.h>
+#include <asm/page.h>
+
+static inline unsigned long get_vdso_base(void)
+{
+	unsigned long addr;
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
index 000000000000..e20c8ca87473
--- /dev/null
+++ b/arch/loongarch/kernel/vdso.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
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
+#include <asm/page.h>
+#include <asm/vdso.h>
+#include <vdso/helpers.h>
+#include <vdso/vsyscall.h>
+#include <generated/vdso-offsets.h>
+
+extern char vdso_start[], vdso_end[];
+
+/* Kernel-provided data used by the VDSO. */
+static union loongarch_vdso_data {
+	u8 page[PAGE_SIZE];
+	struct vdso_data data[CS_BASES];
+} loongarch_vdso_data __page_aligned_data;
+struct vdso_data *vdso_data = loongarch_vdso_data.data;
+static struct page *vdso_pages[] = { NULL };
+
+static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
+{
+	current->mm->context.vdso = (void *)(new_vma->vm_start);
+
+	return 0;
+}
+
+struct loongarch_vdso_info vdso_info = {
+	.vdso = vdso_start,
+	.size = PAGE_SIZE,
+	.code_mapping = {
+		.name = "[vdso]",
+		.pages = vdso_pages,
+		.mremap = vdso_mremap,
+	},
+	.data_mapping = {
+		.name = "[vvar]",
+	},
+	.offset_sigreturn = vdso_offset_sigreturn,
+};
+
+static int __init init_vdso(void)
+{
+	unsigned long i, pfn;
+
+	BUG_ON(!PAGE_ALIGNED(vdso_info.vdso));
+	BUG_ON(!PAGE_ALIGNED(vdso_info.size));
+
+	pfn = __phys_to_pfn(__pa_symbol(vdso_info.vdso));
+	for (i = 0; i < vdso_info.size / PAGE_SIZE; i++)
+		vdso_info.code_mapping.pages[i] = pfn_to_page(pfn + i);
+
+	return 0;
+}
+subsys_initcall(init_vdso);
+
+static unsigned long vdso_base(void)
+{
+	unsigned long base = STACK_TOP;
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
+	int ret;
+	unsigned long vvar_size, size, data_addr, vdso_addr;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	struct loongarch_vdso_info *info = current->thread.vdso;
+
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+
+	/*
+	 * Determine total area size. This includes the VDSO data itself
+	 * and the data page.
+	 */
+	vvar_size = PAGE_SIZE;
+	size = vvar_size + info->size;
+
+	data_addr = get_unmapped_area(NULL, vdso_base(), size, 0, 0);
+	if (IS_ERR_VALUE(data_addr)) {
+		ret = data_addr;
+		goto out;
+	}
+	vdso_addr = data_addr + PAGE_SIZE;
+
+	vma = _install_special_mapping(mm, data_addr, vvar_size,
+				       VM_READ | VM_MAYREAD,
+				       &info->data_mapping);
+	if (IS_ERR(vma)) {
+		ret = PTR_ERR(vma);
+		goto out;
+	}
+
+	/* Map VDSO data page. */
+	ret = remap_pfn_range(vma, data_addr,
+			      virt_to_phys(vdso_data) >> PAGE_SHIFT,
+			      PAGE_SIZE, PAGE_READONLY);
+	if (ret)
+		goto out;
+
+	/* Map VDSO code page. */
+	vma = _install_special_mapping(mm, vdso_addr, info->size,
+				       VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC,
+				       &info->code_mapping);
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
index 000000000000..6b6e16732c60
--- /dev/null
+++ b/arch/loongarch/vdso/Makefile
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: GPL-2.0
+# Objects to go into the VDSO.
+
+# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
+# the inclusion of generic Makefile.
+ARCH_REL_TYPE_ABS := R_LARCH_32|R_LARCH_64|R_LARCH_MARK_LA|R_LARCH_JUMP_SLOT
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
+	-O2 -g -fno-strict-aliasing -fno-common -fno-builtin -G0 \
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
+# Generate VDSO offsets using helper script
+gen-vdsosym := $(srctree)/$(src)/gen_vdso_offsets.sh
+quiet_cmd_vdsosym = VDSOSYM $@
+      cmd_vdsosym = $(NM) $< | $(gen-vdsosym) | LC_ALL=C sort > $@
+
+include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
+	$(call if_changed,vdsosym)
+
+#
+# Build native VDSO.
+#
+
+native-abi := $(filter -mabi=%,$(KBUILD_CFLAGS))
+
+targets += $(obj-vdso-y)
+targets += vdso.lds vdso.so.dbg vdso.so
+
+obj-vdso := $(obj-vdso-y:%.o=$(obj)/%.o)
+
+$(obj-vdso): KBUILD_CFLAGS := $(cflags-vdso) $(native-abi)
+$(obj-vdso): KBUILD_AFLAGS := $(aflags-vdso) $(native-abi)
+
+$(obj)/vdso.lds: KBUILD_CPPFLAGS := $(ccflags-vdso) $(native-abi)
+
+$(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
+	$(call if_changed,vdsold_and_vdso_check)
+
+$(obj)/vdso.so: OBJCOPYFLAGS := -S
+$(obj)/vdso.so: $(obj)/vdso.so.dbg FORCE
+	$(call if_changed,objcopy)
+
+obj-y += vdso.o
+
+$(obj)/vdso.o : $(obj)/vdso.so
+
+# install commands for the unstripped file
+quiet_cmd_vdso_install = INSTALL $@
+      cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
+
+vdso.so: $(obj)/vdso.so.dbg
+	@mkdir -p $(MODLIB)/vdso
+	$(call cmd,vdso_install)
+
+vdso_install: vdso.so
diff --git a/arch/loongarch/vdso/elf.S b/arch/loongarch/vdso/elf.S
new file mode 100644
index 000000000000..9bb21b9f9583
--- /dev/null
+++ b/arch/loongarch/vdso/elf.S
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
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
diff --git a/arch/loongarch/vdso/gen_vdso_offsets.sh b/arch/loongarch/vdso/gen_vdso_offsets.sh
new file mode 100755
index 000000000000..1bb4e12642ff
--- /dev/null
+++ b/arch/loongarch/vdso/gen_vdso_offsets.sh
@@ -0,0 +1,13 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+#
+# Derived from RISC-V and ARM64:
+# Author: Will Deacon <will.deacon@arm.com>
+#
+# Match symbols in the DSO that look like VDSO_*; produce a header file
+# of constant offsets into the shared object.
+#
+
+LC_ALL=C sed -n -e 's/^00*/0/' -e \
+'s/^\([0-9a-fA-F]*\) . VDSO_\([a-zA-Z0-9_]*\)$/\#define vdso_offset_\2\t0x\1/p'
diff --git a/arch/loongarch/vdso/sigreturn.S b/arch/loongarch/vdso/sigreturn.S
new file mode 100644
index 000000000000..9cb3c58fad03
--- /dev/null
+++ b/arch/loongarch/vdso/sigreturn.S
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ *
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
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
diff --git a/arch/loongarch/vdso/vdso.S b/arch/loongarch/vdso/vdso.S
new file mode 100644
index 000000000000..46789bade6ff
--- /dev/null
+++ b/arch/loongarch/vdso/vdso.S
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ *
+ * Derived from RISC-V:
+ * Copyright (C) 2014 Regents of the University of California
+ */
+
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <asm/page.h>
+
+	__PAGE_ALIGNED_DATA
+
+	.globl vdso_start, vdso_end
+	.balign PAGE_SIZE
+vdso_start:
+	.incbin "arch/loongarch/vdso/vdso.so"
+	.balign PAGE_SIZE
+vdso_end:
+
+	.previous
diff --git a/arch/loongarch/vdso/vdso.lds.S b/arch/loongarch/vdso/vdso.lds.S
new file mode 100644
index 000000000000..955f02de4a2d
--- /dev/null
+++ b/arch/loongarch/vdso/vdso.lds.S
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
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
+	LINUX_5.10 {
+	global:
+		__vdso_clock_getres;
+		__vdso_clock_gettime;
+		__vdso_gettimeofday;
+		__vdso_rt_sigreturn;
+	local: *;
+	};
+}
+
+/*
+ * Make the sigreturn code visible to the kernel.
+ */
+VDSO_sigreturn		= __vdso_rt_sigreturn;
diff --git a/arch/loongarch/vdso/vgettimeofday.c b/arch/loongarch/vdso/vgettimeofday.c
new file mode 100644
index 000000000000..b1f4548dae92
--- /dev/null
+++ b/arch/loongarch/vdso/vgettimeofday.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * LoongArch userspace implementations of gettimeofday() and similar.
+ *
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
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

