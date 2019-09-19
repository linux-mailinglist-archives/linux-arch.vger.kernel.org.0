Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B238B7DAC
	for <lists+linux-arch@lfdr.de>; Thu, 19 Sep 2019 17:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403989AbfISPKU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Sep 2019 11:10:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50106 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390959AbfISPJ7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Sep 2019 11:09:59 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iAy4A-0006pw-01; Thu, 19 Sep 2019 17:09:54 +0200
Message-Id: <20190919150809.964620570@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 19 Sep 2019 17:03:29 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [RFC patch 15/15] x86/kvm: Use GENERIC_EXIT_WORKPENDING
References: <20190919150314.054351477@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use the generic infrastructure to check for and handle pending work before
entering into guest mode.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kvm/x86.c |   17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -52,6 +52,7 @@
 #include <linux/irqbypass.h>
 #include <linux/sched/stat.h>
 #include <linux/sched/isolation.h>
+#include <linux/entry-common.h>
 #include <linux/mem_encrypt.h>
 
 #include <trace/events/kvm.h>
@@ -7984,8 +7985,8 @@ static int vcpu_enter_guest(struct kvm_v
 	if (kvm_lapic_enabled(vcpu) && vcpu->arch.apicv_active)
 		kvm_x86_ops->sync_pir_to_irr(vcpu);
 
-	if (vcpu->mode == EXITING_GUEST_MODE || kvm_request_pending(vcpu)
-	    || need_resched() || signal_pending(current)) {
+	if (vcpu->mode == EXITING_GUEST_MODE || kvm_request_pending(vcpu) ||
+	    exit_to_guestmode_work_pending()) {
 		vcpu->mode = OUTSIDE_GUEST_MODE;
 		smp_wmb();
 		local_irq_enable();
@@ -8178,17 +8179,9 @@ static int vcpu_run(struct kvm_vcpu *vcp
 
 		kvm_check_async_pf_completion(vcpu);
 
-		if (signal_pending(current)) {
-			r = -EINTR;
-			vcpu->run->exit_reason = KVM_EXIT_INTR;
-			++vcpu->stat.signal_exits;
+		r = exit_to_guestmode(kvm, vcpu);
+		if (r)
 			break;
-		}
-		if (need_resched()) {
-			srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
-			cond_resched();
-			vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
-		}
 	}
 
 	srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);


