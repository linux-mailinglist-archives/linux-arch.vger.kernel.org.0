Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840294C6D6B
	for <lists+linux-arch@lfdr.de>; Mon, 28 Feb 2022 14:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbiB1NIV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 08:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbiB1NIO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 08:08:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5890E28
        for <linux-arch@vger.kernel.org>; Mon, 28 Feb 2022 05:07:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D1F5B81110
        for <linux-arch@vger.kernel.org>; Mon, 28 Feb 2022 13:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61320C340F3;
        Mon, 28 Feb 2022 13:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646053650;
        bh=eR6+Nci0LoL7aKQRViLwzPw/KMTNexP4A1Vwsad7KCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=arz6RTm6G7WF1D4dG3zMaONz+IapKRtS8LTNL9TlTMZq3q0V0kbK/TQiWQYW7RDtG
         rJsYwbPhJA47y8uQakYismKgSuVWNS9v2hbpGP7NSOspQKkLcOfD3gCFqBLL8mwpqX
         zU9UJd+uWNfs+Nalauw6CeRAei1zL7penJNxDh5ROoBXkAovvMw4/WTDcZwusqeiiF
         i4oFV4bFAJtx0LfGpF5pufhwPkJxao/mr4ZV0jFR+cn8qDheaor6B0sZGLQxDIvD/h
         bKGRWhKJECB6nOEF4P9m2+YN3iVqDAV7gZt3brW3PDeYxA3/dHqz9Co2zyTONk/kx7
         GVIHjn22PyLaw==
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
Subject: [PATCH v10 2/2] arm64: Enable BTI for main executable as well as the interpreter
Date:   Mon, 28 Feb 2022 13:06:06 +0000
Message-Id: <20220228130606.1070960-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220228130606.1070960-1-broonie@kernel.org>
References: <20220228130606.1070960-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3898; h=from:subject; bh=eR6+Nci0LoL7aKQRViLwzPw/KMTNexP4A1Vwsad7KCQ=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiHMi9he8bGD/YxH1JoS8wLCTPp8TgwGqceU/x4SyL 9qOjL+aJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYhzIvQAKCRAk1otyXVSH0O4SB/ 0b8J2hJzjFNvSHoSwCUFCMqb0Sr2QwZtyMY+w1yn9YSXOZsJ7M34Zbf/kK617tos9GKoaO8aVjMum3 NN/WBJBL5u5gIn1/NbFalycV5KdX3l7iIGeZ6PU6rWZ6whzTplc0vAaFQawlI+sX4ZoYFUlJZd3qvQ nPrFRErSQrNKoOfiAjE++bd9XJSDc64pNMdAoQmztT6SFPBymJtzFQt1/v7uO8/mGk8Ys8vbcJr/bV Qpye5QfD3U4pV9h33dcTzXdignXrqrwlIFzof1ck/bGe8Tp0DxA8iYkvo/BPuZ1JSuXiWotyJO0KjS bdf7r1XrOl6E9Yfnnijc3SvAunVFpA
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

