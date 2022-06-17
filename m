Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEDE54F9B5
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jun 2022 16:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbiFQO5G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jun 2022 10:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiFQO5G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jun 2022 10:57:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE93F1C901
        for <linux-arch@vger.kernel.org>; Fri, 17 Jun 2022 07:57:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C52461778
        for <linux-arch@vger.kernel.org>; Fri, 17 Jun 2022 14:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730BBC3411B;
        Fri, 17 Jun 2022 14:57:01 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Add vDSO syscall __vdso_getcpu()
Date:   Fri, 17 Jun 2022 22:58:28 +0800
Message-Id: <20220617145828.582117-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We test 20 million times of getcpu(), the real syscall version take 25
seconds, while the vsyscall version take only 2.4 seconds.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/vdso.h      |  4 +++
 arch/loongarch/include/asm/vdso/vdso.h | 10 +++++-
 arch/loongarch/kernel/vdso.c           | 23 +++++++++-----
 arch/loongarch/vdso/Makefile           |  3 +-
 arch/loongarch/vdso/vdso.lds.S         |  1 +
 arch/loongarch/vdso/vgetcpu.c          | 43 ++++++++++++++++++++++++++
 6 files changed, 74 insertions(+), 10 deletions(-)
 create mode 100644 arch/loongarch/vdso/vgetcpu.c

diff --git a/arch/loongarch/include/asm/vdso.h b/arch/loongarch/include/asm/vdso.h
index 8f8a0f9a4953..e76d5e37480d 100644
--- a/arch/loongarch/include/asm/vdso.h
+++ b/arch/loongarch/include/asm/vdso.h
@@ -12,6 +12,10 @@
 
 #include <asm/barrier.h>
 
+typedef struct vdso_pcpu_data {
+	u32 node;
+} ____cacheline_aligned_in_smp vdso_pcpu_data;
+
 /*
  * struct loongarch_vdso_info - Details of a VDSO image.
  * @vdso: Pointer to VDSO image (page-aligned).
diff --git a/arch/loongarch/include/asm/vdso/vdso.h b/arch/loongarch/include/asm/vdso/vdso.h
index 5a01643a65b3..94055f7c54b7 100644
--- a/arch/loongarch/include/asm/vdso/vdso.h
+++ b/arch/loongarch/include/asm/vdso/vdso.h
@@ -8,6 +8,13 @@
 
 #include <asm/asm.h>
 #include <asm/page.h>
+#include <asm/vdso.h>
+
+#if PAGE_SIZE < SZ_16K
+#define VDSO_DATA_SIZE SZ_16K
+#else
+#define VDSO_DATA_SIZE PAGE_SIZE
+#endif
 
 static inline unsigned long get_vdso_base(void)
 {
@@ -24,7 +31,8 @@ static inline unsigned long get_vdso_base(void)
 
 static inline const struct vdso_data *get_vdso_data(void)
 {
-	return (const struct vdso_data *)(get_vdso_base() - PAGE_SIZE);
+	return (const struct vdso_data *)(get_vdso_base()
+			- VDSO_DATA_SIZE + SMP_CACHE_BYTES * NR_CPUS);
 }
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index e20c8ca87473..6ce322a1bf8b 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -26,11 +26,15 @@ extern char vdso_start[], vdso_end[];
 
 /* Kernel-provided data used by the VDSO. */
 static union loongarch_vdso_data {
-	u8 page[PAGE_SIZE];
-	struct vdso_data data[CS_BASES];
+	u8 page[VDSO_DATA_SIZE];
+	struct {
+		vdso_pcpu_data pdata[NR_CPUS];
+		struct vdso_data data[CS_BASES];
+	};
 } loongarch_vdso_data __page_aligned_data;
-struct vdso_data *vdso_data = loongarch_vdso_data.data;
+
 static struct page *vdso_pages[] = { NULL };
