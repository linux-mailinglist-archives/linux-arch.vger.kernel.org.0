Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12FA28C609
	for <lists+linux-arch@lfdr.de>; Tue, 13 Oct 2020 02:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgJMAdC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 20:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbgJMAcK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Oct 2020 20:32:10 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D09C0613D0
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 17:32:10 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id c67so13739250pfb.23
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 17:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TMDqK7SaU5cOFiGBMdZ8Uvp/vuFhiQD2dpfcaMKefDQ=;
        b=IXTPLb0yFS0o2Ga79gr7xdNEuO4HV13KRVxV2TTekWKuTZxx//v6pgCz5d15EYldkD
         BZ57RN/e61FhDemXvwUx/f/NWB6TRPm+Js/jxH+Ozhr38+xqoMr+mLGrfiRquS2j3kZJ
         fYrUrVndpVuef4YOld3pXFi3jcBOAwRlkcsfQZwg/xUdayEHuKtVYacnXMtm0b/I38Qx
         WxiKUnZ+mL2wNK3BuVJubCd8sZKHY38WZpOm/vNkaFMYl+vqbCp10u/22PEAKbjAh45D
         sMdah9r1FW+zKiF03OY7alXL/9E4fBd9YI1yEFlLk7unOBGLusyORO3j8boBtmXDyJax
         UZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TMDqK7SaU5cOFiGBMdZ8Uvp/vuFhiQD2dpfcaMKefDQ=;
        b=NihCDURRYJ2UOEuYDRbKkD53LwIVpJWJgjvYHU8WGuqX7SQrIWbFXeFQe1uddiXG9/
         d5Doh8K0vzPcuPSeLidCGVg5CwkRO40Lg+z5wkonsgEBhRbahkveoSrOBnaOSfMMIKLm
         hRxa8WsmQf1E1szegjXIvz+3CjaIDSBl8V87Pv9Kuft3LuylWjBa2O5cAqSIExm7a8zG
         XTMr0KZgt3oF6I8hTqsrXk6MwnEJu+meT1RMRZ/UWXwxHHpEExErRdiPDu3cuLdhJLXR
         DFZkQIA0RA7032ggNZpTEUVR8PrHU0QPi7OM0N6L5xDl5GUf7sFuaK8j2Dv+liEV787I
         9KVA==
X-Gm-Message-State: AOAM530p/8IilusCI6QaVoKk4Z2etrjt9lASC0BaBDWATIYOMuP9WRwz
        c8sUsKKUbKVXEyJYUVmU8ws6hwhRiAuN0xsh0hw=
X-Google-Smtp-Source: ABdhPJzsd4CCmnhcLZkBRbfSKkJeEB8ZYCNEDRSF1U6z3faMrYXBKcMOZdLok8oHysnniolDxRFIZGt/9cwSiZFRwQU=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a17:90a:940c:: with SMTP id
 r12mr3210626pjo.1.1602549129256; Mon, 12 Oct 2020 17:32:09 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:31:40 -0700
In-Reply-To: <20201013003203.4168817-1-samitolvanen@google.com>
Message-Id: <20201013003203.4168817-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v6 02/25] objtool: Add a pass for generating __mcount_loc
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Add the --mcount option for generating __mcount_loc sections
needed for dynamic ftrace. Using this pass requires the kernel to
be compiled with -mfentry and CC_USING_NOP_MCOUNT to be defined
in Makefile.

Link: https://lore.kernel.org/lkml/20200625200235.GQ4781@hirez.programming.kicks-ass.net/
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
[Sami: rebased, dropped config changes, fixed to actually use --mcount,
       and wrote a commit message.]
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 tools/objtool/builtin-check.c |  3 +-
 tools/objtool/builtin.h       |  2 +-
 tools/objtool/check.c         | 82 +++++++++++++++++++++++++++++++++++
 tools/objtool/check.h         |  1 +
 tools/objtool/objtool.c       |  1 +
 tools/objtool/objtool.h       |  1 +
 6 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index c6d199bfd0ae..e92e76f69176 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -18,7 +18,7 @@
 #include "builtin.h"
 #include "objtool.h"
 
-bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux;
+bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux, mcount;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -35,6 +35,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('s', "stats", &stats, "print statistics"),
 	OPT_BOOLEAN('d', "duplicate", &validate_dup, "duplicate validation for vmlinux.o"),
 	OPT_BOOLEAN('l', "vmlinux", &vmlinux, "vmlinux.o validation"),
+	OPT_BOOLEAN('M', "mcount", &mcount, "generate __mcount_loc"),
 	OPT_END(),
 };
 
