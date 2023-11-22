Return-Path: <linux-arch+bounces-405-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E81F37F532F
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 23:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158091C20B9D
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 22:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503781F607;
	Wed, 22 Nov 2023 22:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnRtUw8X"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309D21EB5D;
	Wed, 22 Nov 2023 22:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08027C433C7;
	Wed, 22 Nov 2023 22:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700691498;
	bh=ws1Ff4m0CKCCq0jXhgKcjSJUFMraCUT/nm4UVOCqQhg=;
	h=From:To:Subject:Date:From;
	b=MnRtUw8X3gSrnR4ewx0D7eQFlF/xgxYpOjxKQacMBWCSRCV7x723FAvZoKflnETfq
	 k+C0t093EYIm5mFUewviwcIDElWj3mtj8tBpgPmK64TPlpRBT2u5Lps79fcjl3A17M
	 rHfNpZgdL7OXmTveLM+bMatiiXCWA60N5nrKywoSSRe1EmUjYjp7/kc+ZiKoD95d26
	 EPY9qyqkrPnBBjJIHlOrrxakF21t/DOoB9qyFIq66giwOXxXcqBCmbZllXVKIzvRW+
	 qiQbnu8oRCFX60z4egRwlG+IpKoKk0gwfYTsRtibdEZYYJ0nflIA0HVaCg4kZoTVtS
	 R1CkMfn9JsCjg==
From: deller@kernel.org
To: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-modules@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/4] Section alignment issues?
Date: Wed, 22 Nov 2023 23:18:10 +0100
Message-ID: <20231122221814.139916-1-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Helge Deller <deller@gmx.de>

While working on the 64-bit parisc kernel, I noticed that the __ksymtab[]
table was not correctly 64-bit aligned in many modules.
The following patches do fix some of those issues in the generic code.

But further investigation shows that multiple sections in the kernel and in
modules are possibly not correctly aligned, and thus may lead to performance
degregations at runtime (small on x86, huge on parisc, sparc and others which
need exception handlers). Sometimes wrong alignments may also be simply hidden
by the linker or kernel module loader which pulls in the sections by luck with
a correct alignment (e.g. because the previous section was aligned already).

An objdump on a x86 module shows e.g.:

./kernel/net/netfilter/nf_log_syslog.ko:     file format elf64-x86-64
Sections:
Idx Name          Size      VMA               LMA               File off  Algn
  0 .text         00001fdf  0000000000000000  0000000000000000  00000040  2**4
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  1 .init.text    000000f6  0000000000000000  0000000000000000  00002020  2**4
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  2 .exit.text    0000005c  0000000000000000  0000000000000000  00002120  2**4
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
  3 .rodata.str1.8 000000dc  0000000000000000  0000000000000000  00002180  2**3
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  4 .rodata.str1.1 0000030a  0000000000000000  0000000000000000  0000225c  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  5 .rodata       000000b0  0000000000000000  0000000000000000  00002580  2**5
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  6 .modinfo      0000019e  0000000000000000  0000000000000000  00002630  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  7 .return_sites 00000034  0000000000000000  0000000000000000  000027ce  2**0
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
  8 .call_sites   0000029c  0000000000000000  0000000000000000  00002802  2**0
                  CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA

In this example I believe the ".return_sites" and ".call_sites" should have
an alignment of at least 32-bit (4 bytes).

On other architectures or modules other sections like ".altinstructions" or
"__ex_table" may show up wrongly instead.

In general I think it would be beneficial to search for wrong alignments at
link time, and maybe at runtime.

The patch at the end of this cover letter
- adds compile time checks to the "modpost" tool, and
- adds a runtime check to the kernel module loader at runtime.
And it will possibly show false positives too (!!!)
I do understand that some of those sections are not performce critical
and thus any alignment is OK.

The modpost patch will emit at compile time such warnings (on x86-64 kernel build):

WARNING: modpost: vmlinux: section .initcall7.init (type 1, flags 2) has alignment of 1, expected at least 4.
Maybe you need to add ALIGN() to the modules.lds file (or fix modpost) ?
WARNING: modpost: vmlinux: section .altinstructions (type 1, flags 2) has alignment of 1, expected at least 2.
WARNING: modpost: vmlinux: section .initcall6.init (type 1, flags 2) has alignment of 1, expected at least 4.
WARNING: modpost: vmlinux: section .initcallearly.init (type 1, flags 2) has alignment of 1, expected at least 4.
WARNING: modpost: vmlinux: section .rodata.cst2 (type 1, flags 18) has alignment of 2, expected at least 64.
WARNING: modpost: vmlinux: section .static_call_tramp_key (type 1, flags 2) has alignment of 1, expected at least 8.
WARNING: modpost: vmlinux: section .con_initcall.init (type 1, flags 2) has alignment of 1, expected at least 8.
WARNING: modpost: vmlinux: section __bug_table (type 1, flags 3) has alignment of 1, expected at least 4.
...

