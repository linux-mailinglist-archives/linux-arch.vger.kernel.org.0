Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7630E563595
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiGAO3l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiGAO3A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:29:00 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3FB3D4B9
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:25:14 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id 130-20020a1c0288000000b003a18127d11aso66012wmc.6
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l9HW4hvq2CQJApDpi6peUok9IhcNK11lvxcg04+BYhI=;
        b=m0zQVBcwGsjkgBeyzji8njbsYom2zyjvffvZ6f53ygK/a73Sef45vu34Ym/f3GwiY6
         24n4n5Tlgq2qKw2wFpgxSipNYxkrLnqPxJkpsZM0TLgQ2V+ISia+unOFzoAz0KadaQq4
         AvfYtgG93hXBLXmtu/JrK/Ct51BvQc3+jnECwKhDga5fUg0X6Ao4l5Ye7I/3vzo4ftFo
         GeOl93a20QvxkwE/6EI17QYzXpZVp27n/+oALgi5SCFfQ+HUJc4i0Oa+cDwovsuOxHTR
         +8xmXrHToewGWfcV26T9eZU1Ic9Ws7op5A1NuDcoULUqufGrU4oSyUyGYH/L6tZRdLvq
         YiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l9HW4hvq2CQJApDpi6peUok9IhcNK11lvxcg04+BYhI=;
        b=0og+83nXxMMCHyNfYCR1n5GvRaDvgYh8YoQUIzdld3O1nqlCkVjOiKWJKy3sFf/rOl
         jEG/78CbE35XRD5UOSbeXM+AKyWkOyTmJJG0dnKUDZfD+xFf3OmmWRQ0jBvfkbTkYZkN
         wYpRgbYOFYaTF8k35IIw2afX9/kzidSKgpjRFU6blX7fPdDzsCG6DLPWox0UV1fepOiS
         rRgr5c6WECoTEkcEOA2stR68NARk5BFxJHAtJrCmAs1hQbtwjF9h0KlGb24h3lIXwkei
         gtkItZPiMMKFj7yQ5IBg92K8qQTsqcI1Jka8ZHIVpJZ3bmGh8kKcQ9VZRSB5dmUssFZp
         xRiw==
X-Gm-Message-State: AJIora8SmSnfBpUP6gc4qjNnpzoiSUIfOvzcTUmQ7oQksJZI4xExyv63
        glDP1M88+06NRHIv27dxa3AFEMA7u/o=
X-Google-Smtp-Source: AGRyM1u2TNc3xlar4igzHbbMT3NVlXpY+dQRzXKImVUAgX/bRcfEAIkZdgH1TPrbfWv83OzrtLLw5K1VVl4=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a05:6000:10c4:b0:21b:8ea4:a27a with SMTP id
 b4-20020a05600010c400b0021b8ea4a27amr14086444wrx.575.1656685507805; Fri, 01
 Jul 2022 07:25:07 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:23:05 +0200
In-Reply-To: <20220701142310.2188015-1-glider@google.com>
Message-Id: <20220701142310.2188015-41-glider@google.com>
Mime-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 40/45] x86: kmsan: don't instrument stack walking functions
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

Upon function exit, KMSAN marks local variables as uninitialized.
Further function calls may result in the compiler creating the stack
frame where these local variables resided. This results in frame
pointers being marked as uninitialized data, which is normally correct,
because they are not stack-allocated.

However stack unwinding functions are supposed to read and dereference
the frame pointers, in which case KMSAN might be reporting uses of
uninitialized values.

To work around that, we mark update_stack_state(), unwind_next_frame()
and show_trace_log_lvl() with __no_kmsan_checks, preventing all KMSAN
reports inside those functions and making them return initialized
values.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I7001eaed630277e8d2ddaff1d6f223d54e997a6f
---
 arch/x86/kernel/dumpstack.c    |  6 ++++++
 arch/x86/kernel/unwind_frame.c | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index afae4dd774951..476eb504084e4 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -177,6 +177,12 @@ static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
 	}
 }
 
+/*
+ * This function reads pointers from the stack and dereferences them. The
+ * pointers may not have their KMSAN shadow set up properly, which may result
+ * in false positive reports. Disable instrumentation to avoid those.
+ */
+__no_kmsan_checks
 static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 			unsigned long *stack, const char *log_lvl)
 {
diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
index 8e1c50c86e5db..d8ba93778ae32 100644
--- a/arch/x86/kernel/unwind_frame.c
+++ b/arch/x86/kernel/unwind_frame.c
@@ -183,6 +183,16 @@ static struct pt_regs *decode_frame_pointer(unsigned long *bp)
 }
 #endif
 
+/*
+ * While walking the stack, KMSAN may stomp on stale locals from other
+ * functions that were marked as uninitialized upon function exit, and
+ * now hold the call frame information for the current function (e.g. the frame
+ * pointer). Because KMSAN does not specifically mark call frames as
+ * initialized, false positive reports are possible. To prevent such reports,
+ * we mark the functions scanning the stack (here and below) with
+ * __no_kmsan_checks.
+ */
+__no_kmsan_checks
 static bool update_stack_state(struct unwind_state *state,
 			       unsigned long *next_bp)
 {
@@ -250,6 +260,7 @@ static bool update_stack_state(struct unwind_state *state,
 	return true;
 }
 
+__no_kmsan_checks
 bool unwind_next_frame(struct unwind_state *state)
 {
 	struct pt_regs *regs;
-- 
2.37.0.rc0.161.g10f37bed90-goog

