Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D2439B7D6
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 13:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhFDL0z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 07:26:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhFDL0z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 07:26:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFAAF613AC;
        Fri,  4 Jun 2021 11:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622805909;
        bh=YIMcXq5zjPTU6TnWkCaebLW4hx7QitAn2BiMS6aUhsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=svJhnniHyp018bcPRVpVs/LUEEqEYFlolaI7sJs20PkQoznIVIhHSVxkP7SBxNTHl
         tCSCXr3IDcWMsm1tRW+3xPkmfhP2xkYYBPqqexmwsL3ch+RyfCG8HJ/muW05rmwPnR
         wlQTJcgvzBkt02FYiw8bQ8rz03GH6z1mlAfWNql+ER/aXsOsn0hV6oXQ2I8qHHiNoI
         f2jUkgicUaeqxe2UEsF+zXwWLmYDzVThGnDJpPF7o71Jq7NgywzKZGJtmk3sR7d68g
         I1V+I/xvW1XejifAiYwZP3OkPmpwOpJvLn/BW3vZ61F91a1FoFBOQu9ulWFD3Wo94L
         cc6Wf4acxa8Ug==
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
Subject: [PATCH v2 2/3] arm64: Enable BTI for main executable as well as the interpreter
Date:   Fri,  4 Jun 2021 12:24:49 +0100
Message-Id: <20210604112450.13344-3-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210604112450.13344-1-broonie@kernel.org>
References: <20210604112450.13344-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3182; h=from:subject; bh=YIMcXq5zjPTU6TnWkCaebLW4hx7QitAn2BiMS6aUhsU=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBgug2Ad6SBiufM2R00KzOUZstotWdq3dPQbkCl/0c/ dJZN8kGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYLoNgAAKCRAk1otyXVSH0P7/B/ 4tCAwJjnNQXw/27zkcreggBq81xCwXUMkmhe5Da0t2hlVLMTzHUZa5PhTW/xbFgwZ2BmI99tWGhWq1 pRE6tZX/zV980453w2zG4n8Qsn5elye5GzCBVKIqMxzceVRSoiJJAZzI/mtayz0yVxmvooXchICfwo 8Wtb20YOQ/DgbucYrsI6/202fuNW09UlE5Qv6fL76SY0g7vysbyHItn8ewwFSUX+X8otZAAVVam76g rm0vHF0TaYaOtf8opVavaReEWX7BLFGr6taLJ6POefjwh3IuJtR7AdXvhoWTPhAampeepr4s5DwmtW FVATyU00PRaOWSwKpNgRE1Qmfi9orJ
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
 arch/arm64/kernel/process.c  | 18 ++++++------------
 2 files changed, 16 insertions(+), 16 deletions(-)

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
index b4bb67f17a2c..f7fff4a4c99f 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -744,19 +744,13 @@ asmlinkage void __sched arm64_preempt_schedule_irq(void)
 int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
 			 bool has_interp, bool is_interp)
 {
-	/*
-	 * For dynamically linked executables the interpreter is
-	 * responsible for setting PROT_BTI on everything except
-	 * itself.
-	 */
-	if (is_interp != has_interp)
-		return prot;
+	if (prot & PROT_EXEC) {
+		if (state->flags & ARM64_ELF_INTERP_BTI && is_interp)
+			prot |= PROT_BTI;
 
-	if (!(state->flags & ARM64_ELF_BTI))
-		return prot;
-
-	if (prot & PROT_EXEC)
-		prot |= PROT_BTI;
+		if (state->flags & ARM64_ELF_EXEC_BTI && !is_interp)
+			prot |= PROT_BTI;
+	}
 
 	return prot;
 }
-- 
2.20.1

