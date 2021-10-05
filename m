Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9303F42247F
	for <lists+linux-arch@lfdr.de>; Tue,  5 Oct 2021 13:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbhJELEK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Oct 2021 07:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbhJELDm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Oct 2021 07:03:42 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9FEC061369
        for <linux-arch@vger.kernel.org>; Tue,  5 Oct 2021 04:00:37 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id c19-20020ac81e93000000b002a71180fd3dso18105636qtm.1
        for <linux-arch@vger.kernel.org>; Tue, 05 Oct 2021 04:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GVi87uCC9iTMZ0tahcA01mPlZX23fhUUuaenbQ1/OXU=;
        b=eBKhKFS4x1q99vUTWlhpytTALPtvi3mgku2eaV9j+J7rB3DErHSPoLRonHHdXa8PGK
         6HibdPdPZNy+o32rjdkB5tY0E11xrK9Ac3m5LDrgA2eA7J4HLKzrEbZQKgIw1AY8VNHy
         cAXItLXIxr8LebyG5GXhJ5+H92uEdXLdYsxLq82kMDMHBfWpeoLyU9FKZpfWRWKR30/e
         40g9aYJKuuWKDqCwSD6vrOeXjAUAmFMMNRQ8Wu7WwLiT+hOd27rLzpsYzEuWPDXPx3F4
         L1BPhdtoHS1Yj0ZHU4Y3K79zG6ebY4E4kLEZBtO7noFlNeKlrDewmFrRbhHEejhMl+79
         /MaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GVi87uCC9iTMZ0tahcA01mPlZX23fhUUuaenbQ1/OXU=;
        b=AVbZD+gWwEfujY5bXxNUBPb0bMXthU4h/r6T7aliJbMX7xIWJKrk6HD3dukUeNetqJ
         KAWPsLQIJV+fE72s4sZk3KCT4brraLtgEa3hMevJLzs1HRGz8OE9Gn73qwWcNq7HpsT5
         C7mklfexsXKxvigjwgVC7smDJUjf4xditTmp6goHKo4rXhmJnkvPHYrl+ngcC4MPk2ha
         AIXZhaAVgQ7jJYtJ/SwUAL6l16ZHdH34OMy1+KKrQjsjiBr4/1nBvmBnuQDdU6Oz8AaT
         2ebe2nK+A3Z2AKs0kAM4JP69ekSpSI31GxI4w+yqykqxqM7c4KLH8bVN8edpGUi3XAT2
         8XfQ==
X-Gm-Message-State: AOAM531yHCc8gPmcUno46l+I6BZyKLMn8ApUIYK1pITB8S0W+ozzCYFR
        VOYbm36YBDhJprAXCf711hW7kkSVEw==
X-Google-Smtp-Source: ABdhPJyqnmEQmSHt6KCacfuyURYDmMa093deSnQHXsO3BMcqzTTUKZjrrxibP+T5sEG2RF9gpTkjLb8Zvw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e44f:5054:55f8:fcb8])
 (user=elver job=sendgmr) by 2002:a05:6214:1305:: with SMTP id
 a5mr21006975qvv.64.1633431636934; Tue, 05 Oct 2021 04:00:36 -0700 (PDT)
Date:   Tue,  5 Oct 2021 12:59:05 +0200
In-Reply-To: <20211005105905.1994700-1-elver@google.com>
Message-Id: <20211005105905.1994700-24-elver@google.com>
Mime-Version: 1.0
References: <20211005105905.1994700-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH -rcu/kcsan 23/23] objtool, kcsan: Remove memory barrier
 instrumentation from noinstr
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
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
---
 tools/objtool/check.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7e8cd3ba5482..7b694e639164 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -965,6 +965,31 @@ static struct symbol *find_call_destination(struct section *sec, unsigned long o
 	return call_dest;
 }
 
+static bool should_remove_if_noinstr(const char *name)
+{
+	/*
+	 * Many compilers cannot disable KCOV with a function attribute so they
+	 * need a little help, NOP out any KCOV calls from noinstr text.
+	 */
+	if (!strncmp(name, "__sanitizer_cov_", 16))
+		return true;
+
+	/*
+	 * Compilers currently do not remove __tsan_func_entry/exit with the
+	 * __no_sanitize_thread attribute, remove them. Memory barrier
+	 * instrumentation is not emitted by the compiler, but inserted
+	 * explicitly, so we need to also remove them.
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
 /*
  * Find the destination instructions for all calls.
  */
@@ -1031,13 +1056,8 @@ static int add_call_destinations(struct objtool_file *file)
 				      &file->static_call_list);
 		}
 
-		/*
-		 * Many compilers cannot disable KCOV with a function attribute
-		 * so they need a little help, NOP out any KCOV calls from noinstr
-		 * text.
-		 */
 		if (insn->sec->noinstr &&
-		    !strncmp(insn->call_dest->name, "__sanitizer_cov_", 16)) {
+		    should_remove_if_noinstr(insn->call_dest->name)) {
 			if (reloc) {
 				reloc->type = R_NONE;
 				elf_write_reloc(file->elf, reloc);
-- 
2.33.0.800.g4c38ced690-goog

