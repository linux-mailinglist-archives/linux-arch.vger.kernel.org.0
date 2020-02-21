Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9241167F11
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 14:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgBUNue (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 08:50:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56358 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbgBUNud (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=VUxVM0zMD0yTdzXcfGzmRt1JL0NXbyE5uLB6keYVGUw=; b=cw08DLbJQYvhQZudJea9ctbBPs
        gZDQ7Tf8xRXC0YkkOMJ0ti+COpp4uB3qpocq0Q1nq2jpurVEI7n8MIXJNrGHV9FYzNmR8ZPIam9ny
        ZrvTrqLOXA4UwQVvXjnnTNJjrzaOgKNuEByWGsqr/9EHNbxrAGklvNOJf3w6+TTOPWrir9bpUKlXJ
        ldAMxpmdjEDnDHCKH5XKCrHK8LNskWewRk1E9/OWzzeTBPdBan0yCyJWHQCvpG2ZI5y/hnToERfZG
        hxC3SUAmZhWnW5+mJ0V28V4opOw6ghxT3zNjsxKlpYvDUqcCZnadIVYvU85jhTpRNIWgx/plgDzXC
        qlQNNI6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j58gt-0000OT-Nj; Fri, 21 Feb 2020 13:50:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 85E1D304D2C;
        Fri, 21 Feb 2020 14:48:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AFC5829B5903A; Fri, 21 Feb 2020 14:50:00 +0100 (CET)
Message-Id: <20200221134215.206604505@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Feb 2020 14:34:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v4 03/27] x86/entry: Flip _TIF_SIGPENDING and _TIF_NOTIFY_RESUME handling
References: <20200221133416.777099322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Make sure we run task_work before we hit any kind of userspace -- very
much including signals.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/common.c                   |    8 
 usr/src/linux-2.6/arch/x86/entry/common.c |  440 ------------------------------
 2 files changed, 4 insertions(+), 444 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -155,16 +155,16 @@ static void exit_to_usermode_loop(struct
 		if (cached_flags & _TIF_PATCH_PENDING)
 			klp_update_patch_state(current);
 
-		/* deal with pending signal delivery */
-		if (cached_flags & _TIF_SIGPENDING)
-			do_signal(regs);
-
 		if (cached_flags & _TIF_NOTIFY_RESUME) {
 			clear_thread_flag(TIF_NOTIFY_RESUME);
 			tracehook_notify_resume(regs);
 			rseq_handle_notify_resume(NULL, regs);
 		}
 
+		/* deal with pending signal delivery */
+		if (cached_flags & _TIF_SIGPENDING)
+			do_signal(regs);
+
 		if (cached_flags & _TIF_USER_RETURN_NOTIFY)
 			fire_user_return_notifiers();
 


