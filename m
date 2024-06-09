Return-Path: <linux-arch+bounces-4770-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A94E49016A6
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 17:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52BE92817AF
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 15:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0AB46441;
	Sun,  9 Jun 2024 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="T6Hp8Uwa"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145F7A3F;
	Sun,  9 Jun 2024 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717948450; cv=none; b=sKJ7cV/8cgx3Yn93pIeQrhhY08ueDHTWirUUJK1a5dLwjzWaAGnr0Otcr/CAOkSweS6+cWYT2dKIZ5TvsA5gkT9e2Js4UiLBoX6QpNLaKBNVM9D/YWPonvhE5rz4nh3oVwfIlWCi0Hy+1mAuz0B6xVoWinqntaMr3Gs7bmeli0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717948450; c=relaxed/simple;
	bh=Y+IYbl254IykxdsLbiee1NygSlrvXoQ8knEQJ/Bq8wg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcY+7AxmRmv7iPiPwuyc8PeBb4T9XadeU5aX7XhP/q/sUDWmUhNOIw+Zg5bjusWZrg7rPX1uE5RQAOdKJOJpBE4KFVObxVdxlutcOfQ6S/yi5cEwA+C+utA1kUlNdbBR7h44XXufZV0ieLMPqPI3MisyjTHlhps0HSc5x2T6We8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=T6Hp8Uwa; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717948449; x=1749484449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4qx3lmbPV2Q3yA7fOSLXKYqumoQ7GY/syxf0sl+1BMQ=;
  b=T6Hp8UwaOo5qWDEGRU20GflPcOJfpX0USF7UoY39EPOFWrEjf4rjcOJ+
   ImsdafQ1IxH1q98n5BZAI5FZRsPKb76F1nHZv2NDVP0I8/wYu+GkOc0wo
   oh08w7ACVUasuKpGWLdeCL8qmUv20ccE/zLZ6rvIHP9/YT5wMD7yna2PS
   E=;
X-IronPort-AV: E=Sophos;i="6.08,225,1712620800"; 
   d="scan'208";a="349362102"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 15:54:01 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:41173]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.43.97:2525] with esmtp (Farcaster)
 id ec32957b-cdc9-475c-b740-52de9e0a303c; Sun, 9 Jun 2024 15:53:58 +0000 (UTC)
