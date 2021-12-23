Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEA547DBD3
	for <lists+linux-arch@lfdr.de>; Thu, 23 Dec 2021 01:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238611AbhLWAXu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Dec 2021 19:23:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:60203 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345623AbhLWAXh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Dec 2021 19:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640219016; x=1671755016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hwei29Lo6MqEI3NixzQHT9gFQzmzq/5Ubiv0lbsKhgo=;
  b=NBsQrc6q1JL2PyiXJH3fKKZW8DD3WJmV/JYFw1IdiJbx0ihmNCe4qlcL
   IYLr6cvgvEPlcXMCO4BgQouahfvUgUsKoa74CD53tihF6IhYRgm/bYnpw
   0HWHYprd0ODG0kFNWMNQTj0wH93pnMXP6r2VEr5SMu/6EZy5cez97HWyE
   C77U+hN2TkTatEbkZ162wGxYGcygD0eNNarHoTQjDqmWPOM84aU6SalyJ
   k92CK1WcZS7tW5BShMf0XO05WarGr3wCyZ1laC5AJr7bSXxXHdbG4879Q
   xYtm0+P/nDVIZMZfco/Xgrt5Pp+adpDzWQEODAlxceoMPZcgVCTz2el+i
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="228027830"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="228027830"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 16:23:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="522294937"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga007.fm.intel.com with ESMTP; 22 Dec 2021 16:23:27 -0800
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 1BN0N79E032467;
        Thu, 23 Dec 2021 00:23:25 GMT
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     linux-hardening@vger.kernel.org, x86@kernel.org
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v9 09/15] x86: Add support for function granular KASLR
Date:   Thu, 23 Dec 2021 01:22:03 +0100
Message-Id: <20211223002209.1092165-10-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Kristen Carlson Accardi <kristen@linux.intel.com>

This commit contains the changes required to re-layout the kernel text
sections generated by -ffunction-sections shortly after decompression.
Documentation of the feature is also added.

After decompression, the decompressed image's elf headers are parsed.
In order to manually update certain data structures that are built with
relative offsets during the kernel build process, certain symbols are
not stripped by objdump and their location is retained in the elf symbol
tables. These addresses are saved.

If the image was built with -ffunction-sections, there will be ELF section
headers present which contain information about the address range of each
section. Anything that is not broken out into function sections (i.e. is
consolidated into .text) is left in it's original location, but any other
executable section which begins with ".text." is located and shuffled
randomly within the remaining text segment address range.

After the sections have been copied to their new locations, but before
relocations have been applied, the kallsyms tables must be updated to
reflect the new symbol locations. Because it is expected that these tables
will be sorted by address, the kallsyms tables will need to be sorted
after the update.

When applying relocations, the address of the relocation needs to be
adjusted by the offset from the original location of the section that was
randomized to it's new location. In addition, if a value at that relocation
was a location in the text segment that was randomized, it's value will be
adjusted to a new location.

After relocations have been applied, the exception table must be updated
with new symbol locations, and then re-sorted by the new address. The
orc table will have been updated as part of applying relocations, but since
it is expected to be sorted by address, it will need to be resorted.

alobakin:
Handle .altinstr_replacement relocations. Add vmlinux symbols to be
able to determine if a code location belongs to them, and treat this
code as text.
Use the new "gen-symbols.h" header file to ad hoc create a list of
symbols needed for both objcopy (as plain text) and C source
(fgkaslr.c, twice). With this approach, it's easier to add new
sections if needed.
Make use of our "arch/x86/lib/orc.c" introduced a bunch commits
earlier to sort ORC entries at pre-boot time -- include it directly,
similarly to extable.c et al.
Finally, use the new shuffle_array() macro landed in the kallsyms
commit to randomize our section list.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reported-by: kernel test robot <lkp@intel.com> # #if -> #ifdef
Suggested-by: Peter Zijlstra <peterz@infradead.org> # gen-symbols, ORC, ...
Co-developed-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
---
 arch/x86/boot/compressed/.gitignore    |   1 +
 arch/x86/boot/compressed/Makefile      |  15 +-
 arch/x86/boot/compressed/fgkaslr.c     | 755 +++++++++++++++++++++++++
 arch/x86/boot/compressed/gen-symbols.h |  30 +
 arch/x86/boot/compressed/misc.c        | 153 ++++-
 arch/x86/boot/compressed/misc.h        |  28 +
 arch/x86/boot/compressed/utils.c       |  13 +
 arch/x86/include/asm/boot.h            |  13 +-
 arch/x86/kernel/vmlinux.lds.S          |   2 +
 include/uapi/linux/elf.h               |   1 +
 10 files changed, 982 insertions(+), 29 deletions(-)
 create mode 100644 arch/x86/boot/compressed/fgkaslr.c
 create mode 100644 arch/x86/boot/compressed/gen-symbols.h
 create mode 100644 arch/x86/boot/compressed/utils.c

diff --git a/arch/x86/boot/compressed/.gitignore b/arch/x86/boot/compressed/.gitignore
index 25805199a506..bc5f8436be1d 100644
--- a/arch/x86/boot/compressed/.gitignore
+++ b/arch/x86/boot/compressed/.gitignore
@@ -3,5 +3,6 @@ relocs
 vmlinux.bin.all
 vmlinux.relocs
 vmlinux.lds
