Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A923A3E03
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jun 2021 10:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhFKIcp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Jun 2021 04:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhFKIco (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Jun 2021 04:32:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D0BC0613A2;
        Fri, 11 Jun 2021 01:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=R/t9249KjOk7BzHG3fb6t1iMLVk7GKUGrbpwGaTWoSY=; b=OW/sUr9rbPFATW4+5HC6fa2IbA
        We0BzmW4lu2Y80OgCJzv8Btjpvozfiujbo6RzKR9fScXCw1hv+Z/KMURvZYOoCVzhRcXBdLMPmJgz
        cDBOQqk8sIll8ZFvT5bHqblgf7QThHQBeYu/osalJtaISNZo1CJpDOAd3DiV0ddEydoJLiKCwM67H
        0za8uf381bPHa4TBer+UKSXV12yZgmco7UewJTfWseLcZEA0FRmx46D0PmSOFpW+UzDe6Sh97vu8d
        jxVLDE4eu6Ng8u2dly3Nf1v2p22aFE3Ho7YP0+s8hesv3fLQlDPPDjcbzC5aUjiREXHVvsxa2xTgm
        XKQj3aig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lrcXt-005p84-Rx; Fri, 11 Jun 2021 08:29:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3CD7E300593;
        Fri, 11 Jun 2021 10:29:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F388A2BCF3935; Fri, 11 Jun 2021 10:29:42 +0200 (CEST)
Message-ID: <20210611082838.409696194@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 11 Jun 2021 10:28:15 +0200
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
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH v2 5/7] sched,timer: Use __set_current_state()
References: <20210611082810.970791107@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There's an existing helper for setting TASK_RUNNING; must've gotten
lost last time we did this cleanup.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
Acked-by: Will Deacon <will@kernel.org>
---
 kernel/time/timer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1879,7 +1879,7 @@ signed long __sched schedule_timeout(sig
 			printk(KERN_ERR "schedule_timeout: wrong timeout "
 				"value %lx\n", timeout);
 			dump_stack();
-			current->state = TASK_RUNNING;
+			__set_current_state(TASK_RUNNING);
 			goto out;
 		}
 	}


