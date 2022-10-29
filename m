Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1D5612664
	for <lists+linux-arch@lfdr.de>; Sun, 30 Oct 2022 01:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJ2XSy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Oct 2022 19:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2XSx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Oct 2022 19:18:53 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A5B2F007;
        Sat, 29 Oct 2022 16:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=72jtzsfdBJvTgzNVU9mb5qNZZ75BLtKRZFZfbeGDBNg=; b=v8sMHHOMqaV+I7Og/bqdh3MjKC
        yJj9+SjgCHJGUS3+VwuR2Arofn5pLFRdNIH1hQWb1TihodaHKsqGaab0tIZLpGzTOEUvWXfXDSPtP
        dQPIydfpCRYbiVK131Z0N+yloDx83EK4YQIGLxF63KUhPSgJQK6z4zSHxpesShjTZ0oB+2nwP7Pfp
        7Bm6YBXQX9GYvPGHYW3r7aiFai+kxtB23bZcEcztkpLPiEqPN/7XpljTGkYVDHcpmfg7nbhd0W5kG
        ofnmJZEv/yaOHzRYZOOgN3DmjVLSIor8PJmGrPUBEz4HSTpattmDyNkD40ThLPC0jwX2KbxIw74wn
        whjJ8mQw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oov6I-00FOKS-3D;
        Sat, 29 Oct 2022 23:18:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] kill signal_pt_regs()
Date:   Sun, 30 Oct 2022 00:18:41 +0100
Message-Id: <20221029231850.3668437-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <Y120X8dWqe15FPPG@ZenIV>
References: <Y120X8dWqe15FPPG@ZenIV>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Once upon at it was used on hot paths, but that had not been
true since 2013.  IOW, there's no point for arch-optimized
equivalent of task_pt_regs(current) - remaining two users are
not worth bothering with.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/include/asm/ptrace.h | 1 -
 fs/coredump.c                   | 2 +-
 include/linux/ptrace.h          | 9 ---------
 kernel/signal.c                 | 2 +-
 4 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/alpha/include/asm/ptrace.h b/arch/alpha/include/asm/ptrace.h
index df5f317ab3fc..3557ce64ed21 100644
--- a/arch/alpha/include/asm/ptrace.h
+++ b/arch/alpha/include/asm/ptrace.h
@@ -16,7 +16,6 @@
 
 #define current_pt_regs() \
   ((struct pt_regs *) ((char *)current_thread_info() + 2*PAGE_SIZE) - 1)
-#define signal_pt_regs current_pt_regs
 
 #define force_successful_syscall_return() (current_pt_regs()->r0 = 0)
 
diff --git a/fs/coredump.c b/fs/coredump.c
index 7bad7785e8e6..b4ec1bf889f9 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -525,7 +525,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	static atomic_t core_dump_count = ATOMIC_INIT(0);
 	struct coredump_params cprm = {
 		.siginfo = siginfo,
-		.regs = signal_pt_regs(),
+		.regs = task_pt_regs(current),
 		.limit = rlimit(RLIMIT_CORE),
 		/*
 		 * We must use the same mm->flags while dumping core to avoid
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index c952c5ba8fab..eaaef3ffec22 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -389,15 +389,6 @@ static inline void user_single_step_report(struct pt_regs *regs)
 #define current_pt_regs() task_pt_regs(current)
 #endif
 
-/*
- * unlike current_pt_regs(), this one is equal to task_pt_regs(current)
- * on *all* architectures; the only reason to have a per-arch definition
- * is optimisation.
- */
-#ifndef signal_pt_regs
-#define signal_pt_regs() task_pt_regs(current)
-#endif
-
 #ifndef current_user_stack_pointer
 #define current_user_stack_pointer() user_stack_pointer(current_pt_regs())
 #endif
diff --git a/kernel/signal.c b/kernel/signal.c
index d140672185a4..848d5c282d35 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1255,7 +1255,7 @@ int send_signal_locked(int sig, struct kernel_siginfo *info,
 
 static void print_fatal_signal(int signr)
 {
-	struct pt_regs *regs = signal_pt_regs();
+	struct pt_regs *regs = task_pt_regs(current);
 	pr_info("potentially unexpected fatal signal %d.\n", signr);
 
 #if defined(__i386__) && !defined(__arch_um__)
-- 
2.30.2

