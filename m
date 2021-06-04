Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D5939B7D5
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 13:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhFDL0x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 07:26:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhFDL0w (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 07:26:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1056761400;
        Fri,  4 Jun 2021 11:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622805906;
        bh=LNACwJUpIU4MPbvpihqdu3nHssLIcfhkB5anWmhpnGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f1wQJb+QYoHiDmYa/XlAyaFZPzjwkVc79czV9Wmu0ZiG78LDhE8U4rKP+jDJeMX8b
         wLwGNzPC7rAjP62d3YmQphhfkWLyeMWZYPzhaFU0fx9rO/JZQQxJ9JKwPoDPfm4bWC
         i6kZ9NnLBmbix8ZglVlgq3zGCSjNKyxujBDG/DQuxaAVCASIvk/HDef0C3j6kxHA41
         Dfz4om+hcvMEFttBkALw5LZbqJgJKd2h7WovCNYuZyqfRcwID7jgT9ak/s6ewzsd3d
         WlA0nE/4PeQmzgsFARL6W8OX1v6nOtu2UjEiHGixhLHb4Au2nPQrkg/mMJb0Df3///
         UBgXYt7emd9yg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/3] elf: Allow architectures to parse properties on the main executable
Date:   Fri,  4 Jun 2021 12:24:48 +0100
Message-Id: <20210604112450.13344-2-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210604112450.13344-1-broonie@kernel.org>
References: <20210604112450.13344-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5627; h=from:subject; bh=LNACwJUpIU4MPbvpihqdu3nHssLIcfhkB5anWmhpnGw=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBgug2AyEMyESqgyCI9Tpe30MOzC1TtuJIcNi2nFECQ SYLC/N2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYLoNgAAKCRAk1otyXVSH0LPAB/ 9xmukw5tKSV3VrKJU4BoaxlEHxpBRTnYxbKPuzIB4gtC49GFT+lKvBYqXItYHeaOJkLOh9lmGIm9ya fcFn8Pl/EyhHffcyP3JIWzWBOsG+imfNDvrMCJX85mcw1SetjDJGUE5lzsxeBrXJhZZag9wbHCxHx+ hV37aRlYaOTYMHLqbnqh8q8pzIKCYMcpJPCVa2KkUCOK5aNufYxXXZPeMbHfJVQnOdHnZpgWrKqLfO REnv9cfMZkumy8hlFHKaK9XnPfqENQcKoKJYKOFtflIL9e667YaqREF0GUQWVHb6ga542DOzfggbc9 zB74336S0qcRxY9G1+xMNtHTUCU/xD
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
 fs/binfmt_elf.c              | 27 +++++++++++++++++++--------
 include/linux/elf.h          |  4 +++-
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 8d1c8dcb87fd..a488a1329b16 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -261,6 +261,7 @@ struct arch_elf_state {
 
 static inline int arch_parse_elf_property(u32 type, const void *data,
 					  size_t datasz, bool compat,
+					  bool has_interp, bool is_interp,
 					  struct arch_elf_state *arch)
 {
 	/* No known properties for AArch32 yet */
@@ -273,7 +274,7 @@ static inline int arch_parse_elf_property(u32 type, const void *data,
 		if (datasz != sizeof(*p))
 			return -ENOEXEC;
 
-		if (system_supports_bti() &&
+		if (system_supports_bti() && has_interp == is_interp &&
 		    (*p & GNU_PROPERTY_AARCH64_FEATURE_1_BTI))
 			arch->flags |= ARM64_ELF_BTI;
 	}
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 187b3f2b9202..253ca9969345 100644
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
2.20.1

