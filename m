Return-Path: <linux-arch+bounces-12332-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C9CAD7F4D
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 02:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF53317E347
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 00:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09BA17996;
	Fri, 13 Jun 2025 00:01:59 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7214128EA;
	Fri, 13 Jun 2025 00:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749772919; cv=none; b=CCMoV0c4Jll4oEMb2szuocTnLBu6cGcDWnOGavSZzv1kUy3AtsOeVFERKGmbX5sLXpV78y/aAVTJVqyU404+FZsWcYD/qTIqrR6lCag1wY/mr4BTzzo7+bvA9ilpilsK/ymoLCDXCh7HICaq4EWpDhP7Ju8afBUB0YaDK25BWIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749772919; c=relaxed/simple;
	bh=4GTdnC8JJoqpNwB/W+g1szxDcReQDCIveoymk3DB28I=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=mzXr6DY97jRl8lVgBpd77rVStheoVr2cCPgiDp5kobBHVy03cokld0Ryoc6exkMedpDqNmDexxdXiold/OYh2lDrTyX/x519sumVZuxpp1WxEIzMMBIem/GUrONDBGx+9ztGstmn8Hcabjs9eYxSQjESQxbRnmsMLuIyM90j04c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id B9B74803EA;
	Fri, 13 Jun 2025 00:01:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 820CB18;
	Fri, 13 Jun 2025 00:01:52 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uPrtJ-00000001wmf-0POY;
	Thu, 12 Jun 2025 20:03:29 -0400
Message-ID: <20250613000328.962609745@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 12 Jun 2025 19:58:30 -0400
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
Subject: [PATCH v2 3/5] tracing: sorttable: Find unused tracepoints for arm64 that uses reloc
 for address
References: <20250612235827.011358765@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Stat-Signature: 8k1kipsk1c1z5bdwtzwd3ct48fupbpho
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 820CB18
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18pxPIE4BEuo+aRZnoqQLoutoFqpJrDGFk=
X-HE-Tag: 1749772912-602137
X-HE-Meta: U2FsdGVkX1/61XheUcbJtxERV5nct7NlnwnRNyUAUcsAPtW6D+l/COSEV9CvIbKPffQHuyfIJyKhKxZnjW07v+neNNkpmO2J3HcvNnJO7R4RwEhHGgACoFevUKlI8B7ClIC4DBUiFOCROXu0yO+6p48PtCU8Am1la4nqH2OXU62HdFLmbn5nzDoAUcyWsyPknnXqNGrIhlzAxg1yEjXlFe5/YApf0e+44YGakcUinidZW1XYb20QNjCC8W3RkreXgVyrATyJzJs4Xae78NT90d++vIWOk/WeGV5hHR95VqorA0KDyqOW18MQkgsud39KivUcqVVJxg1Y7Kryvm/+UGfotK/D1prGX7rltBa83KPDePVgK6O3YsNA7X1kHGSWlhJAvjtfxZOeXSb6yaCEuA==

From: Steven Rostedt <rostedt@goodmis.org>

