Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867BB49830E
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jan 2022 16:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiAXPHv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jan 2022 10:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbiAXPHv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jan 2022 10:07:51 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E19C06173B
        for <linux-arch@vger.kernel.org>; Mon, 24 Jan 2022 07:07:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 288B1CE1192
        for <linux-arch@vger.kernel.org>; Mon, 24 Jan 2022 15:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A024C340E8;
        Mon, 24 Jan 2022 15:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643036867;
        bh=DIMYvmwhqk0UEHvyTnSBJ71y/3GVySDF1P4XRzb4XOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MSNgLrbDYV1X7OaZ9WQPl35Krk4avEskodfzeICnFngJHs7ev63NUDB8JJDfLMCfl
         /cGMPU/rkTcEIdoD0FUUrNvlkbpQE7xhKz7UD8ADgW7GO9+n9gccdKaOPP1peiW/ht
         kQLgi7z7Pqtvd6nCnVTpPJcujoT8Da+FrLeIan3NpCRFVlr9rTe1uNw56KrbgdALQu
         tskNhsHyLsB28atuw4ZBEek447ZoKD6kWP6vYoKqg+0V5xvhK/iUcyncPapzeSQ3sC
         vBYAZcaaVdiO6cO2AfP4Une/Q71WmhX9aGjCi3NiGOw1NtQmqH21U0HDRdcuxaN6rM
         KmJJmZ5vkm5ug==
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
Subject: [PATCH v8 1/4] elf: Allow architectures to parse properties on the main executable
Date:   Mon, 24 Jan 2022 15:07:01 +0000
Message-Id: <20220124150704.2559523-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124150704.2559523-1-broonie@kernel.org>
References: <20220124150704.2559523-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5824; h=from:subject; bh=DIMYvmwhqk0UEHvyTnSBJ71y/3GVySDF1P4XRzb4XOM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh7sCSGVrZ5lSZXaD4DR/r+rY73nuMupmgWr5KvFSP lK02YVGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYe7AkgAKCRAk1otyXVSH0MLsCA CAPjnPnEKhxpu4nLKw+1jHe5X/CW4i1J4mIuhpXCGiohiAX2TBWJ7L5CGvRcZFkZaj67/nr3fKuUDB lBp1NXCrmX46k5XySdLAf3owLr0UMRAY9Xn7tgJeshU6TcR3JdksvWxn9LIMaHK4CaC6DyPVVYZ9/C YMWxi8vHdh2Ujgaxcovi294drMX9C6akup5DugzodaYsZse7Mr3dNxisY9+kAKvUsWGPPaF/f2mLVg 8SOaM9KgyAM4qrafAbFvGpcRxsBdr4qdTinAfRmrjpShhFf8X7gwfPmAtQBOAEgIzs92UhyLJunl/A J+hho+SAkaGNiULqLtceIPjG7WyNcg
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently the ELF code only attempts to parse properties on the image
that will start execution, either the interpreter or for statically linked
executables the main executable. The expectation is that any property
handling for the main executable will be done by the interpreter. This is
a bit inconsistent since we do map the executable and is causing problems
for the arm64 BTI support when used in conjunction with systemd's use of
seccomp to implement MemoryDenyWriteExecute which stops the dynamic linker
adjusting the permissions of executable segments.

Allow architectures to handle properties for both the dynamic linker and
main executable, adjusting arch_parse_elf_properties() to have a new
flag is_interp flag as with arch_elf_adjust_prot() and calling it for
both the main executable and any intepreter.

The user of this code, arm64, is adapted to ensure that there is no
functional change.

