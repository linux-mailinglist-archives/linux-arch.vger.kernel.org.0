Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EA3250D16
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 02:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgHYAaD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 20:30:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:12299 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728376AbgHYA35 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 20:29:57 -0400
IronPort-SDR: wSyQFvxW6aOYXy81X67MBlU4iqFaVJttYfuWtYE0AzfEn6SLtEGchF3zApEiklnKwbI28JJZwI
 X2Asaap0594Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="136075327"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="136075327"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:29:44 -0700
IronPort-SDR: O38BpPAaXuiCSMvWvFl4YcZutv8k41p7B/0eD76u20d4BlVXdqQJz8EA+P1aUczqdsnCa39Y8Z
 FxFXlc5t4gwg==
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="474135035"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:29:44 -0700
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
        Weijiang Yang <weijiang.yang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v11 23/25] ELF: Introduce arch_setup_elf_property()
Date:   Mon, 24 Aug 2020 17:25:38 -0700
Message-Id: <20200825002540.3351-24-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200825002540.3351-1-yu-cheng.yu@intel.com>
References: <20200825002540.3351-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
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
v11:
- Combine three patches of arch_setup_elf_property() into one.
- Add empty arch_setup_elf_property() for arm64.

v9:
- Change cpu_feature_enabled() to static_cpu_has().

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
index e93be385cd04..6b6dad011763 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1950,6 +1950,8 @@ config X86_INTEL_SHADOW_STACK_USER
 	select X86_INTEL_CET
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
index 9afefe325acb..fd4644865a3b 100644
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
+	if (!IS_ENABLED(CONFIG_X86_INTEL_CET))
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
index 13d053982dd7..2b4cfc256895 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1217,6 +1217,10 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
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

