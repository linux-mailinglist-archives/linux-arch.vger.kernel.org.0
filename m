Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EA6498310
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jan 2022 16:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbiAXPHx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jan 2022 10:07:53 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54672 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbiAXPHx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jan 2022 10:07:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ED0BBCE1192
        for <linux-arch@vger.kernel.org>; Mon, 24 Jan 2022 15:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181F3C340EB;
        Mon, 24 Jan 2022 15:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643036870;
        bh=RP8vWe5V4SiwPaYUzNl2BKIfhh0nf3pGQ2yDgyzXenU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tnv/qcQ+Bom1DgMqdhssP/3yv1GylsuYNyPXz/XYBR3lVD6RYJK/BW6/fqvc7qj+i
         0eIcEuzmuX6JSAYE3pKtSSTYMo46JF8sAPTh2zXP6Z+C1Tw2XMdvUCLn+oE9GWC+/Q
         XislVD69ocU9pPPxHF9f6FuuNSFhf7N/uz/QBgfGKLmcK3zdXpfFv8iMCreavIQhil
         NMKzM5JW90hrl0zxmklnWQZ/rSVJfhvjti482gAiBYJV895KQbsdNGpXWpHr5YQ9jH
         JtZ01zEflMw8k4IzCGHJ+6aYaqoI9f5b9igcRzGvJF/JYLrH7sfPNymS45VNQ+Li7m
         YVvBuuNQ1U5lg==
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
Subject: [PATCH v8 2/4] arm64: Enable BTI for main executable as well as the interpreter
Date:   Mon, 24 Jan 2022 15:07:02 +0000
Message-Id: <20220124150704.2559523-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124150704.2559523-1-broonie@kernel.org>
References: <20220124150704.2559523-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3271; h=from:subject; bh=RP8vWe5V4SiwPaYUzNl2BKIfhh0nf3pGQ2yDgyzXenU=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh7sCTXTHFIvz3vMiH916XxroI4hhVUGMITuiztmGl U9C4yR2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYe7AkwAKCRAk1otyXVSH0AkGB/ wKz/RwlSB6VP7EZkkgneZMez6bIBqh9oMLf5JntkyryFk0HBLW+zZ8rMZoIVPy7GJT/FFmX3Vwq5Qr qkUUKTSnMjqvSBxkCt/GTBw1CEnpedWGdAKX4P/4/e78QyhqtxaC2hf3M9KcnbfGjZjMH3mxrXrqHZ bU3hmIQ4N2Uxarzog62y/qNyUQhBswbnJSRXO1mStmwXMH9jUKtiL9fG9hfdmeSlvcAAJZIpFYwz1x jmvkphO/0Mqxb6unqIgwFpMBKk4hg3v1ezQ97oGKirJ08Du2TzN3Lo3YRXO0H0YtID688qpPsVhGPP 0miy4Mb8HKzkASYyvaVbmFcq3jpxp1
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
index 5369e649fa79..8157910a4181 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -704,18 +704,8 @@ core_initcall(tagged_addr_init);
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

