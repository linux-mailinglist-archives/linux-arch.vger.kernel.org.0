Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86CC41A2DE9
	for <lists+linux-arch@lfdr.de>; Thu,  9 Apr 2020 05:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgDIDTw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Apr 2020 23:19:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbgDIDTv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Apr 2020 23:19:51 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 971C1208E4;
        Thu,  9 Apr 2020 03:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586402391;
        bh=Skv+s0+qxGwHC8wvqzFd5XQbLaeiBxIMll9IxhJBpv0=;
        h=From:To:Cc:Subject:Date:From;
        b=rizq5eNo3UnaP67wpltOyZ3tVyIIZ9aFCcXVMn9Hu4CAtQ3/v1nCqv/4s50QSD5fR
         XzYm+hw5y9KZ+K/uCDdQZvcplSIQIESRL487ID6I5WqU5n5y4FQzbfsMyjcw6JZ3ts
         I0f9KFhGg4v9/+N5uUA5WuQwCFatFFgcgyFTW9fA=
From:   guoren@kernel.org
To:     linux-csky@vger.kernel.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, guoren@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] csky: Fixup compile error for abiv1 entry.S
Date:   Thu,  9 Apr 2020 11:19:41 +0800
Message-Id: <20200409031941.6288-1-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This bug is from uprobe signal definition in thread_info.h. The
instruction (andi) of abiv1 immediate is smaller than abiv2, then
it will cause:

  AS      arch/csky/kernel/entry.o
 arch/csky/kernel/entry.S: Assembler messages:
 arch/csky/kernel/entry.S:224: Error: Operand 2 immediate is overflow.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/include/asm/thread_info.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/thread_info.h
index 442fedad0260..5d33fcfd7f2a 100644
--- a/arch/csky/include/asm/thread_info.h
+++ b/arch/csky/include/asm/thread_info.h
@@ -54,10 +54,10 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_SIGPENDING		0	/* signal pending */
 #define TIF_NOTIFY_RESUME	1       /* callback before returning to user */
 #define TIF_NEED_RESCHED	2	/* rescheduling necessary */
-#define TIF_SYSCALL_TRACE	3	/* syscall trace active */
-#define TIF_SYSCALL_TRACEPOINT	4       /* syscall tracepoint instrumentation */
-#define TIF_SYSCALL_AUDIT	5	/* syscall auditing */
-#define TIF_UPROBE		6	/* uprobe breakpoint or singlestep */
+#define TIF_UPROBE		3	/* uprobe breakpoint or singlestep */
+#define TIF_SYSCALL_TRACE	4	/* syscall trace active */
+#define TIF_SYSCALL_TRACEPOINT	5       /* syscall tracepoint instrumentation */
+#define TIF_SYSCALL_AUDIT	6	/* syscall auditing */
 #define TIF_POLLING_NRFLAG	16	/* poll_idle() is TIF_NEED_RESCHED */
 #define TIF_MEMDIE		18      /* is terminating due to OOM killer */
 #define TIF_RESTORE_SIGMASK	20	/* restore signal mask in do_signal() */
-- 
2.17.0

