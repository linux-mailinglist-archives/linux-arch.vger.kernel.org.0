Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5DA38C987
	for <lists+linux-arch@lfdr.de>; Fri, 21 May 2021 16:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbhEUOwW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 10:52:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232057AbhEUOwU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 10:52:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85AE061244;
        Fri, 21 May 2021 14:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621608657;
        bh=D4NkMwVFUdPc0BTcTl67XPKgjq90SwA/PD6k/bu+LLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vAniQIoUePrIePB+C7b0PO8AoFBHFaKWY6Cj4tBUzxHjgNDtkgLZ7t2Xm0ZcZzOkE
         oFYg3N7mhpTMtT3OTTUSO8H3tiaG782IJp7y2Ot9mes5CqfbkDyS63x/S2lyBNTzru
         CqTXxUcVU5W1bdz/kwXUZ2IRGLMk4mjzJuBfl9rsdPE18GTNo+8ZrHGO5m2B0kZ5iy
         fKP/NVMogLk7eHzqu3S3znbMgziz2RrInEQ3iy3MYfCxAedGOb51HznBCqOMy54UNB
         Y/M2fZClQKCkvg6nHoVKx/hkliauDzmmtt3zt/1tuENQGD+Vk9E1Iv06NuHvmO9lM/
         HyZ8gjp2NBLyA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, libc-alpha@sourceware.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/2] arm64: Enable BTI for main executable as well as the interpreter
Date:   Fri, 21 May 2021 15:46:21 +0100
Message-Id: <20210521144621.9306-3-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210521144621.9306-1-broonie@kernel.org>
References: <20210521144621.9306-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3120; h=from:subject; bh=D4NkMwVFUdPc0BTcTl67XPKgjq90SwA/PD6k/bu+LLY=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBgp8e63Q/Dzu8hcmWFYniSEJxbsvuwGRE0+k9cyO0P 0XKO4s2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYKfHugAKCRAk1otyXVSH0DRBCA CBxIRQ9ElIqsXh6FhTohh75nkTNeSv/jJXMBdCw+Efs/pK/mLYCt9hCEBJAJnsag5dWtMIgbe9TlFv 8y61VecnnoI4jC0yZdj1eyE35cNSMgfCgwSDyZzJ+gGVQ17VkfQ+eHOvnpFPW8Fx2xzfNQiOxEB+Y/ lOVXeRDWno6UtdGseT2IUGfkqR9lkmhwsRwJhlqhVYvcnEnlTArSbuWpLDhJa+XpGfFzEHD99CK/Fe G3FgV8m5QcwY2EDC9oz119hNQmjIb81+ntPbSP4xjaWvQlFvyVARycZejH2j2ewvJQ/Ka/XYd/b5cH OyUD+hwg7ILJqA7HSGboMbgV/M8VR0
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
---
 arch/arm64/include/asm/elf.h | 14 ++++++++++----
 arch/arm64/kernel/process.c  | 18 ++++++------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index c8678a8c36d5..a6e9032b951a 100644
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
 
-		if (system_supports_bti() && is_interp &&
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