while the kernel module loader may show at runtime:

** WARNING **:   module: efivarfs, dest=0xffffffffc02d08d2, section=.retpoline_sites possibly not correctly aligned.
** WARNING **:   module: efivarfs, dest=0xffffffffc02d0bae, section=.ibt_endbr_seal possibly not correctly aligned.
** WARNING **:   module: efivarfs, dest=0xffffffffc02d0be6, section=.orc_unwind possibly not correctly aligned.
** WARNING **:   module: efivarfs, dest=0xffffffffc02d12a6, section=.orc_unwind_ip possibly not correctly aligned.
** WARNING **:   module: efivarfs, dest=0xffffffffc02d178c, section=.note.Linux possibly not correctly aligned.
** WARNING **:   module: efivarfs, dest=0xffffffffc02d17bc, section=.orc_header possibly not correctly aligned.
** WARNING **:   module: xt_addrtype, dest=0xffffffffc01ef18a, size=0x00000020, section=.return_sites

My questions:
- Am I wrong with my analysis?
- What does people see on other architectures?
- Does it make sense to add a compile- and runtime-check, like the patch below, to the kernel?

Helge

---

From: Helge Deller <deller@gmx.de>
Subject: [PATCH] MODPOST: Detect and report possible section alignment issues

IMPORTANT: THIS PATCH IS NOT INTENDED TO BE APPLIED !!!!

The main idea here is to check at compile time (during modpost run) and at
runtime (when loading a module) if the sections in kernel modules (and
vmlinux) are correctly aligned in memory and report if a wrong alignment is
suspected.

It WILL report false positives. Many section names still need to be added to
the various tables.
But even at this stage it gives some insight at the various possibly wrong
section alignments.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 98fedfdb8db5..88201d6b0c17 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2277,6 +2277,10 @@ static int move_module(struct module *mod, struct load_info *info)
 				ret = -ENOEXEC;
 				goto out_enomem;
 			}
+			if (((uintptr_t)dest) & (BITS_PER_LONG/8 - 1)) {
+				printk("** WARNING **: \tmodule: %s, dest=0x%lx, section=%s possibly not correctly aligned.\n",
+					mod->name, (long)dest, info->secstrings + shdr->sh_name);
+			}
 			memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);
 		}
 		/*
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 739402f45509..2add144a05e3 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -49,6 +49,8 @@ modpost-args =										\
 	$(if $(KBUILD_NSDEPS),-d $(MODULES_NSDEPS))					\
 	$(if $(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS)$(KBUILD_NSDEPS),-N)	\
 	$(if $(findstring 1, $(KBUILD_EXTRA_WARN)),-W)					\
+	$(if $(CONFIG_64BIT),-6)							\
+	$(if $(CONFIG_HAVE_ARCH_PREL32_RELOCATIONS),-R)					\
 	-o $@

 modpost-deps := $(MODPOST)
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index cb6406f485a9..70c69db6a17c 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -43,6 +43,10 @@ static bool ignore_missing_files;
 /* If set to 1, only warn (instead of error) about missing ns imports */
 static bool allow_missing_ns_imports;

+/* is target a 64-bit platform and has it prel32 relocation support? */
+static bool target_64bit;
+static bool target_prel32_relocations;
+
 static bool error_occurred;

 static bool extra_warn;
@@ -1493,6 +1497,76 @@ static void check_sec_ref(struct module *mod, struct elf_info *elf)
 	}
 }

+/**
+ * Check alignment of sections in modules.
+ **/
+static void check_sec_alignment(struct module *mod, struct elf_info *elf)
+{
+	/* sections that may use PREL32 relocations and only need 4-byte alignment */
+	static const char *const prel32_sec_list[] = {
+		"__tracepoints_ptrs",
+		"__ksymtab",
+		"__bug_table",
+		".smp_locks",
+		NULL
+	};
+	/* sections that are fine with any/1-byte alignment */
+	static const char *const byte_sec_list[] = {
+		".modinfo",
+		".init.ramfs",
+		NULL
+	};
+	/* sections with special alignment */
+	static struct { int align; const char *name; } const special_list[] = {
+		{ 64,	".rodata.cst2" },
+		{ 0,	NULL }
+	};
+
+	int i;
+
+	/* ignore vmlinux for now? */
+	// if (mod->is_vmlinux) return;
+
+	/* Walk through all sections */
+	for (i = 0; i < elf->num_sections; i++) {
+		Elf_Shdr *sechdr = &elf->sechdrs[i];
+		const char *sec = sech_name(elf, sechdr);
+		const char *modname = mod->name;
+		const int is_shalign = sechdr->sh_addralign;
+		int should_shalign;
+		int k;
+
+		/* ignore some sections */
+		if ((sechdr->sh_type == SHT_NULL) ||
+		    !(sechdr->sh_flags & SHF_ALLOC))
+			continue;
+
+		/* default alignment is 8 for 64-bit and 4 for 32-bit targets * */
+		should_shalign = target_64bit ? 8 : 4;
+		if (match(sec, prel32_sec_list))
+			should_shalign = target_prel32_relocations ? 4 : should_shalign;
+		else if (strstr(sec, "text")) /* assume text segments to be 4-byte aligned */
+			should_shalign = 4;
+		else if (match(sec, byte_sec_list)) /* any alignment is OK. */
+			continue;
+		else {
+			/* search in list with special alignment */
+			k = 0;
+			while (special_list[k].align && strstarts(sec, special_list[k].name)) {
+				should_shalign = special_list[k].align;
+				break;
+			}
+		}
+
+		if (is_shalign  >= should_shalign)
+			continue;
+
+		warn("%s: section %s (type %d, flags %lu) has alignment of %d, expected at least %d.\n"
+		     "Maybe you need to add ALIGN() to the modules.lds file (or fix modpost) ?\n",
+		     modname, sec, sechdr->sh_type, sechdr->sh_flags, is_shalign, should_shalign);
+	}
+}
+
 static char *remove_dot(char *s)
 {
 	size_t n = strcspn(s, ".");
@@ -1653,6 +1727,8 @@ static void read_symbols(const char *modname)
 		handle_moddevtable(mod, &info, sym, symname);
 	}

