Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA35334AAE
	for <lists+linux-arch@lfdr.de>; Wed, 10 Mar 2021 23:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhCJWBu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Mar 2021 17:01:50 -0500
Received: from mga09.intel.com ([134.134.136.24]:59075 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233770AbhCJWBT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Mar 2021 17:01:19 -0500
IronPort-SDR: BgSGaPQq39zWQIRv9DWCMO7xOmXSJV48ipcMp97HYyHywROuJvVuI5LMDPRI2QYaXrHNfgjZiy
 X2jsMMEKzo0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="188670051"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="188670051"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 14:01:19 -0800
IronPort-SDR: gHFCr952tBYYg2Q1b5fLyqzJpAyuUOOCrtO3SoUjDewS7bADLwQCmOtX5N3fjG/vyzJ8XEvvrF
 urLvdDSqvF4Q==
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="403847661"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 14:01:18 -0800
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v22 24/28] ELF: Introduce arch_setup_elf_property()
Date:   Wed, 10 Mar 2021 14:00:42 -0800
Message-Id: <20210310220046.15866-25-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210310220046.15866-1-yu-cheng.yu@intel.com>
References: <20210310220046.15866-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

An ELF file's .note.gnu.property indicates arch features supported by the
file.  These features are extracted by arch_parse_elf_property() and stored
in 'arch_elf_state'.

Introduce x86 feature definitions and arch_setup_elf_property(), which
enables such features.  The first use-case of this function is Shadow
Stack.

ARM64 is the other arch that has ARCH_USE_GNU_PROPERTY and arch_parse_elf_
property().  Add arch_setup_elf_property() for it.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/elf.h |  5 +++++
 arch/x86/Kconfig             |  2 ++
 arch/x86/include/asm/elf.h   | 13 +++++++++++++
 arch/x86/kernel/process_64.c | 32 ++++++++++++++++++++++++++++++++
 fs/binfmt_elf.c              |  4 ++++
 include/linux/elf.h          |  6 ++++++
 include/uapi/linux/elf.h     |  9 +++++++++
 7 files changed, 71 insertions(+)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 8d1c8dcb87fd..d37bc7915935 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -281,6 +281,11 @@ static inline int arch_parse_elf_property(u32 type, const void *data,
 	return 0;
 }
 
+static inline int arch_setup_elf_property(struct arch_elf_state *arch)
+{
+	return 0;
+}
+
 static inline int arch_elf_pt_proc(void *ehdr, void *phdr,
 				   struct file *f, bool is_interp,
 				   struct arch_elf_state *state)
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 102212025993..2c93178262f5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1955,6 +1955,8 @@ config X86_CET
 	depends on ARCH_HAS_SHADOW_STACK
 	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_MAYBE_MKWRITE
+	select ARCH_USE_GNU_PROPERTY
+	select ARCH_BINFMT_ELF_STATE
 	help
 	  Control-flow protection is a set of hardware features which place
 	  additional restrictions on indirect branches.  These help
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 9224d40cdefe..6a131047be8a 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -390,6 +390,19 @@ extern int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
 
 extern bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs);
 
+#ifdef CONFIG_ARCH_BINFMT_ELF_STATE
+struct arch_elf_state {
+	unsigned int gnu_property;
+};
+
+#define INIT_ARCH_ELF_STATE {	\
+	.gnu_property = 0,	\
+}
+
+#define arch_elf_pt_proc(ehdr, phdr, elf, interp, state) (0)
+#define arch_check_elf(ehdr, interp, interp_ehdr, state) (0)
+#endif
+
 /* Do not change the values. See get_align_mask() */
 enum align_flags {
 	ALIGN_VA_32	= BIT(0),
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index d08307df69ad..cda830b0f7ee 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -835,3 +835,35 @@ unsigned long KSTK_ESP(struct task_struct *task)
 {
 	return task_pt_regs(task)->sp;
 }
+
+#ifdef CONFIG_ARCH_USE_GNU_PROPERTY
+int arch_parse_elf_property(u32 type, const void *data, size_t datasz,
+			    bool compat, struct arch_elf_state *state)
+{
+	if (type != GNU_PROPERTY_X86_FEATURE_1_AND)
+		return 0;
+
+	if (datasz != sizeof(unsigned int))
+		return -ENOEXEC;
+
+	state->gnu_property = *(unsigned int *)data;
+	return 0;
+}
+
+int arch_setup_elf_property(struct arch_elf_state *state)
+{
+	int r = 0;
+
+	if (!IS_ENABLED(CONFIG_X86_CET))
+		return r;
+
+	memset(&current->thread.cet, 0, sizeof(struct cet_status));
+
+	if (static_cpu_has(X86_FEATURE_SHSTK)) {
+		if (state->gnu_property & GNU_PROPERTY_X86_FEATURE_1_SHSTK)
+			r = cet_setup_shstk();
+	}
+
+	return r;
+}
+#endif
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index b12ba98ae9f5..fa665eceba04 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1248,6 +1248,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 	set_binfmt(&elf_format);
 
+	retval = arch_setup_elf_property(&arch_state);
+	if (retval < 0)
+		goto out;
+
 #ifdef ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	retval = ARCH_SETUP_ADDITIONAL_PAGES(bprm, elf_ex, !!interpreter);
 	if (retval < 0)
diff --git a/include/linux/elf.h b/include/linux/elf.h
index c9a46c4e183b..be04d15e937f 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -92,9 +92,15 @@ static inline int arch_parse_elf_property(u32 type, const void *data,
 {
 	return 0;
 }
+
+static inline int arch_setup_elf_property(struct arch_elf_state *arch)
+{
+	return 0;
+}
 #else
 extern int arch_parse_elf_property(u32 type, const void *data, size_t datasz,
 				   bool compat, struct arch_elf_state *arch);
+extern int arch_setup_elf_property(struct arch_elf_state *arch);
 #endif
 
 #ifdef CONFIG_ARCH_HAVE_ELF_PROT
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 30f68b42eeb5..24ba55ba8278 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -455,4 +455,13 @@ typedef struct elf64_note {
 /* Bits for GNU_PROPERTY_AARCH64_FEATURE_1_BTI */
 #define GNU_PROPERTY_AARCH64_FEATURE_1_BTI	(1U << 0)
 
+/* .note.gnu.property types for x86: */
+#define GNU_PROPERTY_X86_FEATURE_1_AND		0xc0000002
+
+/* Bits for GNU_PROPERTY_X86_FEATURE_1_AND */
+#define GNU_PROPERTY_X86_FEATURE_1_IBT		0x00000001
+#define GNU_PROPERTY_X86_FEATURE_1_SHSTK	0x00000002
+#define GNU_PROPERTY_X86_FEATURE_1_VALID (GNU_PROPERTY_X86_FEATURE_1_IBT | \
+					   GNU_PROPERTY_X86_FEATURE_1_SHSTK)
+
 #endif /* _UAPI_LINUX_ELF_H */
-- 
2.21.0

