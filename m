Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89536463342
	for <lists+linux-arch@lfdr.de>; Tue, 30 Nov 2021 12:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241009AbhK3LvE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Nov 2021 06:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241173AbhK3Ltm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Nov 2021 06:49:42 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095AFC061372
        for <linux-arch@vger.kernel.org>; Tue, 30 Nov 2021 03:46:01 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id g80-20020a1c2053000000b003331a764709so13625661wmg.2
        for <linux-arch@vger.kernel.org>; Tue, 30 Nov 2021 03:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1F+MofKXejp7ry8lfe8Rm0bUxzdx8s4N4hiT9E57RpU=;
        b=AxG+zGUAuQz1+vXIOQ6DG6QRjOq3T51cJb6xki7f4JHpONQpFZJx8GE/b7CRWzPCsG
         OLRaS1SxhNRItDJ+4oOUU5VmP/nYksafcZlT3TVFS1SWFBK3vno6Gg3Jm9z1cK6Zuest
         ui1H7XkT5tngcQHFEK6CC8n6Ghp1ypFOZCz94aNFgLZvN+GCnNenOMRE9+mty4qRXv1N
         2qGht/8T/o21I4oyxH8o4aKxIfvvRVeX0nUK1yVoam9e7llKFicSRQUZiaWijAt560uq
         Dg7b5UU9ZIUcjYU29xL3ofX78AIwM6oIKYpH7LDX2euCle6y9eO4jBbsvtISE16oErOr
         I/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1F+MofKXejp7ry8lfe8Rm0bUxzdx8s4N4hiT9E57RpU=;
        b=icQbqY8cxMpV7VmSmI60zxmHRLV7k9uApWYQAMrYM7i1QhfcrEV7laf54ScUsfY6sj
         B0tx9dQ5Yid1LXZy2tuxoV6PdiFdvCsIN8kyaJDjkVPQpwiEZVhZuWd4cBe2jHRuyvBK
         oiStstDmeec1GA+hsTlnHjQJI/J9RFxA/toCFRRbQHveGBqF7W30C6SCpjwrY7H4cgFm
         NdVC5sc2zKeNB5YXsgrCb/RqCpgLelMRAUkTd5X+XUFPfEiF/hcy8ipxo8Jn+UtZ16hJ
         F3lJsCVaOn6u8Ex0nYH2BpIePioAEk/bzknYIzR6js7gUWUfADoSxId83eAKRjodsIuZ
         uT0A==
X-Gm-Message-State: AOAM532DQs0YurmZvUV30qLrg6UHJPAM/WwSsJNYGqoClRb1YZyCkeys
        Fw61GkA+Zn6O+cPFBLwHtxiOiHCkfw==
X-Google-Smtp-Source: ABdhPJyPWvl8zulDnZGqXZ4CGIOsIfQU/gfUk/ZE53ZBn+QfJqlzKFrFzo/IqOCXSYJaXQPpXS6SD3dG+A==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:86b7:11e9:7797:99f0])
 (user=elver job=sendgmr) by 2002:a05:600c:1d1b:: with SMTP id
 l27mr624656wms.1.1638272759191; Tue, 30 Nov 2021 03:45:59 -0800 (PST)
Date:   Tue, 30 Nov 2021 12:44:31 +0100
In-Reply-To: <20211130114433.2580590-1-elver@google.com>
Message-Id: <20211130114433.2580590-24-elver@google.com>
Mime-Version: 1.0
References: <20211130114433.2580590-1-elver@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 23/25] objtool, kcsan: Remove memory barrier
 instrumentation from noinstr
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Teach objtool to turn instrumentation required for memory barrier
modeling into nops in noinstr text.

The __tsan_func_entry/exit calls are still emitted by compilers even
with the __no_sanitize_thread attribute. The memory barrier
instrumentation will be inserted explicitly (without compiler help), and
thus needs to also explicitly be removed.

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
v3:
* s/removable_instr/profiling_func/ (suggested by Josh Poimboeuf)
* s/__kcsan_(mb|wmb|rmb|release)/__atomic_signal_fence/, because
  Clang < 14.0 will still emit these in noinstr even with __no_kcsan.
* Fix and add more comments.

v2:
* Rewrite after rebase to v5.16-rc1.
---
 tools/objtool/check.c               | 37 ++++++++++++++++++++++++-----
 tools/objtool/include/objtool/elf.h |  2 +-
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 61dfb66b30b6..a9a1f7259d62 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1072,11 +1072,11 @@ static void annotate_call_site(struct objtool_file *file,
 	}
 
 	/*
-	 * Many compilers cannot disable KCOV with a function attribute
-	 * so they need a little help, NOP out any KCOV calls from noinstr
-	 * text.
+	 * Many compilers cannot disable KCOV or sanitizer calls with a function
+	 * attribute so they need a little help, NOP out any such calls from
+	 * noinstr text.
 	 */
-	if (insn->sec->noinstr && sym->kcov) {
+	if (insn->sec->noinstr && sym->profiling_func) {
 		if (reloc) {
 			reloc->type = R_NONE;
 			elf_write_reloc(file->elf, reloc);
@@ -1991,6 +1991,31 @@ static int read_intra_function_calls(struct objtool_file *file)
 	return 0;
 }
 
+/*
+ * Return true if name matches an instrumentation function, where calls to that
+ * function from noinstr code can safely be removed, but compilers won't do so.
+ */
+static bool is_profiling_func(const char *name)
+{
+	/*
+	 * Many compilers cannot disable KCOV with a function attribute.
+	 */
+	if (!strncmp(name, "__sanitizer_cov_", 16))
+		return true;
+
+	/*
+	 * Some compilers currently do not remove __tsan_func_entry/exit nor
+	 * __tsan_atomic_signal_fence (used for barrier instrumentation) with
+	 * the __no_sanitize_thread attribute, remove them. Once the kernel's
+	 * minimum Clang version is 14.0, this can be removed.
+	 */
+	if (!strncmp(name, "__tsan_func_", 12) ||
+	    !strcmp(name, "__tsan_atomic_signal_fence"))
+		return true;
+
+	return false;
+}
+
 static int classify_symbols(struct objtool_file *file)
 {
 	struct section *sec;
@@ -2011,8 +2036,8 @@ static int classify_symbols(struct objtool_file *file)
 			if (!strcmp(func->name, "__fentry__"))
 				func->fentry = true;
 
-			if (!strncmp(func->name, "__sanitizer_cov_", 16))
-				func->kcov = true;
+			if (is_profiling_func(func->name))
+				func->profiling_func = true;
 		}
 	}
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index cdc739fa9a6f..d22336781401 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -58,7 +58,7 @@ struct symbol {
 	u8 static_call_tramp : 1;
 	u8 retpoline_thunk   : 1;
 	u8 fentry            : 1;
-	u8 kcov              : 1;
+	u8 profiling_func    : 1;
 	struct list_head pv_target;
 };
 
-- 
2.34.0.rc2.393.gf8c9666880-goog

