Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F174F1243
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 11:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354659AbiDDJqe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 05:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354620AbiDDJqe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 05:46:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536E236159
        for <linux-arch@vger.kernel.org>; Mon,  4 Apr 2022 02:44:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9D0761494
        for <linux-arch@vger.kernel.org>; Mon,  4 Apr 2022 09:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDD8C34111;
        Mon,  4 Apr 2022 09:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649065477;
        bh=nM87AwZCcIUCsNfFiO7pQEUlSzAKS0CjflMvMdi3+ho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jasUT0BqCjkbwphByh0sw/sZq5q9PeuCBzvk9xSCRwalgTF7UXNQMh7e5FhgmBxDB
         rZYIAs7Ck2Dxfdo+6WEZ8H4nEW3eeIj/kZoJr9bNSc+/8Zq2+lnNn+rBKVe5Ybg3re
         bMCHyURDg9dinT99ahEuikmyONt2nrhEpDqkXeDic2+5xlaPHtt1J+yKL/Zjy8GMll
         W+Ec1kxxbjMbeYA2EnVAN6CoGpGg3cDtRD0KkMRc+yMfeza4CL0+/rUZCyNlEVfxeo
         +nX1BjWoT87JptqlDPRO/kgJ8SIVvnc6nqXq31q+Re/EaRIIRaLd7EpDKO/Ditkk/v
         m6yvPefsjwncA==
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
Subject: [PATCH v12 2/2] arm64: Enable BTI for main executable as well as the interpreter
Date:   Mon,  4 Apr 2022 10:44:25 +0100
Message-Id: <20220404094425.313821-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404094425.313821-1-broonie@kernel.org>
References: <20220404094425.313821-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3954; h=from:subject; bh=nM87AwZCcIUCsNfFiO7pQEUlSzAKS0CjflMvMdi3+ho=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiSr33GvNrKBRXCqc6UFafyHsWfsmmdTrCliDNXBSv UpscniiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYkq99wAKCRAk1otyXVSH0NKgB/ 0XCk3kRSvXHsxbSHe+clYSh1G0y5XDTqaEeyLTsjhpySX7Qz1om6P1HHhuH8wONvbP7/Tel/IMKpwF WAEwAxtqbpKCh6SciYdcs792OuUlbgPXzqQebPtedBBgZkmcsffJGzjhAz5lCxs4Bal4h2cPmMrLWa P4N/nq4XMrstK6Ay+00oBvgabv2oru4bkw4XL/Th54kxjacuGQ7jku3cM9XUb0ryOtXT7Yh/tnLjLH B1+5vEU+vsImgXsFPejpb1hV8L/8QKuSd5m5PiNznHCTkIQmGAQqWowVoTD7V92Jh2CARGFwH46jzz hRCw09QmqNYEd4HxIU2d1TV3FXWxZa
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 7fa97df55e3a..665d375cc3f1 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -702,23 +702,49 @@ core_initcall(tagged_addr_init);
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