diff --git a/tools/objtool/builtin.h b/tools/objtool/builtin.h
index 85c979caa367..94565a72b701 100644
--- a/tools/objtool/builtin.h
+++ b/tools/objtool/builtin.h
@@ -8,7 +8,7 @@
 #include <subcmd/parse-options.h>
 
 extern const struct option check_options[];
-extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux;
+extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux, mcount;
 
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c6ab44543c92..c39c4d2b432a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -523,6 +523,65 @@ static int create_static_call_sections(struct objtool_file *file)
 	return 0;
 }
 
+static int create_mcount_loc_sections(struct objtool_file *file)
+{
+	struct section *sec, *reloc_sec;
+	struct reloc *reloc;
+	unsigned long *loc;
+	struct instruction *insn;
+	int idx;
+
+	sec = find_section_by_name(file->elf, "__mcount_loc");
+	if (sec) {
+		INIT_LIST_HEAD(&file->mcount_loc_list);
+		WARN("file already has __mcount_loc section, skipping");
+		return 0;
+	}
+
+	if (list_empty(&file->mcount_loc_list))
+		return 0;
+
+	idx = 0;
+	list_for_each_entry(insn, &file->mcount_loc_list, mcount_loc_node)
+		idx++;
+
+	sec = elf_create_section(file->elf, "__mcount_loc", 0, sizeof(unsigned long), idx);
+	if (!sec)
+		return -1;
+
+	reloc_sec = elf_create_reloc_section(file->elf, sec, SHT_RELA);
+	if (!reloc_sec)
+		return -1;
+
+	idx = 0;
+	list_for_each_entry(insn, &file->mcount_loc_list, mcount_loc_node) {
+
+		loc = (unsigned long *)sec->data->d_buf + idx;
+		memset(loc, 0, sizeof(unsigned long));
+
+		reloc = malloc(sizeof(*reloc));
+		if (!reloc) {
+			perror("malloc");
+			return -1;
+		}
+		memset(reloc, 0, sizeof(*reloc));
+
+		reloc->sym = insn->sec->sym;
+		reloc->addend = insn->offset;
+		reloc->type = R_X86_64_64;
+		reloc->offset = idx * sizeof(unsigned long);
+		reloc->sec = reloc_sec;
+		elf_add_reloc(file->elf, reloc);
+
+		idx++;
+	}
+
+	if (elf_rebuild_reloc_section(file->elf, reloc_sec))
+		return -1;
+
+	return 0;
+}
+
 /*
  * Warnings shouldn't be reported for ignored functions.
  */
@@ -949,6 +1008,22 @@ static int add_call_destinations(struct objtool_file *file)
 			insn->type = INSN_NOP;
 		}
 
+		if (mcount && !strcmp(insn->call_dest->name, "__fentry__")) {
+			if (reloc) {
+				reloc->type = R_NONE;
+				elf_write_reloc(file->elf, reloc);
+			}
+
+			elf_write_insn(file->elf, insn->sec,
+				       insn->offset, insn->len,
+				       arch_nop_insn(insn->len));
+
+			insn->type = INSN_NOP;
+
+			list_add_tail(&insn->mcount_loc_node,
+				      &file->mcount_loc_list);
+		}
+
 		/*
 		 * Whatever stack impact regular CALLs have, should be undone
 		 * by the RETURN of the called function.
@@ -2920,6 +2995,13 @@ int check(struct objtool_file *file)
 		goto out;
 	warnings += ret;
 
+	if (mcount) {
+		ret = create_mcount_loc_sections(file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
+	}
+
 out:
 	if (ret < 0) {
 		/*
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 5ec00a4b891b..070baec2050a 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -23,6 +23,7 @@ struct instruction {
 	struct list_head list;
 	struct hlist_node hash;
 	struct list_head static_call_node;
+	struct list_head mcount_loc_node;
 	struct section *sec;
 	unsigned long offset;
 	unsigned int len;
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 9df0cd86d310..c1819a6f2a18 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -62,6 +62,7 @@ struct objtool_file *objtool_open_read(const char *_objname)
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
 	INIT_LIST_HEAD(&file.static_call_list);
+	INIT_LIST_HEAD(&file.mcount_loc_list);
 	file.c_file = !vmlinux && find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
 	file.hints = false;
diff --git a/tools/objtool/objtool.h b/tools/objtool/objtool.h
index 4125d4578b23..cf004dd60c2b 100644
--- a/tools/objtool/objtool.h
+++ b/tools/objtool/objtool.h
@@ -19,6 +19,7 @@ struct objtool_file {
 	struct list_head insn_list;
 	DECLARE_HASHTABLE(insn_hash, 20);
 	struct list_head static_call_list;
+	struct list_head mcount_loc_list;
 	bool ignore_unreachables, c_file, hints, rodata;
 };
 
-- 
2.28.0.1011.ga647a8990f-goog