Signed-off-by: Mark Brown <broonie@kernel.org>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/elf.h |  3 ++-
 fs/binfmt_elf.c              | 27 +++++++++++++++++++--------
 include/linux/elf.h          |  4 +++-
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 97932fbf973d..5cc002376abe 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -259,6 +259,7 @@ struct arch_elf_state {
 
 static inline int arch_parse_elf_property(u32 type, const void *data,
 					  size_t datasz, bool compat,
+					  bool has_interp, bool is_interp,
 					  struct arch_elf_state *arch)
 {
 	/* No known properties for AArch32 yet */
@@ -271,7 +272,7 @@ static inline int arch_parse_elf_property(u32 type, const void *data,
 		if (datasz != sizeof(*p))
 			return -ENOEXEC;
 
-		if (system_supports_bti() &&
+		if (system_supports_bti() && has_interp == is_interp &&
 		    (*p & GNU_PROPERTY_AARCH64_FEATURE_1_BTI))
 			arch->flags |= ARM64_ELF_BTI;
 	}
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 605017eb9349..eabd7e0f6592 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -716,8 +716,9 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
  */
 
 static int parse_elf_property(const char *data, size_t *off, size_t datasz,
-			      struct arch_elf_state *arch,
-			      bool have_prev_type, u32 *prev_type)
+			      struct arch_elf_state *arch, bool has_interp,
+			      bool is_interp, bool have_prev_type,
+			      u32 *prev_type)
 {
 	size_t o, step;
 	const struct gnu_property *pr;
@@ -751,7 +752,8 @@ static int parse_elf_property(const char *data, size_t *off, size_t datasz,
 	*prev_type = pr->pr_type;
 
 	ret = arch_parse_elf_property(pr->pr_type, data + o,
-				      pr->pr_datasz, ELF_COMPAT, arch);
+				      pr->pr_datasz, ELF_COMPAT,
+				      has_interp, is_interp, arch);
 	if (ret)
 		return ret;
 
@@ -764,6 +766,7 @@ static int parse_elf_property(const char *data, size_t *off, size_t datasz,
 #define NOTE_NAME_SZ (sizeof(GNU_PROPERTY_TYPE_0_NAME))
 
 static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
+				bool has_interp, bool is_interp,
 				struct arch_elf_state *arch)
 {
 	union {
@@ -813,7 +816,8 @@ static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
 	have_prev_type = false;
 	do {
 		ret = parse_elf_property(note.data, &off, datasz, arch,
-					 have_prev_type, &prev_type);
+					 has_interp, is_interp, have_prev_type,
+					 &prev_type);
 		have_prev_type = true;
 	} while (!ret);
 
@@ -828,6 +832,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	unsigned long error;
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
 	struct elf_phdr *elf_property_phdata = NULL;
+	struct elf_phdr *interp_elf_property_phdata = NULL;
 	unsigned long elf_bss, elf_brk;
 	int bss_prot = 0;
 	int retval, i;
@@ -963,12 +968,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			goto out_free_dentry;
 
 		/* Pass PT_LOPROC..PT_HIPROC headers to arch code */
-		elf_property_phdata = NULL;
 		elf_ppnt = interp_elf_phdata;
 		for (i = 0; i < interp_elf_ex->e_phnum; i++, elf_ppnt++)
 			switch (elf_ppnt->p_type) {
 			case PT_GNU_PROPERTY:
-				elf_property_phdata = elf_ppnt;
+				interp_elf_property_phdata = elf_ppnt;
 				break;
 
 			case PT_LOPROC ... PT_HIPROC:
@@ -979,10 +983,17 @@ static int load_elf_binary(struct linux_binprm *bprm)
 					goto out_free_dentry;
 				break;
 			}
+
+		retval = parse_elf_properties(interpreter,
+					      interp_elf_property_phdata,
+					      true, true, &arch_state);
+		if (retval)
+			goto out_free_dentry;
+
 	}
 
-	retval = parse_elf_properties(interpreter ?: bprm->file,
-				      elf_property_phdata, &arch_state);
+	retval = parse_elf_properties(bprm->file, elf_property_phdata,
+				      interpreter, false, &arch_state);
 	if (retval)
 		goto out_free_dentry;
 
diff --git a/include/linux/elf.h b/include/linux/elf.h
index c9a46c4e183b..1c45ecf29147 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -88,13 +88,15 @@ struct arch_elf_state;
 #ifndef CONFIG_ARCH_USE_GNU_PROPERTY
 static inline int arch_parse_elf_property(u32 type, const void *data,
 					  size_t datasz, bool compat,
+					  bool has_interp, bool is_interp,
 					  struct arch_elf_state *arch)
 {
 	return 0;
 }
 #else
 extern int arch_parse_elf_property(u32 type, const void *data, size_t datasz,
-				   bool compat, struct arch_elf_state *arch);
+				   bool compat, bool has_interp, bool is_interp,
+				   struct arch_elf_state *arch);
 #endif
 
 #ifdef CONFIG_ARCH_HAVE_ELF_PROT
-- 
2.30.2

