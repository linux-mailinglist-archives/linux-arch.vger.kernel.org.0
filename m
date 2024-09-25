Return-Path: <linux-arch+bounces-7406-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A59B986277
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 17:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD181C24C3D
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 15:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8B118C32C;
	Wed, 25 Sep 2024 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MW6uUn+Z"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220AF18BC23
	for <linux-arch@vger.kernel.org>; Wed, 25 Sep 2024 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276533; cv=none; b=RvB3lFeKBTtz8nrGPvdv5Seuzh7rojSjGbGwB/SKVRfcFf15Wg9HycvV2SHJwq0R0QtltnEXrKHcq6Xp1wwFZWlZoUGIqCXLSjL9xrGtLbDcB/iu+vyPtAXMG5IsqBbAk/iDynyLsL/j05/60UJlY+5Sg0qmf70ypJEmldZvgs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276533; c=relaxed/simple;
	bh=uNZCRc4hsOOw5KhJ4tKlrDfm3UOmHFTj64isJZp8vsM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EEQ1FmR9Rkbp+dT4nriXl/QUkz+e5CYMJXjWkrtcNiIEkYX8609gS1j4aH5EZK8K35qKeUWvHZFuYA1WPrH59mOWoCH7EgQzQJ7+2ePL1ogX3f8yh65gxjT2PqNmmcPOqY5Ubzhd4Vi+IqNOtvDw5wQk5uYQ49uDHLRj+tb4vqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MW6uUn+Z; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d683cfa528so87583057b3.0
        for <linux-arch@vger.kernel.org>; Wed, 25 Sep 2024 08:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727276530; x=1727881330; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lvBkJLcu5Sh3tnaE09NAZ6RZ9jqQeWc/oMvpiTXt3OQ=;
        b=MW6uUn+ZkZmLYEiLpaElXr/beisIKf4BBTfjJogoXH37rHomkt2A4B7qCm+Kiwfe8i
         FAqZas4anHYnFdXfVuHp2PvwmUi7ACiKyFFllm2+Z7yRRdclrUYTvUA4tQUPeMShD8LY
         ZlqhyR7ImxJxRIV9h0l72S+BLqNBA/NpY5xzPQfn4O4hKt/jCRIr3jBlqfjocnzMcaHJ
         Bpv1ps4IrEFACOyXPoBaXnoQAOR4VLwaJSCtUt+qWWFLIgC2NW6G0QTsvGprB9LCOqBx
         gmh8TYa5MGBI5H44V6/wqzoDLuiCSDzoe5P5loSjctWpvVH/Z+rmtLwou5SmGz/KPBHe
         knIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276530; x=1727881330;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lvBkJLcu5Sh3tnaE09NAZ6RZ9jqQeWc/oMvpiTXt3OQ=;
        b=Xdf4QRnGblgx/Oec1FuHO0gb3VrdnxbJRVS0BALxMEhpOhhHHFjRSqqMRHbxxLHG7F
         gDV1TISVq+M3tj/DcXptjjOLq8NHbBTgLTfAjwxDS27UehT4CxV5n11iRGWvE8zBilOC
         Gtnzj3yNvO8x0Iix4JVbdF33Ymt+tG13suq8iulIUZyxFBKENjhTJ20zVPw/i8SSpFFd
         hM66fBe2Wf3mGr/EKC/HjLhgNSDekWhp4lKRdXoskX5n/wn/OhBkoZqqeX6r6Otk+l0d
         d74wC20kP9vTptlVZc7wOkzcRpvfwFO40uKVZWcvG770sNZI3ZfHSG82Bn9KdVm8Obnd
         ji2g==
X-Forwarded-Encrypted: i=1; AJvYcCXSEr4+CeJH4CktayaT4xXFVhV2hQZ1GdUipOuvXkTI6T8LW0PsmPaB1XVZgJ/0V/u48ddXUH+jWhjJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxDg43BHX33Kh6wBsg4Jk/5vRAoKfaKFv45YguLboSbbza98Vsw
	RxmMuZkzd6vH8QLpqdEVWuN3mLmELGfzcKn8qU8r23Bcvf1RQunOynWHfuXploi2mcW/zw==
