Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C849F689AAB
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 14:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjBCN4p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 08:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbjBCN4J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 08:56:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A666499D4D;
        Fri,  3 Feb 2023 05:54:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 369F315A1;
        Fri,  3 Feb 2023 05:54:46 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 679363F71E;
        Fri,  3 Feb 2023 05:54:00 -0800 (PST)
From:   James Morse <james.morse@arm.com>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Len Brown <lenb@kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RFC PATCH 30/32] KVM: arm64: Pass PSCI calls to userspace
Date:   Fri,  3 Feb 2023 13:50:41 +0000
Message-Id: <20230203135043.409192-31-james.morse@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230203135043.409192-1-james.morse@arm.com>
References: <20230203135043.409192-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

When the KVM_CAP_ARM_PSCI_TO_USER capability is available, userspace can
request to handle PSCI calls.

This is required for virtual CPU hotplug to allow the VMM to enforce the
online/offline policy it has advertised via ACPI. By managing PSCI in
user-space, the VMM is able to return PSCI_DENIED when the guest attempts
to bring a disabled vCPU online.
Without this, the VMM is only able to not-run the vCPU, the kernel will
have already returned PSCI_SUCCESS to the guest. This results in
timeouts during boot as the OS must wait for the secondary vCPU.

SMCCC probe requires PSCI v1.x. If userspace only implements PSCI v0.2,
the guest won't query SMCCC support through PSCI and won't use the
spectre workarounds. We could hijack PSCI_VERSION and pretend to support
v1.0 if userspace does not, then handle all v1.0 calls ourselves
(including guessing the PSCI feature set implemented by the guest), but
that seems unnecessary. After all the API already allows userspace to
force a version lower than v1.0 using the firmware pseudo-registers.

The KVM_REG_ARM_PSCI_VERSION pseudo-register currently resets to either
v0.1 if userspace doesn't set KVM_ARM_VCPU_PSCI_0_2, or
KVM_ARM_PSCI_LATEST (1.0).

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
[morse: Added description of why this is required]
Signed-off-by: James Morse <james.morse@arm.com>
---
 Documentation/virt/kvm/api.rst            | 14 ++++++++++++++
 Documentation/virt/kvm/arm/hypercalls.rst |  1 +
 arch/arm64/include/asm/kvm_host.h         |  1 +
 arch/arm64/kvm/arm.c                      | 10 +++++++---
 arch/arm64/kvm/hypercalls.c               |  2 +-
 arch/arm64/kvm/psci.c                     | 13 +++++++++++++
 include/kvm/arm_hypercalls.h              |  1 +
 include/uapi/linux/kvm.h                  |  1 +
 8 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 9a28a9cc1163..eb99436a1d97 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8289,6 +8289,20 @@ This capability indicates that KVM can pass unhandled hypercalls to userspace,
 if the VMM enables it. Hypercalls are passed with KVM_EXIT_HYPERCALL in
 kvm_run::hypercall.
 
+8.38 KVM_CAP_ARM_PSCI_TO_USER
+-----------------------------
+
+:Architectures: arm64
+
+When the VMM enables this capability, all PSCI calls are passed to userspace
+instead of being handled by KVM. Capability KVM_CAP_ARM_HVC_TO_USER must be
+enabled first.
+
+Userspace should support at least PSCI v1.0. Otherwise SMCCC features won't be
+available to the guest. Userspace does not need to handle the SMCCC_VERSION
+parameter for the PSCI_FEATURES function. The KVM_ARM_VCPU_PSCI_0_2 vCPU
+feature should be set even if this capability is enabled.
+
 9. Known KVM API problems
 =========================
 
diff --git a/Documentation/virt/kvm/arm/hypercalls.rst b/Documentation/virt/kvm/arm/hypercalls.rst
index 3e23084644ba..4c111afa7d74 100644
--- a/Documentation/virt/kvm/arm/hypercalls.rst
+++ b/Documentation/virt/kvm/arm/hypercalls.rst
@@ -34,6 +34,7 @@ The following registers are defined:
   - Allows any PSCI version implemented by KVM and compatible with
     v0.2 to be set with SET_ONE_REG
   - Affects the whole VM (even if the register view is per-vcpu)
