Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49B77164836
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 16:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgBSPP1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 10:15:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36044 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgBSPOg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 10:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Tmzlc5GU+2LuXYGWt7gcVS9vojP8AGSHIRv/BiATIi0=; b=RLJ1AqDT5IOdWw0L3nXNI4Y2Xr
        shD5Nx8gbnsbDFZe2ryXjjuQnXWLP/YmRxfeZEEsSNrVOzf2uMUYsCZZYeiO4yACOs+eI6O6x8xrj
        EUC1NGAeky8p3KUo5ROakWtjiFmcQk3AvYLqYiBal6QK/L+qPMaAstVOQyoXDjLTMG70lJloDscgN
        9OkI7g2l9qoSkfs9NyZC2FhppuoaHCyzOctISzMQReuvCOILefpvc/TN+sCfpNCaQ0BWq3pRCPO4G
        6Gv24jTf13J4Xy5gVwinsJ3AwlAXh2+m7TSdOi27Lmf5H0JsScZqtmFnO0fdgIiv3gaG/sTzItXBq
        a2fIo6jA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4R38-00010x-BN; Wed, 19 Feb 2020 15:14:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4DE403070F9;
        Wed, 19 Feb 2020 16:12:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 65E0420D96A36; Wed, 19 Feb 2020 16:14:03 +0100 (CET)
Message-Id: <20200219144724.800607165@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 19 Feb 2020 15:47:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v3 00/22] tracing vs world
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,


These here patches are the result of Mathieu and Steve trying to get commit
865e63b04e9b2 ("tracing: Add back in rcu_irq_enter/exit_irqson() for rcuidle
tracepoints") reverted again.

One of the things discovered is that tracing MUST NOT happen before nmi_enter()
or after nmi_exit(). Audit results of the previous version are still valid.

This then snowballed into auditing other exceptions, notably #MC, and #BP. Lots
of patches came out of that.

I would love for some tooling in this area. Dan, smatch has full callchains
right? Would it be possible to have an __assert_no_tracing__() marker of sorts
that validates that no possible callchain reaching that assertion has hit
tracing before that point?

It would mean you have to handle the various means of 'notrace' annotation
(both the function attribute as well as the Makefile rules), recognising
tracepoints and ideally handling NOKPROBE annotations.

Changes since -v2:

 - #MC / ist_enter() audit -- first 4 patches. After this in_nmi() should
   always be set 'correctly'.
 - RCU IRQ enter/exit function simplification
 - #BP / poke_int3_handler() audit -- last many patches.
 - pulled in some locking/kcsan patches

Changes since -v1:

 - Added tags
 - Changed #4; changed nmi_enter() to use __preempt_count_add() vs
   marking preempt_count_add() notrace.
 - Changed #5; confusion on which functions are notrace due to Makefile
 - Added #9; remove limitation on the perf-function-trace coupling

