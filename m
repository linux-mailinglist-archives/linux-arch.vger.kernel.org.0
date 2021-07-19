Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703D63CE68A
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jul 2021 19:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349116AbhGSQIA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Jul 2021 12:08:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245357AbhGSQGB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Jul 2021 12:06:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD5DD61221;
        Mon, 19 Jul 2021 16:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626713174;
        bh=CO++giUYoHXNfg+ZM1q/9xAugE5bMJJQr1XwojyQrKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eNJY8hxiVd1RhrC0oXUy52ZaWaz8sQERIXMrolFWRhHnCUhP5cjlY/YkoWolZ4Prr
         rRdD6/AEArmBTFYzPofiI3bQ0t4ELzwGigVbK0szH9nDjDrAn05Pv300ANwSjF5Ges
         dPr2at5dczGnEYkZmHQdHMfmt9u8f1xAaOIUPqadjzuYFM9LS00gWkCwr6OoQMNlhm
         iNu+MWxmE98zs1rRi44e9l/B4wAS0u1u/QbMSU0S7DGr1NuNS9//8ggaCsV6xu9B6G
         9UKO/vOy+wqc5VF7TEh9M7wHws4raPJrL9g+6joIlXU54JWFQ7DUrW2peVEROhRNI7
         zYR8D0NKmp24g==
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
Subject: [PATCH v5 2/4] arm64: Enable BTI for main executable as well as the interpreter
Date:   Mon, 19 Jul 2021 17:45:34 +0100
Message-Id: <20210719164536.19143-3-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210719164536.19143-1-broonie@kernel.org>
References: <20210719164536.19143-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3271; h=from:subject; bh=CO++giUYoHXNfg+ZM1q/9xAugE5bMJJQr1XwojyQrKg=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBg9awtaL5taIcuRXN131n30QOb5aon69WBKpFrMP8R NHv0qSmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYPWsLQAKCRAk1otyXVSH0MWMB/ 9DozwfDb3Ukp7lF1mA8M89pvNhCZtoUzvO2dgWfrJILsc/3NiaAI/DVuxuQs/J65X1iMcJ7a95u4la 1GZuZ1Qw5UMWeOu8uSKZn3i9zqopZp8p911btB695cusfSuCRvq22pJ5vxrYuiumdA3R7LCaMQ2hAz +Yoy5pYO+luv4pnogNrq/J7wYmU940IgL55RDypBRtwhVVs+PbU/7tJ//pgPbZkbvVgJEwFhOBDEsf G3d+TR9OTWp0Ifp+kvLAULsrnTy0BoRIHehWZhl5tcyK2sXMXv/B1CMaMArZQieX69o7RWObwi7dvW WtYohV71JPes/5mHmYOGXT1WyPgPPK
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
index a488a1329b16..43b10fd04467 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -253,12 +253,21 @@ struct arch_elf_state {
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
@@ -274,9 +283,9 @@ static inline int arch_parse_elf_property(u32 type, const void *data,
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
index c8989b999250..2645bc79b35e 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -686,18 +686,8 @@ core_initcall(tagged_addr_init);
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

