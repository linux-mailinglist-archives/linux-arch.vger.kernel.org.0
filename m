Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A316845A182
	for <lists+linux-arch@lfdr.de>; Tue, 23 Nov 2021 12:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbhKWLc4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Nov 2021 06:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbhKWLcz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Nov 2021 06:32:55 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8726CC061746
        for <linux-arch@vger.kernel.org>; Tue, 23 Nov 2021 03:29:47 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso1909796wmr.4
        for <linux-arch@vger.kernel.org>; Tue, 23 Nov 2021 03:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RCz+vh2bGRc6vOt1cmcyty/tcvje22f5Ps81nyvaJl8=;
        b=iORsK4eh4R+VVO0sDDWs6uTCsHBtofK80yTNi9dqOfNYeed7XHyX/ZfeH+Dt/A2Mmr
         ibZcB9b26lSFWliz15RiW1sj9gi+8SymVg50wZHsg4kCilz1jTj457cJpB+lC0i2Jw0t
         7zk4vqDtR4SIpE4Ak5/Ihi93S1MuMyeQh3TV/q8qcP77MzIAGUzsEhpHJvK4n3rgn5Vx
         B1wfxE32t81OHx+/2be9ibS6Pif8hlJKRWcKJftKQ+ehU3nb+NOxk46JYSgNYRj5qr1r
         my70BvYQfLjB6Fbt7G3JOfy+QD0RhUzJi1S7h4rogn5D8SGsHp4Ikmb4/hSnuYfHnP9x
         ZVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RCz+vh2bGRc6vOt1cmcyty/tcvje22f5Ps81nyvaJl8=;
        b=d92iSsOMj8PigHvLoRGR5Zyms/uled37hymya6MJjT7d2SZobJc96vx3eQWD2MvkvO
         Cqt1YVxI48y5X0TgCIcfk9kectbh3PcADm+srE3IHMzimOLcrywdA7Qf/7x+uPDaczza
         EZkYLrSgvURq+4likUldvYqO6HhZ9gB2yfy7QwlNk4fEA5Ch8OTXcYm9EVefm2/kcTtH
         MzTNtjv0GB7pUfczmbfLngoGBlyeUUKg8c9RKuTiOC5Vqn5Bj6OAMWOaJEG3CTC2SvEg
         ZCljPAi9MiE7ItCqa707RkzosQCcflvLbhKZRge+ZHHpoG0Pq/s1qlKg6ETuGFQg2iK3
         4IrA==
X-Gm-Message-State: AOAM530a45s0EYJdjbmRugswz3qnGBrsSCHcF5OMjpSq3GEbJKR2DJ2l
        U7XfVZvlbDW1bBKhS2hEYOWlkg==
X-Google-Smtp-Source: ABdhPJxgNU3F5ZbiL2IqSNSUEI6y0Mv5STMnCz4bk2DhNavYM0VNX4mAmCashJwrmSsH5krcZ0V+eg==
X-Received: by 2002:a05:600c:1c20:: with SMTP id j32mr2110302wms.1.1637666985890;
        Tue, 23 Nov 2021 03:29:45 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:1444:3668:5c57:85cc])
        by smtp.gmail.com with ESMTPSA id k27sm1041180wms.41.2021.11.23.03.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:29:44 -0800 (PST)
Date:   Tue, 23 Nov 2021 12:29:39 +0100
From:   Marco Elver <elver@google.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
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
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v2 23/23] objtool, kcsan: Remove memory barrier
 instrumentation from noinstr
Message-ID: <YZzQoz0e/oiutuq5@elver.google.com>
References: <20211118081027.3175699-1-elver@google.com>
 <20211118081027.3175699-24-elver@google.com>
 <20211119203135.clplwzh3hyo5xddg@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119203135.clplwzh3hyo5xddg@treble>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 19, 2021 at 12:31PM -0800, Josh Poimboeuf wrote:
> On Thu, Nov 18, 2021 at 09:10:27AM +0100, Marco Elver wrote:
[...]
> > +	if (insn->sec->noinstr && sym->removable_instr) {
[...]
> I'd love to have a clearer name than 'removable_instr', though I'm
> having trouble coming up with something.
[...]

I now have the below as v3 of this patch. The naming isn't entirely
obvious, but coming up with a short name for this is tricky, but
hopefully the comments make it clear. We can of course still pick
another name.

Does that look reasonable?

Note, I'd like this series to sit in -next for a while (probably from
some time next week after sending v3 if there are no further
complaints). By default everything will be picked up by the -rcu tree,
and we're targeting Linux 5.18.

If you feel there might be objtool conflicts coming, this patch could be
taken through another tree as there are no hard dependencies, as long as
this patch reaches mainline before or with the rest.

Thanks,
-- Marco

------ >8 ------

From: Marco Elver <elver@google.com>
Date: Mon, 9 Aug 2021 12:11:14 +0200
Subject: [PATCH] objtool, kcsan: Remove memory barrier instrumentation from
 noinstr

Teach objtool to turn instrumentation required for memory barrier
modeling into nops in noinstr text.

The __tsan_func_entry/exit calls are still emitted by compilers even
with the __no_sanitize_thread attribute. The memory barrier
instrumentation will be inserted explicitly (without compiler help), and
thus needs to also explicitly be removed.

Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* s/removable_instr/profiling_func/ (suggested by Josh Poimboeuf)
* Fix and add more comments.

v2:
* Rewrite after rebase to v5.16-rc1.
---
 tools/objtool/check.c               | 41 ++++++++++++++++++++++++-----
 tools/objtool/include/objtool/elf.h |  2 +-
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 61dfb66b30b6..a78186c583f4 100644
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
@@ -1991,6 +1991,35 @@ static int read_intra_function_calls(struct objtool_file *file)
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
+	 * Compilers currently do not remove __tsan_func_entry/exit with the
+	 * __no_sanitize_thread attribute, remove them.
+	 *
+	 * Memory barrier instrumentation is not emitted by the compiler, but
+	 * inserted explicitly, so we need to also remove them.
+	 */
+	if (!strncmp(name, "__tsan_func_", 12) ||
+	    !strcmp(name, "__kcsan_mb") ||
+	    !strcmp(name, "__kcsan_wmb") ||
+	    !strcmp(name, "__kcsan_rmb") ||
+	    !strcmp(name, "__kcsan_release"))
+		return true;
+
+	return false;
+}
+
 static int classify_symbols(struct objtool_file *file)
 {
 	struct section *sec;
@@ -2011,8 +2040,8 @@ static int classify_symbols(struct objtool_file *file)
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

