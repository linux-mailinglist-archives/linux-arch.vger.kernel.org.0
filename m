Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FA4563579
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiGAO27 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiGAO1U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:27:20 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA70599CE
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:24:51 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id b7-20020a056402350700b00435bd1c4523so1896345edd.5
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J/zoX+mhuBfgzG0v9rZx6dvFzp5UyG4GyQqVH6m9IHs=;
        b=ReTKlob9Qp/FLxAV1DvlHkuUYXTYWPxzPkj5a7irIhWUye1sNVXC5MtER1Ls2z92mp
         8Wo25eNrT33XToY0e8nz5feDu3mHb7QFF4VgDm2uDBb8l81TfyIVkddhJcjSsD9ufnM1
         Rv9mKSVb0IZG3XVbqV42jTmV3T2Pq2cwTiXOWbvBXBTxw7dePWe5s9bn8qm8wQ8Lt42Z
         FJrd9KclhBhbHdq39ThpfJZtYbwUVP4vwFJvGlzf7CSyuOSqxyBQ2Qn2zplQeikVadq4
         zV+wZJlGCyvmNqBwk6OsqxzwzJFz8qkWXt5LmJX5amCREhfg4UTcaupAIQUr4KVgADMB
         h0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J/zoX+mhuBfgzG0v9rZx6dvFzp5UyG4GyQqVH6m9IHs=;
        b=HnT7xZbz9Zkcsguu/HdF2yMcjU01vAUDPc+KQvLCdoSol14G9g+RdhWV1Q7QlWDAAi
         s9l+uRv7JYdPGhC/PANJClu9CodiIyx/MG85XsBVaNOXJhQgqMA5d5yKKklE/lyrZDx1
         A9mYwOEjcrqHb8tiJ2KFMth6J9muiZ9TfNU6GIWvUrUOSCDQxxuCFmDIBklQ9vGoyqpA
         6ivDoDSOb7dntzIk/WahpCuJezvr5cAwRaHiDtXPzFdz25CX5083KF4MK8UaRM/R/3Pd
         Jz2goh1hTNuBcB8YVfnrFVtKIQtYmGRk9sDNbKqCD3Wm7Na/g7BT5d08jdjMz616ut4U
         0k8A==
X-Gm-Message-State: AJIora+MUNqXi2BOMmtRY50pq8gpEoBZq4gBOV7GOvUCGJXrKe9Jdxf6
        RzMmBjLnF0t+SbLtebCYyWR4LhURwjk=
X-Google-Smtp-Source: AGRyM1txu7w54o9DaeQXovmZ5qxDTEHTCqPpNip+hr7dMrgvfv9CAiY8ULpNYkP1mTZY+VlfmYuBRFUAtEM=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a17:907:a05c:b0:72a:3959:43db with SMTP id
 gz28-20020a170907a05c00b0072a395943dbmr13506354ejc.359.1656685490466; Fri, 01
 Jul 2022 07:24:50 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:22:59 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-35-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 34/45] x86: kmsan: skip shadow checks in __switch_to()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
Link: https://linux-review.googlesource.com/id/Ib7d4d70946f08128ade207519c1ee405fd812839

---
v2:
 -- This patch was previously called "kmsan: skip shadow checks in files
    doing context switches". Per Mark Rutland's suggestion, we now only
    skip checks in low-level arch-specific code, as context switches in
    common code should be invisible to KMSAN. We also apply the checks
    to precisely the functions performing the context switch instead of
    the whole file.

v4:
 -- Replace KMSAN_ENABLE_CHECKS_process_64.o with __no_kmsan_checks

Link: https://linux-review.googlesource.com/id/I45e3ed9c5f66ee79b0409d1673d66ae419029bcb
---
 arch/x86/kernel/process_64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 1962008fe7437..6b3418bff3261 100644
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
2.37.0.rc0.161.g10f37bed90-goog

