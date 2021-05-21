Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C455838C986
	for <lists+linux-arch@lfdr.de>; Fri, 21 May 2021 16:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbhEUOwP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 10:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232057AbhEUOwP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 10:52:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E181F61244;
        Fri, 21 May 2021 14:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621608652;
        bh=G5fA81JEIyxf+M2K0se19yfxqapszMVGJu5iBjN/rtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B3JxskFpfB9iB+wbzAa4PhHuH4nRsrE0/a6Pn8j1SHeFH7cl8iLjFicEbesKwNxwS
         d7NMMgVGP06o1Ay1Bmw6kHPVjsqTC5k9bGgp1/ufgRlbe/oPOd9sJjLcnWYon0J/A6
         yDFtqobm1EYLy03gtXRR5+V62gLaJpsp0YuJeKzubI4N4idWyDPbLKF+rswXSBxNva
         k/OmhFJ4frJSmCPa+bbX/cHpW5pQ2y+LZwIH9Z+VwLs8WLpHwJK7+cvfFj5RVamomI
         08Ldo3lW0Gj9IEA+KhqcCoeyIF2nfEOwUfzakbecp6HkT1IOsQfOGOaQeD5cN5AWmV
         6eIxJDsehsOqA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, libc-alpha@sourceware.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/2] elf: Allow architectures to parse properties on the main executable
Date:   Fri, 21 May 2021 15:46:20 +0100
Message-Id: <20210521144621.9306-2-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210521144621.9306-1-broonie@kernel.org>
References: <20210521144621.9306-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5445; h=from:subject; bh=G5fA81JEIyxf+M2K0se19yfxqapszMVGJu5iBjN/rtQ=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBgp8e6e0g4Ba7kOqu+BRX+NDPWX+ROI7NqnVTvDQiL Z7h39pCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYKfHugAKCRAk1otyXVSH0MoJB/ 9aHsVEDosHoGnVeqTvlQrQd58T1bPPHq6AEfIf8fE5E/t8hmDhu+uStuIW4F7sljABj+6VrE05I1r9 ohBUcW/G9MxVTySzTEuYek6MBcM3NI3uRsJUN647V0LJlWgEzGqcNvLNluEPUBpgGQQg6TtpeMr62V RtDEIbFrZd4h/liK9xTmvJf6JxiewgW5S4WNMbejq05gPcEmc1NLJzpPQoga4dcrzVume29RgyWM0T +c9mvIi+yrZZx09RWMwBIyN9RlDita5gq1H8gbTb6ZjWYbfKRQkXFZVu+hYAw92bWZ29XMQygMQqdG x6QB9f9AWLg5dtGUgzSzQIovAq98Bn
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
main executable, adjusting arch_parse_elf_properties() to have an is_interp
flag as with arch_elf_adjust_prot() and calling it for both the main
executable and any intepreter.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/elf.h |  3 ++-
 fs/binfmt_elf.c              | 25 +++++++++++++++++--------
 include/linux/elf.h          |  4 +++-
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 8d1c8dcb87fd..c8678a8c36d5 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -261,6 +261,7 @@ struct arch_elf_state {
 
 static inline int arch_parse_elf_property(u32 type, const void *data,
 					  size_t datasz, bool compat,
+					  bool is_interp,
 					  struct arch_elf_state *arch)
 {
 	/* No known properties for AArch32 yet */
@@ -273,7 +274,7 @@ static inline int arch_parse_elf_property(u32 type, const void *data,
 		if (datasz != sizeof(*p))
 			return -ENOEXEC;
 
-		if (system_supports_bti() &&
+		if (system_supports_bti() && is_interp &&
 		    (*p & GNU_PROPERTY_AARCH64_FEATURE_1_BTI))
 			arch->flags |= ARM64_ELF_BTI;
 	}
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 187b3f2b9202..c8397664af39 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -716,7 +716,7 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
  */
 
 static int parse_elf_property(const char *data, size_t *off, size_t datasz,
-			      struct arch_elf_state *arch,
+			      struct arch_elf_state *arch, bool is_interp,
 			      bool have_prev_type, u32 *prev_type)
 {
 	size_t o, step;
@@ -751,7 +751,8 @@ static int parse_elf_property(const char *data, size_t *off, size_t datasz,
 	*prev_type = pr->pr_type;
 
 	ret = arch_parse_elf_property(pr->pr_type, data + o,
-				      pr->pr_datasz, ELF_COMPAT, arch);
+				      pr->pr_datasz, ELF_COMPAT, is_interp,
+				      arch);
 	if (ret)
 		return ret;
 
@@ -764,7 +765,7 @@ static int parse_elf_property(const char *data, size_t *off, size_t datasz,
 #define NOTE_NAME_SZ (sizeof(GNU_PROPERTY_TYPE_0_NAME))
 
 static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
-				struct arch_elf_state *arch)
+				bool is_interp, struct arch_elf_state *arch)
 {
 	union {
 		struct elf_note nhdr;
@@ -813,7 +814,8 @@ static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
 	have_prev_type = false;
 	do {
 		ret = parse_elf_property(note.data, &off, datasz, arch,
-					 have_prev_type, &prev_type);
+					 is_interp, have_prev_type,
+					 &prev_type);
 		have_prev_type = true;
 	} while (!ret);
 
@@ -828,6 +830,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	unsigned long error;
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
 	struct elf_phdr *elf_property_phdata = NULL;
+	struct elf_phdr *interp_elf_property_phdata = NULL;
 	unsigned long elf_bss, elf_brk;
 	int bss_prot = 0;
 	int retval, i;
@@ -963,12 +966,11 @@ static int load_elf_binary(struct linux_binprm *bprm)
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
@@ -979,10 +981,17 @@ static int load_elf_binary(struct linux_binprm *bprm)
 					goto out_free_dentry;
 				break;
 			}
+
+		retval = parse_elf_properties(interpreter,
+					      interp_elf_property_phdata,
+					      true, &arch_state);
+		if (retval)
+			goto out_free_dentry;
+
 	}
 
-	retval = parse_elf_properties(interpreter ?: bprm->file,
-				      elf_property_phdata, &arch_state);
+	retval = parse_elf_properties(bprm->file, elf_property_phdata,
+				      false, &arch_state);
 	if (retval)
 		goto out_free_dentry;
 
diff --git a/include/linux/elf.h b/include/linux/elf.h
index c9a46c4e183b..a20dcdcd86c5 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -88,13 +88,15 @@ struct arch_elf_state;
 #ifndef CONFIG_ARCH_USE_GNU_PROPERTY
 static inline int arch_parse_elf_property(u32 type, const void *data,
 					  size_t datasz, bool compat,
+					  bool is_interp,
 					  struct arch_elf_state *arch)
 {
 	return 0;
 }
 #else
 extern int arch_parse_elf_property(u32 type, const void *data, size_t datasz,
-				   bool compat, struct arch_elf_state *arch);
+				   bool compat, bool is_interp,
+				   struct arch_elf_state *arch);
 #endif
 
 #ifdef CONFIG_ARCH_HAVE_ELF_PROT
-- 
2.20.1

