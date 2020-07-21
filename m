Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5BC227E42
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 13:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbgGULIz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 07:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729702AbgGULIy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 07:08:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC664C061794;
        Tue, 21 Jul 2020 04:08:53 -0700 (PDT)
Message-Id: <20200721110809.855490955@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595329732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=gzKkA/2fPeA+5UOM9THMgnEGFcc10CtBaLDGCq6hU48=;
        b=HMx26h367Q98P4nRRiTr3bc3xI9ZA0AKz+Z8IquAY0A/CNvC18rDXbyDYHXrqrvEXpnNUq
        DoGjzoGZUMSxXWcgaxwpTLBbCGMo+chR+K9s6L4vGCSV7K+q9U8Unt2nrEvE8TxerrNVRD
        tctP8lLzwK0EggyCOgvsjOUfVeihoQL58E/syHeHeXNNxwF48l8/ku9bjhik37A4/L7WdY
        /Z7u4FL3Jej8RTkPA23lvFw7Xr1HUslDbxToUZDE10ISoiKbkkSeRrJS5oLHdineNZbyA0
        J9lDBKBUJNvV7tz1MdyYRgQ5a5Bw+Q/pHPaKvE5ty5lrei3Bwmff9anfH9j7uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595329732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=gzKkA/2fPeA+5UOM9THMgnEGFcc10CtBaLDGCq6hU48=;
        b=hibn6cAHmgKEXLEnFx3UeZc14IDl2dVkwLHho2hoK6FWEl9BwmFgvPVk6qBxRlQ5kQSBy5
        dyKO8b1x+NuaLAAw==
Date:   Tue, 21 Jul 2020 12:57:21 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [patch V4 15/15] x86/kvm: Use generic exit to guest work function
References: <20200721105706.030914876@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use the generic infrastructure to check for and handle pending work before
entering into guest mode.

This now handles TIF_NOTIFY_RESUME as well which was ignored so
far. Handling it is important as this covers task work and task work will
be used to offload the heavy lifting of POSIX CPU timers to thread context.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kvm/Kconfig   |    1 +
 arch/x86/kvm/vmx/vmx.c |   11 +++++------
 arch/x86/kvm/x86.c     |   15 ++++++---------
 3 files changed, 12 insertions(+), 15 deletions(-)

--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -42,6 +42,7 @@ config KVM
 	select HAVE_KVM_MSI
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select HAVE_KVM_NO_POLL
+	select KVM_EXIT_TO_GUEST_WORK
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_VFIO
 	select SRCU
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/tboot.h>
 #include <linux/trace_events.h>
+#include <linux/entry-kvm.h>
 
 #include <asm/apic.h>
 #include <asm/asm.h>
@@ -5376,14 +5377,12 @@ static int handle_invalid_guest_state(st
 		}
 
 		/*
-		 * Note, return 1 and not 0, vcpu_run() is responsible for
-		 * morphing the pending signal into the proper return code.
+		 * Note, return 1 and not 0, vcpu_run() will invoke
+		 * exit_to_guest_mode() which will create a proper return
+		 * code.
 		 */
-		if (signal_pending(current))
+		if (__exit_to_guest_mode_work_pending())
 			return 1;
-
-		if (need_resched())
-			schedule();
 	}
 
 	return 1;
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -56,6 +56,7 @@
 #include <linux/sched/stat.h>
 #include <linux/sched/isolation.h>
 #include <linux/mem_encrypt.h>
+#include <linux/entry-kvm.h>
 
 #include <trace/events/kvm.h>
 
@@ -1585,7 +1586,7 @@ EXPORT_SYMBOL_GPL(kvm_emulate_wrmsr);
 bool kvm_vcpu_exit_request(struct kvm_vcpu *vcpu)
 {
 	return vcpu->mode == EXITING_GUEST_MODE || kvm_request_pending(vcpu) ||
-		need_resched() || signal_pending(current);
+		exit_to_guest_mode_work_pending();
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_exit_request);
 
@@ -8676,15 +8677,11 @@ static int vcpu_run(struct kvm_vcpu *vcp
 			break;
 		}
 
-		if (signal_pending(current)) {
-			r = -EINTR;
-			vcpu->run->exit_reason = KVM_EXIT_INTR;
-			++vcpu->stat.signal_exits;
-			break;
-		}
-		if (need_resched()) {
+		if (exit_to_guest_mode_work_pending()) {
 			srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
-			cond_resched();
+			r = exit_to_guest_mode(vcpu);
+			if (r)
+				return r;
 			vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
 		}
 	}