The addresses in the ARM64 ELF file is stored in the RELA sections similar
to the mcount location table. Add support to find the addresses from the
RELA section to use to get the actual addresses for checking the
tracepoints and the checking variables to show if all tracepoints are
used.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 scripts/sorttable.c | 186 ++++++++++++++++++++++++++++----------------
 1 file changed, 118 insertions(+), 68 deletions(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index ddcbec22ca96..edca5b06d8ce 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -578,6 +578,106 @@ static int compare_values_32(const void *a, const void *b)
 
 static int (*compare_values)(const void *a, const void *b);
 
+static char m_err[ERRSTR_MAXSZ];
+static long rela_type;
+static bool sort_reloc;
+static int reloc_shnum;
+
+/* Fill the array with the content of the relocs */
+static int fill_relocs(void *ptr, uint64_t size, Elf_Ehdr *ehdr, uint64_t start_loc)
+{
+	Elf_Shdr *shdr_start;
+	Elf_Rela *rel;
+	unsigned int shnum;
+	unsigned int count = 0;
+	int shentsize;
+	void *array_end = ptr + size;
+
+	shdr_start = (Elf_Shdr *)((char *)ehdr + ehdr_shoff(ehdr));
+	shentsize = ehdr_shentsize(ehdr);
+
+	shnum = ehdr_shnum(ehdr);
+	if (shnum == SHN_UNDEF)
+		shnum = shdr_size(shdr_start);
+
+	for (int i = 0; i < shnum; i++) {
+		Elf_Shdr *shdr = get_index(shdr_start, shentsize, i);
+		void *end;
+
+		if (shdr_type(shdr) != SHT_RELA)
+			continue;
+
+		reloc_shnum = i;
+
+		rel = (void *)ehdr + shdr_offset(shdr);
+		end = (void *)rel + shdr_size(shdr);
+
+		for (; (void *)rel < end; rel = (void *)rel + shdr_entsize(shdr)) {
+			uint64_t offset = rela_offset(rel);
+
+			if (offset >= start_loc && offset < start_loc + size) {
+				if (ptr + long_size > array_end) {
+					snprintf(m_err, ERRSTR_MAXSZ,
+						 "Too many relocations");
+					return -1;
+				}
+
+				/* Make sure this has the correct type */
+				if (rela_info(rel) != rela_type) {
+					snprintf(m_err, ERRSTR_MAXSZ,
+						"rela has type %lx but expected %lx\n",
+						(long)rela_info(rel), rela_type);
+					return -1;
+				}
+
+				if (long_size == 4)
+					*(uint32_t *)ptr = rela_addend(rel);
+				else
+					*(uint64_t *)ptr = rela_addend(rel);
+				ptr += long_size;
+				count++;
+			}
+		}
+	}
+	return count;
+}
+
+static uint64_t get_addr_reloc(Elf_Ehdr *ehdr, uint64_t addr)
+{
+	Elf_Shdr *shdr_start;
+	Elf_Shdr *shdr;
+	Elf_Rela *rel;
+	unsigned int shnum;
+	int shentsize;
+	void *end;
+
+	shdr_start = (Elf_Shdr *)((char *)ehdr + ehdr_shoff(ehdr));
+	shentsize = ehdr_shentsize(ehdr);
+
+	shnum = ehdr_shnum(ehdr);
+	if (shnum == SHN_UNDEF)
+		shnum = shdr_size(shdr_start);
+
+	shdr = get_index(shdr_start, shentsize, reloc_shnum);
+	if (shdr_type(shdr) != SHT_RELA)
+		return 0;
+
+	rel = (void *)ehdr + shdr_offset(shdr);
+	end = (void *)rel + shdr_size(shdr);
+
+	for (; (void *)rel < end; rel = (void *)rel + shdr_entsize(shdr)) {
+		uint64_t offset = rela_offset(rel);
+
+		if (offset == addr) {
+			if (long_size == 4)
+				return rela_addend(rel);
+			else
+				return rela_addend(rel);
+		}
+	}
+	return 0;
+}
+
 static int fill_addrs(void *ptr, uint64_t size, void *addrs)
 {
 	void *end = ptr + size;
@@ -696,11 +796,6 @@ static int parse_symbols(const char *fname)
 }
 
 static pthread_t mcount_sort_thread;
-static bool sort_reloc;
-
-static long rela_type;
-
-static char m_err[ERRSTR_MAXSZ];
 
 struct elf_mcount_loc {
 	Elf_Ehdr *ehdr;
@@ -708,63 +803,6 @@ struct elf_mcount_loc {
 	uint64_t stop_mcount_loc;
 };
 
-/* Fill the array with the content of the relocs */
-static int fill_relocs(void *ptr, uint64_t size, Elf_Ehdr *ehdr, uint64_t start_loc)
-{
-	Elf_Shdr *shdr_start;
-	Elf_Rela *rel;
-	unsigned int shnum;
-	unsigned int count = 0;
-	int shentsize;
-	void *array_end = ptr + size;
-
-	shdr_start = (Elf_Shdr *)((char *)ehdr + ehdr_shoff(ehdr));
-	shentsize = ehdr_shentsize(ehdr);
-
-	shnum = ehdr_shnum(ehdr);
-	if (shnum == SHN_UNDEF)
-		shnum = shdr_size(shdr_start);
-
-	for (int i = 0; i < shnum; i++) {
-		Elf_Shdr *shdr = get_index(shdr_start, shentsize, i);
-		void *end;
-
-		if (shdr_type(shdr) != SHT_RELA)
-			continue;
-
-		rel = (void *)ehdr + shdr_offset(shdr);
-		end = (void *)rel + shdr_size(shdr);
-
-		for (; (void *)rel < end; rel = (void *)rel + shdr_entsize(shdr)) {
-			uint64_t offset = rela_offset(rel);
-
-			if (offset >= start_loc && offset < start_loc + size) {
-				if (ptr + long_size > array_end) {
-					snprintf(m_err, ERRSTR_MAXSZ,
-						 "Too many relocations");
-					return -1;
-				}
-
-				/* Make sure this has the correct type */
-				if (rela_info(rel) != rela_type) {
-					snprintf(m_err, ERRSTR_MAXSZ,
-						"rela has type %lx but expected %lx\n",
-						(long)rela_info(rel), rela_type);
-					return -1;
-				}
-
-				if (long_size == 4)
-					*(uint32_t *)ptr = rela_addend(rel);
-				else
-					*(uint64_t *)ptr = rela_addend(rel);
-				ptr += long_size;
-				count++;
-			}
-		}
-	}
-	return count;
-}
-
 /* Put the sorted vals back into the relocation elements */
 static void replace_relocs(void *ptr, uint64_t size, Elf_Ehdr *ehdr, uint64_t start_loc)
 {
@@ -957,7 +995,15 @@ static void make_trace_array(struct elf_tracepoint *etrace)
 		return;
 	}
 
-	count = fill_addrs(vals, size, start);
+	if (sort_reloc) {
+		count = fill_relocs(vals, size, ehdr, etrace->start_tracepoint_check);
+		/* gcc may use relocs to save the addresses, but clang does not. */
+		if (!count) {
+			count = fill_addrs(vals, size, start);
+			sort_reloc = 0;
+		}
+	} else
+		count = fill_addrs(vals, size, start);
 
 	compare_values = long_size == 4 ? compare_values_32 : compare_values_64;
 	qsort(vals, count, long_size, compare_values);
@@ -1017,10 +1063,14 @@ static int failed_event(struct elf_tracepoint *etrace, uint64_t addr)
 	if (name_ptr > file_map_end)
 		goto bad_addr;
 
-	if (long_size == 4)
-		addr = r(name_ptr);
-	else
-		addr = r8(name_ptr);
+	if (sort_reloc) {
+		addr = get_addr_reloc(ehdr, addr);
+	} else {
+		if (long_size == 4)
+			addr = r(name_ptr);
+		else
+			addr = r8(name_ptr);
+	}
 
 	sec_addr = shdr_addr(ro_data_sec);
 	sec_offset = shdr_offset(ro_data_sec);
@@ -1473,9 +1523,9 @@ static int do_file(char const *const fname, void *addr)
 
 	switch (r2(&ehdr->e32.e_machine)) {
 	case EM_AARCH64:
-#ifdef MCOUNT_SORT_ENABLED
 		sort_reloc = true;
 		rela_type = 0x403;
+#ifdef MCOUNT_SORT_ENABLED
 		/* arm64 uses patchable function entry placing before function */
 		before_func = 8;
 #endif
-- 
2.47.2



