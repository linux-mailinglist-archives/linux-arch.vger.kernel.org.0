Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E856F689B01
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 15:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjBCOFm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 09:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbjBCOFN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 09:05:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EF0DA87A6;
        Fri,  3 Feb 2023 06:02:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F41321764;
        Fri,  3 Feb 2023 05:54:41 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30BAE3F71E;
        Fri,  3 Feb 2023 05:53:56 -0800 (PST)
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
Subject: [RFC PATCH 29/32] KVM: arm64: Pass hypercalls to userspace
Date:   Fri,  3 Feb 2023 13:50:40 +0000
Message-Id: <20230203135043.409192-30-james.morse@arm.com>
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

When capability KVM_CAP_ARM_HVC_TO_USER is available, userspace can
request to handle all hypercalls that aren't handled by KVM. With the
help of another capability, this will allow userspace to handle PSCI
calls.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: James Morse <james.morse@arm.com>

---

Notes on this implementation:

* A similar mechanism was proposed for SDEI some time ago [1]. This RFC
  generalizes the idea to all hypercalls, since that was suggested on
  the list [2, 3].

* We're reusing kvm_run.hypercall. I copied x0-x5 into
  kvm_run.hypercall.args[] to help userspace but I'm tempted to remove
  this, because:
  - Most user handlers will need to write results back into the
    registers (x0-x3 for SMCCC), so if we keep this shortcut we should
    go all the way and read them back on return to kernel.
  - QEMU doesn't care about this shortcut, it pulls all vcpu regs before
    handling the call.
  - SMCCC uses x0-x16 for parameters.
  x0 does contain the SMCCC function ID and may be useful for fast
  dispatch, we could keep that plus the immediate number.

* Add a flag in the kvm_run.hypercall telling whether this is HVC or
  SMC?  Can be added later in those bottom longmode and pad fields.

* On top of this we could share with userspace which HVC ranges are
  available and which ones are handled by KVM. That can actually be added
  independently, through a vCPU/VM device attribute which doesn't consume
  a new ioctl:
  - userspace issues HAS_ATTR ioctl on the vcpu fd to query whether this
    feature is available.
  - userspace queries the number N of HVC ranges using one GET_ATTR.
  - userspace passes an array of N ranges using another GET_ATTR. The
    array is filled and returned by KVM.

* Enabling this using a vCPU arch feature rather than the whole-VM
  capability would be fine, but it would be difficult to do the same for
  the following psci-in-user capability. So let's enable everything at
  the VM scope.

* No idea whether this work out of the box for AArch32 guests.

[1] https://lore.kernel.org/linux-arm-kernel/20170808164616.25949-12-james.morse@arm.com/
[2] https://lore.kernel.org/linux-arm-kernel/bf7e83f1-c58e-8d65-edd0-d08f27b8b766@arm.com/
[3] https://lore.kernel.org/linux-arm-kernel/f56cf420-affc-35f0-2355-801a924b8a35@arm.com/
---
 Documentation/virt/kvm/api.rst    | 17 +++++++++++++++--
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/arm.c              |  5 +++++
 arch/arm64/kvm/hypercalls.c       | 28 +++++++++++++++++++++++++++-
 include/kvm/arm_psci.h            |  4 ++++
 include/uapi/linux/kvm.h          |  1 +
 6 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index deb494f759ed..9a28a9cc1163 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6122,8 +6122,12 @@ to the byte array.
 			__u32 pad;
 		} hypercall;
 
-Unused.  This was once used for 'hypercall to userspace'.  To implement
-such functionality, use KVM_EXIT_IO (x86) or KVM_EXIT_MMIO (all except s390).
+On x86 this was once used for 'hypercall to userspace'.  To implement such
+functionality, use KVM_EXIT_IO (x86) or KVM_EXIT_MMIO (all except s390).
+
+On arm64 it is used for hypercalls, when the KVM_CAP_ARM_HVC_TO_USER capability
+is enabled. 'nr' contains the HVC or SMC immediate. 'args' contains registers
+x0 - x5. The other parameters are unused.
 
 .. note:: KVM_EXIT_IO is significantly faster than KVM_EXIT_MMIO.
 
@@ -8276,6 +8280,15 @@ structure.
 When getting the Modified Change Topology Report value, the attr->addr
 must point to a byte where the value will be stored or retrieved from.
 
