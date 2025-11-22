Return-Path: <linux-arch+bounces-15042-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F2952C7C67D
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 05:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B62F8363A5D
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 04:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB9F23ABBE;
	Sat, 22 Nov 2025 04:40:08 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66E43A1C9;
	Sat, 22 Nov 2025 04:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763786407; cv=none; b=nBeYYYwrBME3VQNRDjsDVZyuSKQmmziS97vVeohdqw6p1AivwiXYuucd9VU5BT7AEP1WyYbySLah+jDbs+nHpeaSUwGPRHlxcZLjKM1ombXEbPJKrG6+zQ6sJOP03/SyKVv76owyNhD5dg/eRD75Uev15sxR8OaKsJfeuaRrLho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763786407; c=relaxed/simple;
	bh=aQx7HiOi3X1vk14M3py2qMHO/WxzFvSZYrjY6JZIBO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imyssmmX0aRIZvrPI8SsxWd2VhIMV48zCCJCMI5o0k0+8eM4bwb/Ois7Ijlf0hxrxbpfsjYZx8zPPzmSwhtxEsVoRqCAVZnxEw/4tDisvR229Tyj1TwhGszzLUJbxMv2e+3obMT/5Tj5hRWGNVH+T6xvrFQVUgl/Z3/5gv9Orvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221E0C4CEF5;
	Sat, 22 Nov 2025 04:40:04 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-arch@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V3 08/14] LoongArch: Adjust module loader for 32BIT/64BIT
Date: Sat, 22 Nov 2025 12:36:28 +0800
Message-ID: <20251122043634.3447854-9-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251122043634.3447854-1-chenhuacai@loongson.cn>
References: <20251122043634.3447854-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust module loader for both 32BIT and 64BIT, including: change the s64
type to long, change the u64 type to unsigned long, change the plt entry
definition and handling, etc.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/module.h | 11 ++++
 arch/loongarch/include/asm/percpu.h |  2 +-
 arch/loongarch/kernel/module.c      | 80 +++++++++++++++++------------
 3 files changed, 59 insertions(+), 34 deletions(-)

