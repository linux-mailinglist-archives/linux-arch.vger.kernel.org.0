Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7414EAD7B
	for <lists+linux-arch@lfdr.de>; Tue, 29 Mar 2022 14:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbiC2Mqj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Mar 2022 08:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236682AbiC2Moh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Mar 2022 08:44:37 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8F2238D37
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:41:48 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id k16-20020a17090632d000b006ae1cdb0f07so8117816ejk.16
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2022 05:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=O02VuhTFNs3OTl+6EdHhE8hyAxR47CEkJ1c0ak5Vr4s=;
        b=C7gGD19m/XveB8Ws/Mrjzquo4UNw5iFhMF9IPlHcdW4Pk7ozQxZ0PNkEpCOMh/tb00
         yCiWkUdHR91r9//CRvGweQPLnnFSzPbvrVzmonGkPHKHJKpSLL7cZLAlDCFYeFIGL0Ss
         /IHCNCWokewlL1qO8a1mb2PQPEKWlCRk5OzGhzGAqj2hGFDN9YdHtSVskka/fzfTrsMa
         j1HMSwQQR8sw9adaQ+zA9d1GRw1pKIsT10NfugO2m9bXeTnFmGN1T9OiXau82BOJCc7K
         C/JGIJ/LSEbzSTmqkiIN+J1LwkC97hJDp0NnsDzTO1d3X/gZnjcZCBRAdS59i777oAr4
         GMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=O02VuhTFNs3OTl+6EdHhE8hyAxR47CEkJ1c0ak5Vr4s=;
        b=X50nGz5/kIBulN3O3JIK18DTUDMEH0zXA1hIgZVDjf4GnCKrLFyz+pfD8rpOa94CkK
         +CJBy45XApG3xmbhuLj8X2gjkrK8gqVDwZLJDrg0tvEJ1RCbY/OjDKdMGkPcPhslLZMK
         F5PaKIxPZgP0RRNapdWGapZW7UmvKmW1sAJ4R4EUf5CpidKtH2YXmytqWuCsGBR2BXNe
         4HqPWtAO0mjoW1X9XdW/AZoDkmdRif3nyvJZOWOqeqDocjlh3X+aV1GloiJtiLATbVhB
         bZ41VSu6Kqnf9nuxF5O8KUvYWwWON1Or8g6TslWRS/D1jFuWC1ki+04sjB+1vLf3EqBK
         L5Gw==
X-Gm-Message-State: AOAM53130g2NZyfUdZslG4IKEjZ1YVy1c1OKFIeSCoYh97lnYG9UpPjr
        P6wit/ArwQHL0NbiSxYY5iJD3DpoPDg=
X-Google-Smtp-Source: ABdhPJyB/bcFcN+qpi65yKy1mIxhG89Sd6SxBmOpeaEdxDCuTuOOvV2uj+2kKbIDqHQp3uDGpI9M/qBVr2s=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a17:906:4786:b0:6e0:c7b:d267 with SMTP id
 cw6-20020a170906478600b006e00c7bd267mr34808708ejc.115.1648557707096; Tue, 29
 Mar 2022 05:41:47 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:39:58 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-30-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 29/48] kmsan: entry: handle register passing from
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
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
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
index bad713684c2e3..dcf91ab14512a 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -21,7 +21,7 @@ static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
 	CT_WARN_ON(ct_state() != CONTEXT_USER);
 	user_exit_irqoff();
 
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 	trace_hardirqs_off_finish();
 	instrumentation_end();
 }
@@ -103,7 +103,7 @@ noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 
 	__enter_from_user_mode(regs);
 
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 	local_irq_enable();
 	ret = __syscall_enter_from_user_work(regs, syscall);
 	instrumentation_end();
@@ -114,7 +114,7 @@ noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
 {
 	__enter_from_user_mode(regs);
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 	local_irq_enable();
 	instrumentation_end();
 }
@@ -296,7 +296,7 @@ void syscall_exit_to_user_mode_work(struct pt_regs *regs)
 
 __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
 {
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 	__syscall_exit_to_user_mode_work(regs);
 	instrumentation_end();
 	__exit_to_user_mode();
@@ -309,7 +309,7 @@ noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 
 noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 {
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 	exit_to_user_mode_prepare(regs);
 	instrumentation_end();
 	__exit_to_user_mode();
@@ -357,7 +357,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 		 */
 		lockdep_hardirqs_off(CALLER_ADDR0);
 		rcu_irq_enter();
-		instrumentation_begin();
+		instrumentation_begin_with_regs(regs);
 		trace_hardirqs_off_finish();
 		instrumentation_end();
 
@@ -372,7 +372,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	 * in having another one here.
 	 */
 	lockdep_hardirqs_off(CALLER_ADDR0);
-	instrumentation_begin();
+	instrumentation_begin_with_regs(regs);
 	rcu_irq_enter_check_tick();
 	trace_hardirqs_off_finish();
 	instrumentation_end();
@@ -409,7 +409,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 		 * and RCU as the return to user mode path.
 		 */
 		if (state.exit_rcu) {
-			instrumentation_begin();
+			instrumentation_begin_with_regs(regs);
 			/* Tell the tracer that IRET will enable interrupts */
 			trace_hardirqs_on_prepare();
 			lockdep_hardirqs_on_prepare(CALLER_ADDR0);
@@ -419,7 +419,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 			return;
 		}
 
-		instrumentation_begin();
+		instrumentation_begin_with_regs(regs);
 		if (IS_ENABLED(CONFIG_PREEMPTION)) {
 #ifdef CONFIG_PREEMPT_DYNAMIC
 			static_call(irqentry_exit_cond_resched)();
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
2.35.1.1021.g381101b075-goog

