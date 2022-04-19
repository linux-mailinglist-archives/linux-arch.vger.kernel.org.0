Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F58650692A
	for <lists+linux-arch@lfdr.de>; Tue, 19 Apr 2022 12:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbiDSKyu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Apr 2022 06:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiDSKyt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Apr 2022 06:54:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D781DA6A
        for <linux-arch@vger.kernel.org>; Tue, 19 Apr 2022 03:52:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE07B610F4
        for <linux-arch@vger.kernel.org>; Tue, 19 Apr 2022 10:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71350C385A8;
        Tue, 19 Apr 2022 10:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650365526;
        bh=NCzXe13FcVx4VA66g8hUUmNVgp9mtHr0Kq/SFND26Mo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=efm2d1e8sKCZbK0IHSd6bJ2pw30sCC1TMiHn3nFNUcE6t1qAV6TsId7lLltDXMgGt
         nwUYqy1+VJ7r9MD16Zwg6qN39u7Bo9YY/tnEy3QpJp1mI7O11Ht1E1uNgVtOh27K8a
         JJRnrKtA8cKsDAT9Gn2FvzSoGjh24wHXTlygmmaHHlk+8CC26vcrl1gHVRdpRRAG1W
         e5eSBKKEonWZFSdy0685Pnp8EZHWio4F2EvNaLmFeFWLVfvIOHpagiOv3BD7atoFEo
         IqIs6UUY4+zCw6rHEaPuwSoPZcfGMO+Sn33ZhW29C/NfhbxQHNXS7rGJMN1s9JEu2G
         bgT3zuRc6Jshg==
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
        libc-alpha@sourceware.org, Mark Brown <broonie@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v13 1/2] elf: Allow architectures to parse properties on the main executable
Date:   Tue, 19 Apr 2022 11:51:55 +0100
Message-Id: <20220419105156.347168-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419105156.347168-1-broonie@kernel.org>
References: <20220419105156.347168-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6534; h=from:subject; bh=NCzXe13FcVx4VA66g8hUUmNVgp9mtHr0Kq/SFND26Mo=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXpRKDQo096nWiJD5RNV0UNPsGraLKTlFa+rOrepO I5dOJKSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl6USgAKCRAk1otyXVSH0DFeB/ 4mM8UgJboA3Ke3r8IZZL2C8G/JiklUTVnURTN8ciKtasiqznoNXcVgEpcYIzcHSVO5MvVmX21quuEm bOV5TYkHIpBwQuSMjSNIwtKgh118doM+MY9G0T+4BhEVcC9/r4Pw26L8MrTFIfQwxvBxUrZQWlYv0I APIWzhID1t7HnDvPE9TJVSR7DEtv9XQPfwsFbY8MmD3GROCwviwb4PIklKpZuteXhu6qovIa7cv+Ow QvzVtAwXfix+wmEJzj2E9P76vbAdSP6oDkcB39K2VlLqM94FKJ4ZjAnw6KqC7VMb2jlPZqCrXfgjoF qXagbB/fMdIOa7PyxIJaWLb9CJ3dhF
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/elf.h |  3 ++-
 fs/binfmt_elf.c              | 34 ++++++++++++++++++++++++----------
 include/linux/elf.h          |  4 +++-
 3 files changed, 29 insertions(+), 12 deletions(-)

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
index 63c7ebb0da89..ed09918d6d69 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -717,8 +717,9 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
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
@@ -752,7 +753,8 @@ static int parse_elf_property(const char *data, size_t *off, size_t datasz,
 	*prev_type = pr->pr_type;
 
 	ret = arch_parse_elf_property(pr->pr_type, data + o,
-				      pr->pr_datasz, ELF_COMPAT, arch);
+				      pr->pr_datasz, ELF_COMPAT,
+				      has_interp, is_interp, arch);
 	if (ret)
 		return ret;
 
@@ -765,6 +767,7 @@ static int parse_elf_property(const char *data, size_t *off, size_t datasz,
 #define NOTE_NAME_SZ (sizeof(GNU_PROPERTY_TYPE_0_NAME))
 
 static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
+				bool has_interp, bool is_interp,
 				struct arch_elf_state *arch)
 {
 	union {
@@ -814,7 +817,8 @@ static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
 	have_prev_type = false;
 	do {
 		ret = parse_elf_property(note.data, &off, datasz, arch,
-					 have_prev_type, &prev_type);
+					 has_interp, is_interp, have_prev_type,
+					 &prev_type);
 		have_prev_type = true;
 	} while (!ret);
 
@@ -829,6 +833,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	unsigned long error;
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
 	struct elf_phdr *elf_property_phdata = NULL;
+	struct elf_phdr *interp_elf_property_phdata = NULL;
 	unsigned long elf_bss, elf_brk;
 	int bss_prot = 0;
 	int retval, i;
@@ -866,12 +871,15 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	for (i = 0; i < elf_ex->e_phnum; i++, elf_ppnt++) {
 		char *elf_interpreter;
 
+		if (interpreter && elf_property_phdata)
+			break;
+
 		if (elf_ppnt->p_type == PT_GNU_PROPERTY) {
 			elf_property_phdata = elf_ppnt;
 			continue;
 		}
 
-		if (elf_ppnt->p_type != PT_INTERP)
+		if (interpreter || elf_ppnt->p_type != PT_INTERP)
 			continue;
 
 		/*
@@ -920,7 +928,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		if (retval < 0)
 			goto out_free_dentry;
 
-		break;
+		continue;
 
 out_free_interp:
 		kfree(elf_interpreter);
@@ -964,12 +972,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
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
@@ -980,10 +987,17 @@ static int load_elf_binary(struct linux_binprm *bprm)
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