X-Google-Smtp-Source: AGHT+IENPFDDE4RBTdISjbf4G4pk2mGOjzo8FmXYzCFJ7WDt9ZFnIbiw80yVnuCNeltTBlMkQAqf4tvt
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:c9c:b0:6b0:d571:3540 with SMTP id
 00721157ae682-6e21da796e6mr255067b3.6.1727276529787; Wed, 25 Sep 2024
 08:02:09 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:01:08 +0200
In-Reply-To: <20240925150059.3955569-30-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6334; i=ardb@kernel.org;
 h=from:subject; bh=rOkV7b1W8gqAvLsLoQ2i9zRn35wAefNGZsd9tIotAWg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2L6vYGW5mupTcMu0+/lmvg/R+5wEt4Wbk5z8ydQtZqX
 U8bN7/vKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABO5Lc3wP3L7HcnzmyvvZR1M
 rS85onToQ4R+5Y7wJefSbJaqGNxXYmVkaHXklA3NNHruJrHYtjJMvdzeSUx0wZXnutnTlvEcNXD iBAA=
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240925150059.3955569-38-ardb+git@google.com>
Subject: [RFC PATCH 08/28] scripts/kallsyms: Remove support for absolute
 per-CPU variables
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

SMP on x86_64 no longer needs absolute per-CPU variables, so this
support can be dropped from kallsyms as well, as no other architectures
rely on this functionality.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 init/Kconfig            |  4 --
 kernel/kallsyms.c       | 12 +----
 scripts/kallsyms.c      | 51 +++-----------------
 scripts/link-vmlinux.sh |  4 --
 4 files changed, 9 insertions(+), 62 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index be8a9a786d3c..f6eeba81282d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1835,10 +1835,6 @@ config KALLSYMS_ALL
 
 	  Say N unless you really need all symbols, or kernel live patching.
 
-config KALLSYMS_ABSOLUTE_PERCPU
-	bool
-	depends on KALLSYMS
-
 # end of the "standard kernel features (expert users)" menu
 
 config ARCH_HAS_MEMBARRIER_CALLBACKS
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index a9a0ca605d4a..4198f30aac3c 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -148,16 +148,8 @@ static unsigned int get_symbol_offset(unsigned long pos)
 
 unsigned long kallsyms_sym_address(int idx)
 {
-	/* values are unsigned offsets if --absolute-percpu is not in effect */
-	if (!IS_ENABLED(CONFIG_KALLSYMS_ABSOLUTE_PERCPU))
-		return kallsyms_relative_base + (u32)kallsyms_offsets[idx];
-
-	/* ...otherwise, positive offsets are absolute values */
-	if (kallsyms_offsets[idx] >= 0)
-		return kallsyms_offsets[idx];
-
-	/* ...and negative offsets are relative to kallsyms_relative_base - 1 */
-	return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
+	/* values are unsigned offsets */
+	return kallsyms_relative_base + (u32)kallsyms_offsets[idx];
 }
 
 static unsigned int get_symbol_seq(int index)
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 09757d300a05..9c34b9397872 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -5,7 +5,7 @@
  * This software may be used and distributed according to the terms
  * of the GNU General Public License, incorporated herein by reference.
  *
- * Usage: kallsyms [--all-symbols] [--absolute-percpu]  in.map > out.S
+ * Usage: kallsyms [--all-symbols]  in.map > out.S
  *
  *      Table compression uses all the unused char codes on the symbols and
  *  maps these to the most used substrings (tokens). For instance, it might
@@ -37,7 +37,6 @@ struct sym_entry {
 	unsigned long long addr;
 	unsigned int len;
 	unsigned int seq;
-	bool percpu_absolute;
 	unsigned char sym[];
 };
 
