Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 425CEDCCB4
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 19:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505412AbfJRR1Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 13:27:25 -0400
Received: from [217.140.110.172] ([217.140.110.172]:47136 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2502239AbfJRR1Z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Oct 2019 13:27:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49747142F;
        Fri, 18 Oct 2019 10:26:53 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5B4BB3F718;
        Fri, 18 Oct 2019 10:26:50 -0700 (PDT)
From:   Dave Martin <Dave.Martin@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Jones <drjones@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Sudakshina Das <sudi.das@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 06/12] elf: Allow arch to tweak initial mmap prot flags
Date:   Fri, 18 Oct 2019 18:25:39 +0100
Message-Id: <1571419545-20401-7-git-send-email-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1571419545-20401-1-git-send-email-Dave.Martin@arm.com>
References: <1571419545-20401-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

An arch may want to tweak the mmap prot flags for an
ELFexecutable's initial mappings.  For example, arm64 is going to
need to add PROT_BTI for executable pages in an ELF process whose
executable is marked as using Branch Target Identification (an
ARMv8.5-A control flow integrity feature).

So that this can be done in a generic way, add a hook
arch_elf_adjust_prot() to modify the prot flags as desired: arches
can select CONFIG_HAVE_ELF_PROT and implement their own backend
where necessary.

By default, leave the prot flags unchanged.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 fs/Kconfig.binfmt   |  3 +++
 fs/binfmt_elf.c     | 18 ++++++++++++------
 include/linux/elf.h | 12 ++++++++++++
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index d2cfe07..2358368 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -36,6 +36,9 @@ config COMPAT_BINFMT_ELF
 config ARCH_BINFMT_ELF_STATE
 	bool
 
+config ARCH_HAVE_ELF_PROT
+	bool
+
 config ARCH_USE_GNU_PROPERTY
 	bool
 
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index ae345f6..dbfab2e 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -531,7 +531,8 @@ static inline int arch_check_elf(struct elfhdr *ehdr, bool has_interp,
 
 #endif /* !CONFIG_ARCH_BINFMT_ELF_STATE */
 
-static inline int make_prot(u32 p_flags)
+static inline int make_prot(u32 p_flags, struct arch_elf_state *arch_state,
+			    bool has_interp, bool is_interp)
 {
 	int prot = 0;
 
@@ -541,7 +542,8 @@ static inline int make_prot(u32 p_flags)
 		prot |= PROT_WRITE;
 	if (p_flags & PF_X)
 		prot |= PROT_EXEC;
-	return prot;
+
+	return arch_elf_adjust_prot(prot, arch_state, has_interp, is_interp);
 }
 
 /* This is much more generalized than the library routine read function,
@@ -551,7 +553,8 @@ static inline int make_prot(u32 p_flags)
 
 static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 		struct file *interpreter, unsigned long *interp_map_addr,
-		unsigned long no_base, struct elf_phdr *interp_elf_phdata)
+		unsigned long no_base, struct elf_phdr *interp_elf_phdata,
+		struct arch_elf_state *arch_state)
 {
 	struct elf_phdr *eppnt;
 	unsigned long load_addr = 0;
@@ -583,7 +586,8 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 	for (i = 0; i < interp_elf_ex->e_phnum; i++, eppnt++) {
 		if (eppnt->p_type == PT_LOAD) {
 			int elf_type = MAP_PRIVATE | MAP_DENYWRITE;
-			int elf_prot = make_prot(eppnt->p_flags);
+			int elf_prot = make_prot(eppnt->p_flags, arch_state,
+						 true, true);
 			unsigned long vaddr = 0;
 			unsigned long k, map_addr;
 
@@ -1040,7 +1044,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			}
 		}
 
-		elf_prot = make_prot(elf_ppnt->p_flags);
+		elf_prot = make_prot(elf_ppnt->p_flags, &arch_state,
+				     !!interpreter, false);
 
 		elf_flags = MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE;
 
@@ -1186,7 +1191,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		elf_entry = load_elf_interp(&loc->interp_elf_ex,
 					    interpreter,
 					    &interp_map_addr,
-					    load_bias, interp_elf_phdata);
+					    load_bias, interp_elf_phdata,
+					    &arch_state);
 		if (!IS_ERR((void *)elf_entry)) {
 			/*
 			 * load_elf_interp() returns relocation
diff --git a/include/linux/elf.h b/include/linux/elf.h
index 7bdc6da..1b6e895 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -83,4 +83,16 @@ extern int arch_parse_elf_property(u32 type, const void *data, size_t datasz,
 				   bool compat, struct arch_elf_state *arch);
 #endif
 
+#ifdef CONFIG_ARCH_HAVE_ELF_PROT
+int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
+			 bool has_interp, bool is_interp);
+#else
+static inline int arch_elf_adjust_prot(int prot,
+				       const struct arch_elf_state *state,
+				       bool has_interp, bool is_interp)
+{
+	return prot;
+}
+#endif
+
 #endif /* _LINUX_ELF_H */
-- 
2.1.4

