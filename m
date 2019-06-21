Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C21844E506
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2019 11:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfFUJxn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jun 2019 05:53:43 -0400
Received: from foss.arm.com ([217.140.110.172]:55508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726972AbfFUJxl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Jun 2019 05:53:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF10414FF;
        Fri, 21 Jun 2019 02:53:40 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25B8B3F246;
        Fri, 21 Jun 2019 02:53:38 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v7 12/25] arm64: compat: vDSO setup for compat layer
Date:   Fri, 21 Jun 2019 10:52:39 +0100
Message-Id: <20190621095252.32307-13-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190621095252.32307-1-vincenzo.frascino@arm.com>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

If CONFIG_GENERIC_COMPAT_VDSO is enabled, compat vDSO are installed in a
compat (32 bit) process instead of sigpage.

Add the necessary code to setup the vDSO required pages.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Tested-by: Shijith Thotton <sthotton@marvell.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/kernel/vdso.c | 90 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index aa1fb25a9fe4..ad3a81b2c7ce 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -40,12 +40,22 @@
 #include <asm/vdso.h>
 
 extern char vdso_start[], vdso_end[];
+#ifdef CONFIG_COMPAT_VDSO
+extern char vdso32_start[], vdso32_end[];
+#endif /* CONFIG_COMPAT_VDSO */
 
 /* vdso_lookup arch_index */
 enum arch_vdso_type {
 	ARM64_VDSO = 0,
+#ifdef CONFIG_COMPAT_VDSO
+	ARM64_VDSO32 = 1,
+#endif /* CONFIG_COMPAT_VDSO */
 };
+#ifdef CONFIG_COMPAT_VDSO
+#define VDSO_TYPES		(ARM64_VDSO32 + 1)
+#else
 #define VDSO_TYPES		(ARM64_VDSO + 1)
+#endif /* CONFIG_COMPAT_VDSO */
 
 struct __vdso_abi {
 	const char *name;
@@ -64,6 +74,13 @@ static struct __vdso_abi vdso_lookup[VDSO_TYPES] __ro_after_init = {
 		.vdso_code_start = vdso_start,
 		.vdso_code_end = vdso_end,
 	},
+#ifdef CONFIG_COMPAT_VDSO
+	{
+		.name = "vdso32",
+		.vdso_code_start = vdso32_start,
+		.vdso_code_end = vdso32_end,
+	},
+#endif /* CONFIG_COMPAT_VDSO */
 };
 
 /*
@@ -174,24 +191,52 @@ static int __setup_additional_pages(enum arch_vdso_type arch_index,
 /*
  * Create and map the vectors page for AArch32 tasks.
  */
+#ifdef CONFIG_COMPAT_VDSO
+static int aarch32_vdso_mremap(const struct vm_special_mapping *sm,
+		struct vm_area_struct *new_vma)
+{
+	return __vdso_remap(ARM64_VDSO32, sm, new_vma);
+}
+#endif /* CONFIG_COMPAT_VDSO */
+
 /*
  * aarch32_vdso_pages:
  * 0 - kuser helpers
  * 1 - sigreturn code
+ * or (CONFIG_COMPAT_VDSO):
+ * 0 - kuser helpers
+ * 1 - vdso data
+ * 2 - vdso code
  */
 #define C_VECTORS	0
+#ifdef CONFIG_COMPAT_VDSO
+#define C_VVAR		1
+#define C_VDSO		2
+#define C_PAGES		(C_VDSO + 1)
+#else
 #define C_SIGPAGE	1
 #define C_PAGES		(C_SIGPAGE + 1)
+#endif /* CONFIG_COMPAT_VDSO */
 static struct page *aarch32_vdso_pages[C_PAGES] __ro_after_init;
-static const struct vm_special_mapping aarch32_vdso_spec[C_PAGES] = {
+static struct vm_special_mapping aarch32_vdso_spec[C_PAGES] = {
 	{
 		.name	= "[vectors]", /* ABI */
 		.pages	= &aarch32_vdso_pages[C_VECTORS],
 	},
+#ifdef CONFIG_COMPAT_VDSO
+	{
+		.name = "[vvar]",
+	},
+	{
+		.name = "[vdso]",
+		.mremap = aarch32_vdso_mremap,
+	},
+#else
 	{
 		.name	= "[sigpage]", /* ABI */
 		.pages	= &aarch32_vdso_pages[C_SIGPAGE],
 	},
+#endif /* CONFIG_COMPAT_VDSO */
 };
 
 static int aarch32_alloc_kuser_vdso_page(void)
@@ -214,7 +259,33 @@ static int aarch32_alloc_kuser_vdso_page(void)
 	return 0;
 }
 
-static int __init aarch32_alloc_vdso_pages(void)
+#ifdef CONFIG_COMPAT_VDSO
+static int __aarch32_alloc_vdso_pages(void)
+{
+	int ret;
+
+	vdso_lookup[ARM64_VDSO32].dm = &aarch32_vdso_spec[C_VVAR];
+	vdso_lookup[ARM64_VDSO32].cm = &aarch32_vdso_spec[C_VDSO];
+
+	ret = __vdso_init(ARM64_VDSO32);
+	if (ret)
+		return ret;
+
+	ret = aarch32_alloc_kuser_vdso_page();
+	if (ret) {
+		unsigned long c_vvar =
+			(unsigned long)page_to_virt(aarch32_vdso_pages[C_VVAR]);
+		unsigned long c_vdso =
+			(unsigned long)page_to_virt(aarch32_vdso_pages[C_VDSO]);
+
+		free_page(c_vvar);
+		free_page(c_vdso);
+	}
+
+	return ret;
+}
+#else
+static int __aarch32_alloc_vdso_pages(void)
 {
 	extern char __aarch32_sigret_code_start[], __aarch32_sigret_code_end[];
 	int sigret_sz = __aarch32_sigret_code_end - __aarch32_sigret_code_start;
@@ -235,6 +306,12 @@ static int __init aarch32_alloc_vdso_pages(void)
 
 	return ret;
 }
+#endif /* CONFIG_COMPAT_VDSO */
+
+static int __init aarch32_alloc_vdso_pages(void)
+{
+	return __aarch32_alloc_vdso_pages();
+}
 arch_initcall(aarch32_alloc_vdso_pages);
 
 static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
@@ -256,6 +333,7 @@ static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 	return PTR_ERR_OR_ZERO(ret);
 }
 
+#ifndef CONFIG_COMPAT_VDSO
 static int aarch32_sigreturn_setup(struct mm_struct *mm)
 {
 	unsigned long addr;
@@ -283,6 +361,7 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
 out:
 	return PTR_ERR_OR_ZERO(ret);
 }
+#endif /* !CONFIG_COMPAT_VDSO */
 
 int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
@@ -296,7 +375,14 @@ int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	if (ret)
 		goto out;
 
+#ifdef CONFIG_COMPAT_VDSO
+	ret = __setup_additional_pages(ARM64_VDSO32,
+				       mm,
+				       bprm,
+				       uses_interp);
+#else
 	ret = aarch32_sigreturn_setup(mm);
+#endif /* CONFIG_COMPAT_VDSO */
 
 out:
 	up_write(&mm->mmap_sem);
-- 
2.21.0