+8.37 KVM_CAP_ARM_HVC_TO_USER
+----------------------------
+
+:Architecture: arm64
+
+This capability indicates that KVM can pass unhandled hypercalls to userspace,
+if the VMM enables it. Hypercalls are passed with KVM_EXIT_HYPERCALL in
+kvm_run::hypercall.
+
 9. Known KVM API problems
 =========================
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 35a159d131b5..40911ebfa710 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -213,6 +213,7 @@ struct kvm_arch {
 #define KVM_ARCH_FLAG_EL1_32BIT				4
 	/* PSCI SYSTEM_SUSPEND enabled for the guest */
 #define KVM_ARCH_FLAG_SYSTEM_SUSPEND_ENABLED		5
+#define KVM_ARCH_FLAG_HVC_TO_USER			6
 
 	unsigned long flags;
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 9c5573bc4614..815b7e8f88e1 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -101,6 +101,10 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		r = 0;
 		set_bit(KVM_ARCH_FLAG_SYSTEM_SUSPEND_ENABLED, &kvm->arch.flags);
 		break;
+	case KVM_CAP_ARM_HVC_TO_USER:
+		r = 0;
+		set_bit(KVM_ARCH_FLAG_HVC_TO_USER, &kvm->arch.flags);
+		break;
 	default:
 		r = -EINVAL;
 		break;
@@ -230,6 +234,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_VCPU_ATTRIBUTES:
 	case KVM_CAP_PTP_KVM:
 	case KVM_CAP_ARM_SYSTEM_SUSPEND:
+	case KVM_CAP_ARM_HVC_TO_USER:
 		r = 1;
 		break;
 	case KVM_CAP_SET_GUEST_DEBUG2:
diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index c9f401fa01a9..efaf05d40dab 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -121,6 +121,28 @@ static bool kvm_hvc_call_allowed(struct kvm_vcpu *vcpu, u32 func_id)
 	}
 }
 
+static int kvm_hvc_user(struct kvm_vcpu *vcpu)
+{
+	int i;
+	struct kvm_run *run = vcpu->run;
+
+	if (!test_bit(KVM_ARCH_FLAG_HVC_TO_USER, &vcpu->kvm->arch.flags)) {
+		smccc_set_retval(vcpu, SMCCC_RET_NOT_SUPPORTED, 0, 0, 0);
+		return 1;
+	}
+
+	run->exit_reason = KVM_EXIT_HYPERCALL;
+	run->hypercall.nr = kvm_vcpu_hvc_get_imm(vcpu);
+	/* Add the first parameters for fast access. */
+	for (i = 0; i < 6; i++)
+		run->hypercall.args[i] = vcpu_get_reg(vcpu, i);
+	run->hypercall.ret = 0;
+	run->hypercall.longmode = 0;
+	run->hypercall.pad = 0;
+
+	return 0;
+}
+
 int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 {
 	struct kvm_smccc_features *smccc_feat = &vcpu->kvm->arch.smccc_feat;
@@ -219,8 +241,12 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 	case ARM_SMCCC_TRNG_RND32:
 	case ARM_SMCCC_TRNG_RND64:
 		return kvm_trng_call(vcpu);
-	default:
+	case KVM_PSCI_FN_BASE...KVM_PSCI_FN_LAST:
+	case PSCI_0_2_FN_BASE...PSCI_0_2_FN_LAST:
+	case PSCI_0_2_FN64_BASE...PSCI_0_2_FN64_LAST:
 		return kvm_psci_call(vcpu);
+	default:
+		return kvm_hvc_user(vcpu);
 	}
 
 out:
diff --git a/include/kvm/arm_psci.h b/include/kvm/arm_psci.h
index 6e55b9283789..7391fa51419a 100644
--- a/include/kvm/arm_psci.h
+++ b/include/kvm/arm_psci.h
@@ -17,6 +17,10 @@
 
 #define KVM_ARM_PSCI_LATEST	KVM_ARM_PSCI_1_1
 
+#define KVM_PSCI_FN_LAST	KVM_PSCI_FN(3)
+#define PSCI_0_2_FN_LAST	PSCI_0_2_FN(0x3f)
+#define PSCI_0_2_FN64_LAST	PSCI_0_2_FN64(0x3f)
+
 static inline int kvm_psci_version(struct kvm_vcpu *vcpu)
 {
 	/*
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 55155e262646..2ead8b9aae56 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1175,6 +1175,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_DIRTY_LOG_RING_ACQ_REL 223
 #define KVM_CAP_S390_PROTECTED_ASYNC_DISABLE 224
 #define KVM_CAP_DIRTY_LOG_RING_WITH_BITMAP 225
+#define KVM_CAP_ARM_HVC_TO_USER 226
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.30.2

