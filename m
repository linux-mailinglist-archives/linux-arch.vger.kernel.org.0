Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81C0450842
	for <lists+linux-arch@lfdr.de>; Mon, 15 Nov 2021 16:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbhKOPac (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Nov 2021 10:30:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:51772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236405AbhKOPaY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 15 Nov 2021 10:30:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA32461AA5;
        Mon, 15 Nov 2021 15:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636990049;
        bh=D7YPrbFYzpSg2f9JH5grl1r/4F+OGQUL22/T47/t85M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hzT2afYtO4+4VegxT7dgaDrVT2ZSIkOjeWRn45+eGjFjrNBBORsbJVfnqc9S5fEl5
         OcUEQCyCpm/ioDpgOALDnqV/luTQH9zxKfow0ZtEgtDRVw9CmVCQHZdCvUuqXYf43B
         6Ri53PCJjlJSp8SfUFiVh5M6cJW0fPotm8WVhAEQ/V20Kpl/qgL9DLsMqKrxjRBS0R
         h8rIGJFowwFjwa+fiJ++IK+mZ6ZaM/RD2XSk750VaCYffOxRl7XXz4VAxLOnuzxRfU
         EFoB3EFALg/zQrjV++xd9BgyQD5ekLLn4tVxYfPdAFpTcFU5Gz33mDTqA1rm4Phg5S
         sYhUlS4OAVH9w==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Mark Brown <broonie@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v7 2/4] arm64: Enable BTI for main executable as well as the interpreter
Date:   Mon, 15 Nov 2021 15:27:12 +0000
Message-Id: <20211115152714.3205552-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211115152714.3205552-1-broonie@kernel.org>
References: <20211115152714.3205552-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3271; h=from:subject; bh=D7YPrbFYzpSg2f9JH5grl1r/4F+OGQUL22/T47/t85M=; b=owGbwMvMwMWocq27KDak/QLjabUkhsRJNT57ChhYpK70qFaudWLbdspCVSrVxKboWkOE7zn1O7YS OXmdjMYsDIxcDLJiiixrn2WsSg+X2Dr/0fxXMINYmUCmMHBxCsBEWqzZ/ymKHBIP4PrmsU9ClGFxs+ tst+8RMlO49jpMfpb7U+Nh1DS7PfxtW469eHh85dbTBmaOTyqj+nZ807XbbGil3ugxb750SLGcaV+/ 8CE/gx33cxPeHzfb0Rj/tdlcNTDVslVWcdlU8dDlyoez+iu8Je5nbRWyF+nYnfFVrJ2tSvvGg+oE9g WGO6WuNvNc+rAnNnPLwm7bEv9llxemHDP96POoeomD3gzzB36HrAsfiZwSnemwJYYvulave5nHEWau TVt5fwV7Vz5KjPAv+bz754QnbE9vlk9LMmt8YZbmG2t6RvyKucKuLMsMqaJP9kvKS7a0bZ00UzRpz4 /2O3lTO96X317jfsci3k+iVXEyAA==
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
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/elf.h | 15 ++++++++++++---
 arch/arm64/kernel/process.c  | 14 ++------------
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 5cc002376abe..c4aa60db76a4 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -251,12 +251,21 @@ struct arch_elf_state {
 	int flags;
 };
 
-#define ARM64_ELF_BTI		(1 << 0)
+#define ARM64_ELF_INTERP_BTI		(1 << 0)
+#define ARM64_ELF_EXEC_BTI		(1 << 1)
 
 #define INIT_ARCH_ELF_STATE {			\
 	.flags = 0,				\
 }
 
+static inline int arm64_elf_bti_flag(bool is_interp)
+{
+	if (is_interp)
+		return ARM64_ELF_INTERP_BTI;
+	else
+		return ARM64_ELF_EXEC_BTI;
+}
+
 static inline int arch_parse_elf_property(u32 type, const void *data,
 					  size_t datasz, bool compat,
 					  bool has_interp, bool is_interp,
@@ -272,9 +281,9 @@ static inline int arch_parse_elf_property(u32 type, const void *data,
 		if (datasz != sizeof(*p))
 			return -ENOEXEC;
 
-		if (system_supports_bti() && has_interp == is_interp &&
+		if (system_supports_bti() &&
 		    (*p & GNU_PROPERTY_AARCH64_FEATURE_1_BTI))
-			arch->flags |= ARM64_ELF_BTI;
+			arch->flags |= arm64_elf_bti_flag(is_interp);
 	}
 
 	return 0;
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index aacf2f5559a8..a6b6b587cab9 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -702,18 +702,8 @@ core_initcall(tagged_addr_init);
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
-
-	if (!(state->flags & ARM64_ELF_BTI))
-		return prot;
-
-	if (prot & PROT_EXEC)
+	if ((prot & PROT_EXEC) &&
+	    (state->flags & arm64_elf_bti_flag(is_interp)))
 		prot |= PROT_BTI;
 
 	return prot;
-- 
2.30.2

