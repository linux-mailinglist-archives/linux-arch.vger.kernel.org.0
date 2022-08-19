Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39455996E6
	for <lists+linux-arch@lfdr.de>; Fri, 19 Aug 2022 10:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347296AbiHSIRf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 04:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347582AbiHSIRH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 04:17:07 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 109E5E190D;
        Fri, 19 Aug 2022 01:17:03 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx32v5Rv9isI4EAA--.18159S2;
        Fri, 19 Aug 2022 16:16:57 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, hejinyang@loongson.cn,
        zhangqing@loongson.cn
Subject: [PATCH 6/9] LoongArch: modules/ftrace: Initialize PLT at load time
Date:   Fri, 19 Aug 2022 16:16:54 +0800
Message-Id: <20220819081657.7254-1-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx32v5Rv9isI4EAA--.18159S2
X-Coremail-Antispam: 1UD129KBjvJXoWfGF47Jr13WF1UJFW8ZF17GFg_yoWkXrWkpF
        9Fyrn5GrWUGrn3WFW09wn8ur1UWFZ7W342gFW7G34akr42qry5ZF10kr1qvFyFqw4DWFWS
        gayfur4UuFWUXw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
        42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjfU0yxRDUUUU
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

To Implement ftrace trampiones through plt entry.

Tested by forcing ftrace_make_call() to use the module PLT, and then
loading up a module after setting up ftrace with:

| echo ":mod:<module-name>" > set_ftrace_filter;
| echo function > current_tracer;
| modprobe <module-name>

Since FTRACE_ADDR/FTRACE_REGS_ADDR is only defined when CONFIG_DYNAMIC_FTRACE
is selected, we wrap its use along with most of module_init_ftrace_plt() with
ifdeffery rather than using IS_ENABLED().

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/include/asm/ftrace.h     |  4 ++
 arch/loongarch/include/asm/inst.h       |  2 +
 arch/loongarch/include/asm/module.h     | 14 +++--
 arch/loongarch/include/asm/module.lds.h |  1 +
 arch/loongarch/kernel/ftrace_dyn.c      | 79 +++++++++++++++++++++++++
 arch/loongarch/kernel/inst.c            | 12 ++++
 arch/loongarch/kernel/module-sections.c | 11 ++++
 arch/loongarch/kernel/module.c          | 48 +++++++++++++++
 8 files changed, 166 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
index a3f974a7a5ce..0ed3d649c1ba 100644
--- a/arch/loongarch/include/asm/ftrace.h
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -6,6 +6,10 @@
 #ifndef _ASM_LOONGARCH_FTRACE_H
 #define _ASM_LOONGARCH_FTRACE_H
 
+#define FTRACE_PLT_IDX		0
+#define FTRACE_REGS_PLT_IDX	1
+#define NR_FTRACE_PLTS		2
+
 #ifdef CONFIG_FUNCTION_TRACER
 #define MCOUNT_INSN_SIZE 4		/* sizeof mcount call */
 
diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 713b4996bfac..41cb15c4c475 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -52,6 +52,7 @@ enum reg2i12_op {
 };
 
 enum reg2i16_op {
+	addu16id_op     = 0x04,
 	jirl_op		= 0x13,
 	beq_op		= 0x16,
 	bne_op		= 0x17,
@@ -191,6 +192,7 @@ u32 larch_insn_gen_nop(void);
 u32 larch_insn_gen_b(unsigned long pc, unsigned long dest);
 u32 larch_insn_gen_bl(unsigned long pc, unsigned long dest);
 
+u32 larch_insn_gen_addu16id(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
 u32 larch_insn_gen_or(enum loongarch_gpr rd, enum loongarch_gpr rj,
 			enum loongarch_gpr rk);
 u32 larch_insn_gen_move(enum loongarch_gpr rd, enum loongarch_gpr rj);
diff --git a/arch/loongarch/include/asm/module.h b/arch/loongarch/include/asm/module.h
index 9f6718df1854..1aac156cd187 100644
--- a/arch/loongarch/include/asm/module.h
+++ b/arch/loongarch/include/asm/module.h
@@ -19,10 +19,13 @@ struct mod_section {
 struct mod_arch_specific {
 	struct mod_section plt;
 	struct mod_section plt_idx;
+
+	/* for CONFIG_DYNAMIC_FTRACE */
+	struct plt_entry *ftrace_trampolines;
 };
 
 struct plt_entry {
-	u32 inst_lu12iw;
+	u32 inst_addu16id;
 	u32 inst_lu32id;
 	u32 inst_lu52id;
 	u32 inst_jirl;
@@ -36,14 +39,15 @@ Elf_Addr module_emit_plt_entry(struct module *mod, unsigned long val);
 
 static inline struct plt_entry emit_plt_entry(unsigned long val)
 {
-	u32 lu12iw, lu32id, lu52id, jirl;
+	u32 addu16id, lu32id, lu52id, jirl;
 
-	lu12iw = (lu12iw_op << 25 | (((val >> 12) & 0xfffff) << 5) | LOONGARCH_GPR_T1);
+	addu16id = larch_insn_gen_addu16id(LOONGARCH_GPR_T1, LOONGARCH_GPR_ZERO,
+		ADDR_IMM(val, ADDU16ID));
 	lu32id = larch_insn_gen_lu32id(LOONGARCH_GPR_T1, ADDR_IMM(val, LU32ID));
 	lu52id = larch_insn_gen_lu52id(LOONGARCH_GPR_T1, LOONGARCH_GPR_T1, ADDR_IMM(val, LU52ID));
-	jirl = larch_insn_gen_jirl(0, LOONGARCH_GPR_T1, 0, (val & 0xfff));
+	jirl = larch_insn_gen_jirl(0, LOONGARCH_GPR_T1, 0, (val & 0xffff));
 
-	return (struct plt_entry) { lu12iw, lu32id, lu52id, jirl };
+	return (struct plt_entry) { addu16id, lu32id, lu52id, jirl };
 }
 
 static inline struct plt_idx_entry emit_plt_idx_entry(unsigned long val)
diff --git a/arch/loongarch/include/asm/module.lds.h b/arch/loongarch/include/asm/module.lds.h
index 31c1c0db11a3..ecff54b81754 100644
--- a/arch/loongarch/include/asm/module.lds.h
+++ b/arch/loongarch/include/asm/module.lds.h
@@ -4,4 +4,5 @@ SECTIONS {
 	. = ALIGN(4);
 	.plt : { BYTE(0) }
 	.plt.idx : { BYTE(0) }
+	.ftrace_trampoline : { BYTE(0) }
 }
diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
index ec3d951be50c..a7c36b92e558 100644
--- a/arch/loongarch/kernel/ftrace_dyn.c
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -9,6 +9,7 @@
 #include <linux/uaccess.h>
 
 #include <asm/inst.h>
+#include <asm/module.h>
 
 static int ftrace_modify_code(unsigned long pc, u32 old, u32 new,
 			      bool validate)
@@ -72,12 +73,63 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 	return ftrace_modify_code(pc, old, new, true);
 }
 
+static inline int __get_mod(struct module **mod, unsigned long addr)
+{
+	preempt_disable();
+	*mod = __module_text_address(addr);
+	preempt_enable();
+
+	if (WARN_ON(!(*mod)))
+		return -EINVAL;
+
+	return 0;
+}
+
+static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
+{
+	struct plt_entry *plt = mod->arch.ftrace_trampolines;
+
+	if (addr == FTRACE_ADDR)
+		return &plt[FTRACE_PLT_IDX];
+	if (addr == FTRACE_REGS_ADDR &&
+			IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
+		return &plt[FTRACE_REGS_PLT_IDX];
+
+	return NULL;
+}
+
+static unsigned long get_plt_addr(struct module *mod, unsigned long addr)
+{
+	struct plt_entry *plt;
+
+	plt = get_ftrace_plt(mod, addr);
+	if (!plt) {
+		pr_err("ftrace: no module PLT for %ps\n", (void *)addr);
+		return -EINVAL;
+	}
+
+	return (unsigned long)plt;
+}
+
 int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
 	unsigned long pc;
+	long offset;
 	u32 old, new;
 
 	pc = rec->ip + LOONGARCH_INSN_SIZE;
+	offset = (long)pc - (long)addr;
+
+	if (offset < -SZ_128M || offset >= SZ_128M) {
+		int ret;
+		struct module *mod;
+
+		ret = __get_mod(&mod, pc);
+		if (ret)
+			return ret;
+
+		addr = get_plt_addr(mod, addr);
+	}
 
 	old = larch_insn_gen_nop();
 	new = larch_insn_gen_bl(pc, addr);
@@ -89,9 +141,22 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 		    unsigned long addr)
 {
 	unsigned long pc;
+	long offset;
 	u32 old, new;
 
 	pc = rec->ip + LOONGARCH_INSN_SIZE;
+	offset = (long)pc - (long)addr;
+
+	if (offset < -SZ_128M || offset >= SZ_128M) {
+		int ret;
+		struct module *mod;
+
+		ret = __get_mod(&mod, pc);
+		if (ret)
+			return ret;
+
+		addr = get_plt_addr(mod, addr);
+	}
 
 	new = larch_insn_gen_nop();
 	old = larch_insn_gen_bl(pc, addr);
@@ -108,6 +173,20 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 	u32 old, new;
 
 	pc = rec->ip + LOONGARCH_INSN_SIZE;
+	offset = (long)pc - (long)addr;
+
+	if (offset < -SZ_128M || offset >= SZ_128M) {
+		int ret;
+		struct module *mod;
+
+		ret = __get_mod(&mod, pc);
+		if (ret)
+			return ret;
+
+		addr = get_plt_addr(mod, addr);
+
+		old_addr = get_plt_addr(mod, old_addr);
+	}
 
 	old = larch_insn_gen_bl(pc, old_addr);
 	new = larch_insn_gen_bl(pc, addr);
diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
index 4f7a62ddf210..9a1769620b25 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -103,6 +103,18 @@ u32 larch_insn_gen_bl(unsigned long pc, unsigned long dest)
 	return insn.word;
 }
 
+u32 larch_insn_gen_addu16id(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
+{
+	union loongarch_instruction insn;
+
+	insn.reg2i16_format.opcode = addu16id_op;
+	insn.reg2i16_format.rd = rd;
+	insn.reg2i16_format.rj = rj;
+	insn.reg2i16_format.immediate = imm;
+
+	return insn.word;
+}
+
 u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm)
 {
 	union loongarch_instruction insn;
diff --git a/arch/loongarch/kernel/module-sections.c b/arch/loongarch/kernel/module-sections.c
index 6d498288977d..b75fc711f144 100644
--- a/arch/loongarch/kernel/module-sections.c
+++ b/arch/loongarch/kernel/module-sections.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/elf.h>
+#include <linux/ftrace.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 
@@ -67,6 +68,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			      char *secstrings, struct module *mod)
 {
 	unsigned int i, num_plts = 0;
+	Elf_Shdr *tramp = NULL;
 
 	/*
 	 * Find the empty .plt sections.
@@ -76,6 +78,8 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			mod->arch.plt.shdr = sechdrs + i;
 		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt.idx"))
 			mod->arch.plt_idx.shdr = sechdrs + i;
+		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".ftrace_trampoline"))
+			tramp = sechdrs + i;
 	}
 
 	if (!mod->arch.plt.shdr) {
@@ -117,5 +121,12 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	mod->arch.plt_idx.num_entries = 0;
 	mod->arch.plt_idx.max_entries = num_plts;
 
+	if (tramp) {
+		tramp->sh_type = SHT_NOBITS;
+		tramp->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
+		tramp->sh_addralign = __alignof__(struct plt_entry);
+		tramp->sh_size = NR_FTRACE_PLTS * sizeof(struct plt_entry);
+	}
+
 	return 0;
 }
diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
index 638427ff0d51..acb75bccb6c5 100644
--- a/arch/loongarch/kernel/module.c
+++ b/arch/loongarch/kernel/module.c
@@ -10,6 +10,7 @@
 
 #include <linux/moduleloader.h>
 #include <linux/elf.h>
+#include <linux/ftrace.h>
 #include <linux/mm.h>
 #include <linux/numa.h>
 #include <linux/vmalloc.h>
@@ -17,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
+#include <asm/inst.h>
 
 static inline bool signed_imm_check(long val, unsigned int bit)
 {
@@ -373,3 +375,49 @@ void *module_alloc(unsigned long size)
 	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
 			GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE, __builtin_return_address(0));
 }
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+static const Elf_Shdr *find_section(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
+				    const char *name)
+{
+	const Elf_Shdr *s, *se;
+	const char *secstrs = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
+
+	for (s = sechdrs, se = sechdrs + hdr->e_shnum; s < se; s++) {
+		if (strcmp(name, secstrs + s->sh_name) == 0)
+			return s;
+	}
+
+	return NULL;
+}
+#endif
+
+static int module_init_ftrace_plt(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
+				  struct module *mod)
+{
+#ifdef CONFIG_DYNAMIC_FTRACE
+	const Elf_Shdr *s;
+	struct plt_entry *ftrace_plts;
+
+	s = find_section(hdr, sechdrs, ".ftrace_trampoline");
+	if (!s)
+		return -ENOEXEC;
+
+	ftrace_plts = (void *)s->sh_addr;
+
+	ftrace_plts[FTRACE_PLT_IDX] = emit_plt_entry(FTRACE_ADDR);
+
+	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS))
+		ftrace_plts[FTRACE_REGS_PLT_IDX] = emit_plt_entry(FTRACE_REGS_ADDR);
+
+	mod->arch.ftrace_trampolines = ftrace_plts;
+#endif
+	return 0;
+}
+
+int module_finalize(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs, struct module *mod)
+{
+	module_init_ftrace_plt(hdr, sechdrs, mod);
+
+	return 0;
+}
-- 
2.36.1

