Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170D925BE4B
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 11:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgICJR6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 05:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgICJRo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 05:17:44 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F09C061245
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 02:17:44 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id z23so2762935ejr.13
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 02:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SrGd93fxkwD2pyEKRstXopHn1z8dcE4gBzaKU7CKZCA=;
        b=HRlIL51l59ebWCHj5J3CT4xkM9IlN8rKbGmg8e0Y9n86Lri/I1YlfU6fXP/zgUmqw3
         nI8nRSnDI3ygU5E/oBVeCszNwIutKvZ6t1sxteGwQ0KPwzLsDX4JM3hYqiP33Bwr+Gyr
         bkvINlzb0gkhs/MK+1+UNMhwQsNntGM/ivuFzAxzp1qwt3i+pA3M+i4kc706jN0aad/D
         eXhAux7wYJSt0YamlmnEbFIguBmpR0upVjXVL8Bvqs/5w/5+ugq1VJ/GICOHT1KU57/p
         P2GzWRMcQGTSN20ojg2OTkQK1ruNM2qz+o4lFnMGtyVfVJVFe6jTjoKi8EEKKbTBo0LJ
         g3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SrGd93fxkwD2pyEKRstXopHn1z8dcE4gBzaKU7CKZCA=;
        b=E54j1CLPieqlOJ68Gy2kr95FqOmqHK8Oj0/r9R16os9bX2VSLVyruRheOTuLc3DcxU
         SLzQzSQdGylaXOlRsan2NiMHStLaCXlgTqaIkjVaA7UX3h70FItb2W/Vo6ZF++ohuJFN
         im+8REsibXvjYHwtV3HCeX07GGO3zR16Dy4sMEfoAotYWW4pITlrj727yhxMZhv7na00
         9i2KfRWsMdU1YghXQDoYKhgrSF1wVMqIXEJbhIVeyBPambDMRaYJGYMfQBoRRSzKFi+B
         FiOlAbPha8czr0FKdUK7T5JgVJx/Ri843r9e3D7JfJovr91Oy3M2kNiPh4uWc3J0taqO
         Twgg==
X-Gm-Message-State: AOAM53009+LMBhw0wqMP2iu5mmXsG8gtd2/gAJG9hKtRjtej05b/iE6L
        fpTBqE8oszl4+MBapL+oL2+LBw==
X-Google-Smtp-Source: ABdhPJzHjBZW2yUpqLooMNfefLtRAJ+xiOCyrfqzLjU8r36iKi/k8YqA2eAD2V40RD+Fun2kL9iNRA==
X-Received: by 2002:a17:907:2168:: with SMTP id rl8mr1136229ejb.308.1599124662488;
        Thu, 03 Sep 2020 02:17:42 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-919a-a06e-64ac-0036-822c-68d3.ipv6.broadband.iol.cz. [2a00:1028:919a:a06e:64ac:36:822c:68d3])
        by smtp.gmail.com with ESMTPSA id bq24sm2672780ejb.27.2020.09.03.02.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 02:17:41 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 03/10] kvm: arm64: Remove __hyp_this_cpu_read
Date:   Thu,  3 Sep 2020 11:17:05 +0200
Message-Id: <20200903091712.46456-4-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903091712.46456-1-dbrazdil@google.com>
References: <20200903091712.46456-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

this_cpu_ptr is meant for use in kernel proper because it selects between
TPIDR_EL1/2 based on nVHE/VHE. __hyp_this_cpu_ptr was used in hyp to always
select TPIDR_EL2. Unify all users behind this_cpu_ptr and friends by
selecting _EL2 register under __KVM_NVHE_HYPERVISOR__.

Under CONFIG_DEBUG_PREEMPT, the kernel helpers perform a preemption check
which is omitted by the hyp helpers. Preserve the behavior for nVHE by
overriding the corresponding macros under __KVM_NVHE_HYPERVISOR__. Extend
the checks into VHE hyp code.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_asm.h          | 20 --------------
 arch/arm64/include/asm/percpu.h           | 33 +++++++++++++++++++++--
 arch/arm64/kvm/hyp/include/hyp/debug-sr.h |  4 +--
 arch/arm64/kvm/hyp/include/hyp/switch.h   |  8 +++---
 arch/arm64/kvm/hyp/nvhe/switch.c          |  2 +-
 arch/arm64/kvm/hyp/vhe/switch.c           |  2 +-
 arch/arm64/kvm/hyp/vhe/sysreg-sr.c        |  4 +--
 7 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 6f98fbd0ac81..9149079f0269 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -149,26 +149,6 @@ extern char __smccc_workaround_1_smc[__SMCCC_WORKAROUND_1_SMC_SZ];
 		addr;							\
 	})
 
