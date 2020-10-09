Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BAA288E80
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 18:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389144AbgJIQQG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 12:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389663AbgJIQNu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2020 12:13:50 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8E3C0613DA
        for <linux-arch@vger.kernel.org>; Fri,  9 Oct 2020 09:13:45 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id s9so6639197plq.15
        for <linux-arch@vger.kernel.org>; Fri, 09 Oct 2020 09:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=U8f6ydCzrFA1+gsHZeI/xdFghtBOR6cuTFbAmTrQoXE=;
        b=AItaKTzLek+Kl7jK3RNLvZRYo7H+x3YRAWKjf/ABpeXnBLdWaZUH0Hlh1KpIONMTwq
         jiYyf8+3C7oQRhMwU8bIBlq0UHWYZXhJhwT583e1of4hboHqIxwmj7UteX5nb9U3z34d
         Duq/s5v91hPc3mZ1sWLt2I+oh6/4bTz4zMiBXguAmWySuKoU/4KEli88R9buTO6Znlhl
         oUrVM67QZgCiMINt0i6ppWsu6a1Z81LQn7HTvCzQaP6BOwhbxQmEuwmkiUxs9nchgwOf
         wP2l2UXnMkIlmqlSyzAESBkf2xSWjcChp3Bq4f/Xu0hGHvdc0s1tC7YeBUZbuCyoMYrz
         /BRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U8f6ydCzrFA1+gsHZeI/xdFghtBOR6cuTFbAmTrQoXE=;
        b=TlzxnuLdrr4I8Evfte8Hsmibp04rgzCi0adas9TO4KJ+hsPcd43k8wsfiwVYMCYiLh
         wQVjoY5e7H2PT3YC0nShCFy5KsUPV+470+8vYbizbCRmLkBC/XtAvzmXTHLv+jpmndJe
         gzssLQd0jddquLfqfQGQ3DXtzmTwJUmxeR6ZveXjIjdkB8jey8NM5nWgdkBgvwcXbXCO
         CP4j/OqIa8OeKMNwE2w/nRPaRCqwiny29daXWsbXVCydUJyqKW4W692jxZ5/pqqQudrN
         B+ea5uUUiCoJW7w4cbo15bHxblfncjX3mVquk9/iiFtrSDIKYAkfa1okfNTpgNfbCOan
         J2XA==
X-Gm-Message-State: AOAM531l6Ocbihew+K7FEGsvww54pjrE1Ugv35hOM4ltUhi/LLe1p0YJ
        C96MT14JZK93O7wkjtvZSJPrQyjLb3KhWnR/Tp0=
X-Google-Smtp-Source: ABdhPJwI3rPMzgx92txY8T8cv2wnkKpDmMqEAMKh3J40sl8wPiOy4wivyYi5erW3mMoN7CkZzYGTL+4hic37o6P26LY=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a63:370f:: with SMTP id
 e15mr2644515pga.124.1602260024950; Fri, 09 Oct 2020 09:13:44 -0700 (PDT)
Date:   Fri,  9 Oct 2020 09:13:11 -0700
In-Reply-To: <20201009161338.657380-1-samitolvanen@google.com>
Message-Id: <20201009161338.657380-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201009161338.657380-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 02/29] objtool: Add a pass for generating __mcount_loc
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
 tools/objtool/builtin-check.c           |  3 +-
 tools/objtool/check.c                   | 82 +++++++++++++++++++++++++
 tools/objtool/include/objtool/builtin.h |  2 +-
 tools/objtool/include/objtool/check.h   |  1 +
 tools/objtool/include/objtool/objtool.h |  1 +
 tools/objtool/objtool.c                 |  1 +
 6 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index f47951e19c9d..6518c1a6ad1e 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -18,7 +18,7 @@
 #include <objtool/builtin.h>
 #include <objtool/objtool.h>
 
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
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 32e6a0db6768..61dcd80feec5 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -524,6 +524,65 @@ static int create_static_call_sections(struct objtool_file *file)
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
@@ -950,6 +1009,22 @@ static int add_call_destinations(struct objtool_file *file)
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
@@ -2921,6 +2996,13 @@ int check(struct objtool_file *file)
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
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 85c979caa367..94565a72b701 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -8,7 +8,7 @@
 #include <subcmd/parse-options.h>
 
 extern const struct option check_options[];
-extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux;
+extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats, validate_dup, vmlinux, mcount;
 
 extern int cmd_check(int argc, const char **argv);
 extern int cmd_orc(int argc, const char **argv);
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index bba10968eac0..f04415852c29 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -23,6 +23,7 @@ struct instruction {
 	struct list_head list;
 	struct hlist_node hash;
 	struct list_head static_call_node;
+	struct list_head mcount_loc_node;
 	struct section *sec;
 	unsigned long offset;
 	unsigned int len;
diff --git a/tools/objtool/include/objtool/objtool.h b/tools/objtool/include/objtool/objtool.h
index 32f4cd1da9fa..3c899e0ab861 100644
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -19,6 +19,7 @@ struct objtool_file {
 	struct list_head insn_list;
 	DECLARE_HASHTABLE(insn_hash, 20);
 	struct list_head static_call_list;
+	struct list_head mcount_loc_list;
 	bool ignore_unreachables, c_file, hints, rodata;
 };
 
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index e848feb0a5fc..7b97ce499405 100644
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
-- 
2.28.0.1011.ga647a8990f-goog

