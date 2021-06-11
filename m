Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EE53A3E23
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jun 2021 10:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhFKIjY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Jun 2021 04:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhFKIjX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Jun 2021 04:39:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3805C061574;
        Fri, 11 Jun 2021 01:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=7H9ckOY0q8/daAWi91yAwu+hjhrdU6assedtwAPtwYM=; b=lWne/qXftq6MxTMznHwljGyvT6
        jEBXBkzEPopJHKbKwHpayR+3zDEjvO93iqbTLXeKANHVfY1DyyreIj2PxTK50ap1OcUKW+2i8aMTj
        IfKUv1kVuljed1hu0hNwoWVJ2OXFcwTShq7kltvDRyq/DHn5QKYDld+lwQBsiAICcqg6vXnSLgFfq
        /VQewNZBY7iEX9B1UK668EBeDM5V516xPsO4RXRqcL4MSQ9BQWrLWnPwfl1H5mh1UCphOy6yjOZ+4
        907meFJCL4cxb9X0cKMJpDDuy9EwGkxwXSt6bPCn3gQrd9f/BABXUDO/ktiGkFNSeeEaRm5DzYgZn
        6HjDbRWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lrcY1-002ZW3-7C; Fri, 11 Jun 2021 08:30:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 47CE530059D;
        Fri, 11 Jun 2021 10:29:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 025962BCF3933; Fri, 11 Jun 2021 10:29:43 +0200 (CEST)
Message-ID: <20210611082838.472811363@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 11 Jun 2021 10:28:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 6/7] sched,arch: Remove unused TASK_STATE offsets
References: <20210611082810.970791107@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

All 6 architectures define TASK_STATE in asm-offsets, but then never
actually use it. Remove the definitions to make sure they never will.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/csky/kernel/asm-offsets.c       |    1 -
 arch/h8300/kernel/asm-offsets.c      |    1 -
 arch/microblaze/kernel/asm-offsets.c |    1 -
 arch/mips/kernel/asm-offsets.c       |    1 -
 arch/openrisc/kernel/asm-offsets.c   |    1 -
 arch/parisc/kernel/asm-offsets.c     |    1 -
 6 files changed, 6 deletions(-)

--- a/arch/csky/kernel/asm-offsets.c
+++ b/arch/csky/kernel/asm-offsets.c
@@ -9,7 +9,6 @@
 int main(void)
 {
 	/* offsets into the task struct */
-	DEFINE(TASK_STATE,        offsetof(struct task_struct, state));
 	DEFINE(TASK_THREAD_INFO,  offsetof(struct task_struct, stack));
 	DEFINE(TASK_FLAGS,        offsetof(struct task_struct, flags));
 	DEFINE(TASK_PTRACE,       offsetof(struct task_struct, ptrace));
--- a/arch/h8300/kernel/asm-offsets.c
+++ b/arch/h8300/kernel/asm-offsets.c
@@ -21,7 +21,6 @@
 int main(void)
 {
 	/* offsets into the task struct */
-	OFFSET(TASK_STATE, task_struct, state);
 	OFFSET(TASK_FLAGS, task_struct, flags);
 	OFFSET(TASK_PTRACE, task_struct, ptrace);
 	OFFSET(TASK_BLOCKED, task_struct, blocked);
--- a/arch/microblaze/kernel/asm-offsets.c
+++ b/arch/microblaze/kernel/asm-offsets.c
@@ -70,7 +70,6 @@ int main(int argc, char *argv[])
 
 	/* struct task_struct */
 	DEFINE(TS_THREAD_INFO, offsetof(struct task_struct, stack));
-	DEFINE(TASK_STATE, offsetof(struct task_struct, state));
 	DEFINE(TASK_FLAGS, offsetof(struct task_struct, flags));
 	DEFINE(TASK_PTRACE, offsetof(struct task_struct, ptrace));
 	DEFINE(TASK_BLOCKED, offsetof(struct task_struct, blocked));
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -78,7 +78,6 @@ void output_ptreg_defines(void)
 void output_task_defines(void)
 {
 	COMMENT("MIPS task_struct offsets.");
-	OFFSET(TASK_STATE, task_struct, state);
 	OFFSET(TASK_THREAD_INFO, task_struct, stack);
 	OFFSET(TASK_FLAGS, task_struct, flags);
 	OFFSET(TASK_MM, task_struct, mm);
--- a/arch/openrisc/kernel/asm-offsets.c
+++ b/arch/openrisc/kernel/asm-offsets.c
@@ -37,7 +37,6 @@
 int main(void)
 {
 	/* offsets into the task_struct */
-	DEFINE(TASK_STATE, offsetof(struct task_struct, state));
 	DEFINE(TASK_FLAGS, offsetof(struct task_struct, flags));
 	DEFINE(TASK_PTRACE, offsetof(struct task_struct, ptrace));
 	DEFINE(TASK_THREAD, offsetof(struct task_struct, thread));
--- a/arch/parisc/kernel/asm-offsets.c
+++ b/arch/parisc/kernel/asm-offsets.c
@@ -42,7 +42,6 @@
 int main(void)
 {
 	DEFINE(TASK_THREAD_INFO, offsetof(struct task_struct, stack));
-	DEFINE(TASK_STATE, offsetof(struct task_struct, state));
 	DEFINE(TASK_FLAGS, offsetof(struct task_struct, flags));
 	DEFINE(TASK_SIGPENDING, offsetof(struct task_struct, pending));
 	DEFINE(TASK_PTRACE, offsetof(struct task_struct, ptrace));