diff --git a/arch/loongarch/include/asm/module.h b/arch/loongarch/include/asm/module.h
index f33f3fd32ecc..d56a968273de 100644
--- a/arch/loongarch/include/asm/module.h
+++ b/arch/loongarch/include/asm/module.h
@@ -38,8 +38,10 @@ struct got_entry {
 
 struct plt_entry {
 	u32 inst_lu12iw;
+#ifdef CONFIG_64BIT
 	u32 inst_lu32id;
 	u32 inst_lu52id;
+#endif
 	u32 inst_jirl;
 };
 
@@ -57,6 +59,14 @@ static inline struct got_entry emit_got_entry(Elf_Addr val)
 
 static inline struct plt_entry emit_plt_entry(unsigned long val)
 {
+#ifdef CONFIG_32BIT
+	u32 lu12iw, jirl;
+
+	lu12iw = larch_insn_gen_lu12iw(LOONGARCH_GPR_T1, ADDR_IMM(val, LU12IW));
+	jirl = larch_insn_gen_jirl(0, LOONGARCH_GPR_T1, ADDR_IMM(val, ORI));
+
+	return (struct plt_entry) { lu12iw, jirl };
+#else
 	u32 lu12iw, lu32id, lu52id, jirl;
 
 	lu12iw = larch_insn_gen_lu12iw(LOONGARCH_GPR_T1, ADDR_IMM(val, LU12IW));
@@ -65,6 +75,7 @@ static inline struct plt_entry emit_plt_entry(unsigned long val)
 	jirl = larch_insn_gen_jirl(0, LOONGARCH_GPR_T1, ADDR_IMM(val, ORI));
 
 	return (struct plt_entry) { lu12iw, lu32id, lu52id, jirl };
+#endif
 }
 
 static inline struct plt_idx_entry emit_plt_idx_entry(unsigned long val)
diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/include/asm/percpu.h
index 44a8aea2b0e5..583f2466262f 100644
--- a/arch/loongarch/include/asm/percpu.h
+++ b/arch/loongarch/include/asm/percpu.h
@@ -13,7 +13,7 @@
  * the loading address of main kernel image, but far from where the modules are
  * loaded. Tell the compiler this fact when using explicit relocs.
  */
-#if defined(MODULE) && defined(CONFIG_AS_HAS_EXPLICIT_RELOCS)
+#if defined(MODULE) && defined(CONFIG_AS_HAS_EXPLICIT_RELOCS) && defined(CONFIG_64BIT)
 # if __has_attribute(model)
 #  define PER_CPU_ATTRIBUTES __attribute__((model("extreme")))
 # else
diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
index 36d6d9eeb7c7..27f6d6b2e3ff 100644
--- a/arch/loongarch/kernel/module.c
+++ b/arch/loongarch/kernel/module.c
@@ -22,72 +22,76 @@
 #include <asm/inst.h>
 #include <asm/unwind.h>
 
-static int rela_stack_push(s64 stack_value, s64 *rela_stack, size_t *rela_stack_top)
+static int rela_stack_push(long stack_value, long *rela_stack, size_t *rela_stack_top)
 {
 	if (*rela_stack_top >= RELA_STACK_DEPTH)
 		return -ENOEXEC;
 
 	rela_stack[(*rela_stack_top)++] = stack_value;
-	pr_debug("%s stack_value = 0x%llx\n", __func__, stack_value);
+	pr_debug("%s stack_value = 0x%lx\n", __func__, stack_value);
 
 	return 0;
 }
 
-static int rela_stack_pop(s64 *stack_value, s64 *rela_stack, size_t *rela_stack_top)
+static int rela_stack_pop(long *stack_value, long *rela_stack, size_t *rela_stack_top)
 {
 	if (*rela_stack_top == 0)
 		return -ENOEXEC;
 
 	*stack_value = rela_stack[--(*rela_stack_top)];
-	pr_debug("%s stack_value = 0x%llx\n", __func__, *stack_value);
+	pr_debug("%s stack_value = 0x%lx\n", __func__, *stack_value);
 
 	return 0;
 }
 
 static int apply_r_larch_none(struct module *mod, u32 *location, Elf_Addr v,
-			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
+			long *rela_stack, size_t *rela_stack_top, unsigned int type)
 {
 	return 0;
 }
 
 static int apply_r_larch_error(struct module *me, u32 *location, Elf_Addr v,
-			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
+			long *rela_stack, size_t *rela_stack_top, unsigned int type)
 {
 	pr_err("%s: Unsupport relocation type %u, please add its support.\n", me->name, type);
 	return -EINVAL;
 }
 
 static int apply_r_larch_32(struct module *mod, u32 *location, Elf_Addr v,
-			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
+			long *rela_stack, size_t *rela_stack_top, unsigned int type)
 {
 	*location = v;
 	return 0;
 }
 
+#ifdef CONFIG_32BIT
+#define apply_r_larch_64 apply_r_larch_error
+#else
 static int apply_r_larch_64(struct module *mod, u32 *location, Elf_Addr v,
-			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
+			long *rela_stack, size_t *rela_stack_top, unsigned int type)
 {
 	*(Elf_Addr *)location = v;
 	return 0;
 }
+#endif
 
 static int apply_r_larch_sop_push_pcrel(struct module *mod, u32 *location, Elf_Addr v,
-			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
+			long *rela_stack, size_t *rela_stack_top, unsigned int type)
 {
-	return rela_stack_push(v - (u64)location, rela_stack, rela_stack_top);
+	return rela_stack_push(v - (unsigned long)location, rela_stack, rela_stack_top);
 }
 
 static int apply_r_larch_sop_push_absolute(struct module *mod, u32 *location, Elf_Addr v,
-			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
+			long *rela_stack, size_t *rela_stack_top, unsigned int type)
 {
 	return rela_stack_push(v, rela_stack, rela_stack_top);
 }
 
 static int apply_r_larch_sop_push_dup(struct module *mod, u32 *location, Elf_Addr v,
-			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
+			long *rela_stack, size_t *rela_stack_top, unsigned int type)
 {
 	int err = 0;
-	s64 opr1;
+	long opr1;
 
 	err = rela_stack_pop(&opr1, rela_stack, rela_stack_top);
 	if (err)
@@ -104,7 +108,7 @@ static int apply_r_larch_sop_push_dup(struct module *mod, u32 *location, Elf_Add
 
 static int apply_r_larch_sop_push_plt_pcrel(struct module *mod,
 			Elf_Shdr *sechdrs, u32 *location, Elf_Addr v,
-			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
+			long *rela_stack, size_t *rela_stack_top, unsigned int type)
 {
 	ptrdiff_t offset = (void *)v - (void *)location;
 
@@ -118,10 +122,10 @@ static int apply_r_larch_sop_push_plt_pcrel(struct module *mod,
 }
 
 static int apply_r_larch_sop(struct module *mod, u32 *location, Elf_Addr v,
-			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
+			long *rela_stack, size_t *rela_stack_top, unsigned int type)
 {
 	int err = 0;
-	s64 opr1, opr2, opr3;
+	long opr1, opr2, opr3;
 
 	if (type == R_LARCH_SOP_IF_ELSE) {
 		err = rela_stack_pop(&opr3, rela_stack, rela_stack_top);
@@ -164,10 +168,10 @@ static int apply_r_larch_sop(struct module *mod, u32 *location, Elf_Addr v,
 }
 
 static int apply_r_larch_sop_imm_field(struct module *mod, u32 *location, Elf_Addr v,
-			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
+			long *rela_stack, size_t *rela_stack_top, unsigned int type)
 {
 	int err = 0;
-	s64 opr1;
+	long opr1;
 	union loongarch_instruction *insn = (union loongarch_instruction *)location;
 
 	err = rela_stack_pop(&opr1, rela_stack, rela_stack_top);
@@ -244,31 +248,33 @@ static int apply_r_larch_sop_imm_field(struct module *mod, u32 *location, Elf_Ad
 	}
 
 overflow:
-	pr_err("module %s: opr1 = 0x%llx overflow! dangerous %s (%u) relocation\n",
+	pr_err("module %s: opr1 = 0x%lx overflow! dangerous %s (%u) relocation\n",
 		mod->name, opr1, __func__, type);
 	return -ENOEXEC;
 
 unaligned:
-	pr_err("module %s: opr1 = 0x%llx unaligned! dangerous %s (%u) relocation\n",
+	pr_err("module %s: opr1 = 0x%lx unaligned! dangerous %s (%u) relocation\n",
 		mod->name, opr1, __func__, type);
 	return -ENOEXEC;
 }
 
 static int apply_r_larch_add_sub(struct module *mod, u32 *location, Elf_Addr v,
-			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
+			long *rela_stack, size_t *rela_stack_top, unsigned int type)
 {
 	switch (type) {
 	case R_LARCH_ADD32:
 		*(s32 *)location += v;
 		return 0;
-	case R_LARCH_ADD64:
-		*(s64 *)location += v;
-		return 0;
 	case R_LARCH_SUB32:
 		*(s32 *)location -= v;
 		return 0;
+#ifdef CONFIG_64BIT
+	case R_LARCH_ADD64:
+		*(s64 *)location += v;
+		return 0;
 	case R_LARCH_SUB64:
 		*(s64 *)location -= v;
+#endif
 		return 0;
 	default:
 		pr_err("%s: Unsupport relocation type %u\n", mod->name, type);
@@ -278,7 +284,7 @@ static int apply_r_larch_add_sub(struct module *mod, u32 *location, Elf_Addr v,
 
 static int apply_r_larch_b26(struct module *mod,
 			Elf_Shdr *sechdrs, u32 *location, Elf_Addr v,
-			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
+			long *rela_stack, size_t *rela_stack_top, unsigned int type)
 {
 	ptrdiff_t offset = (void *)v - (void *)location;
 	union loongarch_instruction *insn = (union loongarch_instruction *)location;
@@ -311,14 +317,16 @@ static int apply_r_larch_b26(struct module *mod,
 }
 
 static int apply_r_larch_pcala(struct module *mod, u32 *location, Elf_Addr v,
-			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
+			long *rela_stack, size_t *rela_stack_top, unsigned int type)
 {
 	union loongarch_instruction *insn = (union loongarch_instruction *)location;
 	/* Use s32 for a sign-extension deliberately. */
 	s32 offset_hi20 = (void *)((v + 0x800) & ~0xfff) -
 			  (void *)((Elf_Addr)location & ~0xfff);
+#ifdef CONFIG_64BIT
 	Elf_Addr anchor = (((Elf_Addr)location) & ~0xfff) + offset_hi20;
 	ptrdiff_t offset_rem = (void *)v - (void *)anchor;
+#endif
 
 	switch (type) {
 	case R_LARCH_PCALA_LO12:
@@ -328,6 +336,7 @@ static int apply_r_larch_pcala(struct module *mod, u32 *location, Elf_Addr v,
 		v = offset_hi20 >> 12;
 		insn->reg1i20_format.immediate = v & 0xfffff;
 		break;
+#ifdef CONFIG_64BIT
 	case R_LARCH_PCALA64_LO20:
 		v = offset_rem >> 32;
 		insn->reg1i20_format.immediate = v & 0xfffff;
@@ -336,6 +345,7 @@ static int apply_r_larch_pcala(struct module *mod, u32 *location, Elf_Addr v,
 		v = offset_rem >> 52;
 		insn->reg2i12_format.immediate = v & 0xfff;
 		break;
+#endif
 	default:
 		pr_err("%s: Unsupport relocation type %u\n", mod->name, type);
 		return -EINVAL;
@@ -346,7 +356,7 @@ static int apply_r_larch_pcala(struct module *mod, u32 *location, Elf_Addr v,
 
 static int apply_r_larch_got_pc(struct module *mod,
 			Elf_Shdr *sechdrs, u32 *location, Elf_Addr v,
-			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
+			long *rela_stack, size_t *rela_stack_top, unsigned int type)
 {
 	Elf_Addr got = module_emit_got_entry(mod, sechdrs, v);
 
@@ -369,7 +379,7 @@ static int apply_r_larch_got_pc(struct module *mod,
 }
 
 static int apply_r_larch_32_pcrel(struct module *mod, u32 *location, Elf_Addr v,
-				  s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
+				  long *rela_stack, size_t *rela_stack_top, unsigned int type)
 {
 	ptrdiff_t offset = (void *)v - (void *)location;
 
@@ -377,14 +387,18 @@ static int apply_r_larch_32_pcrel(struct module *mod, u32 *location, Elf_Addr v,
 	return 0;
 }
 
+#ifdef CONFIG_32BIT
+#define apply_r_larch_64_pcrel apply_r_larch_error
+#else
 static int apply_r_larch_64_pcrel(struct module *mod, u32 *location, Elf_Addr v,
-				  s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
+				  long *rela_stack, size_t *rela_stack_top, unsigned int type)
 {
 	ptrdiff_t offset = (void *)v - (void *)location;
 
 	*(u64 *)location = offset;
 	return 0;
 }
+#endif
 
 /*
  * reloc_handlers_rela() - Apply a particular relocation to a module
@@ -397,7 +411,7 @@ static int apply_r_larch_64_pcrel(struct module *mod, u32 *location, Elf_Addr v,
  * Return: 0 upon success, else -ERRNO
  */
 typedef int (*reloc_rela_handler)(struct module *mod, u32 *location, Elf_Addr v,
-			s64 *rela_stack, size_t *rela_stack_top, unsigned int type);
+			long *rela_stack, size_t *rela_stack_top, unsigned int type);
 
 /* The handlers for known reloc types */
 static reloc_rela_handler reloc_rela_handlers[] = {
@@ -425,7 +439,7 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 {
 	int i, err;
 	unsigned int type;
-	s64 rela_stack[RELA_STACK_DEPTH];
+	long rela_stack[RELA_STACK_DEPTH];
 	size_t rela_stack_top = 0;
 	reloc_rela_handler handler;
 	void *location;
@@ -462,9 +476,9 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 			return -EINVAL;
 		}
 
-		pr_debug("type %d st_value %llx r_addend %llx loc %llx\n",
+		pr_debug("type %d st_value %lx r_addend %lx loc %lx\n",
 		       (int)ELF_R_TYPE(rel[i].r_info),
-		       sym->st_value, rel[i].r_addend, (u64)location);
+		       (unsigned long)sym->st_value, (unsigned long)rel[i].r_addend, (unsigned long)location);
 
 		v = sym->st_value + rel[i].r_addend;
 		switch (type) {
-- 
2.47.3