-/*
- * Home-grown __this_cpu_{ptr,read} variants that always work at HYP,
- * provided that sym is really a *symbol* and not a pointer obtained from
- * a data structure. As for SHIFT_PERCPU_PTR(), the creative casting keeps
- * sparse quiet.
- */
-#define __hyp_this_cpu_ptr(sym)						\
-	({								\
-		void *__ptr;						\
-		__verify_pcpu_ptr(&sym);				\
-		__ptr = hyp_symbol_addr(sym);				\
-		__ptr += read_sysreg(tpidr_el2);			\
-		(typeof(sym) __kernel __force *)__ptr;			\
-	 })
-
-#define __hyp_this_cpu_read(sym)					\
-	({								\
-		*__hyp_this_cpu_ptr(sym);				\
-	 })
-
 #define __KVM_EXTABLE(from, to)						\
 	"	.pushsection	__kvm_ex_table, \"a\"\n"		\
 	"	.align		3\n"					\
diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 0b6409b89e5e..b4008331475b 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -19,7 +19,21 @@ static inline void set_my_cpu_offset(unsigned long off)
 			:: "r" (off) : "memory");
 }
 
-static inline unsigned long __my_cpu_offset(void)
+static inline unsigned long __hyp_my_cpu_offset(void)
+{
+	unsigned long off;
+
+	/*
+	 * We want to allow caching the value, so avoid using volatile and
+	 * instead use a fake stack read to hazard against barrier().
+	 */
+	asm("mrs %0, tpidr_el2" : "=r" (off) :
+		"Q" (*(const unsigned long *)current_stack_pointer));
+
+	return off;
+}
+
+static inline unsigned long __kern_my_cpu_offset(void)
 {
 	unsigned long off;
 
@@ -35,7 +49,12 @@ static inline unsigned long __my_cpu_offset(void)
 
 	return off;
 }
-#define __my_cpu_offset __my_cpu_offset()
+
+#ifdef __KVM_NVHE_HYPERVISOR__
+#define __my_cpu_offset __hyp_my_cpu_offset()
+#else
+#define __my_cpu_offset __kern_my_cpu_offset()
+#endif
 
 #define PERCPU_RW_OPS(sz)						\
 static inline unsigned long __percpu_read_##sz(void *ptr)		\
@@ -227,4 +246,14 @@ PERCPU_RET_OP(add, add, ldadd)
 
 #include <asm-generic/percpu.h>
 
+/* Redefine macros for nVHE hyp under DEBUG_PREEMPT to avoid its dependencies. */
+#if defined(__KVM_NVHE_HYPERVISOR__) && defined(CONFIG_DEBUG_PREEMPT)
+#undef	this_cpu_ptr
+#define	this_cpu_ptr		raw_cpu_ptr
+#undef	__this_cpu_read
+#define	__this_cpu_read		raw_cpu_read
+#undef	__this_cpu_write
+#define	__this_cpu_write	raw_cpu_write
+#endif
+
 #endif /* __ASM_PERCPU_H */
diff --git a/arch/arm64/kvm/hyp/include/hyp/debug-sr.h b/arch/arm64/kvm/hyp/include/hyp/debug-sr.h
index 5e28ea6aa097..4ebe9f558f3a 100644
--- a/arch/arm64/kvm/hyp/include/hyp/debug-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/debug-sr.h
@@ -135,7 +135,7 @@ static inline void __debug_switch_to_guest_common(struct kvm_vcpu *vcpu)
 	if (!(vcpu->arch.flags & KVM_ARM64_DEBUG_DIRTY))
 		return;
 
-	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
+	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	guest_ctxt = &vcpu->arch.ctxt;
 	host_dbg = &vcpu->arch.host_debug_state.regs;
 	guest_dbg = kern_hyp_va(vcpu->arch.debug_ptr);
