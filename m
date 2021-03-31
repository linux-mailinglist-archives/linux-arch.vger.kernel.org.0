Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2142350509
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 18:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbhCaQtE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 12:49:04 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:30362 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234319AbhCaQss (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Mar 2021 12:48:48 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F9XML0dYWz9txhj;
        Wed, 31 Mar 2021 18:48:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id TTBTIRemNYKk; Wed, 31 Mar 2021 18:48:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F9XMK6lHHz9txhd;
        Wed, 31 Mar 2021 18:48:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 275298B828;
        Wed, 31 Mar 2021 18:48:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id T_myeNdn2HI3; Wed, 31 Mar 2021 18:48:47 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CEA068B80D;
        Wed, 31 Mar 2021 18:48:46 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id AEB1E67641; Wed, 31 Mar 2021 16:48:46 +0000 (UTC)
Message-Id: <f401eb1ebc0bfc4d8f0e10dc8e525fd409eb68e2.1617209142.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1617209141.git.christophe.leroy@csgroup.eu>
References: <cover.1617209141.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH RESEND v1 3/4] powerpc/vdso: Separate vvar vma from vdso
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dima@arista.com, avagin@gmail.com, arnd@arndb.de,
        tglx@linutronix.de, vincenzo.frascino@arm.com, luto@kernel.org,
        linux-arch@vger.kernel.org
Date:   Wed, 31 Mar 2021 16:48:46 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Dmitry Safonov <dima@arista.com>

Since commit 511157ab641e ("powerpc/vdso: Move vdso datapage up front")
VVAR page is in front of the VDSO area. In result it breaks CRIU
(Checkpoint Restore In Userspace) [1], where CRIU expects that "[vdso]"
from /proc/../maps points at ELF/vdso image, rather than at VVAR data page.
Laurent made a patch to keep CRIU working (by reading aux vector).
But I think it still makes sence to separate two mappings into different
VMAs. It will also make ppc64 less "special" for userspace and as
a side-bonus will make VVAR page un-writable by debugger (which previously
would COW page and can be unexpected).

I opportunistically Cc stable on it: I understand that usually such
stuff isn't a stable material, but that will allow us in CRIU have
one workaround less that is needed just for one release (v5.11) on
one platform (ppc64), which we otherwise have to maintain.
I wouldn't go as far as to say that the commit 511157ab641e is ABI
regression as no other userspace got broken, but I'd really appreciate
if it gets backported to v5.11 after v5.12 is released, so as not
to complicate already non-simple CRIU-vdso code. Thanks!