+	check_sec_alignment(mod, &info);
+
 	check_sec_ref(mod, &info);

 	if (!mod->is_vmlinux) {
@@ -2183,7 +2259,7 @@ int main(int argc, char **argv)
 	LIST_HEAD(dump_lists);
 	struct dump_list *dl, *dl2;

-	while ((opt = getopt(argc, argv, "ei:MmnT:to:au:WwENd:")) != -1) {
+	while ((opt = getopt(argc, argv, "ei:MmnT:to:au:WwENd:6R")) != -1) {
 		switch (opt) {
 		case 'e':
 			external_module = true;
@@ -2232,6 +2308,12 @@ int main(int argc, char **argv)
 		case 'd':
 			missing_namespace_deps = optarg;
 			break;
+		case '6':
+			target_64bit = true;
+			break;
+		case 'R':
+			target_prel32_relocations = true;
+			break;
 		default:
 			exit(1);
 		}
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 70c69db6a17c..b09ab081dc03 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1510,15 +1510,24 @@ static void check_sec_alignment(struct module *mod, struct elf_info *elf)
 		".smp_locks",
 		NULL
 	};
-	/* sections that are fine with any/1-byte alignment */
+	/* sections that are fine with any alignment */
 	static const char *const byte_sec_list[] = {
 		".modinfo",
 		".init.ramfs",
 		NULL
 	};
-	/* sections with special alignment */
+	/* sections with special given minimal alignment. Checked with
+	 * startswith(). */
 	static struct { int align; const char *name; } const special_list[] = {
 		{ 64,	".rodata.cst2" },
+		{ 2,	".altinstructions" }, /* at least on x86 */
+		{ 1,	".altinstr_replacement" },
+		{ 1,	".altinstr_aux" },
+		{ 4,	".call_sites" },
+		{ 4,	".return_sites" },
+		{ 1,	".note.Linux" },	/* correct? */
+		{ 4,	"__ex_table" },
+		{ 4,	".initcall" },		/* at least 4 ? */
 		{ 0,	NULL }
 	};

@@ -1545,16 +1554,17 @@ static void check_sec_alignment(struct module *mod, struct elf_info *elf)
 		should_shalign = target_64bit ? 8 : 4;
 		if (match(sec, prel32_sec_list))
 			should_shalign = target_prel32_relocations ? 4 : should_shalign;
-		else if (strstr(sec, "text")) /* assume text segments to be 4-byte aligned */
-			should_shalign = 4;
 		else if (match(sec, byte_sec_list)) /* any alignment is OK. */
 			continue;
+		else if (strstr(sec, "text")) /* assume text segments to be 4-byte aligned */
+			should_shalign = 4;
 		else {
 			/* search in list with special alignment */
-			k = 0;
-			while (special_list[k].align && strstarts(sec, special_list[k].name)) {
-				should_shalign = special_list[k].align;
-				break;
+			for (k = 0; special_list[k].align; k++) {
+				if (strstarts(sec, special_list[k].name)) {
+					should_shalign = special_list[k].align;
+					break;
+				}
 			}
 		}

Helge Deller (4):
  linux/export: Fix alignment for 64-bit ksymtab entries
  modules: Ensure 64-bit alignment on __ksymtab_* sections
  vmlinux.lds.h: Fix alignment for __ksymtab*, __kcrctab_* and
    .pci_fixup sections
  modules: Add missing entry for __ex_table

 include/asm-generic/vmlinux.lds.h | 5 +++++
 include/linux/export-internal.h   | 5 ++++-
 scripts/module.lds.S              | 9 +++++----
 3 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.41.0


