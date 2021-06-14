Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065E83A71F5
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 00:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhFNWfO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Jun 2021 18:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229829AbhFNWfN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Jun 2021 18:35:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26C5061350;
        Mon, 14 Jun 2021 22:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623709989;
        bh=17k+MoyNqJzjgGdNm9vWTmTrX55pYmEUuacR3oROtGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B96pXCAPu73HDcTLqF6DScu6eWnDuyXEGJ0+mKySi4KTsGB1UHyickhXQWBsGFH/7
         PQFYCy0CuEQZM71ufwsxJ7e8RdUIYse0bDGSBwqkx5S2mJbOZyVq9QDW9pHJTRZBCq
         GQzt43v5Fj+UxG1sO95/eYcFGUCmMCh6+ju87sDuJN0/JUlYk3zRc4IpB47K5/gHsm
         o2XI+62U+DfvoQV0O2b9XoQR5Zl4Mmkj6WV80K/FP1DjmkBNQU/GZCMslG2szLX+pz
         QnbvQ2B8gv2mlx+xAq0ubxF3nTEBL3d2s/xM544/jadd+MOuq3rrpQEHxuHk5GP3os
         Jt6etQ8wES66w==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Mark Brown <broonie@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v3 2/4] arm64: Enable BTI for main executable as well as the interpreter
Date:   Mon, 14 Jun 2021 23:32:12 +0100
Message-Id: <20210614223214.39011-3-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210614223214.39011-1-broonie@kernel.org>
References: <20210614223214.39011-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3373; h=from:subject; bh=17k+MoyNqJzjgGdNm9vWTmTrX55pYmEUuacR3oROtGc=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBgx9jrQwZiPSdRs/BCvcJegZDLgaOo3lU/tk5go+kw +KrIJRyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYMfY6wAKCRAk1otyXVSH0Dt3B/ 9gbtsNgGoILSpsLB1V/Ykg9QDHZUdvpmJIO6J131l/HOYdFFyXRYlAvXPmiQTL2LYg3YNtuGplzd+h nefV7uBs+s2uO3w96j14BkRycwYPTSnpH2M2AYqURcsfBF6JPoXzBcAepB/WGG4wqICltrMFmTk1tn mvzRui//tTOa5O4gionTkSd26b87u2oJlqUNQOJZ7gGNXgZxCSLAprT5RP5PK6f27LEoYYXygcVK9S AcY8za6+3vdXyo5777gKo559Ih4+A0pmo/0Zy1WZUYKf0oAapPwPoXNHrfTaTyytLO486ee/dGMpGf MFekzKI7szXUVWMrSwWhPmwiYmKpz7
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently for dynamically linked ELF executables we only enable BTI for
the interpreter, expecting the interpreter to do this for the main
executable. This is a bit inconsistent since we do map main executable and
is causing issues with systemd's MemoryDenyWriteExecute feature which is
implemented using a seccomp filter which prevents setting PROT_EXEC on
already mapped memory and lacks the context to be able to detect that
memory is already mapped with PROT_EXEC.

Resolve this by checking the BTI property for the main executable and
enabling BTI if it is present when doing the initial mapping. This does
mean that we may get more code with BTI enabled if running on a system
without BTI support in the dynamic linker, this is expected to be a safe
configuration and testing seems to confirm that. It also reduces the
flexibility userspace has to disable BTI but it is expected that for cases
where there are problems which require BTI to be disabled it is more likely
that it will need to be disabled on a system level.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/elf.h | 14 ++++++++++----
 arch/arm64/kernel/process.c  | 23 +++++++++++------------
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index a488a1329b16..9f86dbce2680 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -253,7 +253,8 @@ struct arch_elf_state {
 	int flags;
 };
 
-#define ARM64_ELF_BTI		(1 << 0)
+#define ARM64_ELF_INTERP_BTI		(1 << 0)
+#define ARM64_ELF_EXEC_BTI		(1 << 1)
 
 #define INIT_ARCH_ELF_STATE {			\
 	.flags = 0,				\
@@ -274,9 +275,14 @@ static inline int arch_parse_elf_property(u32 type, const void *data,
 		if (datasz != sizeof(*p))
 			return -ENOEXEC;
 
-		if (system_supports_bti() && has_interp == is_interp &&
-		    (*p & GNU_PROPERTY_AARCH64_FEATURE_1_BTI))
-			arch->flags |= ARM64_ELF_BTI;
+		if (system_supports_bti() &&
+		    (*p & GNU_PROPERTY_AARCH64_FEATURE_1_BTI)) {
+			if (is_interp) {
+				arch->flags |= ARM64_ELF_INTERP_BTI;
+			} else {
+				arch->flags |= ARM64_ELF_EXEC_BTI;
+			}
+		}
 	}
 
 	return 0;
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index b4bb67f17a2c..21f1f0997c43 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -741,21 +741,20 @@ asmlinkage void __sched arm64_preempt_schedule_irq(void)
 }
 
 #ifdef CONFIG_BINFMT_ELF
-int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
-			 bool has_interp, bool is_interp)
+static inline int arm64_elf_bti_flag(bool is_interp)
 {
-	/*
-	 * For dynamically linked executables the interpreter is
-	 * responsible for setting PROT_BTI on everything except
-	 * itself.
-	 */
-	if (is_interp != has_interp)
-		return prot;
+	if (is_interp)
+		return ARM64_ELF_INTERP_BTI;
+	else
+		return ARM64_ELF_EXEC_BTI;
+}
 
-	if (!(state->flags & ARM64_ELF_BTI))
-		return prot;
 
-	if (prot & PROT_EXEC)
+int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
+			 bool has_interp, bool is_interp)
+{
+	if ((prot & PROT_EXEC) &&
+	    (state->flags & arm64_elf_bti_flag(is_interp)))
 		prot |= PROT_BTI;
 
 	return prot;
-- 
2.20.1

