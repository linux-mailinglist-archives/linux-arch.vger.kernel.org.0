Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8A34632CC
	for <lists+linux-arch@lfdr.de>; Tue, 30 Nov 2021 12:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240970AbhK3Lsg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Nov 2021 06:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240889AbhK3Lsb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Nov 2021 06:48:31 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDBFC061757
        for <linux-arch@vger.kernel.org>; Tue, 30 Nov 2021 03:45:11 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id v17-20020adfedd1000000b0017c5e737b02so3522892wro.18
        for <linux-arch@vger.kernel.org>; Tue, 30 Nov 2021 03:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cCyxJnES0DWyrpQ2J5vRoZu9DlHTb3+fL88VjiCWbjg=;
        b=cKjMDTXM8NjyKwJV3lDtGCObCm4HpcJe5F+4CzZRRXVIIKSOXaY8t1H5jc/MfrMybp
         l7C1C5PdFSieee+5Ow4GgXoKOJzHKEgRplPyzIuWqJojZ+nN2/4IJsjhDdaZMC4hfGLc
         YjipwbrwuXGRJcsG9dWRqwvvUcQGiVB9s3RVhs0q+yDpoxr5r2oMHuFRBcQ1r5QIpX3k
         KQBK18DLneuEMmku+aWMunTXlRFji0E50ji38pRBCDpdp+D21l7U1sivA4dITmYi7DXU
         QeLVu19keyQA504MdNHYtGnlBTN/rI+Vy0aqov/bs8mgOaxhMmA9ff8gcphJR+tq3WW4
         AyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cCyxJnES0DWyrpQ2J5vRoZu9DlHTb3+fL88VjiCWbjg=;
        b=a8wiNEntj9WBV9fXgyJugLxJl9NzBEdtViwy+QaxkEui0cu0lclhH/4fDw3i3DLcFr
         ARvKWkZfiIe3+aqk7IO4vrLZ4xxmXcoO+sOxJYhfUEWlTtRDalZtmF5cv6howJPu/1ry
         FrdCtgKg/jwmJiI/+VLSSYDYG8ArArluHwnoXJkq85LFw6ZOJ/6Ovd+OJyz8tvvHMccb
         tfqTfiHSNnlwSwnuYH7r8WhG49YaROgAK94LAVLRlkAQAhjbVSULRWKHYrCNvhbYI+qq
         Q7YPDG3POj0S5vOgTlvJJZ0udPyDWOgjkmmF7p0yItbdBaC9rxkmk5OcjaPNMN0qCLtx
         rmDQ==
X-Gm-Message-State: AOAM5301DogwR9ZvXS0LQv9D/j5yRtscWA4Orh+ZsThdL2bfq2ewYrU7
        /WZRXVn80GTLm++R9ZrATQ1tkbByMg==
X-Google-Smtp-Source: ABdhPJz78uHZ/XMYdk54D/l9GyDkbV5tPc83Pq6RQwiWk9kg5EHHGLp650DVfz5FKzeodb/NW5W0kpyZ5g==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:86b7:11e9:7797:99f0])
 (user=elver job=sendgmr) by 2002:a05:600c:1d1b:: with SMTP id
 l27mr623895wms.1.1638272709978; Tue, 30 Nov 2021 03:45:09 -0800 (PST)
Date:   Tue, 30 Nov 2021 12:44:11 +0100
In-Reply-To: <20211130114433.2580590-1-elver@google.com>
Message-Id: <20211130114433.2580590-4-elver@google.com>
Mime-Version: 1.0
References: <20211130114433.2580590-1-elver@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 03/25] kcsan: Avoid checking scoped accesses from nested contexts
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
        linux-mm@kvack.org, llvm@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Avoid checking scoped accesses from nested contexts (such as nested
interrupts or in scheduler code) which share the same kcsan_ctx.

This is to avoid detecting false positive races of accesses in the same
thread with currently scoped accesses: consider setting up a watchpoint
for a non-scoped (normal) access that also "conflicts" with a current
scoped access. In a nested interrupt (or in the scheduler), which shares
the same kcsan_ctx, we cannot check scoped accesses set up in the parent
context -- simply ignore them in this case.

With the introduction of kcsan_ctx::disable_scoped, we can also clean up
kcsan_check_scoped_accesses()'s recursion guard, and do not need to
modify the list's prev pointer.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/kcsan.h |  1 +
 kernel/kcsan/core.c   | 18 +++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/kcsan.h b/include/linux/kcsan.h
index fc266ecb2a4d..13cef3458fed 100644
--- a/include/linux/kcsan.h
+++ b/include/linux/kcsan.h
@@ -21,6 +21,7 @@
  */
 struct kcsan_ctx {
 	int disable_count; /* disable counter */
+	int disable_scoped; /* disable scoped access counter */
 	int atomic_next; /* number of following atomic ops */
 
 	/*
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index e34a1710b7bc..bd359f8ee63a 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -204,15 +204,17 @@ check_access(const volatile void *ptr, size_t size, int type, unsigned long ip);
 static noinline void kcsan_check_scoped_accesses(void)
 {
 	struct kcsan_ctx *ctx = get_ctx();
-	struct list_head *prev_save = ctx->scoped_accesses.prev;
 	struct kcsan_scoped_access *scoped_access;
 
-	ctx->scoped_accesses.prev = NULL;  /* Avoid recursion. */
+	if (ctx->disable_scoped)
+		return;
+
+	ctx->disable_scoped++;
 	list_for_each_entry(scoped_access, &ctx->scoped_accesses, list) {
 		check_access(scoped_access->ptr, scoped_access->size,
 			     scoped_access->type, scoped_access->ip);
 	}
-	ctx->scoped_accesses.prev = prev_save;
+	ctx->disable_scoped--;
 }
 
 /* Rules for generic atomic accesses. Called from fast-path. */
@@ -465,6 +467,15 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type, unsigned
 		goto out;
 	}
 
+	/*
+	 * Avoid races of scoped accesses from nested interrupts (or scheduler).
+	 * Assume setting up a watchpoint for a non-scoped (normal) access that
+	 * also conflicts with a current scoped access. In a nested interrupt,
+	 * which shares the context, it would check a conflicting scoped access.
+	 * To avoid, disable scoped access checking.
+	 */
+	ctx->disable_scoped++;
+
 	/*
 	 * Save and restore the IRQ state trace touched by KCSAN, since KCSAN's
 	 * runtime is entered for every memory access, and potentially useful
@@ -578,6 +589,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type, unsigned
 	if (!kcsan_interrupt_watcher)
 		local_irq_restore(irq_flags);
 	kcsan_restore_irqtrace(current);
+	ctx->disable_scoped--;
 out:
 	user_access_restore(ua_flags);
 }
-- 
2.34.0.rc2.393.gf8c9666880-goog

