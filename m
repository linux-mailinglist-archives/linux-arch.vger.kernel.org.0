Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72DF51045D
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbiDZQvt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239611AbiDZQuQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:50:16 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B3E40911
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:35 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id dt18-20020a170907729200b006f377ebe5cbso4559399ejc.22
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7rWXomHmmGtw2qSW/Jql3Xky6Nc8Jl3o+xpl6HNe0X8=;
        b=q5MasDLtRuk73svjnlxTla0qBFDkgnt0PsXrVkFMN41i4z8Uc7BjsHa4IZlwyI4mOh
         PSjNtr6oT4aSfGpSW0YXGpJKMOZ3sk1QnOzt4PQcjsP2frb+KqFrSVrmWcDHhZkns/d/
         pdEqJGCSd8xeQiS1/OQIYoiHjeol8c3Q+yW+/B+Knn6wOUS02dBp111b/1mBG/LNHKLX
         o57oj7KW5sVZwCE68ycL0SdOrbqmApIoCkh8dUgH6H+ygVwXbl7Gp7mJ6YMwZNc44jBv
         kf7eWkFxMSiWJtqo7427dYj43Sgw5gav9YAFNr+RIt6rHBJ0ZfsALEQce0T6+nWFX4OZ
         E6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7rWXomHmmGtw2qSW/Jql3Xky6Nc8Jl3o+xpl6HNe0X8=;
        b=S4KLCTG7jMYGvJu36QqlpAiQhl1heftOjGqx3Sn3aqfAIBmW/is7cYewBdXUp2lmAT
         WHTh/Nym8ClKTLVxanoMPWcNUTv28aucbiYqgq5uoYC0SBgm2ksE7NWo9sHHP/btRl+r
         tVLDQXyfusJemDToh//TXuBOirbBQMmmXfXYjMWxa+8DWF5ls94qfmGnOI4ZgZTUpv0t
         CHyDd/k/+JB+oeTA2MRXEk79GhavuQZ8b2EBZW7fyQdyfnqyJNmApTdn99gdYU9jbLMV
         49m01Wv+PDaC5Qu147QDnKF6XpHPEheHP91n+juDrO3PJp73tbHzb6H36//es1b/kbXy
         WwEA==
X-Gm-Message-State: AOAM532JzBCeERtNmZrJLZTZtHo/F4AvvgRPv7gMdr2MQifPOitypZFJ
        3+uaq22iX+87CY2wv6v28DUQXYmYSpU=
X-Google-Smtp-Source: ABdhPJyHNp1hORgE0TcahA4SesrvDuNa9ln2vyqb/yiKW2MgJrSo3ZS2uZRSG/oHoxHKcWZIpPWb90g9a0g=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:a05:6402:27d1:b0:425:f92f:aac0 with SMTP id
 c17-20020a05640227d100b00425f92faac0mr5194069ede.409.1650991533278; Tue, 26
 Apr 2022 09:45:33 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:42:57 +0200
In-Reply-To: <20220426164315.625149-1-glider@google.com>
Message-Id: <20220426164315.625149-29-glider@google.com>
Mime-Version: 1.0
References: <20220426164315.625149-1-glider@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 28/46] kmsan: entry: handle register passing from
 uninstrumented code
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Replace instrumentation_begin()	with instrumentation_begin_with_regs()
to let KMSAN handle the non-instrumented code and unpoison pt_regs
passed from the instrumented part.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I7f0a9809b66bd85faae43142971d0095771b7a42
---
 kernel/entry/common.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 93c3b86e781c1..ce2324374882c 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -23,7 +23,7 @@ static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
 	CT_WARN_ON(ct_state() != CONTEXT_USER);
 	user_exit_irqoff();
 
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 	trace_hardirqs_off_finish();
 	instrumentation_end();
 }
@@ -105,7 +105,7 @@ noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 
 	__enter_from_user_mode(regs);
 
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 	local_irq_enable();
 	ret = __syscall_enter_from_user_work(regs, syscall);
 	instrumentation_end();
@@ -116,7 +116,7 @@ noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
 {
 	__enter_from_user_mode(regs);
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 	local_irq_enable();
 	instrumentation_end();
 }
@@ -290,7 +290,7 @@ void syscall_exit_to_user_mode_work(struct pt_regs *regs)
 
 __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
 {
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 	__syscall_exit_to_user_mode_work(regs);
 	instrumentation_end();
 	__exit_to_user_mode();
@@ -303,7 +303,7 @@ noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 
 noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 {
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 	exit_to_user_mode_prepare(regs);
 	instrumentation_end();
 	__exit_to_user_mode();
@@ -351,7 +351,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 		 */
 		lockdep_hardirqs_off(CALLER_ADDR0);
 		rcu_irq_enter();
-		instrumentation_begin();
+		instrumentation_begin_with_regs(regs);
 		trace_hardirqs_off_finish();
 		instrumentation_end();
 
@@ -366,7 +366,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	 * in having another one here.
 	 */
 	lockdep_hardirqs_off(CALLER_ADDR0);
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 	rcu_irq_enter_check_tick();
 	trace_hardirqs_off_finish();
 	instrumentation_end();
@@ -413,7 +413,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 		 * and RCU as the return to user mode path.
 		 */
 		if (state.exit_rcu) {
-			instrumentation_begin();
+			instrumentation_begin_with_regs(regs);
 			/* Tell the tracer that IRET will enable interrupts */
 			trace_hardirqs_on_prepare();
 			lockdep_hardirqs_on_prepare(CALLER_ADDR0);
@@ -423,7 +423,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 			return;
 		}
 
-		instrumentation_begin();
+		instrumentation_begin_with_regs(regs);
 		if (IS_ENABLED(CONFIG_PREEMPTION))
 			irqentry_exit_cond_resched();
 
@@ -451,7 +451,7 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
 	lockdep_hardirq_enter();
 	rcu_nmi_enter();
 
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 	trace_hardirqs_off_finish();
 	ftrace_nmi_enter();
 	instrumentation_end();
@@ -461,7 +461,7 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
 
 void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state)
 {
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 	ftrace_nmi_exit();
 	if (irq_state.lockdep) {
 		trace_hardirqs_on_prepare();
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