@@ -154,7 +154,7 @@ static inline void __debug_switch_to_host_common(struct kvm_vcpu *vcpu)
 	if (!(vcpu->arch.flags & KVM_ARM64_DEBUG_DIRTY))
 		return;
 
-	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
+	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	guest_ctxt = &vcpu->arch.ctxt;
 	host_dbg = &vcpu->arch.host_debug_state.regs;
 	guest_dbg = kern_hyp_va(vcpu->arch.debug_ptr);
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 5b6b8fa00f0a..f150407fa798 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -386,7 +386,7 @@ static inline bool __hyp_handle_ptrauth(struct kvm_vcpu *vcpu)
 	    !esr_is_ptrauth_trap(kvm_vcpu_get_esr(vcpu)))
 		return false;
 
-	ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
+	ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	__ptrauth_save_key(ctxt, APIA);
 	__ptrauth_save_key(ctxt, APIB);
 	__ptrauth_save_key(ctxt, APDA);
@@ -495,7 +495,7 @@ static inline void __set_guest_arch_workaround_state(struct kvm_vcpu *vcpu)
 	 * guest wants it disabled, so be it...
 	 */
 	if (__needs_ssbd_off(vcpu) &&
-	    __hyp_this_cpu_read(arm64_ssbd_callback_required))
+	    __this_cpu_read(arm64_ssbd_callback_required))
 		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_WORKAROUND_2, 0, NULL);
 #endif
 }
@@ -507,7 +507,7 @@ static inline void __set_host_arch_workaround_state(struct kvm_vcpu *vcpu)
 	 * If the guest has disabled the workaround, bring it back on.
 	 */
 	if (__needs_ssbd_off(vcpu) &&
-	    __hyp_this_cpu_read(arm64_ssbd_callback_required))
+	    __this_cpu_read(arm64_ssbd_callback_required))
 		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_WORKAROUND_2, 1, NULL);
 #endif
 }
@@ -521,7 +521,7 @@ static inline void __kvm_unexpected_el2_exception(void)
 
 	entry = hyp_symbol_addr(__start___kvm_ex_table);
 	end = hyp_symbol_addr(__stop___kvm_ex_table);
-	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
+	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 
 	while (entry < end) {
 		addr = (unsigned long)&entry->insn + entry->insn;
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 0970442d2dbc..cc4f8e790fb3 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -175,7 +175,7 @@ int __kvm_vcpu_run(struct kvm_vcpu *vcpu)
 
 	vcpu = kern_hyp_va(vcpu);
 
-	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
+	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	host_ctxt->__hyp_running_vcpu = vcpu;
 	guest_ctxt = &vcpu->arch.ctxt;
 
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index c1da4f86ccac..575e8054f116 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -108,7 +108,7 @@ static int __kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 	struct kvm_cpu_context *guest_ctxt;
 	u64 exit_code;
 
-	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
+	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	host_ctxt->__hyp_running_vcpu = vcpu;
 	guest_ctxt = &vcpu->arch.ctxt;
 
diff --git a/arch/arm64/kvm/hyp/vhe/sysreg-sr.c b/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
index 996471e4c138..2a0b8c88d74f 100644
--- a/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
+++ b/arch/arm64/kvm/hyp/vhe/sysreg-sr.c
@@ -66,7 +66,7 @@ void kvm_vcpu_load_sysregs_vhe(struct kvm_vcpu *vcpu)
 	struct kvm_cpu_context *guest_ctxt = &vcpu->arch.ctxt;
 	struct kvm_cpu_context *host_ctxt;
 
-	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
+	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	__sysreg_save_user_state(host_ctxt);
 
 	/*
@@ -100,7 +100,7 @@ void kvm_vcpu_put_sysregs_vhe(struct kvm_vcpu *vcpu)
 	struct kvm_cpu_context *guest_ctxt = &vcpu->arch.ctxt;
 	struct kvm_cpu_context *host_ctxt;
 
-	host_ctxt = &__hyp_this_cpu_ptr(kvm_host_data)->host_ctxt;
+	host_ctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
 	deactivate_traps_vhe_put();
 
 	__sysreg_save_el1_state(guest_ctxt);
-- 
2.28.0.402.g5ffc5be6b7-goog

