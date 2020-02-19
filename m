Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56484164827
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 16:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgBSPOk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 10:14:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36046 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgBSPOh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 10:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=/oBPWrG9EVgl4LEO/hSDsTUt0NUc1tA6jTJTcYoVfdU=; b=AiWjSqqIp3k2jloN1TiEdGcBcC
        Ft9vfrIO6/4JzY80jOuMOH4/b9yyPfMEjpycF9vqB9RIdd0CFqoB5aauBsvuycsY+XOaiRYGQQT8T
        nWI6apRhWMR1xfnAwPFaTiHGX3kAB/GNR6SNK4SsVLScTMT8gcR4EfgHd4SiYNIKa2iymLyxy6n32
        qF/1vf8qD8U84MPHhMSMsZvqjo09CUQejocu2Nd9Qm7qxI2d4jn3YhZSpxlRzCeLWJnjKq3LSCIWY
        4EH2tll0iqgHErsPd5X1ni2XOQ3Ei7AsckfJJ9HoRAezPSduwt4wu/2dXnkmuUDmEw4zukQnDE/UC
        /AAIy3uA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4R39-000111-8o; Wed, 19 Feb 2020 15:14:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 045EE30782A;
        Wed, 19 Feb 2020 16:12:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 960212B4D7B84; Wed, 19 Feb 2020 16:14:03 +0100 (CET)
Message-Id: <20200219150745.183988025@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 19 Feb 2020 15:47:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v3 14/22] perf,tracing: Allow function tracing when !RCU
References: <20200219144724.800607165@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since perf is now able to deal with !rcu_is_watching() contexts,
remove the restraint.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/trace/trace_event_perf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -477,7 +477,7 @@ static int perf_ftrace_function_register
 {
 	struct ftrace_ops *ops = &event->ftrace_ops;
 
-	ops->flags   = FTRACE_OPS_FL_RCU;
+	ops->flags   = 0;
 	ops->func    = perf_ftrace_function_call;
 	ops->private = (void *)(unsigned long)nr_cpu_ids;
 


