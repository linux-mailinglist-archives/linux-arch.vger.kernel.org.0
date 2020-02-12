Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1AFB15B295
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 22:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgBLVOZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 16:14:25 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33530 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbgBLVOT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 16:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=mocOxZQUeqTQQ8yUjNc0DjmC3mFU9HxodacHaxasgBg=; b=mrMcE+oEiR7AV3tvqz+nagCfXK
        vZ92EkbvuT8cXWn1bQiE89yk8R3NYhjZ+9Qheg0zZbWcLBbuFY7t3KrktePTvJJgkxMz+ovBpYEfe
        Y4I0dQAYEwfJyAfdsnpKViQjv/YLaTUo2HWc0W3Fxz6T8t7xY/EtoOZcvg8NShXbRvSsNibsTEqUL
        SSM97GW1Gs4wHn44HLhH5WYXCjsr5WR1pTWepn5f0BOOnV9aadDR7IasMyZWbCdcNrfeYTbBXmqGR
        fZfnx/63uTOpFV1Qw4nsMwQ6SR512lABJ8Iko+VKTizDZGJLpU37qaDCLS+EtJjqyTjv53lYlMGf7
        3C1fM8qg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1zKM-0002Kx-3D; Wed, 12 Feb 2020 21:13:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C1BC8306E5C;
        Wed, 12 Feb 2020 22:11:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 85972203A89A9; Wed, 12 Feb 2020 22:13:41 +0100 (CET)
Message-Id: <20200212210750.084959585@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 12 Feb 2020 22:01:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: [PATCH v2 5/9] x86,tracing: Add comments to do_nmi()
References: <20200212210139.382424693@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a few comments to do_nmi() as a result of the audit.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/nmi.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -529,11 +529,14 @@ do_nmi(struct pt_regs *regs, long error_
 	 * continue to use the NMI stack.
 	 */
 	if (unlikely(is_debug_stack(regs->sp))) {
-		debug_stack_set_zero();
+		debug_stack_set_zero(); /* notrace due to Makefile */
 		this_cpu_write(update_debug_stack, 1);
 	}
 #endif
 
+	/*
+	 * It is important that no tracing happens before nmi_enter()!
+	 */
 	nmi_enter();
 
 	inc_irq_stat(__nmi_count);
@@ -542,10 +545,13 @@ do_nmi(struct pt_regs *regs, long error_
 		default_do_nmi(regs);
 
 	nmi_exit();
+	/*
+	 * No tracing after nmi_exit()!
+	 */
 
 #ifdef CONFIG_X86_64
 	if (unlikely(this_cpu_read(update_debug_stack))) {
-		debug_stack_reset();
+		debug_stack_reset(); /* notrace due to Makefile */
 		this_cpu_write(update_debug_stack, 0);
 	}
 #endif


