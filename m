Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C557222A1D6
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 00:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733156AbgGVWLi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 18:11:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52552 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733097AbgGVWLe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 18:11:34 -0400
Message-Id: <20200722220520.159112003@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595455892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=bWVGXey2lJ1irAVnA4O/ihpzfVujSYh2rHOVl6EK2E4=;
        b=ZNcGnPirO7GVvvAKk9/7xCrJWwZ6f+4PeCHE1jv4M7ohUxPI0xu+EbEiolyQPIg/6FrIG1
        X/YXtnhorLabIwG7Lg5vAmTdWFHTuD56ik6uBsel6qkZrixIBYA+ZSTKrDgl1hv6P4VcWu
        rFgZfdPFrqBqcMYG/uRvkdOw6Z03RvrsSTBx80O6FgbiJpaecp+GnNjkg0jK5jmUovzmjN
        0LzCfkPm/RaAlUpxpN0GKakOPhrKh6z8RIJIWHJYr73MVi5ReuMKgVi26cFaCN18vhVs3f
        LaYhpfBrD3riByGsqsDgadOlBdWiqqYNv2EiyOVUjKnl8MXPeCD+1VAR7CQ9mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595455892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=bWVGXey2lJ1irAVnA4O/ihpzfVujSYh2rHOVl6EK2E4=;
        b=/a03u3noJLM9zDItsYn43MQPIsBHcRhqWneRAGKvqbAQY+vFZMWFjARoDT/BzzbQ+AU7KF
        HPkC7UtN0E83yQAA==
Date:   Thu, 23 Jul 2020 00:00:02 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V5 08/15] x86/entry: Move user return notifier out of loop
References: <20200722215954.464281930@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

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
 