+  - Defaults to PSCI 1.0 if userspace enables KVM_CAP_ARM_PSCI_TO_USER.
 
 * KVM_REG_ARM_SMCCC_ARCH_WORKAROUND_1:
     Holds the state of the firmware support to mitigate CVE-2017-5715, as
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 40911ebfa710..a9eff47bcb43 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -214,6 +214,7 @@ struct kvm_arch {
 	/* PSCI SYSTEM_SUSPEND enabled for the guest */
 #define KVM_ARCH_FLAG_SYSTEM_SUSPEND_ENABLED		5
 #define KVM_ARCH_FLAG_HVC_TO_USER			6
+#define KVM_ARCH_FLAG_PSCI_TO_USER			7
 
 	unsigned long flags;
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 815b7e8f88e1..3dba4e01f4d8 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -76,7 +76,7 @@ int kvm_arch_check_processor_compat(void *opaque)
 int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			    struct kvm_enable_cap *cap)
 {
-	int r;
+	int r = -EINVAL;
 
 	if (cap->flags)
 		return -EINVAL;
@@ -105,8 +105,11 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		r = 0;
 		set_bit(KVM_ARCH_FLAG_HVC_TO_USER, &kvm->arch.flags);
 		break;
-	default:
-		r = -EINVAL;
+	case KVM_CAP_ARM_PSCI_TO_USER:
+		if (test_bit(KVM_ARCH_FLAG_HVC_TO_USER, &kvm->arch.flags)) {
+			r = 0;
+			set_bit(KVM_ARCH_FLAG_PSCI_TO_USER, &kvm->arch.flags);
+		}
 		break;
 	}
 
@@ -235,6 +238,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_PTP_KVM:
 	case KVM_CAP_ARM_SYSTEM_SUSPEND:
 	case KVM_CAP_ARM_HVC_TO_USER:
+	case KVM_CAP_ARM_PSCI_TO_USER:
 		r = 1;
 		break;
 	case KVM_CAP_SET_GUEST_DEBUG2:
diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index efaf05d40dab..3c2136cd7a3f 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -121,7 +121,7 @@ static bool kvm_hvc_call_allowed(struct kvm_vcpu *vcpu, u32 func_id)
 	}
 }
 
-static int kvm_hvc_user(struct kvm_vcpu *vcpu)
+int kvm_hvc_user(struct kvm_vcpu *vcpu)
 {
 	int i;
 	struct kvm_run *run = vcpu->run;
diff --git a/arch/arm64/kvm/psci.c b/arch/arm64/kvm/psci.c
index 7fbc4c1b9df0..8505b26f0a83 100644
--- a/arch/arm64/kvm/psci.c
+++ b/arch/arm64/kvm/psci.c
@@ -418,6 +418,16 @@ static int kvm_psci_0_1_call(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+static bool kvm_psci_call_is_user(struct kvm_vcpu *vcpu)
+{
+	/* Handle the special case of SMCCC probe through PSCI */
+	if (smccc_get_function(vcpu) == PSCI_1_0_FN_PSCI_FEATURES &&
+	    smccc_get_arg1(vcpu) == ARM_SMCCC_VERSION_FUNC_ID)
+		return false;
+
+	return test_bit(KVM_ARCH_FLAG_PSCI_TO_USER, &vcpu->kvm->arch.flags);
+}
+
 /**
  * kvm_psci_call - handle PSCI call if r0 value is in range
  * @vcpu: Pointer to the VCPU struct
@@ -443,6 +453,9 @@ int kvm_psci_call(struct kvm_vcpu *vcpu)
 		return 1;
 	}
 
+	if (kvm_psci_call_is_user(vcpu))
+		return kvm_hvc_user(vcpu);
+
 	switch (kvm_psci_version(vcpu)) {
 	case KVM_ARM_PSCI_1_1:
 		return kvm_psci_1_x_call(vcpu, 1);
diff --git a/include/kvm/arm_hypercalls.h b/include/kvm/arm_hypercalls.h
index 1188f116cf4e..ea7073d1a82e 100644
--- a/include/kvm/arm_hypercalls.h
+++ b/include/kvm/arm_hypercalls.h
@@ -6,6 +6,7 @@
 
 #include <asm/kvm_emulate.h>
 
+int kvm_hvc_user(struct kvm_vcpu *vcpu);
 int kvm_hvc_call_handler(struct kvm_vcpu *vcpu);
 
 static inline u32 smccc_get_function(struct kvm_vcpu *vcpu)
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 2ead8b9aae56..c5da9d703a0f 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1176,6 +1176,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_PROTECTED_ASYNC_DISABLE 224
 #define KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP 225
 #define KVM_CAP_ARM_HVC_TO_USER 226
+#define KVM_CAP_ARM_PSCI_TO_USER 227
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.30.2

