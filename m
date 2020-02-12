Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59D9015A533
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 10:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgBLJnr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 04:43:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46602 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbgBLJno (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 04:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=NXy2WyoL4s4z0mcmpcFDbcqBMvtipXVeSVJos+aTK1g=; b=GejmEm9Y7cV7Ba1G2f7pZWWy7T
        QUCw0G0+t61o78o+jGumOnaT0Y+y7UjPYwQz9Wh+A5qTiGK/hm9FyBSqPrdvsK38IJxVr0NbTanfG
        Gy9Cs8SpG3QMIhASTJxtsUK5Ax1BXOkBgH9PYh+FPQ/ec+GZt0b1NYWh81iPDuUuZYUbhMFMtjzOa
        QTObZqtS2F2WYhuS8vuFHKMBQTN95NDB3lT5mGiRTiWX2QqFeOgEFK/Glc3eYMvaMO6q4M4Twgu9/
        xTxigTgfdU52VoQ6hX6e5VgPkA0JyTg38UDQngjh5EbiAazvUcB1v5FtD5riRDfvEuXklcsPtPEI+
        7qXikSKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1oYG-0006zU-BH; Wed, 12 Feb 2020 09:43:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 59B5530700B;
        Wed, 12 Feb 2020 10:41:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4ECDA2B9154E6; Wed, 12 Feb 2020 10:43:21 +0100 (CET)
Message-Id: <20200212094107.724286700@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 12 Feb 2020 10:32:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: [PATCH 2/8] rcu: Mark rcu_dynticks_curr_cpu_in_eqs() inline
References: <20200212093210.468391728@infradead.org>
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
 