+vmlinux.symbols
 mkpiggy
 piggy.S
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 2cf809f5c642..6f8dcbbbad80 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -90,6 +90,7 @@ vmlinux-objs-y := $(obj)/vmlinux.lds $(obj)/kernel_info.o $(obj)/head_$(BITS).o
 
 vmlinux-objs-$(CONFIG_EARLY_PRINTK) += $(obj)/early_serial_console.o
 vmlinux-objs-$(CONFIG_RANDOMIZE_BASE) += $(obj)/kaslr.o
+vmlinux-objs-$(CONFIG_FG_KASLR) += $(obj)/fgkaslr.o $(obj)/utils.o
 ifdef CONFIG_X86_64
 	vmlinux-objs-y += $(obj)/ident_map_64.o
 	vmlinux-objs-y += $(obj)/idt_64.o $(obj)/idt_handlers_64.o
@@ -108,11 +109,21 @@ $(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
 
 OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
 
+targets += vmlinux.symbols
+
 ifdef CONFIG_FG_KASLR
+quiet_cmd_vmlinux_symbols = GEN     $@
+      cmd_vmlinux_symbols = $(CPP) $(cpp_flags) -P -D"GEN(s)"=s -o $@ $<
+
+VMLINUX_SYMBOLS = $(obj)/vmlinux.symbols
+$(VMLINUX_SYMBOLS): $(src)/gen-symbols.h FORCE
+	$(call if_changed_dep,vmlinux_symbols)
+
+OBJCOPYFLAGS += --keep-symbols=$(VMLINUX_SYMBOLS)
 RELOCS_ARGS += --fg-kaslr
-endif
+endif # CONFIG_FG_KASLR
 
-$(obj)/vmlinux.bin: vmlinux FORCE
+$(obj)/vmlinux.bin: vmlinux $(VMLINUX_SYMBOLS) FORCE
 	$(call if_changed,objcopy)
 
 targets += $(patsubst $(obj)/%,%,$(vmlinux-objs-y)) vmlinux.bin.all vmlinux.relocs
diff --git a/arch/x86/boot/compressed/fgkaslr.c b/arch/x86/boot/compressed/fgkaslr.c
new file mode 100644
index 000000000000..91b3b6ea3a93
--- /dev/null
+++ b/arch/x86/boot/compressed/fgkaslr.c
@@ -0,0 +1,755 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This contains the routines needed to reorder the kernel text section
+ * at boot time.
+ *
+ * Copyright (C) 2020-2021, Intel Corporation.
+ * Author: Kristen Carlson Accardi <kristen@linux.intel.com>
+ */
+
+#include "misc.h"
+#include "error.h"
+#include "pgtable.h"
+#include "../string.h"
+#include "../voffset.h"
+#include <linux/sort.h>
+#include <linux/random.h>
+#include <linux/bsearch.h>
+#include "../../include/asm/extable.h"
+#include "../../include/asm/orc_types.h"
+
+/*
+ * Use normal definitions of mem*() from string.c. There are already
+ * included header files which expect a definition of memset() and by
+ * the time we define memset macro, it is too late.
+ */
+#undef memcpy
+#undef memset
+#define memmove		memmove
+
+void *memmove(void *dest, const void *src, size_t n);
+
+static int nofgkaslr;
+
+static unsigned long percpu_start;
+static unsigned long percpu_end;
+
+#define GEN(s)		static long addr_##s;
+#include "gen-symbols.h"
+#undef GEN
+
+/* addresses in mapped address space */
+static int *base;
+static u8 *names;
+static unsigned long relative_base;
+static unsigned int *markers_addr;
+
+struct kallsyms_name {
+	u8 len;
+	u8 indecis[256];
+};
+
+static struct kallsyms_name *names_table;
+
+/* Array of pointers to sections headers for randomized sections */
+static Elf_Shdr **sections;
+
+/* Number of elements in the randomized section header array (sections) */
+static int sections_size;
+
+/* Array of all section headers, randomized or otherwise */
+static Elf_Shdr *sechdrs;
+
+static bool is_orc_unwind(long addr)
+{
+	if (addr >= addr___start_orc_unwind_ip &&
+	    addr < addr___stop_orc_unwind_ip)
+		return true;
+	return false;
+}
+
+static bool is_text(long addr)
+{
+	if ((addr >= addr__stext && addr < addr__etext) ||
+	    (addr >= addr__sinittext && addr < addr__einittext) ||
+	    (addr >= addr___altinstr_replacement &&
+	     addr < addr___altinstr_replacement_end))
+		return true;
+	return false;
+}
+
+bool is_percpu_addr(long pc, long offset)
+{
+	unsigned long ptr;
+	long address;
+
+	address = pc + offset + 4;
+
+	ptr = (unsigned long)address;
+
+	if (ptr >= percpu_start && ptr < percpu_end)
+		return true;
+
+	return false;
+}
+
+static bool cur_addr_orc;
+
+static int cmp_section_addr(const void *a, const void *b)
+{
+	const Elf_Shdr *s = *(const Elf_Shdr **)b;
+	unsigned long end = s->sh_addr + s->sh_size;
+	unsigned long ptr = (unsigned long)a;
+
+	if (cur_addr_orc)
+		/* orc relocations can be one past the end of the section */
+		end++;
+
+	if (ptr >= s->sh_addr && ptr < end)
+		return 0;
+
+	if (ptr < s->sh_addr)
+		return -1;
+
+	return 1;
+}
+
+/*
+ * Discover if the address is in a randomized section and if so,
+ * adjust by the saved offset.
+ */
+Elf_Shdr *adjust_address(long *address)
+{
+	Elf_Shdr **s, *shdr;
+
+	if (nofgkaslr)
+		return NULL;
+
+	s = bsearch((const void *)*address, sections, sections_size,
+		    sizeof(*s), cmp_section_addr);
+	if (!s)
+		return NULL;
+
+	shdr = *s;
+	*address += shdr->sh_offset;
+
+	return shdr;
+}
+
+void adjust_relative_offset(long pc, long *value, Elf_Shdr *section)
+{
+	long address;
+	Elf_Shdr *s;
+
+	if (nofgkaslr)
+		return;
+
+	/*
+	 * sometimes we are updating a relative offset that would
+	 * normally be relative to the next instruction (such as a call).
+	 * In this case to calculate the target, you need to add 32bits to
+	 * the pc to get the next instruction value. However, sometimes
+	 * targets are just data that was stored in a table such as ksymtab
+	 * or cpu alternatives. In this case our target is not relative to
+	 * the next instruction.
+	 */
+
+	/* Calculate the address that this offset would call. */
+	if (!is_text(pc))
+		address = pc + *value;
+	else
+		address = pc + *value + 4;
+
+	/*
+	 * orc ip addresses are sorted at build time after relocs have
+	 * been applied, making the relocs no longer valid. Skip any
+	 * relocs for the orc_unwind_ip table. These will be updated
+	 * separately.
+	 */
+	if (is_orc_unwind(pc))
+		return;
+
+	s = adjust_address(&address);
+
+	/*
+	 * if the address is in section that was randomized,
+	 * we need to adjust the offset.
+	 */
+	if (s)
+		*value += s->sh_offset;
+
+	/*
+	 * If the PC that this offset was calculated for was in a section
+	 * that has been randomized, the value needs to be adjusted by the
+	 * same amount as the randomized section was adjusted from it's original
+	 * location.
+	 */
+	if (section)
+		*value -= section->sh_offset;
+}
+
+static void kallsyms_swp(void *a, void *b, int size)
+{
+	struct kallsyms_name name_a;
+	int idx1, idx2;
+
+	/* Determine our index into the array. */
+	idx1 = (const int *)a - base;
+	idx2 = (const int *)b - base;
+	swap(base[idx1], base[idx2]);
+
+	/* Swap the names table. */
+	memcpy(&name_a, &names_table[idx1], sizeof(name_a));
+	memcpy(&names_table[idx1], &names_table[idx2],
+	       sizeof(struct kallsyms_name));
+	memcpy(&names_table[idx2], &name_a, sizeof(struct kallsyms_name));
+}
+
+static int kallsyms_cmp(const void *a, const void *b)
+{
+	unsigned long uaddr_a, uaddr_b;
+	int addr_a, addr_b;
+
+	addr_a = *(const int *)a;
+	addr_b = *(const int *)b;
+
+	if (addr_a >= 0)
+		uaddr_a = addr_a;
+	if (addr_b >= 0)
+		uaddr_b = addr_b;
+
+	if (addr_a < 0)
+		uaddr_a = relative_base - 1 - addr_a;
+	if (addr_b < 0)
+		uaddr_b = relative_base - 1 - addr_b;
+
+	if (uaddr_b > uaddr_a)
+		return -1;
+
+	return 0;
+}
+
+static void deal_with_names(int num_syms)
+{
+	int num_bytes;
+	int offset;
+	int i, j;
+
+	/* we should have num_syms kallsyms_name entries */
+	num_bytes = num_syms * sizeof(*names_table);
+	names_table = malloc(num_syms * sizeof(*names_table));
+	if (!names_table) {
+		debug_putstr("\nbytes requested: ");
+		debug_puthex(num_bytes);
+		error("\nunable to allocate space for names table\n");
+	}
+
+	/* read all the names entries */
+	offset = 0;
+	for (i = 0; i < num_syms; i++) {
+		names_table[i].len = names[offset];
+		offset++;
+		for (j = 0; j < names_table[i].len; j++) {
+			names_table[i].indecis[j] = names[offset];
+			offset++;
+		}
+	}
+}
+
+static void write_sorted_names(int num_syms)
+{
+	unsigned int *markers;
+	int offset = 0;
+	int i, j;
+
+	/*
+	 * we are going to need to regenerate the markers table, which is a
+	 * table of offsets into the compressed stream every 256 symbols.
+	 * this code copied almost directly from scripts/kallsyms.c
+	 */
+	markers = malloc(sizeof(unsigned int) * ((num_syms + 255) / 256));
+	if (!markers) {
+		debug_putstr("\nfailed to allocate heap space of ");
+		debug_puthex(((num_syms + 255) / 256));
+		debug_putstr(" bytes\n");
+		error("Unable to allocate space for markers table");
+	}
+
+	for (i = 0; i < num_syms; i++) {
+		if ((i & 0xFF) == 0)
+			markers[i >> 8] = offset;
+
+		names[offset] = (u8)names_table[i].len;
+		offset++;
+		for (j = 0; j < names_table[i].len; j++) {
+			names[offset] = (u8)names_table[i].indecis[j];
+			offset++;
+		}
+	}
+
+	/* write new markers table over old one */
+	for (i = 0; i < ((num_syms + 255) >> 8); i++)
+		markers_addr[i] = markers[i];
+
+	free(markers);
+	free(names_table);
+}
+
+static void sort_kallsyms(unsigned long map)
+{
+	int num_syms;
+	int i;
+
+	debug_putstr("\nRe-sorting kallsyms...\n");
+
+	num_syms = *(int *)(addr_kallsyms_num_syms + map);
+	base = (int *)(addr_kallsyms_offsets + map);
+	relative_base = *(unsigned long *)(addr_kallsyms_relative_base + map);
+	markers_addr = (unsigned int *)(addr_kallsyms_markers + map);
+	names = (u8 *)(addr_kallsyms_names + map);
+
+	/*
+	 * the kallsyms table was generated prior to any randomization.
+	 * it is a bunch of offsets from "relative base". In order for
+	 * us to check if a symbol has an address that was in a randomized
+	 * section, we need to reconstruct the address to it's original
+	 * value prior to handle_relocations.
+	 */
+	for (i = 0; i < num_syms; i++) {
+		unsigned long addr;
+
+		/*
+		 * according to kernel/kallsyms.c, positive offsets are absolute
+		 * values and negative offsets are relative to the base.
+		 */
+		if (base[i] >= 0)
+			addr = base[i];
+		else
+			addr = relative_base - 1 - base[i];
+
+		if (adjust_address(&addr))
+			/* here we need to recalcuate the offset */
+			base[i] = relative_base - 1 - addr;
+	}
+
+	/*
+	 * here we need to read in all the kallsyms_names info
+	 * so that we can regenerate it.
+	 */
+	deal_with_names(num_syms);
+
+	sort(base, num_syms, sizeof(int), kallsyms_cmp, kallsyms_swp);
+
+	/* write the newly sorted names table over the old one */
+	write_sorted_names(num_syms);
+}
+
+/*
+ * We need to include this file here rather than in utils.c because
+ * some of the helper functions in extable.c are used to update
+ * the extable below and are defined as "static" in extable.c
+ */
+#include "../../../../lib/extable.c"
+
+static inline unsigned long
+ex_fixup_addr(const struct exception_table_entry *x)
+{
+	return ((unsigned long)&x->fixup + x->fixup);
+}
+
+static void update_ex_table(unsigned long map)
+{
+	struct exception_table_entry *start_ex_table =
+		(struct exception_table_entry *)(addr___start___ex_table + map);
+	int num_entries =
+		(addr___stop___ex_table - addr___start___ex_table) /
+		sizeof(struct exception_table_entry);
+	int i;
+
+	debug_putstr("\nUpdating exception table...");
+	for (i = 0; i < num_entries; i++) {
+		unsigned long fixup = ex_fixup_addr(&start_ex_table[i]);
+		unsigned long insn = ex_to_insn(&start_ex_table[i]);
+		unsigned long addr;
+		Elf_Shdr *s;
+
+		/* check each address to see if it needs adjusting */
+		addr = insn - map;
+		s = adjust_address(&addr);
+		if (s)
+			start_ex_table[i].insn += s->sh_offset;
+
+		addr = fixup - map;
+		s = adjust_address(&addr);
+		if (s)
+			start_ex_table[i].fixup += s->sh_offset;
+	}
+}
+
+static void sort_ex_table(unsigned long map)
+{
+	struct exception_table_entry *start_ex_table =
+		(struct exception_table_entry *)(addr___start___ex_table + map);
+	struct exception_table_entry *stop_ex_table =
+		(struct exception_table_entry *)(addr___stop___ex_table + map);
+
+	debug_putstr("\nRe-sorting exception table...");
+
+	sort_extable(start_ex_table, stop_ex_table);
+}
+
+#define ORC_COMPRESSED_BOOT
+#include "../../lib/orc.c"
+
+static void update_orc_table(unsigned long map)
+{
+	int *ip_table = (int *)(addr___start_orc_unwind_ip + map);
+	int num_entries, i;
+
+	num_entries = addr___stop_orc_unwind_ip - addr___start_orc_unwind_ip;
+	num_entries /= sizeof(int);
+
+	debug_putstr("\nUpdating orc tables...\n");
+	cur_addr_orc = true;
+
+	for (i = 0; i < num_entries; i++) {
+		unsigned long ip = orc_ip(ip_table + i);
+		Elf_Shdr *s;
+
+		/* check each address to see if it needs adjusting */
+		ip = ip - map;
+
+		/*
+		 * objtool places terminator entries just outside the end of
+		 * the section. To identify an orc_unwind_ip address that might
+		 * need adjusting, the address should be compared differently
+		 * than a normal address.
+		 */
+		s = adjust_address(&ip);
+		if (s)
+			ip_table[i] += s->sh_offset;
+	}
+
+	cur_addr_orc = false;
+}
+
+static void sort_orc_table(unsigned long map)
+{
+	struct orc_entry *orc_table;
+	int num_entries;
+	int *ip_table;
+
+	orc_table = (struct orc_entry *)(addr___start_orc_unwind + map);
+	ip_table = (int *)(addr___start_orc_unwind_ip + map);
+
+	num_entries = addr___stop_orc_unwind_ip - addr___start_orc_unwind_ip;
+	num_entries /= sizeof(int);
+
+	debug_putstr("\nRe-sorting orc tables...\n");
+	orc_sort(ip_table, orc_table, num_entries);
+}
+
+void post_relocations_cleanup(unsigned long map)
+{
+	if (!nofgkaslr) {
+		update_ex_table(map);
+		sort_ex_table(map);
+		update_orc_table(map);
+		sort_orc_table(map);
+	}
+
+	/*
+	 * maybe one day free will do something. So, we "free" this memory
+	 * in either case
+	 */
+	free(sections);
+	free(sechdrs);
+}
+
+void pre_relocations_cleanup(unsigned long map)
+{
+	if (nofgkaslr)
+		return;
+
+	sort_kallsyms(map);
+}
+
+static void move_text(int num_sections, char *secstrings, Elf_Shdr *text,
+		      void *source, void *dest, Elf64_Phdr *phdr)
+{
+	unsigned long adjusted_addr;
+	int *index_list;
+	int copy_bytes;
+	void *stash;
+	int i, j;
+
+	memmove(dest, source + text->sh_offset, text->sh_size);
+	copy_bytes = text->sh_size;
+	dest += text->sh_size;
+	adjusted_addr = text->sh_addr + text->sh_size;
+
+	/*
+	 * we leave the sections sorted in their original order
+	 * by s->sh_addr, but shuffle the indexes in a random
+	 * order for copying.
+	 */
+	index_list = malloc(sizeof(int) * num_sections);
+	if (!index_list)
+		error("Failed to allocate space for index list");
+
+	for (i = 0; i < num_sections; i++)
+		index_list[i] = i;
+
+#define get_random_long()	kaslr_get_random_long(NULL)
+	shuffle_array(index_list, num_sections);
+#undef get_random_long
+
+	/*
+	 * to avoid overwriting earlier sections before they can get
+	 * copied to dest, stash everything into a buffer first.
+	 * this will cause our source address to be off by
+	 * phdr->p_offset though, so we'll adjust s->sh_offset below.
+	 *
+	 * TBD: ideally we'd simply decompress higher up so that our
+	 * copy wasn't in danger of overwriting anything important.
+	 */
+	stash = malloc(phdr->p_filesz);
+	if (!stash)
+		error("Failed to allocate space for text stash");
+
+	memcpy(stash, source + phdr->p_offset, phdr->p_filesz);
+
+	/* now we'd walk through the sections. */
+	for (j = 0; j < num_sections; j++) {
+		unsigned long aligned_addr;
+		int pad_bytes;
+		Elf_Shdr *s;
+		void *src;
+
+		s = sections[index_list[j]];
+
+		/* align addr for this section */
+		aligned_addr = ALIGN(adjusted_addr, s->sh_addralign);
+
+		/*
+		 * copy out of stash, so adjust offset
+		 */
+		src = stash + s->sh_offset - phdr->p_offset;
+
+		/*
+		 * Fill any space between sections with int3
+		 */
+		pad_bytes = aligned_addr - adjusted_addr;
+		memset(dest, 0xcc, pad_bytes);
+
+		dest = (void *)ALIGN((unsigned long)dest, s->sh_addralign);
+
+		memmove(dest, src, s->sh_size);
+
+		dest += s->sh_size;
+		copy_bytes += s->sh_size + pad_bytes;
+		adjusted_addr = aligned_addr + s->sh_size;
+
+		/* we can blow away sh_offset for our own uses */
+		s->sh_offset = aligned_addr - s->sh_addr;
+	}
+
+	free(index_list);
+
+	/*
+	 * move remainder of text segment. Ok to just use original source
+	 * here since this area is untouched.
+	 */
+	memmove(dest, source + text->sh_offset + copy_bytes,
+		phdr->p_filesz - copy_bytes);
+	free(stash);
+}
+
+static void parse_symtab(const Elf64_Sym *symtab, const char *strtab,
+			 long num_syms)
+{
+	const Elf64_Sym *sym;
+
+	if (!symtab || !strtab)
+		return;
+
+	debug_putstr("\nLooking for symbols... ");
+
+	/*
+	 * walk through the symbol table looking for the symbols
+	 * that we care about.
+	 */
+	for (sym = symtab; --num_syms >= 0; sym++) {
+		if (!sym->st_name)
+			continue;
+
+#define GEN(s) ({						\
+	if (!addr_##s && !strcmp(#s, strtab + sym->st_name)) {	\
+		addr_##s = sym->st_value;			\
+		continue;					\
+	}							\
+});
+#include "gen-symbols.h"
+#undef GEN
+	}
+}
+
+void layout_randomized_image(void *output, Elf64_Ehdr *ehdr, Elf64_Phdr *phdrs)
+{
+	Elf64_Sym *symtab = NULL;
+	Elf_Shdr *percpu = NULL;
+	Elf_Shdr *text = NULL;
+	unsigned int shstrndx;
+	int num_sections = 0;
+	unsigned long shnum;
+	char *strtab = NULL;
+	long num_syms = 0;
+	const char *sname;
+	char *secstrings;
+	Elf_Shdr shdr;
+	Elf_Shdr *s;
+	void *dest;
+	int i;
+
+	debug_putstr("\nParsing ELF section headers... ");
+
+	/*
+	 * Even though fgkaslr may have been disabled, we still
+	 * need to parse through the section headers to get the
+	 * start and end of the percpu section. This is because
+	 * if we were built with CONFIG_FG_KASLR, there are more
+	 * relative relocations present in vmlinux.relocs than
+	 * just the percpu, and only the percpu relocs need to be
+	 * adjusted when using just normal base address kaslr.
+	 */
+	if (cmdline_find_option_bool("nofgkaslr")) {
+		warn("FG_KASLR disabled on cmdline.");
+		nofgkaslr = 1;
+	}
+
+	/* read the first section header */
+	shnum = ehdr->e_shnum;
+	shstrndx = ehdr->e_shstrndx;
+	if (shnum == SHN_UNDEF || shstrndx == SHN_XINDEX) {
+		memcpy(&shdr, output + ehdr->e_shoff, sizeof(shdr));
+		if (shnum == SHN_UNDEF)
+			shnum = shdr.sh_size;
+		if (shstrndx == SHN_XINDEX)
+			shstrndx = shdr.sh_link;
+	}
+
+	/* we are going to need to allocate space for the section headers */
+	sechdrs = malloc(sizeof(*sechdrs) * shnum);
+	if (!sechdrs)
+		error("Failed to allocate space for shdrs");
+
+	sections = malloc(sizeof(*sections) * shnum);
+	if (!sections)
+		error("Failed to allocate space for section pointers");
+
+	memcpy(sechdrs, output + ehdr->e_shoff,
+	       sizeof(*sechdrs) * shnum);
+
+	/* we need to allocate space for the section string table */
+	s = &sechdrs[shstrndx];
+
+	secstrings = malloc(s->sh_size);
+	if (!secstrings)
+		error("Failed to allocate space for shstr");
+
+	memcpy(secstrings, output + s->sh_offset, s->sh_size);
+
+	/*
+	 * now we need to walk through the section headers and collect the
+	 * sizes of the .text sections to be randomized.
+	 */
+	for (i = 0; i < shnum; i++) {
+		s = &sechdrs[i];
+		sname = secstrings + s->sh_name;
+
+		if (s->sh_type == SHT_SYMTAB) {
+			/* only one symtab per image */
+			if (symtab)
+				error("Unexpected duplicate symtab");
+
+			symtab = malloc(s->sh_size);
+			if (!symtab)
+				error("Failed to allocate space for symtab");
+
+			memcpy(symtab, output + s->sh_offset, s->sh_size);
+			num_syms = s->sh_size / sizeof(*symtab);
+			continue;
+		}
+
+		if (s->sh_type == SHT_STRTAB && i != ehdr->e_shstrndx) {
+			if (strtab)
+				error("Unexpected duplicate strtab");
+
+			strtab = malloc(s->sh_size);
+			if (!strtab)
+				error("Failed to allocate space for strtab");
+
+			memcpy(strtab, output + s->sh_offset, s->sh_size);
+		}
+
+		if (!strcmp(sname, ".text")) {
+			if (text)
+				error("Unexpected duplicate .text section");
+
+			text = s;
+			continue;
+		}
+
+		if (!strcmp(sname, ".data..percpu")) {
+			/* get start addr for later */
+			percpu = s;
+			continue;
+		}
+
+		if (!(s->sh_flags & SHF_ALLOC) ||
+		    !(s->sh_flags & SHF_EXECINSTR) ||
+		    !(strstarts(sname, ".text")))
+			continue;
+
+		sections[num_sections] = s;
+
+		num_sections++;
+	}
+	sections[num_sections] = NULL;
+	sections_size = num_sections;
+
+	parse_symtab(symtab, strtab, num_syms);
+
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		Elf64_Phdr *phdr = &phdrs[i];
+
+		switch (phdr->p_type) {
+		case PT_LOAD:
+			if ((phdr->p_align % 0x200000) != 0)
+				error("Alignment of LOAD segment isn't multiple of 2MB");
+			dest = output;
+			dest += (phdr->p_paddr - LOAD_PHYSICAL_ADDR);
+			if (!nofgkaslr &&
+			    (text && phdr->p_offset == text->sh_offset)) {
+				move_text(num_sections, secstrings, text,
+					  output, dest, phdr);
+			} else {
+				if (percpu &&
+				    phdr->p_offset == percpu->sh_offset) {
+					percpu_start = percpu->sh_addr;
+					percpu_end = percpu_start +
+							phdr->p_filesz;
+				}
+				memmove(dest, output + phdr->p_offset,
+					phdr->p_filesz);
+			}
+			break;
+		default: /* Ignore other PT_* */
+			break;
+		}
+	}
+
+	/* we need to keep the section info to redo relocs */
+	free(secstrings);
+	free(phdrs);
+}
diff --git a/arch/x86/boot/compressed/gen-symbols.h b/arch/x86/boot/compressed/gen-symbols.h
new file mode 100644
index 000000000000..6828c80dd19f
--- /dev/null
+++ b/arch/x86/boot/compressed/gen-symbols.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * List of symbols needed for both C code and objcopy when FG-KASLR is on.
+ * We declare them once and then just use GEN() definition.
+ *
+ * Copyright (C) 2021, Intel Corporation.
+ * Author: Alexander Lobakin <alexandr.lobakin@intel.com>
+ */
+
+#ifdef GEN
+GEN(__altinstr_replacement)
+GEN(__altinstr_replacement_end)
+GEN(__start___ex_table)
+GEN(__start_orc_unwind)
+GEN(__start_orc_unwind_ip)
+GEN(__stop___ex_table)
+GEN(__stop_orc_unwind_ip)
+GEN(_einittext)
+GEN(_etext)
+GEN(_sinittext)
+GEN(_stext)
+GEN(kallsyms_addresses)
+GEN(kallsyms_markers)
+GEN(kallsyms_names)
+GEN(kallsyms_num_syms)
+GEN(kallsyms_offsets)
+GEN(kallsyms_relative_base)
+GEN(kallsyms_token_index)
+GEN(kallsyms_token_table)
+#endif /* GEN */
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index a4339cb2d247..bd733e1abc75 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -207,10 +207,21 @@ static void handle_relocations(void *output, unsigned long output_len,
 	if (IS_ENABLED(CONFIG_X86_64))
 		delta = virt_addr - LOAD_PHYSICAL_ADDR;
 
-	if (!delta) {
-		debug_putstr("No relocation needed... ");
-		return;
+	/*
+	 * it is possible to have delta be zero and still have enabled
+	 * fg kaslr. We need to perform relocations for fgkaslr regardless
+	 * of whether the base address has moved.
+	 */
+	if (!IS_ENABLED(CONFIG_FG_KASLR) ||
+	    cmdline_find_option_bool("nokaslr")) {
+		if (!delta) {
+			debug_putstr("No relocation needed... ");
+			return;
+		}
 	}
+
+	pre_relocations_cleanup(map);
+
 	debug_putstr("Performing relocations... ");
 
 	/*
@@ -234,35 +245,105 @@ static void handle_relocations(void *output, unsigned long output_len,
 	 */
 	for (reloc = output + output_len - sizeof(*reloc); *reloc; reloc--) {
 		long extended = *reloc;
+		long value;
+
+		/*
+		 * if using fgkaslr, we might have moved the address
+		 * of the relocation. Check it to see if it needs adjusting
+		 * from the original address.
+		 */
+		adjust_address(&extended);
+
 		extended += map;
 
 		ptr = (unsigned long)extended;
 		if (ptr < min_addr || ptr > max_addr)
 			error("32-bit relocation outside of kernel!\n");
 
-		*(uint32_t *)ptr += delta;
+		value = *(int32_t *)ptr;
+
+		/*
+		 * If using fgkaslr, the value of the relocation
+		 * might need to be changed because it referred
+		 * to an address that has moved.
+		 */
+		adjust_address(&value);
+
+		value += delta;
+
+		*(uint32_t *)ptr = value;
 	}
 #ifdef CONFIG_X86_64
 	while (*--reloc) {
 		long extended = *reloc;
+		long oldvalue, value;
+		Elf64_Shdr *s;
+
+		/*
+		 * if using fgkaslr, we might have moved the address
+		 * of the relocation. Check it to see if it needs adjusting
+		 * from the original address.
+		 */
+		s = adjust_address(&extended);
+
 		extended += map;
 
 		ptr = (unsigned long)extended;
 		if (ptr < min_addr || ptr > max_addr)
 			error("inverse 32-bit relocation outside of kernel!\n");
 
-		*(int32_t *)ptr -= delta;
+		value = *(int32_t *)ptr;
+		oldvalue = value;
+
+		/*
+		 * If using fgkaslr, these relocs will contain
+		 * relative offsets which might need to be
+		 * changed because it referred
+		 * to an address that has moved.
+		 */
+		adjust_relative_offset(*reloc, &value, s);
+
+		/*
+		 * only percpu symbols need to have their values adjusted for
+		 * base address kaslr since relative offsets within the .text
+		 * and .text.* sections are ok wrt each other.
+		 */
+		if (is_percpu_addr(*reloc, oldvalue))
+			value -= delta;
+
+		*(int32_t *)ptr = value;
 	}
 	for (reloc--; *reloc; reloc--) {
 		long extended = *reloc;
+		long value;
+
+		/*
+		 * if using fgkaslr, we might have moved the address
+		 * of the relocation. Check it to see if it needs adjusting
+		 * from the original address.
+		 */
+		adjust_address(&extended);
+
 		extended += map;
 
 		ptr = (unsigned long)extended;
 		if (ptr < min_addr || ptr > max_addr)
 			error("64-bit relocation outside of kernel!\n");
 
-		*(uint64_t *)ptr += delta;
+		value = *(int64_t *)ptr;
+
+		/*
+		 * If using fgkaslr, the value of the relocation
+		 * might need to be changed because it referred
+		 * to an address that has moved.
+		 */
+		adjust_address(&value);
+
+		value += delta;
+
+		*(uint64_t *)ptr = value;
 	}
+	post_relocations_cleanup(map);
 #endif
 }
 #else
@@ -271,6 +352,35 @@ static inline void handle_relocations(void *output, unsigned long output_len,
 { }
 #endif
 
+static void layout_image(void *output, Elf_Ehdr *ehdr, Elf_Phdr *phdrs)
+{
+	int i;
+	void *dest;
+	Elf_Phdr *phdr;
+
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		phdr = &phdrs[i];
+
+		switch (phdr->p_type) {
+		case PT_LOAD:
+#ifdef CONFIG_X86_64
+			if ((phdr->p_align % 0x200000) != 0)
+				error("Alignment of LOAD segment isn't multiple of 2MB");
+#endif
+#ifdef CONFIG_RELOCATABLE
+			dest = output;
+			dest += (phdr->p_paddr - LOAD_PHYSICAL_ADDR);
+#else
+			dest = (void *)(phdr->p_paddr);
+#endif
+			memmove(dest, output + phdr->p_offset, phdr->p_filesz);
+			break;
+		default: /* Ignore other PT_* */
+			break;
+		}
+	}
+}
+
 static void parse_elf(void *output)
 {
 #ifdef CONFIG_X86_64
@@ -282,6 +392,7 @@ static void parse_elf(void *output)
 #endif
 	void *dest;
 	int i;
+	int nokaslr;
 
 	memcpy(&ehdr, output, sizeof(ehdr));
 	if (ehdr.e_ident[EI_MAG0] != ELFMAG0 ||
@@ -292,6 +403,12 @@ static void parse_elf(void *output)
 		return;
 	}
 
+	if (IS_ENABLED(CONFIG_FG_KASLR)) {
+		nokaslr = cmdline_find_option_bool("nokaslr");
+		if (nokaslr)
+			warn("FG_KASLR disabled: 'nokaslr' on cmdline.");
+	}
+
 	debug_putstr("Parsing ELF... ");
 
 	phdrs = malloc(sizeof(*phdrs) * ehdr.e_phnum);
@@ -300,26 +417,10 @@ static void parse_elf(void *output)
 
 	memcpy(phdrs, output + ehdr.e_phoff, sizeof(*phdrs) * ehdr.e_phnum);
 
-	for (i = 0; i < ehdr.e_phnum; i++) {
-		phdr = &phdrs[i];
-
-		switch (phdr->p_type) {
-		case PT_LOAD:
-#ifdef CONFIG_X86_64
-			if ((phdr->p_align % 0x200000) != 0)
-				error("Alignment of LOAD segment isn't multiple of 2MB");
-#endif
-#ifdef CONFIG_RELOCATABLE
-			dest = output;
-			dest += (phdr->p_paddr - LOAD_PHYSICAL_ADDR);
-#else
-			dest = (void *)(phdr->p_paddr);
-#endif
-			memmove(dest, output + phdr->p_offset, phdr->p_filesz);
-			break;
-		default: /* Ignore other PT_* */ break;
-		}
-	}
+	if (IS_ENABLED(CONFIG_FG_KASLR) && !nokaslr)
+		layout_randomized_image(output, &ehdr, phdrs);
+	else
+		layout_image(output, &ehdr, phdrs);
 
 	free(phdrs);
 }
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 16ed360b6692..1315a101c1c9 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -83,6 +83,34 @@ struct mem_vector {
 	u64 size;
 };
 
+#ifdef CONFIG_X86_64
+#define Elf_Ehdr Elf64_Ehdr
+#define Elf_Phdr Elf64_Phdr
+#define Elf_Shdr Elf64_Shdr
+#else
+#define Elf_Ehdr Elf32_Ehdr
+#define Elf_Phdr Elf32_Phdr
+#define Elf_Shdr Elf32_Shdr
+#endif
+
+#ifdef CONFIG_FG_KASLR
+void layout_randomized_image(void *output, Elf_Ehdr *ehdr, Elf_Phdr *phdrs);
+void pre_relocations_cleanup(unsigned long map);
+void post_relocations_cleanup(unsigned long map);
+Elf_Shdr *adjust_address(long *address);
+void adjust_relative_offset(long pc, long *value, Elf_Shdr *section);
+bool is_percpu_addr(long pc, long offset);
+#else
+static inline void layout_randomized_image(void *output, Elf_Ehdr *ehdr,
+					   Elf_Phdr *phdrs) { }
+static inline void pre_relocations_cleanup(unsigned long map) { }
+static inline void post_relocations_cleanup(unsigned long map) { }
+static inline Elf_Shdr *adjust_address(long *address) { return NULL; }
+static inline void adjust_relative_offset(long pc, long *value,
+					  Elf_Shdr *section) { }
+static inline bool is_percpu_addr(long pc, long offset) { return true; }
+#endif
+
 #ifdef CONFIG_RANDOMIZE_BASE
 /* kaslr.c */
 void choose_random_location(unsigned long input,
diff --git a/arch/x86/boot/compressed/utils.c b/arch/x86/boot/compressed/utils.c
new file mode 100644
index 000000000000..7c3c745f6251
--- /dev/null
+++ b/arch/x86/boot/compressed/utils.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This contains various libraries that are needed for FG-KASLR.
+ *
+ * Copyright (C) 2020-2021, Intel Corporation.
+ * Author: Kristen Carlson Accardi <kristen@linux.intel.com>
+ */
+
+#define _LINUX_KPROBES_H
+#define NOKPROBE_SYMBOL(fname)
+
+#include "../../../../lib/sort.c"
+#include "../../../../lib/bsearch.c"
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 9191280d9ea3..ce5fdee49046 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -24,7 +24,18 @@
 # error "Invalid value for CONFIG_PHYSICAL_ALIGN"
 #endif
 
-#if defined(CONFIG_KERNEL_BZIP2)
+#ifdef CONFIG_FG_KASLR
+/*
+ * We need extra boot heap when using fgkaslr because we make a copy
+ * of the original decompressed kernel to avoid issues with writing
+ * over ourselves when shuffling the sections. We also need extra
+ * space for resorting kallsyms after shuffling. This value could
+ * be decreased if free() would release memory properly, or if we
+ * could avoid the kernel copy. It would need to be increased if we
+ * find additional tables that need to be resorted.
+ */
+# define BOOT_HEAP_SIZE		0x4800000
+#elif defined(CONFIG_KERNEL_BZIP2)
 # define BOOT_HEAP_SIZE		0x400000
 #elif defined(CONFIG_KERNEL_ZSTD)
 /*
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 6f026400261e..6620f069b7ef 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -304,7 +304,9 @@ SECTIONS
 	 * get the address and the length of them to patch the kernel safely.
 	 */
 	.altinstr_replacement : AT(ADDR(.altinstr_replacement) - LOAD_OFFSET) {
+		__altinstr_replacement = .;
 		*(.altinstr_replacement)
+		__altinstr_replacement_end = .;
 	}
 
 	/*
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 61bf4774b8f2..1c74d9594919 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -299,6 +299,7 @@ typedef struct elf64_phdr {
 #define SHN_LIVEPATCH	0xff20
 #define SHN_ABS		0xfff1
 #define SHN_COMMON	0xfff2
+#define SHN_XINDEX	0xffff
 #define SHN_HIRESERVE	0xffff
  
 typedef struct elf32_shdr {
-- 
2.33.1

