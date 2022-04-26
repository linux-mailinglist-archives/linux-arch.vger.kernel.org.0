Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B6151046A
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353309AbiDZQvc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353361AbiDZQu7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:50:59 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A15B48383
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:46:03 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id go12-20020a1709070d8c00b006f009400732so9167284ejc.1
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XLE4dDKZQivTtEUon/Tj4SL+cxx+nqfawlbFCYGovJc=;
        b=JMsNnrgA3RJaeGbSFsIbMJk1WKHAyC9mHh9w+Ezp2I0AryPzMo0hvP3hFHcM3Fes/j
         0Od6aTn5hLCVFSLoC+QEN/Y51yJ/k3To1PPqp71oGx9SidpVIg7W/FFigKzrWKt5pZNf
         ObR3IfkU591CrM0QCB8Yyv69AzGBOduai/CQ5ZELgXkxhQBpzhytZFiVH0+MwZEQnsa3
         V3yvl4lBVXMYXdY61XOr/QmKRJgkZHWIaUhgcwCtzjh2gZfAxHgEOuB8kzeynle/cRhb
         dXMQ2W1fkb0VB8Nx+GeffYe9rusz/mxzvp3Q0HOhGVl2s14bRkzEjCgm6Hi/UlxZ9QPZ
         fd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XLE4dDKZQivTtEUon/Tj4SL+cxx+nqfawlbFCYGovJc=;
        b=c189ztkVF9lbmdrP47PTDdKrMhRaI/vL5w77+JdTZYVNQwJzSXhO7ZBxwlDw+BX+KJ
         nzh3i7cvW59JnG/91HuxQHhQ2Mrjdo2IaoQTmulmJDjup5QnVovnvA1/E6M1nl+QYf7t
         Uo0fOyZ6aILsp230Ku3McqQOSHUcSSgs3x8dIy48xF6ib3luwYUUP0wTS2DiQGknOpaX
         Q0e4dfEpJ+Up2RBc64yK1nY+5vWtcUQ6PCn4Ojbsh+wQbMNocHE1vC+9VzKgCPJWAp5z
         mBwNa0uUQVL6Cq7sb0LqGjK2G9RZSutqsraXP/edFjaIyepZNygJlZu62R7s9tuWwelb
         PRDA==
X-Gm-Message-State: AOAM532bvqXyNU5zg3bOHP3aEuuNUB0d05+jjH455qud4V7OlmLyEnAZ
        cSwOzv7Idf55nQDNWCjLPveSjAiudzE=
X-Google-Smtp-Source: ABdhPJw2dp1WxDXIXbxKtYrp2TPHwfmzrgTwJgDoJzBSZTqGhvOW8ABWyU8M8nHDx8YckvsgOVfYsGY3TJA=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a17:907:3e21:b0:6f3:bd59:1aa0 with SMTP id
 hp33-20020a1709073e2100b006f3bd591aa0mr1461947ejc.682.1650991561485; Tue, 26
 Apr 2022 09:46:01 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:43:08 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-40-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 39/46] x86: kmsan: skip shadow checks in __switch_to()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When instrumenting functions, KMSAN obtains the per-task state (mostly
pointers to metadata for function arguments and return values) once per
function at its beginning, using the `current` pointer.

Every time the instrumented function calls another function, this state
(`struct kmsan_context_state`) is updated with shadow/origin data of the
passed and returned values.

When `current` changes in the low-level arch code, instrumented code can
not notice that, and will still refer to the old state, possibly corrupting
it or using stale data. This may result in false positive reports.

To deal with that, we need to apply __no_kmsan_checks to the functions
performing context switching - this will result in skipping all KMSAN
shadow checks and marking newly created values as initialized,
preventing all false positive reports in those functions. False negatives
are still possible, but we expect them to be rare and impersistent.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>

---
v2:
 -- This patch was previously called "kmsan: skip shadow checks in files
    doing context switches". Per Mark Rutland's suggestion, we now only
    skip checks in low-level arch-specific code, as context switches in
    common code should be invisible to KMSAN. We also apply the checks
    to precisely the functions performing the context switch instead of
    the whole file.

Link: https://linux-review.googlesource.com/id/I45e3ed9c5f66ee79b0409d1673d66ae419029bcb

Replace KMSAN_ENABLE_CHECKS_process_64.o with __no_kmsan_checks
---
 arch/x86/kernel/process_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index e459253649be2..9952a4c7e1d20 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -553,6 +553,7 @@ void compat_start_thread(struct pt_regs *regs, u32 new_ip, u32 new_sp, bool x32)
  * Kprobes not supported here. Set the probe on schedule instead.
  * Function graph tracer not supported too.
  */
+__no_kmsan_checks
 __visible __notrace_funcgraph struct task_struct *
 __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 {
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

