Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA350450841
	for <lists+linux-arch@lfdr.de>; Mon, 15 Nov 2021 16:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhKOPaW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Nov 2021 10:30:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:51748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235326AbhKOPaV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 15 Nov 2021 10:30:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BB93611BF;
        Mon, 15 Nov 2021 15:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636990046;
        bh=lABzqA8s9esZMvDdLtam2OJTFo66NW6WzdinTrCHF6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gP6NJoHJ1Z7xstcRs0yhhwEHfdfgRR7yq8uZR4FsYY2kvEwXjNvwEyQctwwWdJmem
         wi9kTJnE4S/X4dG8xbWcndwZfQ8wC9CsmIcu9o9Z84MkliXFtx5+5Xl6iWvcQvB/8Y
         wTGrEAICA1pmXEMNXOb3EnLBiDVw/sGjXKFfGjX0rIWXHT3jPGKG8n9zm9RXjh7CNY
         gslpN3Z8Wd9N9sQilZebcTGMwYXh1NcrcUGqmDv6j5TUbUKRZZl3ceKLZzh/epo6th
         CMKhPOxZz6cfz6tabJJEiLG48G0l1HOlj9zbUAE9jFnCAmEwxs+FWEU9X/pOkP/MY7
         kLUboc8pUj1cw==
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
Subject: [PATCH v7 1/4] elf: Allow architectures to parse properties on the main executable
Date:   Mon, 15 Nov 2021 15:27:11 +0000
Message-Id: <20211115152714.3205552-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211115152714.3205552-1-broonie@kernel.org>
References: <20211115152714.3205552-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5824; h=from:subject; bh=lABzqA8s9esZMvDdLtam2OJTFo66NW6WzdinTrCHF6o=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhknxLaie3JsMJ6cyrgGXw5RxqXHE5rN6FzNUopRCJ Dirq82CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYZJ8SwAKCRAk1otyXVSH0H1ZB/ 953ucOH/N5mdxpzOgXD8gIc2hEr70MzTJHaUXTNwKDKCYVCcM0UqbBDo/7w+psfnT3CLOQF8Lj/ljU LxtpQslqJ64qbaD7IMl9sgbc+/FlpUED6/qsLbsNsykZ/7KHGxbalZJPb2NTTu9Lekl9JrOCoMIPvD e5ynhmp8dvnhIddcpJJwTcLP66i2P3A4pUkU864JLsbCWd26xCoNB4PDZgKhPEfHivWZ+wchvr/TCY M92+jA+2LdPsDIypxSteLd2SvjafFfWpoIebw5wkyDEiUCQYy0qRPxefp42kT+8LKCKdXhyF6xfspL COgoKhbE2/P4xB7MkdPAr+OifWLVpL
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
index f8c7f26f1fbb..fb9c24a63c62 100644
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

