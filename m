Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F01A11A1E59
	for <lists+linux-arch@lfdr.de>; Wed,  8 Apr 2020 11:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgDHJz4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Apr 2020 05:55:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbgDHJz4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Apr 2020 05:55:56 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 631BF20753;
        Wed,  8 Apr 2020 09:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586339755;
        bh=QhPbt6zYiW/rTOqTjrmG+ydjpfkEi4dIPOfuNUBglQY=;
        h=From:To:Cc:Subject:Date:From;
        b=mboVFIO4HrA7a/NMbPHs3p55GcrNj79v1XemEP/Lc7fuSBwHinAPnCHJ2LnyRbK0t
         BhQBdVfYhW67AnvTI3lJsOTH1JdBzC9IwkXyMi/NT/b5mAfl+Nys4BplnQxtMKFUOR
         nvwDZYNZMd45yFCFq+zyLL1JeM2g0txQKsK9NzgE=
From:   guoren@kernel.org
To:     linux-csky@vger.kernel.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, guoren@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] csky/ftrace: Fixup error when disable CONFIG_DYNAMIC_FTRACE
Date:   Wed,  8 Apr 2020 17:55:46 +0800
Message-Id: <20200408095546.31763-1-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

When CONFIG_DYNAMIC_FTRACE is enabled, static ftrace will fail to
boot up and compile. It's a carelessness when developing "dynamic
ftrace" and "ftrace with regs".

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/abiv2/mcount.S  | 2 ++
 arch/csky/kernel/ftrace.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/csky/abiv2/mcount.S b/arch/csky/abiv2/mcount.S
index 9331c7ed5958..911512bf480f 100644
--- a/arch/csky/abiv2/mcount.S
+++ b/arch/csky/abiv2/mcount.S
@@ -103,6 +103,8 @@ ENTRY(_mcount)
 	mov	a0, lr
 	subi	a0, 4
 	ldw	a1, (sp, 24)
+	lrw	a2, function_trace_op
+	ldw	a2, (a2, 0)
 
 	jsr	r26
 
diff --git a/arch/csky/kernel/ftrace.c b/arch/csky/kernel/ftrace.c
index 44628e3f7fa6..3c425b84e3be 100644
--- a/arch/csky/kernel/ftrace.c
+++ b/arch/csky/kernel/ftrace.c
@@ -202,6 +202,7 @@ int ftrace_disable_ftrace_graph_caller(void)
 #endif /* CONFIG_DYNAMIC_FTRACE */
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
+#ifdef CONFIG_DYNAMIC_FTRACE
 #ifndef CONFIG_CPU_HAS_ICACHE_INS
 struct ftrace_modify_param {
 	int command;
@@ -231,6 +232,7 @@ void arch_ftrace_update_code(int command)
 	stop_machine(__ftrace_modify_code, &param, cpu_online_mask);
 }
 #endif
+#endif /* CONFIG_DYNAMIC_FTRACE */
 
 /* _mcount is defined in abi's mcount.S */
 EXPORT_SYMBOL(_mcount);
-- 
2.17.0