@@ -62,7 +61,6 @@ static struct addr_range percpu_range = {
 static struct sym_entry **table;
 static unsigned int table_size, table_cnt;
 static int all_symbols;
-static int absolute_percpu;
 
 static int token_profit[0x10000];
 
@@ -73,7 +71,7 @@ static unsigned char best_table_len[256];
 
 static void usage(void)
 {
-	fprintf(stderr, "Usage: kallsyms [--all-symbols] [--absolute-percpu] in.map > out.S\n");
+	fprintf(stderr, "Usage: kallsyms [--all-symbols] in.map > out.S\n");
 	exit(1);
 }
 
@@ -175,7 +173,6 @@ static struct sym_entry *read_symbol(FILE *in, char **buf, size_t *buf_len)
 	sym->len = len;
 	sym->sym[0] = type;
 	strcpy(sym_name(sym), name);
-	sym->percpu_absolute = false;
 
 	return sym;
 }
@@ -319,11 +316,6 @@ static int expand_symbol(const unsigned char *data, int len, char *result)
 	return total;
 }
 
-static bool symbol_absolute(const struct sym_entry *s)
-{
-	return s->percpu_absolute;
-}
-
 static int compare_names(const void *a, const void *b)
 {
 	int ret;
@@ -457,20 +449,10 @@ static void write_src(void)
 		long long offset;
 		bool overflow;
 
-		if (!absolute_percpu) {
-			offset = table[i]->addr - relative_base;
-			overflow = offset < 0 || offset > UINT_MAX;
-		} else if (symbol_absolute(table[i])) {
-			offset = table[i]->addr;
-			overflow = offset < 0 || offset > INT_MAX;
-		} else {
-			offset = relative_base - table[i]->addr - 1;
-			overflow = offset < INT_MIN || offset >= 0;
-		}
+		offset = table[i]->addr - relative_base;
+		overflow = (offset < 0 || offset > UINT_MAX);
 		if (overflow) {
-			fprintf(stderr, "kallsyms failure: "
-				"%s symbol value %#llx out of range in relative mode\n",
-				symbol_absolute(table[i]) ? "absolute" : "relative",
+			fprintf(stderr, "kallsyms failure: symbol value %#llx out of range\n",
 				table[i]->addr);
 			exit(EXIT_FAILURE);
 		}
@@ -725,32 +707,16 @@ static void sort_symbols(void)
 	qsort(table, table_cnt, sizeof(table[0]), compare_symbols);
 }
 
-static void make_percpus_absolute(void)
-{
-	unsigned int i;
-
-	for (i = 0; i < table_cnt; i++)
-		if (symbol_in_range(table[i], &percpu_range, 1)) {
-			/*
-			 * Keep the 'A' override for percpu symbols to
-			 * ensure consistent behavior compared to older
-			 * versions of this tool.
-			 */
-			table[i]->sym[0] = 'A';
-			table[i]->percpu_absolute = true;
-		}
-}
-
 /* find the minimum non-absolute symbol address */
 static void record_relative_base(void)
 {
 	unsigned int i;
 
 	for (i = 0; i < table_cnt; i++)
-		if (table[i]->addr && !symbol_absolute(table[i])) {
+		if (table[i]->addr) {
 			/*
 			 * The table is sorted by address.
-			 * Take the first non-absolute symbol value.
+			 * Take the first non-zero symbol value.
 			 */
 			relative_base = table[i]->addr;
 			return;
@@ -762,7 +728,6 @@ int main(int argc, char **argv)
 	while (1) {
 		static const struct option long_options[] = {
 			{"all-symbols",     no_argument, &all_symbols,     1},
-			{"absolute-percpu", no_argument, &absolute_percpu, 1},
 			{},
 		};
 
@@ -779,8 +744,6 @@ int main(int argc, char **argv)
 
 	read_map(argv[optind]);
 	shrink_table();
-	if (absolute_percpu)
-		make_percpus_absolute();
 	sort_symbols();
 	record_relative_base();
 	optimize_token_table();
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index a9b3f34a78d2..df5f3fbb46f3 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -140,10 +140,6 @@ kallsyms()
 		kallsymopt="${kallsymopt} --all-symbols"
 	fi
 
-	if is_enabled CONFIG_KALLSYMS_ABSOLUTE_PERCPU; then
-		kallsymopt="${kallsymopt} --absolute-percpu"
-	fi
-
 	info KSYMS "${2}.S"
 	scripts/kallsyms ${kallsymopt} "${1}" > "${2}.S"
 
-- 
2.46.0.792.g87dc391469-goog


