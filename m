Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC3C4A2F26
	for <lists+linux-arch@lfdr.de>; Sat, 29 Jan 2022 13:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345593AbiA2MU3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Jan 2022 07:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347579AbiA2MTq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Jan 2022 07:19:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B364FC061756;
        Sat, 29 Jan 2022 04:19:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5134CB827B2;
        Sat, 29 Jan 2022 12:19:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5294AC340F3;
        Sat, 29 Jan 2022 12:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643458750;
        bh=eDtFnYtl1P+8gGdjDyWJtW5RKhu6KT9cerp6/kSgWiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=snsNEVBy/qtMGNes3m3UXdVsYW0dkS4jpSI+ak+hcqMBJ/F7gUKP+TBsjZuvke9ZB
         wtwaRdz+zdaUW4zZb/Qq6tLtUw3Lynin1JDf4KpaBBOHhiquyjwlPtmLVQuON2068e
         EcCTeAMJ9jeY7iiPVoZvOh9GFc0N4YNpz41ezhlmQ32ATtr53KClUBGmqldFzI2mM/
         K04FTt14wRgoHIaTiSskI2xtAdvcAh07HvE2Wq99QMSgOcJMKByVpxpgNhNfu9lian
         F3fS5755QXLw9kZtYW/vqP+YhkOgSANaPl7YAOUNkdqjhCNECAoqEQRTM4HcFDE0Ut
         WUabzie6AYjlQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup@brainfault.org, gregkh@linuxfoundation.org,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, hch@lst.de, hch@infradead.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V4 13/17] riscv: compat: vdso: Add setup additional pages implementation
