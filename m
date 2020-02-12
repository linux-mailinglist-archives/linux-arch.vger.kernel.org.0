Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC83715B28D
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 22:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgBLVOK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 16:14:10 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33414 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbgBLVOI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 16:14:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=NDPamACi2y3JNfAuuZKbQohXItpap+A5gFGcdigl8YU=; b=GcUXw9JKL+61en5oLNNM3Phx1s
        N4U3vvOH2T+shLsk3ohhM0AK0snp7i1qHZEWzsAuekXFU4blKQ1IERv0AefmUUNMV6NA7isUnFYwV
        YimPfkTjuHDVcf3h/b/luKiOTcBoHMB5fj2wEvnz79TzTQ2cp3JuJ7q5V//WHrTDrbOarGDLzLcjb
        4QT8pv/aaL1hdPj4eFi/f/QpFIP09mD5eIOYQKZ+BabN0pNEmxD8Dvt0/0LGhb7cDRzyfFM7cvVxm
        PHd100srBvEHeYP7DDC6zCu7gyWjSBjGj5VKtZLTYkPvfYD6FYilaCtfQqqvv1ddytHJwaaWwj6cY
        hV/S8Tlw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1zKK-0002Kh-Jr; Wed, 12 Feb 2020 21:13:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3B28230066E;
        Wed, 12 Feb 2020 22:11:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 707ED203A8994; Wed, 12 Feb 2020 22:13:41 +0100 (CET)
Message-Id: <20200212210139.382424693@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 12 Feb 2020 22:01:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: [PATCH v2 0/9] tracing vs rcu vs nmi
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

Changes since -v1:

 - Added tags
 - Changed #4; changed nmi_enter() to use __preempt_count_add() vs
   marking preempt_count_add() notrace.
 - Changed #5; confusion on which functions are notrace due to Makefile
 - Added #9; remove limitation on the perf-function-trace coupling

