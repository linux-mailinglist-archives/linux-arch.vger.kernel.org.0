Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46C49159F10
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 03:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbgBLC1B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Feb 2020 21:27:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:58648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbgBLC1A (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Feb 2020 21:27:00 -0500
Received: from localhost.localdomain (89.208.247.74.16clouds.com [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 539712082F;
        Wed, 12 Feb 2020 02:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581474420;
        bh=FOM6ShHGfdrGYdqrB/c61jbqI2+Z0wVkTwBfSD8/QHw=;
        h=From:To:Cc:Subject:Date:From;
        b=IkvnqeF6dXlU0xRckeIb9ArZbAJjkV7+AqfX+Uy3t0waw6awv7aTTeJEsXE/FIo+T
         P0/tY/fN9ss2Q0ph8qgY0s7EhBWXzTOG3qOY/iNLmeb2NtA5Dyat/aCYPhqzqq11hP
         GVQvdOb0ejbdcom95WhSoaH2OXWqgVjWANOri1bM=
From:   guoren@kernel.org
To:     linux-csky@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Amanieu d'Antras <amanieu@gmail.com>
Subject: [PATCH] csky: Implement copy_thread_tls
Date:   Wed, 12 Feb 2020 10:26:51 +0800
Message-Id: <20200212022651.11169-1-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This is required for clone3 which passes the TLS value through a
struct rather than a register.

Cc: Amanieu d'Antras <amanieu@gmail.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/Kconfig          | 1 +
 arch/csky/kernel/process.c | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 72b2999a889a..047427f71d83 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -36,6 +36,7 @@ config CSKY
 	select GX6605S_TIMER if CPU_CK610
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_COPY_THREAD_TLS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index 5349cd8c0f30..f7b231ca269a 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -40,10 +40,11 @@ unsigned long thread_saved_pc(struct task_struct *tsk)
 	return sw->r15;
 }
 
-int copy_thread(unsigned long clone_flags,
+int copy_thread_tls(unsigned long clone_flags,
 		unsigned long usp,
 		unsigned long kthread_arg,
-		struct task_struct *p)
+		struct task_struct *p,
+		unsigned long tls)
 {
 	struct switch_stack *childstack;
 	struct pt_regs *childregs = task_pt_regs(p);
@@ -70,7 +71,7 @@ int copy_thread(unsigned long clone_flags,
 			childregs->usp = usp;
 		if (clone_flags & CLONE_SETTLS)
 			task_thread_info(p)->tp_value = childregs->tls
-						      = childregs->regs[0];
+						      = tls;
 
 		childregs->a0 = 0;
 		childstack->r15 = (unsigned long) ret_from_fork;
-- 
2.17.0