X-Farcaster-Flow-ID: ec32957b-cdc9-475c-b740-52de9e0a303c
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:53:58 +0000
Received: from dev-dsk-nsaenz-1b-189b39ae.eu-west-1.amazon.com (10.13.235.138)
 by EX19D004EUC001.ant.amazon.com (10.252.51.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sun, 9 Jun 2024 15:53:52 +0000
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
To: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <pbonzini@redhat.com>, <seanjc@google.com>, <vkuznets@redhat.com>,
	<linux-doc@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<graf@amazon.de>, <dwmw2@infradead.org>, <paul@amazon.com>,
	<nsaenz@amazon.com>, <mlevitsk@redhat.com>, <jgowans@amazon.com>,
	<corbet@lwn.net>, <decui@microsoft.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <amoorthy@google.com>
Subject: [PATCH 05/18] KVM: x86: hyper-v: Introduce MP_STATE_HV_INACTIVE_VTL
Date: Sun, 9 Jun 2024 15:49:34 +0000
Message-ID: <20240609154945.55332-6-nsaenz@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240609154945.55332-1-nsaenz@amazon.com>
References: <20240609154945.55332-1-nsaenz@amazon.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

Model inactive VTL vCPUs' behaviour with a new MP state.

Inactive VTLs are in an artificial halt state. They enter into this
state in response to invoking HvCallVtlCall, HvCallVtlReturn.
User-space, which is VTL aware, can processes the hypercall, and set the
vCPU in MP_STATE_HV_INACTIVE_VTL. When a vCPU is run in this state it'll
block until a wakeup event is received. The rules of what constitutes an
event are analogous to halt's except that VTL's ignore RFLAGS.IF.

When a wakeup event is registered, KVM will exit to user-space with a
KVM_SYSTEM_EVENT exit, and KVM_SYSTEM_EVENT_WAKEUP event type.
User-space is responsible of deciding whether the event has precedence
over the active VTL and will switch the vCPU to KVM_MP_STATE_RUNNABLE
before resuming execution on it.

Running a KVM_MP_STATE_HV_INACTIVE_VTL vCPU with pending events will
return immediately to user-space.

Note that by re-using the readily available halt infrastructure in
KVM_RUN, MP_STATE_HV_INACTIVE_VTL correctly handles (or disables)
virtualisation features like the VMX preemption timer or APICv before
blocking.

Suggested-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>

---

I do recall Sean mentioning using MP states for this might have
unexpected side-effects. But it was in the context of introducing a
broader `HALTED_USERSPACE` style state. I believe that by narrowing down
the MP state's semantics to the specifics of inactive VTLs --
alternatively, we could change RFLAGS.IF in user-space before updating
the mp state -- we cement this as a VSM-only API as well as limit the
ambiguity on the guest/vCPU's state upon entering into this execution
mode.

 Documentation/virt/kvm/api.rst | 19 +++++++++++++++++++
 arch/x86/kvm/hyperv.h          |  8 ++++++++
 arch/x86/kvm/svm/svm.c         |  7 ++++++-
 arch/x86/kvm/vmx/vmx.c         |  7 ++++++-
 arch/x86/kvm/x86.c             | 16 +++++++++++++++-
 include/uapi/linux/kvm.h       |  1 +
 6 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 17893b330b76f..e664c54a13b04 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -1517,6 +1517,8 @@ Possible values are:
                                  [s390]
    KVM_MP_STATE_SUSPENDED        the vcpu is in a suspend state and is waiting
                                  for a wakeup event [arm64]
+   KVM_MP_STATE_HV_INACTIVE_VTL  the vcpu is an inactive VTL and is waiting for
+                                 a wakeup event [x86]
    ==========================    ===============================================
 
 On x86, this ioctl is only useful after KVM_CREATE_IRQCHIP. Without an
@@ -1559,6 +1561,23 @@ KVM_MP_STATE_RUNNABLE which reflect if the vcpu is paused or not.
 On LoongArch, only the KVM_MP_STATE_RUNNABLE state is used to reflect
 whether the vcpu is runnable.
 
+For x86:
+^^^^^^^^
+
+KVM_MP_STATE_HV_INACTIVE_VTL is only available to a VM if Hyper-V's
+HV_ACCESS_VSM CPUID is exposed to the guest.  This processor state models the
+behavior of an inactive VTL and should only be used for this purpose. A
+userspace process should only switch a vCPU into this MP state in response to a
+HvCallVtlCall, HvCallVtlReturn.
+
+If a vCPU is in KVM_MP_STATE_HV_INACTIVE_VTL, KVM will emulate the
+architectural execution of a HLT instruction with the caveat that RFLAGS.IF is
+ignored when deciding whether to wake up (TLFS 12.12.2.1).  If a wakeup is
+recognized, KVM will exit to userspace with a KVM_SYSTEM_EVENT exit, where the
+event type is KVM_SYSTEM_EVENT_WAKEUP. Userspace has the responsibility to
+switch the vCPU back into KVM_MP_STATE_RUNNABLE state. Calling KVM_RUN on a
+KVM_MP_STATE_HV_INACTIVE_VTL vCPU with pending events will exit immediately.
+
 4.39 KVM_SET_MP_STATE
 ---------------------
 
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index d007d2203e0e4..d42fe3f85b002 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -271,6 +271,10 @@ static inline bool kvm_hv_cpuid_vsm_enabled(struct kvm_vcpu *vcpu)
 
 	return hv_vcpu && (hv_vcpu->cpuid_cache.features_ebx & HV_ACCESS_VSM);
 }
+static inline bool kvm_hv_vcpu_is_idle_vtl(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.mp_state == KVM_MP_STATE_HV_INACTIVE_VTL;
+}
 #else /* CONFIG_KVM_HYPERV */
 static inline void kvm_hv_setup_tsc_page(struct kvm *kvm,
 					 struct pvclock_vcpu_time_info *hv_clock) {}
@@ -332,6 +336,10 @@ static inline bool kvm_hv_cpuid_vsm_enabled(struct kvm_vcpu *vcpu)
 {
 	return false;
 }
