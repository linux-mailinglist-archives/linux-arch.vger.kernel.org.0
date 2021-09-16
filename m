Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEBC40DDFE
	for <lists+linux-arch@lfdr.de>; Thu, 16 Sep 2021 17:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbhIPPcA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Sep 2021 11:32:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239052AbhIPPb7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Sep 2021 11:31:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C04C16124B;
        Thu, 16 Sep 2021 15:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631806239;
        bh=rTVazhUNkG5j722LE4noH1VWtBsKLbISqMxAF9fJEBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CRZYlC2rMxfqgJJRuaK+r1Gpd19aOfMiJpiAB7+R2JZQ8Ww1mzGvotehQUDZF9qra
         E+bCll8xzJTTcORFtoBmprMuXCUzGFHQkS9nbdlaHuxXbS2Q4c+T0Isv65cK/I2gwZ
         IY6YdabTueTP49jN6RnOQ9HqWZ3BxCDuWa9OZ52j3+IZu+ZK3KtPx9SgtsLJl/YBt8
         yXLPoJhqYyKEqUGEtyDNB4HrWw/5byJc2Byr2G8Qj65iP7B5s7wpwyrqZLjNGvMFmS
         vx8FBXdYt42A5gUqjPIMv9WOwEDxH5sPOPwwmWzDKzfGtlCi1D5MmaTw5I7TGH6p/Q
         +qW1bWqjiV0UQ==
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
Subject: [PATCH v6 2/4] arm64: Enable BTI for main executable as well as the interpreter
Date:   Thu, 16 Sep 2021 16:28:19 +0100
Message-Id: <20210916152821.1153-3-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916152821.1153-1-broonie@kernel.org>
References: <20210916152821.1153-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3271; h=from:subject; bh=rTVazhUNkG5j722LE4noH1VWtBsKLbISqMxAF9fJEBA=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhQ2KSBTRUxUybXN12U+BV+jLcUnzYrvdhcj8e2Js9 6J5JfWmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUNikgAKCRAk1otyXVSH0D+cB/ 4i3WtYq4jhAqHpYm4V+ainvFPDPdmlQkW1GWtAM46gN4v+8aeDaM130ZQ9ZzaRzxJ6KOJeWixFAlqU spMMsO6/vvcrn9H7DPZClLqQ0ZCer87Duro9qcPI3n0n8UeRxNjefikub84hF1HfxEx86cOjH8K/km 24pPgcERPyB2xEnM1wBy/hFl+fGpX3hz1UTUD3u2/AyUKMaAV344+AlhnZqj8YHQGN068GM8hL8JFn jn3eqp7JZQP8MYysoucpOtxqCYWtTk8kFwI894EMeWVVmLeXe4l73NjFF39hxKndYK4ZLZiTIfHz49 QbLPgVcD1FAYHAvFVa/+0kmsH3u0B0
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
index 19100fe8f7e4..1aecb20facd5 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -705,18 +705,8 @@ core_initcall(tagged_addr_init);
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
2.20.1