Date:   Sat, 29 Jan 2022 20:17:24 +0800
Message-Id: <20220129121728.1079364-14-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220129121728.1079364-1-guoren@kernel.org>
References: <20220129121728.1079364-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Reconstruct __setup_additional_pages() by appending vdso info
pointer argument to meet compat_vdso_info requirement. And change
vm_special_mapping *dm, *cm initialization into static.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/include/asm/elf.h |   5 ++
 arch/riscv/include/asm/mmu.h |   1 +
 arch/riscv/kernel/vdso.c     | 104 +++++++++++++++++++++++++----------
 3 files changed, 81 insertions(+), 29 deletions(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index c1fc31629d40..6f374e6bc786 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -135,5 +135,10 @@ do {    if ((ex).e_ident[EI_CLASS] == ELFCLASS32)		\
 typedef compat_ulong_t			compat_elf_greg_t;
 typedef compat_elf_greg_t		compat_elf_gregset_t[ELF_NGREG];
 
+extern int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
+					      int uses_interp);
+#define compat_arch_setup_additional_pages \
+				compat_arch_setup_additional_pages
+
 #endif /* CONFIG_COMPAT */
 #endif /* _ASM_RISCV_ELF_H */
diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index 0099dc116168..cedcf8ea3c76 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -16,6 +16,7 @@ typedef struct {
 	atomic_long_t id;
 #endif
 	void *vdso;
+	void *vdso_info;
 #ifdef CONFIG_SMP
 	/* A local icache flush is needed before user execution can resume. */
 	cpumask_t icache_stale_mask;
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index a9436a65161a..deca69524799 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -23,6 +23,9 @@ struct vdso_data {
 #endif
 
 extern char vdso_start[], vdso_end[];
+#ifdef CONFIG_COMPAT
+extern char compat_vdso_start[], compat_vdso_end[];
+#endif
 
 enum vvar_pages {
 	VVAR_DATA_PAGE_OFFSET,
@@ -30,6 +33,11 @@ enum vvar_pages {
 	VVAR_NR_PAGES,
 };
 
+enum rv_vdso_map {
+	RV_VDSO_MAP_VVAR,
+	RV_VDSO_MAP_VDSO,
+};
+
 #define VVAR_SIZE  (VVAR_NR_PAGES << PAGE_SHIFT)
 
 /*
@@ -52,12 +60,6 @@ struct __vdso_info {
 	struct vm_special_mapping *cm;
 };
 
-static struct __vdso_info vdso_info __ro_after_init = {
-	.name = "vdso",
-	.vdso_code_start = vdso_start,
-	.vdso_code_end = vdso_end,
-};
-
 static int vdso_mremap(const struct vm_special_mapping *sm,
 		       struct vm_area_struct *new_vma)
 {
@@ -66,35 +68,35 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 	return 0;
 }
 
-static int __init __vdso_init(void)
+static int __init __vdso_init(struct __vdso_info *vdso_info)
 {
 	unsigned int i;
 	struct page **vdso_pagelist;
 	unsigned long pfn;
 
-	if (memcmp(vdso_info.vdso_code_start, "\177ELF", 4)) {
+	if (memcmp(vdso_info->vdso_code_start, "\177ELF", 4)) {
 		pr_err("vDSO is not a valid ELF object!\n");
 		return -EINVAL;
 	}
 
-	vdso_info.vdso_pages = (
-		vdso_info.vdso_code_end -
-		vdso_info.vdso_code_start) >>
+	vdso_info->vdso_pages = (
+		vdso_info->vdso_code_end -
+		vdso_info->vdso_code_start) >>
 		PAGE_SHIFT;
 
-	vdso_pagelist = kcalloc(vdso_info.vdso_pages,
+	vdso_pagelist = kcalloc(vdso_info->vdso_pages,
 				sizeof(struct page *),
 				GFP_KERNEL);
 	if (vdso_pagelist == NULL)
 		return -ENOMEM;
 
 	/* Grab the vDSO code pages. */
-	pfn = sym_to_pfn(vdso_info.vdso_code_start);
+	pfn = sym_to_pfn(vdso_info->vdso_code_start);
 
-	for (i = 0; i < vdso_info.vdso_pages; i++)
+	for (i = 0; i < vdso_info->vdso_pages; i++)
 		vdso_pagelist[i] = pfn_to_page(pfn + i);
 
-	vdso_info.cm->pages = vdso_pagelist;
+	vdso_info->cm->pages = vdso_pagelist;
 
 	return 0;
 }
@@ -116,13 +118,14 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 {
 	struct mm_struct *mm = task->mm;
 	struct vm_area_struct *vma;
+	struct __vdso_info *vdso_info = mm->context.vdso_info;
 
 	mmap_read_lock(mm);
 
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		unsigned long size = vma->vm_end - vma->vm_start;
 
-		if (vma_is_special_mapping(vma, vdso_info.dm))
+		if (vma_is_special_mapping(vma, vdso_info->dm))
 			zap_page_range(vma, vma->vm_start, size);
 	}
 
@@ -187,11 +190,6 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 	return vmf_insert_pfn(vma, vmf->address, pfn);
 }
 
-enum rv_vdso_map {
-	RV_VDSO_MAP_VVAR,
-	RV_VDSO_MAP_VDSO,
-};
-
 static struct vm_special_mapping rv_vdso_maps[] __ro_after_init = {
 	[RV_VDSO_MAP_VVAR] = {
 		.name   = "[vvar]",
@@ -203,25 +201,53 @@ static struct vm_special_mapping rv_vdso_maps[] __ro_after_init = {
 	},
 };
 
+static struct __vdso_info vdso_info __ro_after_init = {
+	.name = "vdso",
+	.vdso_code_start = vdso_start,
+	.vdso_code_end = vdso_end,
+	.dm = &rv_vdso_maps[RV_VDSO_MAP_VVAR],
+	.cm = &rv_vdso_maps[RV_VDSO_MAP_VDSO],
+};
+
+#ifdef CONFIG_COMPAT
+static struct __vdso_info compat_vdso_info __ro_after_init = {
+	.name = "compat_vdso",
+	.vdso_code_start = compat_vdso_start,
+	.vdso_code_end = compat_vdso_end,
+	.dm = &rv_vdso_maps[RV_VDSO_MAP_VVAR],
+	.cm = &rv_vdso_maps[RV_VDSO_MAP_VDSO],
+};
+#endif
+
 static int __init vdso_init(void)
 {
-	vdso_info.dm = &rv_vdso_maps[RV_VDSO_MAP_VVAR];
-	vdso_info.cm = &rv_vdso_maps[RV_VDSO_MAP_VDSO];
+	int ret;
+
+	ret = __vdso_init(&vdso_info);
+	if (ret)
+		goto out;
 
-	return __vdso_init();
+#ifdef CONFIG_COMPAT
+	ret = __vdso_init(&compat_vdso_info);
+	if (ret)
+		goto out;
+#endif
+out:
+	return ret;
 }
 arch_initcall(vdso_init);
 
 static int __setup_additional_pages(struct mm_struct *mm,
 				    struct linux_binprm *bprm,
-				    int uses_interp)
+				    int uses_interp,
+				    struct __vdso_info *vdso_info)
 {
 	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
 	void *ret;
 
 	BUILD_BUG_ON(VVAR_NR_PAGES != __VVAR_PAGES);
 
-	vdso_text_len = vdso_info.vdso_pages << PAGE_SHIFT;
+	vdso_text_len = vdso_info->vdso_pages << PAGE_SHIFT;
 	/* Be sure to map the data page */
 	vdso_mapping_len = vdso_text_len + VVAR_SIZE;
 
@@ -232,16 +258,18 @@ static int __setup_additional_pages(struct mm_struct *mm,
 	}
 
 	ret = _install_special_mapping(mm, vdso_base, VVAR_SIZE,
-		(VM_READ | VM_MAYREAD | VM_PFNMAP), vdso_info.dm);
+		(VM_READ | VM_MAYREAD | VM_PFNMAP), vdso_info->dm);
 	if (IS_ERR(ret))
 		goto up_fail;
 
 	vdso_base += VVAR_SIZE;
 	mm->context.vdso = (void *)vdso_base;
+	mm->context.vdso_info = (void *)vdso_info;
+
 	ret =
 	   _install_special_mapping(mm, vdso_base, vdso_text_len,
 		(VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC),
-		vdso_info.cm);
+		vdso_info->cm);
 
 	if (IS_ERR(ret))
 		goto up_fail;
@@ -253,6 +281,24 @@ static int __setup_additional_pages(struct mm_struct *mm,
 	return PTR_ERR(ret);
 }
 
+#ifdef CONFIG_COMPAT
+int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
+				       int uses_interp)
+{
+	struct mm_struct *mm = current->mm;
+	int ret;
+
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+
+	ret = __setup_additional_pages(mm, bprm, uses_interp,
+							&compat_vdso_info);
+	mmap_write_unlock(mm);
+
+	return ret;
+}
+#endif
+
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mm_struct *mm = current->mm;
@@ -261,7 +307,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
-	ret = __setup_additional_pages(mm, bprm, uses_interp);
+	ret = __setup_additional_pages(mm, bprm, uses_interp, &vdso_info);
 	mmap_write_unlock(mm);
 
 	return ret;
-- 
2.25.1

