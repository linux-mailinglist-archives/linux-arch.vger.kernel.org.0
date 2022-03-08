Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8064D191D
	for <lists+linux-arch@lfdr.de>; Tue,  8 Mar 2022 14:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343989AbiCHNZf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Mar 2022 08:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347129AbiCHNZe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Mar 2022 08:25:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CCA41FA1
        for <linux-arch@vger.kernel.org>; Tue,  8 Mar 2022 05:24:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B707961022
        for <linux-arch@vger.kernel.org>; Tue,  8 Mar 2022 13:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4591C340F7;
        Tue,  8 Mar 2022 13:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646745877;
        bh=uekWLuTeuAPbxKz2+RfH89ey7s+mfr2vZ1i359l07Mk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=As9vgWzQcHC9k1i/RFedaQqF+3kGXD/sLp+dyfmmK1X2PDq6SslFjGKKeve/SSZvr
         OJkEAuJ1m5q35vAhZvLUQ1qEb/ATuw8km9+nLitI/YJWh05CXulTmGG7lfPIfn0UQj
         UqvNgFmc9GD/BYGjfIIMgnMAm7ctrbeYmoCK0l/rYhopRl4b1SuZdXejJbcyK+LOhW
         MaYYSe7H+V0F1vRFpBU3nyEfX37O7UsG2i6Op5fb73mWn90FfeBBGrgAhj6e/WJoqX
         1XmUptwbIkLmS2isM3rdDFEx0+1lCrXZ1n/9wwUjjtvK8v2ElCy5T2oN1s5H/8Jn00
         G7D2vVyssFuvQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v11 2/2] arm64: Enable BTI for main executable as well as the interpreter
Date:   Tue,  8 Mar 2022 13:22:40 +0000
Message-Id: <20220308132240.1697784-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220308132240.1697784-1-broonie@kernel.org>
References: <20220308132240.1697784-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3954; h=from:subject; bh=uekWLuTeuAPbxKz2+RfH89ey7s+mfr2vZ1i359l07Mk=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiJ1ic3SJIqA5CA/Ix0aaYKO1oN9856cF1XwHAWEa+ sLC4HY+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYidYnAAKCRAk1otyXVSH0G4RB/ 9Mk90zfmkidbljt3perRxjDgIev5VztiuEROBGeqGjH2nSkKteDJxdKE8Qos0SjbhNjFymXDQ7EaDw qkeLKqNndNQrtlkMDeSi5dTTaTX5yZGpQpbyqUbg/9dxhUIYiVpBBRotdQoRIk9xa26B0ZBAUgbPaO 1tVWmfr9YRiRC+PzV83DTE9+v4TEV+sBDY5MAtcEqGmdxUy8M+n7jY2zu32yPzldVeLjI1bEQEzzT9 kNa11CRAz7ol+qvTihWC9YIZt9JHOzBj2rSyXBLW69FEFsPuvtbQqhadt+tlWYMFwBBrsV8F89ngkU CsBYGrtIcdNfjDfWZc/qzSSTbh2AbY
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Resolve this by adding a sysctl abi.bti_main which causes the kernel to
checking the BTI property for the main executable and enable BTI if it
is present when doing the initial mapping. This sysctl is disabled by
default.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/elf.h | 15 ++++++++---
 arch/arm64/kernel/process.c  | 52 +++++++++++++++++++++++++++---------
 2 files changed, 51 insertions(+), 16 deletions(-)

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
index 5369e649fa79..82aaf361fa17 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -701,23 +701,49 @@ core_initcall(tagged_addr_init);
 #endif	/* CONFIG_ARM64_TAGGED_ADDR_ABI */
 
 #ifdef CONFIG_BINFMT_ELF
+static unsigned int bti_main;
+
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
+	    (is_interp || !has_interp || bti_main) &&
+	    (state->flags & arm64_elf_bti_flag(is_interp)))
 		prot |= PROT_BTI;
 
 	return prot;
 }
-#endif
+
+#ifdef CONFIG_ARM64_BTI
+/*
+ * If this sysctl is enabled then we will apply PROT_BTI to the main
+ * executable as well as the dynamic linker if it has the appropriate
+ * ELF note.  It is disabled by default, in which case we will only
+ * apply PROT_BTI to the dynamic linker or static binaries.
+ */
+static struct ctl_table bti_main_sysctl_table[] = {
+	{
+		.procname	= "bti_main",
+		.mode		= 0644,
+		.data		= &bti_main,
+		.maxlen		= sizeof(int),
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{ }
+};
+
+static int __init bti_main_init(void)
+{
+	if (!system_supports_bti())
+		return 0;
+
+	if (!register_sysctl("abi", bti_main_sysctl_table))
+		return -EINVAL;
+	return 0;
+}
+core_initcall(bti_main_init);
+#endif /* CONFIG_ARM64_BTI */
+
+#endif /* CONFIG_BINFMT_ELF */
-- 
2.30.2

