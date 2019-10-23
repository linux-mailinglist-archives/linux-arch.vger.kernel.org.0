Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B85CE1A5B
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 14:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391473AbfJWMby (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 08:31:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49155 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391444AbfJWMbq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Oct 2019 08:31:46 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iNFni-00019G-NO; Wed, 23 Oct 2019 14:31:42 +0200
Message-Id: <20191023123119.271229148@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 23 Oct 2019 14:27:22 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [patch V2 17/17] x86/kvm: Use generic exit to guest work function
References: <20191023122705.198339581@linutronix.de>
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
 arch/x86/kvm/Kconfig |    1 +
 arch/x86/kvm/x86.c   |   17 +++++------------
 2 files changed, 6 insertions(+), 12 deletions(-)

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
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -52,6 +52,7 @@
 #include <linux/irqbypass.h>
 #include <linux/sched/stat.h>
 #include <linux/sched/isolation.h>
+#include <linux/entry-common.h>
 #include <linux/mem_encrypt.h>
 
 #include <trace/events/kvm.h>
@@ -8115,8 +8116,8 @@ static int vcpu_enter_guest(struct kvm_v
 	if (kvm_lapic_enabled(vcpu) && vcpu->arch.apicv_active)
 		kvm_x86_ops->sync_pir_to_irr(vcpu);
 
-	if (vcpu->mode == EXITING_GUEST_MODE || kvm_request_pending(vcpu)
-	    || need_resched() || signal_pending(current)) {
+	if (vcpu->mode == EXITING_GUEST_MODE || kvm_request_pending(vcpu) ||
+	    exit_to_guestmode_work_pending()) {
 		vcpu->mode = OUTSIDE_GUEST_MODE;
 		smp_wmb();
 		local_irq_enable();
@@ -8309,17 +8310,9 @@ static int vcpu_run(struct kvm_vcpu *vcp
 
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


