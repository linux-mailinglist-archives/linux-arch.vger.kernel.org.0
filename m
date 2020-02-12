Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D65DD15A535
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 10:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgBLJnr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 04:43:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbgBLJnp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 04:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=qyYgZMuOWCAOWnIH7ZGLAqejtnVfskS/7yQ5JC3wMFY=; b=rFd2rAAJq42yjHLB9LjIsrZIti
        dl6xFyt0RvHOxZ7LBgxWgBCZ3OtZ/3JgBe8wGsW6ZsCSdRynnfEA6cqAis4cptBUuGHA8JyomOgLh
        2GqGVsFSHqa/FBG9EP9IkOTzVe68Nkd8GXCY2k1TaooQu+kosWWZV9XXiMTMpiapef6N3U+E2XV8U
        o4vF8Xwl6jV7XnXi/F0txQ5JCRJGFdF3+tabjuSese8ta1YxDrKaK1/iu6G4r7m+Pb873jzyqD7xF
        I+8hU+E7uxAiXuHlTHct5BC3DgDdBjIEhjR5X3zuWqkt0H7LgD/qOmrLFFywZSRKSCXzc+RAMMaut
        pw414+MA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1oYG-0006zV-98; Wed, 12 Feb 2020 09:43:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5B8BA307793;
        Wed, 12 Feb 2020 10:41:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 57FB22B9154F4; Wed, 12 Feb 2020 10:43:21 +0100 (CET)
Message-Id: <20200212094107.838108888@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 12 Feb 2020 10:32:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: [PATCH 4/8] sched,rcu,tracing: Mark preempt_count_{add,sub}() notrace
References: <20200212093210.468391728@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Because of the requirement that no tracing happens until after we've
incremented preempt_count, see nmi_enter() / trace_rcu_enter(), mark
these functions as notrace.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3781,7 +3781,7 @@ static inline void preempt_latency_start
 	}
 }
 
-void preempt_count_add(int val)
+void notrace preempt_count_add(int val)
 {
 #ifdef CONFIG_DEBUG_PREEMPT
 	/*
@@ -3813,7 +3813,7 @@ static inline void preempt_latency_stop(
 		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 }
 
-void preempt_count_sub(int val)
+void notrace preempt_count_sub(int val)
 {
 #ifdef CONFIG_DEBUG_PREEMPT
 	/*


