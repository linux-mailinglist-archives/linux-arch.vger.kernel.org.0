Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F2E5A2AE2
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 17:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245207AbiHZPQM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 11:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244309AbiHZPO7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 11:14:59 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04DD8B2EB
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:10:08 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id a17-20020a05600c349100b003a545125f6eso4195657wmq.4
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 08:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=BglHskuQEcyUyCGOJUH508pmeGJAtuUxUacPJvhZbyk=;
        b=dLOEePxQJ3Q8NTUKaCKscxiPUndoB4UtDuE3c4k6e51Ijeopi1Q2jwY0fQKx91/gRV
         tjQCOKAvn8SFyX8Z/lnl+CXNB72GSSg2BB8Hq6Vt7SqvWnhLYEqRJylixp3qoaDTG2zm
         raV0B1FrZYeNKlh2L47/qDrSM5egy+WYAo9m1hFPEaFpdxuy6sh5qTqGIMfCAvjZyI9j
         3naaSJ5illmzgZ7ldkbeAiiQNTjVVsYNVEYdyNBLpQSwjzyRINT8fbPdzQGGY0zreFu8
         UWmcW7wtBNkjvMa2czQus+EuHAF96CwCURikCoYjx9Tb33q6CXTdGxIjYlAAIrQDAeMj
         IDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=BglHskuQEcyUyCGOJUH508pmeGJAtuUxUacPJvhZbyk=;
        b=3JqSNPAxDo1vlsnVJhQwcnDNYNQZrvZIrZOS/ayoYRQEzFFTGgGRkqPs9IadQlke6F
         DjUu7DPNjgMlc9L+xnpCbFe0gv54htEHFwAKpTcXczfl/5CST2VxDRcpv92tiZTuqfgS
         QxS7V2Cd+lHMAFcIOt2UT/NAtiG5ahzoVHmEFhia3p2eYgy+UBC1zL5GxTJhVSArF/6O
         YtPldorPxR9hHySEjEDDt5Pf+IY1iJtvCXLiSAmulCq8qi4mmlv/ZEiB1CuMdlpS2ZYr
         kmOmMfQEliv1hSJIQNkLs4UqdbeOj4tE61Pu5H3b0gTf/cV3gNPtEabM4su+c+MAaAZm
         irHA==
X-Gm-Message-State: ACgBeo0mC8DqeT0AMSJn3Oim6F6FXNxrjL9PtF9Ee9D6VJDPaGqdJk6B
        nGW9JfTNasSUFXdPrNB3iipsJsFS+Lg=
X-Google-Smtp-Source: AA6agR6NknND7Ys7dLoaR0YpbVpHtssuPzgQY9WE+k93NXy2tjYdfG5ALV06XNy3sKThCmImd1fIcvZnQyg=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:5207:ac36:fdd3:502d])
 (user=glider job=sendgmr) by 2002:a5d:58d6:0:b0:226:cf81:f68d with SMTP id
 o22-20020a5d58d6000000b00226cf81f68dmr60412wrf.131.1661526605261; Fri, 26 Aug
 2022 08:10:05 -0700 (PDT)
Date:   Fri, 26 Aug 2022 17:08:03 +0200
In-Reply-To: <20220826150807.723137-1-glider@google.com>
Mime-Version: 1.0
References: <20220826150807.723137-1-glider@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826150807.723137-41-glider@google.com>
Subject: [PATCH v5 40/44] x86: kmsan: don't instrument stack walking functions
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Link: https://linux-review.googlesource.com/id/I6550563768fbb08aa60b2a96803675dcba93d802
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
2.37.2.672.g94769d06f0-goog

