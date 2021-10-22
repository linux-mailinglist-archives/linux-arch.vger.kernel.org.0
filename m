Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2032B4379D5
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 17:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbhJVP0y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Oct 2021 11:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbhJVP0v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Oct 2021 11:26:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BD3C061764;
        Fri, 22 Oct 2021 08:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=uED+2ZV2VEyhC8o6f5uAnr+HyJpQd8KdLThCoXdBuLY=; b=PecYHINX9k2IIZiG3nQYvWOhEV
        kXpDyNAyCvFTSBnsqtakfi18UmCRjQ+HKWf/9opu4JQnE+c0YLmWzMZ9Qyh26tjBt1Tw0n8RH8BXZ
        nMsE16KomzHuLJYvOVP2YbB2KE8iKAyd8En/1TPZbPxjwJYDeLYA27W6ylDwEewkfomSZ9dvwC5Us
        lx9Fi0BJbgkf2p23CC/ZBmibT9T7cI20ZwUb2IbmCRvNEPy1UOXpy7o0ge0CY9TS57StPYw741qnv
        nZlpX0PIqOyWaZiWytWuGKUKUS3v/y92Lz72f+QrwgkQJ/xbmAZiKP7TbwhxnBwqxavukaGS1RSzl
        O1XjJBTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdwOE-00BbLz-57; Fri, 22 Oct 2021 15:23:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 83B303002DE;
        Fri, 22 Oct 2021 17:23:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 61732203C8A88; Fri, 22 Oct 2021 17:23:23 +0200 (CEST)
Message-ID: <20211022152104.137058575@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 17:09:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     keescook@chromium.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, akpm@linux-foundation.org,
        mark.rutland@arm.com, zhengqi.arch@bytedance.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-arch@vger.kernel.org, ardb@kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 1/7] x86: Fix __get_wchan() for !STACKTRACE
References: <20211022150933.883959987@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use asm/unwind.h to implement wchan, since we cannot always rely on
STACKTRACE=y.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: bc9bbb81730e ("x86: Fix get_wchan() to support the ORC unwinder")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/process.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -43,6 +43,7 @@
 #include <asm/io_bitmap.h>
 #include <asm/proto.h>
 #include <asm/frame.h>
+#include <asm/unwind.h>
 
 #include "process.h"
 
@@ -949,10 +950,20 @@ unsigned long arch_randomize_brk(struct
  */
 unsigned long __get_wchan(struct task_struct *p)
 {
-	unsigned long entry = 0;
+	struct unwind_state state;
+	unsigned long addr = 0;
 
-	stack_trace_save_tsk(p, &entry, 1, 0);
-	return entry;
+	for (unwind_start(&state, p, NULL, NULL); !unwind_done(&state);
+	     unwind_next_frame(&state)) {
+		addr = unwind_get_return_address(&state);
+		if (!addr)
+			break;
+		if (in_sched_functions(addr))
+			continue;
+		break;
+	}
+
+	return addr;
 }
 
 long do_arch_prctl_common(struct task_struct *task, int option,


