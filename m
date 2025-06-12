Return-Path: <linux-arch+bounces-12335-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C853AD7F52
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 02:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB868189807F
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 00:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B897DA6C;
	Fri, 13 Jun 2025 00:02:00 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851672F32;
	Fri, 13 Jun 2025 00:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749772920; cv=none; b=YhyW7pp54MUvvhD7aEs1MdoXYwiASALiqzxvCGahdik6zwLjfrix0wvA1VWfOSSvYi6mqyPF/E85iKuuKDt1DJAO5naH6f3RuiZuKENNBN1m4v8ZqnlwPmUxWrDO9eyxwtpcK4TD1n8uPE/YDp/iWd9BLfOZVKSg3xq9I52D7uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749772920; c=relaxed/simple;
	bh=1Wi9qsaoZ7r24PsCIiOD/iqfyYPhK4+xa9EZGFFJa4M=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=bjj40iWPRtfnJXPxn+rxFLdJaoUS+7nkQ2KH6SsZO5q37EONjRgjfk83VwLXSBSl6SgGHzWO0oWT2bZu2WNXRm+WZDK0Lti4ZpRQ5/EHKmjn5zCjhJQxEVCB/CVkPOtmS5dmUAhXmaoPyydIguSCCoYSvD00C8PPmA9iow217L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id E15F9803ED;
	Fri, 13 Jun 2025 00:01:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 7F95220015;
	Fri, 13 Jun 2025 00:01:52 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uPrtI-00000001wm9-3vfQ;
	Thu, 12 Jun 2025 20:03:28 -0400
Message-ID: <20250613000328.791312828@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 12 Jun 2025 19:58:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org,
 llvm@lists.linux.dev
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 2/5] tracing: sorttable: Add a tracepoint verification check at build time
References: <20250612235827.011358765@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 7F95220015
X-Stat-Signature: sxgz9x5g6f1cm6dcjexxbymqjm63cmzj
X-Rspamd-Server: rspamout07
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18kGkDH3+IFv6sDugiAQU0LksiTCnTzpO8=
X-HE-Tag: 1749772912-916592
X-HE-Meta: U2FsdGVkX190KiQD5thmSaOLS8ParT9bX55XnJIDqlp7gELTcyqwWw6cd4pdN/PaPppbBFZMBY/1E9SAvYNhQFyWk2VG7zJVluIV2Rgfk84s1QzrDHQ5lXY2mTnGyC+f3PUdsZE/sg3ponRFZB5EC7rtOQCPTPAQV7deENgyolbyqDWk9RmWydc9e2iiYpHAEq4HIpQIX0JQwwsSJD1w9Ga3iMXUqw/u8h1zojAbbBNrSOZeXf/pkdv6ZGsa1WhgZr9EDT1f1k/UL12Ly4NeCposGOyCjv7pHKbqom9MWEIO+leAJtpa4nhV1LNHr908ZFG0M6oUS6ZlWVRUgWmNZKmMHfshtNDAIQ1MH/v2rlJV/0dcMY9MOxbOq6DAURZ/u/XzUmuWZaPbfD4wDKDCHA==

From: Steven Rostedt <rostedt@goodmis.org>

Update the sorttable code to check the tracepoint_check and tracepoint_ptr
sections to see what trace events have been created but not used. Trace
events can take up approximately 5K of memory each regardless if they are
called or not.

List the tracepoints that are not used at build time. Note, this currently
only handles tracepoints that are builtin and not in modules.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig |  12 ++
 scripts/Makefile     |   4 +
 scripts/sorttable.c  | 268 +++++++++++++++++++++++++++++++++++++++----
 3 files changed, 261 insertions(+), 23 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e676b802b721..6c28b06c9231 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -1063,6 +1063,18 @@ config TRACEPOINT_WARN_ON_UNUSED
 	  A warning will be triggered if a tracepoint is found and
 	  not used at bootup.
 
+config TRACEPOINT_WARN_ON_UNUSED_BUILD
+	bool "Warn on build if a tracepoint is defined but not used"
+	depends on TRACEPOINTS
+	select TRACEPOINT_VERIFY_USED
+	default y
+	help
+	  This option checks if every builtin defined tracepoint is
+	  used in the code. If a tracepoint is defined but not used,
+	  it will waste memory as its meta data is still created.
+	  This will cause a warning at build time if the architecture
+	  supports it.
+
 config FTRACE_SELFTEST
 	bool
 
