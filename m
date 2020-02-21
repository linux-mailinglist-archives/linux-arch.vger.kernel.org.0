Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7289D167F35
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 14:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgBUNvE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 08:51:04 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45626 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728910AbgBUNuq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=sYu+JxnZTtA31kq9+f82lnncD9DGOqvi2euVK6Brrok=; b=eKWphM90Sulztyajps6xzS7aiE
        jOGZx7cRlBZ+52JD7aHLQClJfcH8UlVwK3ea948XEVnYo0bwF1oga7aZDPvUJjOOm872xteqcf7u/
        maXz4brq87JDkp4tEtbLgZbWo2Go5ky7iQIk/bOPU/EKMqvPSdFcHUrSBcla30xitvg2Uj5fs9gEB
        px82bn4+uoqtBLujHrNSrp2T5cHmfc3+EX49MYphdszT0ec3IIKS/I7jSQ67ex3HHFgfqW/BrgjUK
        MLkPLFp3+VrJMn43rh33ukJM/zOU4vthCgY8xpKp8k1kkQhxsF96ZC7/0VTTzf4jTvuaFE5WqfFlS
        C53vdYtQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j58gv-0006Ux-3I; Fri, 21 Feb 2020 13:50:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 695293072C0;
        Fri, 21 Feb 2020 14:48:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CB9BF29D740A9; Fri, 21 Feb 2020 14:50:00 +0100 (CET)
Message-Id: <20200221134215.616973418@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Feb 2020 14:34:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v4 10/27] rcu: Mark rcu_dynticks_curr_cpu_in_eqs() inline
References: <20200221133416.777099322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since rcu_is_watching() is notrace (and needs to be, as it can be
called from the tracers), make sure everything it in turn calls is
notrace too.

To that effect, mark rcu_dynticks_curr_cpu_in_eqs() inline, which
implies notrace, as the function is tiny.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -294,7 +294,7 @@ static void rcu_dynticks_eqs_online(void
  *
  * No ordering, as we are sampling CPU-local information.
  */
-static bool rcu_dynticks_curr_cpu_in_eqs(void)
+static inline bool rcu_dynticks_curr_cpu_in_eqs(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 


