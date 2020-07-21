Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A8B227E36
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 13:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbgGULIq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 07:08:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37356 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbgGULIp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 07:08:45 -0400
Message-Id: <20200721110809.106972388@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595329723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=+JhihBtBRnfhnJQwGd90XJXoqMCU8kw0agti/vqJ948=;
        b=3Y7E/nYFUOYf+T5096+T4N0PRyZbSJzdR85w1Ia5rnYp1JjR9YhoVwPb4vXmyGzC8iesA2
        TVPabAvlVi6i8A2ZrqLT+M9R2gGouPnXC8vr8LyIImI8hporGhIygHaX7bmxYZt3ensQhZ
        w/8s+DiF2A6LpUJMk2eglNXbGcCnOsFWZV2lN1GwfsFpO2XzwyXRhAaOYm1cuj9EfTdDLa
        Kdbq+pymw2EfuX37qtY3tzZE4PsBQJlVVoN7vDNfJ6E2rRj9dEUdwFWGXeP1g5ICoKCL/w
        69ASYc2ulb8RuA/K/z9W8hvkEOJt5xaZayinnjDqSMOlbv5bWOCFsihxk+MNEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595329723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=+JhihBtBRnfhnJQwGd90XJXoqMCU8kw0agti/vqJ948=;
        b=au3hbSFWuVNeNshIBJpEOZ5yE8X1HQHJoZLPFGTF0v/qvGZ4YosvhE5VOvPbsUyjBGrd8e
        UoTyyZCA5K4blQBA==
Date:   Tue, 21 Jul 2020 12:57:14 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [patch V4 08/15] x86/entry: Move user return notifier out of loop
References: <20200721105706.030914876@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Guests and user space share certain MSRs. KVM sets these MSRs to guest
values once and does not set them back to user space values on every VM
exit to spare the costly MSR operations.

User return notifiers ensure that these MSRs are set back to the correct
values before returning to user space in exit_to_usermode_loop().

There is no reason to evaluate the TIF flag indicating that user return
notifiers need to be invoked in the loop. The important point is that they
are invoked before returning to user space.

Move the invocation out of the loop into the section which does the last
preperatory steps before returning to user space. That section is not
preemptible and runs with interrupts disabled until the actual return.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: New patch
---
 arch/x86/entry/common.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -208,7 +208,7 @@ static long syscall_trace_enter(struct p
 
 #define EXIT_TO_USERMODE_LOOP_FLAGS				\
 	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |	\
-	 _TIF_NEED_RESCHED | _TIF_USER_RETURN_NOTIFY | _TIF_PATCH_PENDING)
+	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING)
 
 static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
 {
@@ -242,9 +242,6 @@ static void exit_to_usermode_loop(struct
 			rseq_handle_notify_resume(NULL, regs);
 		}
 
-		if (cached_flags & _TIF_USER_RETURN_NOTIFY)
-			fire_user_return_notifiers();
-
 		/* Disable IRQs and retry */
 		local_irq_disable();
 
@@ -273,6 +270,9 @@ static void __prepare_exit_to_usermode(s
 	/* Reload ti->flags; we may have rescheduled above. */
 	cached_flags = READ_ONCE(ti->flags);
 
+	if (cached_flags & _TIF_USER_RETURN_NOTIFY)
+		fire_user_return_notifiers();
+
 	if (unlikely(cached_flags & _TIF_IO_BITMAP))
 		tss_update_io_bitmap();
 