+struct vdso_data *vdso_data = loongarch_vdso_data.data;
 
 static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
 {
@@ -55,11 +59,14 @@ struct loongarch_vdso_info vdso_info = {
 
 static int __init init_vdso(void)
 {
-	unsigned long i, pfn;
+	unsigned long i, cpu, pfn;
 
 	BUG_ON(!PAGE_ALIGNED(vdso_info.vdso));
 	BUG_ON(!PAGE_ALIGNED(vdso_info.size));
 
+	for_each_possible_cpu(cpu)
+		loongarch_vdso_data.pdata[cpu].node = cpu_to_node(cpu);
+
 	pfn = __phys_to_pfn(__pa_symbol(vdso_info.vdso));
 	for (i = 0; i < vdso_info.size / PAGE_SIZE; i++)
 		vdso_info.code_mapping.pages[i] = pfn_to_page(pfn + i);
@@ -93,9 +100,9 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	/*
 	 * Determine total area size. This includes the VDSO data itself
-	 * and the data page.
+	 * and the data pages.
 	 */
-	vvar_size = PAGE_SIZE;
+	vvar_size = VDSO_DATA_SIZE;
 	size = vvar_size + info->size;
 
 	data_addr = get_unmapped_area(NULL, vdso_base(), size, 0, 0);
@@ -115,8 +122,8 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	/* Map VDSO data page. */
 	ret = remap_pfn_range(vma, data_addr,
-			      virt_to_phys(vdso_data) >> PAGE_SHIFT,
-			      PAGE_SIZE, PAGE_READONLY);
+			      virt_to_phys(&loongarch_vdso_data) >> PAGE_SHIFT,
+			      vvar_size, PAGE_READONLY);
 	if (ret)
 		goto out;
 
diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index 6b6e16732c60..d89e2ac75f7b 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -6,7 +6,7 @@
 ARCH_REL_TYPE_ABS := R_LARCH_32|R_LARCH_64|R_LARCH_MARK_LA|R_LARCH_JUMP_SLOT
 include $(srctree)/lib/vdso/Makefile
 
-obj-vdso-y := elf.o vgettimeofday.o sigreturn.o
+obj-vdso-y := elf.o vgetcpu.o vgettimeofday.o sigreturn.o
 
 # Common compiler flags between ABIs.
 ccflags-vdso := \
@@ -21,6 +21,7 @@ ccflags-vdso += $(filter --target=%,$(KBUILD_CFLAGS))
 endif
 
 cflags-vdso := $(ccflags-vdso) \
+	-isystem $(shell $(CC) -print-file-name=include) \
 	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
 	-O2 -g -fno-strict-aliasing -fno-common -fno-builtin -G0 \
 	-fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING \
diff --git a/arch/loongarch/vdso/vdso.lds.S b/arch/loongarch/vdso/vdso.lds.S
index 955f02de4a2d..56ad855896de 100644
--- a/arch/loongarch/vdso/vdso.lds.S
+++ b/arch/loongarch/vdso/vdso.lds.S
@@ -58,6 +58,7 @@ VERSION
 {
 	LINUX_5.10 {
 	global:
+		__vdso_getcpu;
 		__vdso_clock_getres;
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
diff --git a/arch/loongarch/vdso/vgetcpu.c b/arch/loongarch/vdso/vgetcpu.c
new file mode 100644
index 000000000000..23fe2362f4e0
--- /dev/null
+++ b/arch/loongarch/vdso/vgetcpu.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Fast user context implementation of getcpu()
+ */
+
+#include <asm/vdso.h>
+#include <linux/getcpu.h>
+
+static __always_inline int read_cpu_id(void)
+{
+	int cpu_id;
+
+	__asm__ __volatile__(
+	"	rdtime.d $zero, %0\n"
+	: "=r" (cpu_id)
+	:
+	: "memory");
+
+	return cpu_id;
+}
+
+static __always_inline const vdso_pcpu_data *get_pcpu_data(void)
+{
+	return (vdso_pcpu_data *)(get_vdso_base() - VDSO_DATA_SIZE);
+}
+
+int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *unused)
+{
+	int cpu_id;
+	const vdso_pcpu_data *data;
+
+	cpu_id = read_cpu_id();
+
+	if (cpu)
+		*cpu = cpu_id;
+
+	if (node) {
+		data = get_pcpu_data();
+		*node = data[cpu_id].node;
+	}
+
+	return 0;
+}
-- 
2.27.0