+static inline bool kvm_hv_vcpu_is_idle_vtl(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
 #endif /* CONFIG_KVM_HYPERV */
 
 #endif /* __ARCH_X86_KVM_HYPERV_H__ */
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 296c524988f95..9671191fef4ea 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -49,6 +49,7 @@
 #include "svm.h"
 #include "svm_ops.h"
 
+#include "hyperv.h"
 #include "kvm_onhyperv.h"
 #include "svm_onhyperv.h"
 
@@ -3797,6 +3798,10 @@ bool svm_interrupt_blocked(struct kvm_vcpu *vcpu)
 	if (!gif_set(svm))
 		return true;
 
+	/*
+	 * The Hyper-V TLFS states that RFLAGS.IF is ignored when deciding
+	 * whether to block interrupts targeted at inactive VTLs.
+	 */
 	if (is_guest_mode(vcpu)) {
 		/* As long as interrupts are being delivered...  */
 		if ((svm->nested.ctl.int_ctl & V_INTR_MASKING_MASK)
@@ -3808,7 +3813,7 @@ bool svm_interrupt_blocked(struct kvm_vcpu *vcpu)
 		if (nested_exit_on_intr(svm))
 			return false;
 	} else {
-		if (!svm_get_if_flag(vcpu))
+		if (!svm_get_if_flag(vcpu) && !kvm_hv_vcpu_is_idle_vtl(vcpu))
 			return true;
 	}
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b3c83c06f8265..ac0682fece604 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5057,7 +5057,12 @@ bool vmx_interrupt_blocked(struct kvm_vcpu *vcpu)
 	if (is_guest_mode(vcpu) && nested_exit_on_intr(vcpu))
 		return false;
 
-	return !(vmx_get_rflags(vcpu) & X86_EFLAGS_IF) ||
+	/*
+	 * The Hyper-V TLFS states that RFLAGS.IF is ignored when deciding
+	 * whether to block interrupts targeted at inactive VTLs.
+	 */
+	return (!(vmx_get_rflags(vcpu) & X86_EFLAGS_IF) &&
+		!kvm_hv_vcpu_is_idle_vtl(vcpu)) ||
 	       (vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) &
 		(GUEST_INTR_STATE_STI | GUEST_INTR_STATE_MOV_SS));
 }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8c9e4281d978d..a6e2312ccb68f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -134,6 +134,7 @@ static int kvm_vcpu_do_singlestep(struct kvm_vcpu *vcpu);
 
 static int __set_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
 static void __get_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
+static inline bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu);
 
 static DEFINE_MUTEX(vendor_module_lock);
 struct kvm_x86_ops kvm_x86_ops __read_mostly;
@@ -11176,7 +11177,8 @@ static inline int vcpu_block(struct kvm_vcpu *vcpu)
 			kvm_lapic_switch_to_sw_timer(vcpu);
 
 		kvm_vcpu_srcu_read_unlock(vcpu);
-		if (vcpu->arch.mp_state == KVM_MP_STATE_HALTED)
+		if (vcpu->arch.mp_state == KVM_MP_STATE_HALTED ||
+		    kvm_hv_vcpu_is_idle_vtl(vcpu))
 			kvm_vcpu_halt(vcpu);
 		else
 			kvm_vcpu_block(vcpu);
@@ -11218,6 +11220,7 @@ static inline int vcpu_block(struct kvm_vcpu *vcpu)
 		vcpu->arch.apf.halted = false;
 		break;
 	case KVM_MP_STATE_INIT_RECEIVED:
+	case KVM_MP_STATE_HV_INACTIVE_VTL:
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -11264,6 +11267,13 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
 		if (kvm_cpu_has_pending_timer(vcpu))
 			kvm_inject_pending_timer_irqs(vcpu);
 
+		if (kvm_hv_vcpu_is_idle_vtl(vcpu) && kvm_vcpu_has_events(vcpu)) {
+			r = 0;
+			vcpu->run->exit_reason = KVM_EXIT_SYSTEM_EVENT;
+			vcpu->run->system_event.type = KVM_SYSTEM_EVENT_WAKEUP;
+			break;
+		}
+
 		if (dm_request_for_irq_injection(vcpu) &&
 			kvm_vcpu_ready_for_interrupt_injection(vcpu)) {
 			r = 0;
@@ -11703,6 +11713,10 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 			goto out;
 		break;
 
+	case KVM_MP_STATE_HV_INACTIVE_VTL:
+		if (is_guest_mode(vcpu) || !kvm_hv_cpuid_vsm_enabled(vcpu))
+			goto out;
+		break;
 	case KVM_MP_STATE_RUNNABLE:
 		break;
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index fbdee8d754595..f4864e6907e0b 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -564,6 +564,7 @@ struct kvm_vapic_addr {
 #define KVM_MP_STATE_LOAD              8
 #define KVM_MP_STATE_AP_RESET_HOLD     9
 #define KVM_MP_STATE_SUSPENDED         10
+#define KVM_MP_STATE_HV_INACTIVE_VTL   11
 
 struct kvm_mp_state {
 	__u32 mp_state;
-- 
2.40.1