diff --git a/scripts/Makefile b/scripts/Makefile
index 46f860529df5..f81947ec9486 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -42,6 +42,10 @@ HOSTCFLAGS_sorttable.o += -I$(srctree)/tools/arch/$(SRCARCH)/include
 HOSTCFLAGS_sorttable.o += -DUNWINDER_ORC_ENABLED
 endif
 
+ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+HOSTCFLAGS_sorttable.o += -DPREL32_RELOCATIONS
+endif
+
 ifdef CONFIG_BUILDTIME_MCOUNT_SORT
 HOSTCFLAGS_sorttable.o += -DMCOUNT_SORT_ENABLED
 endif
diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index deed676bfe38..ddcbec22ca96 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -92,6 +92,12 @@ static void (*w)(uint32_t, uint32_t *);
 static void (*w8)(uint64_t, uint64_t *);
 typedef void (*table_sort_t)(char *, int);
 
+static Elf_Shdr *init_data_sec;
+static Elf_Shdr *ro_data_sec;
+static Elf_Shdr *data_data_sec;
+
+static void *file_map_end;
+
 static struct elf_funcs {
 	int (*compare_extable)(const void *a, const void *b);
 	uint64_t (*ehdr_shoff)(Elf_Ehdr *ehdr);
@@ -550,8 +556,6 @@ static void *sort_orctable(void *arg)
 }
 #endif
 
