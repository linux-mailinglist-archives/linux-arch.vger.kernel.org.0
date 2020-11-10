Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345642ADBB1
	for <lists+linux-arch@lfdr.de>; Tue, 10 Nov 2020 17:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbgKJQXA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Nov 2020 11:23:00 -0500
Received: from mga05.intel.com ([192.55.52.43]:28141 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730833AbgKJQW5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Nov 2020 11:22:57 -0500
IronPort-SDR: M3yiDuY/gpVWkZqeVkHsJS65M+OtzOyEczpO8qtAuotfyANrRphE3gJLXTe3MUeYPFRyOlqvv/
 PVmjPksBavyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="254713397"
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="254713397"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 08:22:55 -0800
IronPort-SDR: RO1Tkj4Pv4RRSxTqHagL3KexBLy7/1p2b1BpS9iaAunkmPTqVduTP50mpaLy+paUAM4N/vHHPN
 jBHknhTY8mBQ==
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="365572931"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 08:22:55 -0800
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
        Pengfei Xu <pengfei.xu@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v15 23/26] ELF: Introduce arch_setup_elf_property()
Date:   Tue, 10 Nov 2020 08:22:08 -0800
Message-Id: <20201110162211.9207-24-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201110162211.9207-1-yu-cheng.yu@intel.com>
References: <20201110162211.9207-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

An ELF file's .note.gnu.property indicates arch features supported by the
file.  These features are extracted by arch_parse_elf_property() and stored
in 'arch_elf_state'.  Introduce arch_setup_elf_property() for enabling such
features.  The first use-case of this function is shadow stack.

ARM64 is the other arch that has ARCH_USER_GNU_PROPERTY and arch_parse_elf_
property().  Add arch_setup_elf_property() for it.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
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
 6 files changed, 62 insertions(+)

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
index 960993862b96..18fd8cb549ad 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1953,6 +1953,8 @@ config X86_SHADOW_STACK_USER
 	select X86_CET
 	select ARCH_MAYBE_MKWRITE
 	select ARCH_HAS_SHADOW_STACK
+	select ARCH_USE_GNU_PROPERTY
+	select ARCH_BINFMT_ELF_STATE
 	help
 	  Shadow Stacks provides protection against program stack
 	  corruption.  It's a hardware feature.  This only matters
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index b9a5d488f1a5..0e1be2a13359 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -385,6 +385,19 @@ extern int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
 					      int uses_interp);
 #define compat_arch_setup_additional_pages compat_arch_setup_additional_pages
 
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
index df342bedea88..7c4687a0f001 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -837,3 +837,35 @@ unsigned long KSTK_ESP(struct task_struct *task)
 {
 	return task_pt_regs(task)->sp;
 }
+
+#ifdef CONFIG_ARCH_USE_GNU_PROPERTY
+int arch_parse_elf_property(u32 type, const void *data, size_t datasz,
+			     bool compat, struct arch_elf_state *state)
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
index fa50e8936f5f..1ae32cc0f61b 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1245,6 +1245,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 	set_binfmt(&elf_format);
 
+	retval = arch_setup_elf_property(&arch_state);
+	if (retval < 0)
+		goto out;
+
 #ifdef ARCH_HAS_SETUP_ADDITIONAL_PAGES
 	retval = arch_setup_additional_pages(bprm, !!interpreter);
 	if (retval < 0)
diff --git a/include/linux/elf.h b/include/linux/elf.h
index 5d5b0321da0b..4827695ca415 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -82,9 +82,15 @@ static inline int arch_parse_elf_property(u32 type, const void *data,
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
-- 
2.21.0