Cc: Andrei Vagin <avagin@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Laurent Dufour <ldufour@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: stable@vger.kernel.org # v5.11
[1]: https://github.com/checkpoint-restore/criu/issues/1417
Signed-off-by: Dmitry Safonov <dima@arista.com>
Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/mmu_context.h |  2 +-
 arch/powerpc/kernel/vdso.c             | 54 +++++++++++++++++++-------
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 652ce85f9410..4bc45d3ed8b0 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -263,7 +263,7 @@ extern void arch_exit_mmap(struct mm_struct *mm);
 static inline void arch_unmap(struct mm_struct *mm,
 			      unsigned long start, unsigned long end)
 {
-	unsigned long vdso_base = (unsigned long)mm->context.vdso - PAGE_SIZE;
+	unsigned long vdso_base = (unsigned long)mm->context.vdso;
 
 	if (start <= vdso_base && vdso_base < end)
 		mm->context.vdso = NULL;
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index e839a906fdf2..b14907209822 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -55,10 +55,10 @@ static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_area_struc
 {
 	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
 
-	if (new_size != text_size + PAGE_SIZE)
+	if (new_size != text_size)
 		return -EINVAL;
 
-	current->mm->context.vdso = (void __user *)new_vma->vm_start + PAGE_SIZE;
+	current->mm->context.vdso = (void __user *)new_vma->vm_start;
 
 	return 0;
 }
@@ -73,6 +73,10 @@ static int vdso64_mremap(const struct vm_special_mapping *sm, struct vm_area_str
 	return vdso_mremap(sm, new_vma, &vdso64_end - &vdso64_start);
 }
 
+static struct vm_special_mapping vvar_spec __ro_after_init = {
+	.name = "[vvar]",
+};
+
 static struct vm_special_mapping vdso32_spec __ro_after_init = {
 	.name = "[vdso]",
 	.mremap = vdso32_mremap,
@@ -89,11 +93,11 @@ static struct vm_special_mapping vdso64_spec __ro_after_init = {
  */
 static int __arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
-	struct mm_struct *mm = current->mm;
+	unsigned long vdso_size, vdso_base, mappings_size;
 	struct vm_special_mapping *vdso_spec;
+	unsigned long vvar_size = PAGE_SIZE;
+	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	unsigned long vdso_size;
-	unsigned long vdso_base;
 
 	if (is_32bit_task()) {
 		vdso_spec = &vdso32_spec;
@@ -110,8 +114,8 @@ static int __arch_setup_additional_pages(struct linux_binprm *bprm, int uses_int
 		vdso_base = 0;
 	}
 
-	/* Add a page to the vdso size for the data page */
-	vdso_size += PAGE_SIZE;
+	mappings_size = vdso_size + vvar_size;
+	mappings_size += (VDSO_ALIGNMENT - 1) & PAGE_MASK;
 
 	/*
 	 * pick a base address for the vDSO in process space. We try to put it
@@ -119,9 +123,7 @@ static int __arch_setup_additional_pages(struct linux_binprm *bprm, int uses_int
 	 * and end up putting it elsewhere.
 	 * Add enough to the size so that the result can be aligned.
 	 */
-	vdso_base = get_unmapped_area(NULL, vdso_base,
-				      vdso_size + ((VDSO_ALIGNMENT - 1) & PAGE_MASK),
-				      0, 0);
+	vdso_base = get_unmapped_area(NULL, vdso_base, mappings_size, 0, 0);
 	if (IS_ERR_VALUE(vdso_base))
 		return vdso_base;
 
@@ -133,7 +135,13 @@ static int __arch_setup_additional_pages(struct linux_binprm *bprm, int uses_int
 	 * install_special_mapping or the perf counter mmap tracking code
 	 * will fail to recognise it as a vDSO.
 	 */
-	mm->context.vdso = (void __user *)vdso_base + PAGE_SIZE;
+	mm->context.vdso = (void __user *)vdso_base + vvar_size;
+
+	vma = _install_special_mapping(mm, vdso_base, vvar_size,
+				       VM_READ | VM_MAYREAD | VM_IO |
+				       VM_DONTDUMP | VM_PFNMAP, &vvar_spec);
+	if (IS_ERR(vma))
+		return PTR_ERR(vma);
 
 	/*
 	 * our vma flags don't have VM_WRITE so by default, the process isn't
@@ -145,9 +153,12 @@ static int __arch_setup_additional_pages(struct linux_binprm *bprm, int uses_int
 	 * It's fine to use that for setting breakpoints in the vDSO code
 	 * pages though.
 	 */
-	vma = _install_special_mapping(mm, vdso_base, vdso_size,
+	vma = _install_special_mapping(mm, vdso_base + vvar_size, vdso_size,
 				       VM_READ | VM_EXEC | VM_MAYREAD |
 				       VM_MAYWRITE | VM_MAYEXEC, vdso_spec);
+	if (IS_ERR(vma))
+		do_munmap(mm, vdso_base, vvar_size, NULL);
+
 	return PTR_ERR_OR_ZERO(vma);
 }
 
@@ -249,11 +260,22 @@ static struct page ** __init vdso_setup_pages(void *start, void *end)
 	if (!pagelist)
 		panic("%s: Cannot allocate page list for VDSO", __func__);
 
-	pagelist[0] = virt_to_page(vdso_data);
-
 	for (i = 0; i < pages; i++)
-		pagelist[i + 1] = virt_to_page(start + i * PAGE_SIZE);
+		pagelist[i] = virt_to_page(start + i * PAGE_SIZE);
+
+	return pagelist;
+}
+
+static struct page ** __init vvar_setup_pages(void)
+{
+	struct page **pagelist;
 
+	/* .pages is NULL-terminated */
+	pagelist = kcalloc(2, sizeof(struct page *), GFP_KERNEL);
+	if (!pagelist)
+		panic("%s: Cannot allocate page list for VVAR", __func__);
+
+	pagelist[0] = virt_to_page(vdso_data);
 	return pagelist;
 }
 
@@ -295,6 +317,8 @@ static int __init vdso_init(void)
 	if (IS_ENABLED(CONFIG_PPC64))
 		vdso64_spec.pages = vdso_setup_pages(&vdso64_start, &vdso64_end);
 
+	vvar_spec.pages = vvar_setup_pages();
+
 	smp_wmb();
 
 	return 0;
-- 
2.25.0