-#ifdef MCOUNT_SORT_ENABLED
-
 static int compare_values_64(const void *a, const void *b)
 {
 	uint64_t av = *(uint64_t *)a;
@@ -574,6 +578,22 @@ static int compare_values_32(const void *a, const void *b)
 
 static int (*compare_values)(const void *a, const void *b);
 
+static int fill_addrs(void *ptr, uint64_t size, void *addrs)
+{
+	void *end = ptr + size;
+	int count = 0;
+
+	for (; ptr < end; ptr += long_size, addrs += long_size, count++) {
+		if (long_size == 4)
+			*(uint32_t *)ptr = r(addrs);
+		else
+			*(uint64_t *)ptr = r8(addrs);
+	}
+	return count;
+}
+
+#ifdef MCOUNT_SORT_ENABLED
+
 /* Only used for sorting mcount table */
 static void rela_write_addend(Elf_Rela *rela, uint64_t val)
 {
@@ -684,7 +704,6 @@ static char m_err[ERRSTR_MAXSZ];
 
 struct elf_mcount_loc {
 	Elf_Ehdr *ehdr;
-	Elf_Shdr *init_data_sec;
 	uint64_t start_mcount_loc;
 	uint64_t stop_mcount_loc;
 };
@@ -785,20 +804,6 @@ static void replace_relocs(void *ptr, uint64_t size, Elf_Ehdr *ehdr, uint64_t st
 	}
 }
 
-static int fill_addrs(void *ptr, uint64_t size, void *addrs)
-{
-	void *end = ptr + size;
-	int count = 0;
-
-	for (; ptr < end; ptr += long_size, addrs += long_size, count++) {
-		if (long_size == 4)
-			*(uint32_t *)ptr = r(addrs);
-		else
-			*(uint64_t *)ptr = r8(addrs);
-	}
-	return count;
-}
-
 static void replace_addrs(void *ptr, uint64_t size, void *addrs)
 {
 	void *end = ptr + size;
@@ -815,8 +820,8 @@ static void replace_addrs(void *ptr, uint64_t size, void *addrs)
 static void *sort_mcount_loc(void *arg)
 {
 	struct elf_mcount_loc *emloc = (struct elf_mcount_loc *)arg;
-	uint64_t offset = emloc->start_mcount_loc - shdr_addr(emloc->init_data_sec)
-					+ shdr_offset(emloc->init_data_sec);
+	uint64_t offset = emloc->start_mcount_loc - shdr_addr(init_data_sec)
+					+ shdr_offset(init_data_sec);
 	uint64_t size = emloc->stop_mcount_loc - emloc->start_mcount_loc;
 	unsigned char *start_loc = (void *)emloc->ehdr + offset;
 	Elf_Ehdr *ehdr = emloc->ehdr;
@@ -920,6 +925,211 @@ static void get_mcount_loc(struct elf_mcount_loc *emloc, Elf_Shdr *symtab_sec,
 static inline int parse_symbols(const char *fname) { return 0; }
 #endif
 
+struct elf_tracepoint {
+	Elf_Ehdr *ehdr;
+	uint64_t start_tracepoint_check;
+	uint64_t stop_tracepoint_check;
+	uint64_t start_tracepoint;
+	uint64_t stop_tracepoint;
+	uint64_t *array;
+	int count;
+};
+
+static void make_trace_array(struct elf_tracepoint *etrace)
+{
+	uint64_t offset = etrace->start_tracepoint_check - shdr_addr(init_data_sec)
+					+ shdr_offset(init_data_sec);
+	uint64_t size = etrace->stop_tracepoint_check - etrace->start_tracepoint_check;
+	Elf_Ehdr *ehdr = etrace->ehdr;
+	void *start = (void *)ehdr + offset;
+	int count = 0;
+	void *vals;
+
+	etrace->array = NULL;
+
+	/* If CONFIG_TRACEPOINT_VERIFY_USED is not set, there's nothing to do */
+	if (!size)
+		return;
+
+	vals = malloc(long_size * size);
+	if (!vals) {
+		fprintf(stderr, "Failed to allocate tracepoint check array");
+		return;
+	}
+
+	count = fill_addrs(vals, size, start);
+
+	compare_values = long_size == 4 ? compare_values_32 : compare_values_64;
+	qsort(vals, count, long_size, compare_values);
+
+	etrace->array = vals;
+	etrace->count = count;
+}
+
+static int cmp_addr_64(const void *K, const void *A)
+{
+	uint64_t key = *(const uint64_t *)K;
+	const uint64_t *a = A;
+
+	if (key < *a)
+		return -1;
+	return key > *a;
+}
+
+static int cmp_addr_32(const void *K, const void *A)
+{
+	uint32_t key = *(const uint32_t *)K;
+	const uint32_t *a = A;
+
+	if (key < *a)
+		return -1;
+	return key > *a;
+}
+
+static int find_event(void *array, size_t size, uint64_t key)
+{
+	uint32_t val_32;
+	uint64_t val_64;
+	void *val;
+	int (*cmp_func)(const void *A, const void *B);
+
+	if (long_size == 4) {
+		val_32 = key;
+		val = &val_32;
+		cmp_func = cmp_addr_32;
+	} else {
+		val_64 = key;
+		val = &val_64;
+		cmp_func = cmp_addr_64;
+	}
+	return bsearch(val, array, size, long_size, cmp_func) != NULL;
+}
+
+static int failed_event(struct elf_tracepoint *etrace, uint64_t addr)
+{
+	uint64_t sec_addr = shdr_addr(data_data_sec);
+	uint64_t sec_offset = shdr_offset(data_data_sec);
+	uint64_t offset = addr - sec_addr + sec_offset;
+	Elf_Ehdr *ehdr = etrace->ehdr;
+	void *name_ptr = (void *)ehdr + offset;
+	char *name;
+
+	if (name_ptr > file_map_end)
+		goto bad_addr;
+
+	if (long_size == 4)
+		addr = r(name_ptr);
+	else
+		addr = r8(name_ptr);
+
+	sec_addr = shdr_addr(ro_data_sec);
+	sec_offset = shdr_offset(ro_data_sec);
+	offset = addr - sec_addr + sec_offset;
+	name = (char *)ehdr + offset;
+	if ((void *)name > file_map_end)
+		goto bad_addr;
+
+	fprintf(stderr, "warning: tracepoint '%s' is unused.\n", name);
+	return 0;
+bad_addr:
+	fprintf(stderr, "warning: Failed to verify unused trace events.\n");
+	return -1;
+}
+
+static void check_tracepoints(struct elf_tracepoint *etrace)
+{
+	uint64_t sec_addr = shdr_addr(ro_data_sec);
+	uint64_t sec_offset = shdr_offset(ro_data_sec);
+	uint64_t offset = etrace->start_tracepoint - sec_addr + sec_offset;
+	uint64_t size = etrace->stop_tracepoint - etrace->start_tracepoint;
+	Elf_Ehdr *ehdr = etrace->ehdr;
+	void *start = (void *)ehdr + offset;
+	void *end = start + size;
+	void *addrs;
+	int inc = long_size;
+
+	if (!etrace->array)
+		return;
+
+	if (!size)
+		return;
+
+#ifdef PREL32_RELOCATIONS
+	inc = 4;
+#endif
+
+	sec_offset = sec_offset + (uint64_t)ehdr;
+	for (addrs = start; addrs < end; addrs += inc) {
+		uint64_t val;
+
+#ifdef PREL32_RELOCATIONS
+		val = r(addrs);
+		val += sec_addr + ((uint64_t)addrs - sec_offset);
+#else
+		val = long_size == 4 ? r(addrs) : r8(addrs);
+#endif
+		if (!find_event(etrace->array, etrace->count, val)) {
+			if (failed_event(etrace, val))
+				return;
+		}
+	}
+	free(etrace->array);
+}
+
+static void *tracepoint_check(struct elf_tracepoint *etrace, Elf_Shdr *symtab_sec,
+			      const char *strtab)
+{
+	Elf_Sym *sym, *end_sym;
+	int symentsize = shdr_entsize(symtab_sec);
+	int found = 0;
+
+	sym = (void *)etrace->ehdr + shdr_offset(symtab_sec);
+	end_sym = (void *)sym + shdr_size(symtab_sec);
+
+	while (sym < end_sym) {
+		if (!strcmp(strtab + sym_name(sym), "__start___tracepoint_check")) {
+			etrace->start_tracepoint_check = sym_value(sym);
+			if (++found == 4)
+				break;
+		} else if (!strcmp(strtab + sym_name(sym), "__stop___tracepoint_check")) {
+			etrace->stop_tracepoint_check = sym_value(sym);
+			if (++found == 4)
+				break;
+		} else if (!strcmp(strtab + sym_name(sym), "__start___tracepoints_ptrs")) {
+			etrace->start_tracepoint = sym_value(sym);
+			if (++found == 4)
+				break;
+		} else if (!strcmp(strtab + sym_name(sym), "__stop___tracepoints_ptrs")) {
+			etrace->stop_tracepoint = sym_value(sym);
+			if (++found == 4)
+				break;
+		}
+		sym = (void *)sym + symentsize;
+	}
+
+	if (!etrace->start_tracepoint_check) {
+		fprintf(stderr, "warning: get start_tracepoint_check error!\n");
+		return NULL;
+	}
+	if (!etrace->stop_tracepoint_check) {
+		fprintf(stderr, "warning: get stop_tracepoint_check error!\n");
+		return NULL;
+	}
+	if (!etrace->start_tracepoint) {
+		fprintf(stderr, "warning: get start_tracepoint error!\n");
+		return NULL;
+	}
+	if (!etrace->stop_tracepoint) {
+		fprintf(stderr, "warning: get start_tracepoint error!\n");
+		return NULL;
+	}
+
+	make_trace_array(etrace);
+	check_tracepoints(etrace);
+
+	return NULL;
+}
+
 static int do_sort(Elf_Ehdr *ehdr,
 		   char const *const fname,
 		   table_sort_t custom_sort)
@@ -948,6 +1158,7 @@ static int do_sort(Elf_Ehdr *ehdr,
 	int i;
 	unsigned int shnum;
 	unsigned int shstrndx;
+	struct elf_tracepoint tstruct = {0};
 #ifdef MCOUNT_SORT_ENABLED
 	struct elf_mcount_loc mstruct = {0};
 #endif
@@ -985,11 +1196,17 @@ static int do_sort(Elf_Ehdr *ehdr,
 			symtab_shndx = (Elf32_Word *)((const char *)ehdr +
 						      shdr_offset(shdr));
 
-#ifdef MCOUNT_SORT_ENABLED
 		/* locate the .init.data section in vmlinux */
 		if (!strcmp(secstrings + idx, ".init.data"))
-			mstruct.init_data_sec = shdr;
-#endif
+			init_data_sec = shdr;
+
+		/* locate the .ro.data section in vmlinux */
+		if (!strcmp(secstrings + idx, ".rodata"))
+			ro_data_sec = shdr;
+
+		/* locate the .data section in vmlinux */
+		if (!strcmp(secstrings + idx, ".data"))
+			data_data_sec = shdr;
 
 #ifdef UNWINDER_ORC_ENABLED
 		/* locate the ORC unwind tables */
@@ -1055,7 +1272,7 @@ static int do_sort(Elf_Ehdr *ehdr,
 	mstruct.ehdr = ehdr;
 	get_mcount_loc(&mstruct, symtab_sec, strtab);
 
-	if (!mstruct.init_data_sec || !mstruct.start_mcount_loc || !mstruct.stop_mcount_loc) {
+	if (!init_data_sec || !mstruct.start_mcount_loc || !mstruct.stop_mcount_loc) {
 		fprintf(stderr,
 			"incomplete mcount's sort in file: %s\n",
 			fname);
@@ -1071,6 +1288,9 @@ static int do_sort(Elf_Ehdr *ehdr,
 	}
 #endif
 
+	tstruct.ehdr = ehdr;
+	tracepoint_check(&tstruct, symtab_sec, strtab);
+
 	if (custom_sort) {
 		custom_sort(extab_image, shdr_size(extab_sec));
 	} else {
@@ -1404,6 +1624,8 @@ int main(int argc, char *argv[])
 			continue;
 		}
 
+		file_map_end = addr + size;
+
 		if (do_file(argv[i], addr))
 			++n_error;
 
-- 
2.47.2



