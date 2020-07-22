Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DFE229D6C
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 18:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbgGVQp1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 12:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731019AbgGVQpL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 12:45:11 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302F2C0619DC
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 09:45:11 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w3so2619486wmi.4
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 09:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DU9IS6flmS7+CCKUEvUpb29VHABYdzHg412IRg1X/w0=;
        b=ZoZ7p09HWfpUjJlNSAYgo5+THZR1yZ39Tb1hSTFAuI79CRWviUIu2KF9NNnIdD+EwI
         6646r5SDYQxnXB+TpAP40VJ6UGdFAvmoYXuCG8G9ehWrrn2ZL19+r2xd6Cgi+QBmNMa5
         W+SnpNM7fDifDUxbKd/0pGdA/4l5k+6oLqhpQY/TAvw3w8IgrZoQJcRaSOanCkiCcvBK
         S1ZGtEK7Xoma+JGFq3q/YsWMBJGdtUwR5PTx9O2DC/rZDgRT+uys/1oJSEEdXu0956gJ
         W6nnxlJnjkwZqDILf8sdUheSEKq3VS0cpMMfCtXKN1Z6nyQBw7zv5yVe2WOImkYa9dao
         zhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DU9IS6flmS7+CCKUEvUpb29VHABYdzHg412IRg1X/w0=;
        b=uL2RGiHBBeLrj94fZceiZ/VUT/uGDT4s/P6uxSWvXdRt4Zq7gB+R4ebF01j5VtkTCQ
         C1JFB8clUVHGDnOXFdgoh37AdGSXrFgjtbw5OL7YkBSr091ra+obNV35VazmZWa8r2Of
         iFCSAfUWjHqQvZAneU/3IRlPHZgm8i9DWwK9ctUtl7ivKqFzltG3jj4s30/zFcRFpvXM
         W+NkwNC7cZ/ns/jcH2hQW+4wwtRYM57LSSg12HhMJkjt7m8sYOqwLzLsRuv5L+Jaz1x6
         zPy/VR34gyy8ddUKw9jW7c6SMtmruy0bsUjpNohVN9tBW1u5x9uSKckdQ//cDRhNWBy0
         zRJA==
X-Gm-Message-State: AOAM532m6H96k5VzQ3a12TwHolqVw+3Ucq2DkdJ2La1heXlamQnYkNTe
        JEMpicTEpDPp/6zp51kZ2e/oYA==
X-Google-Smtp-Source: ABdhPJy9BRTUrJxQau5L70fZlV8vjr6phvTKyvOL3z0vh9LpXeBczB7Rf+5/QVXJY/5OxbBCW4oJ3A==
X-Received: by 2002:a1c:7402:: with SMTP id p2mr448503wmc.117.1595436309683;
        Wed, 22 Jul 2020 09:45:09 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:b0ee:900a:e004:b9d0])
        by smtp.gmail.com with ESMTPSA id q4sm346683wme.31.2020.07.22.09.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 09:45:08 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        kernel-team@google.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 6/9] kvm: arm64: Create separate instances of kvm_host_data for VHE/nVHE
Date:   Wed, 22 Jul 2020 17:44:21 +0100
Message-Id: <20200722164424.42225-7-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722164424.42225-1-dbrazdil@google.com>
References: <20200722164424.42225-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Host CPU context is stored in a global per-cpu variable `kvm_host_data`.
In preparation for introducing independent per-CPU region for nVHE hyp,
create two separate instances of `kvm_host_data`, one for VHE and one
for nVHE.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_host.h | 2 +-
 arch/arm64/kernel/image-vars.h    | 1 -
 arch/arm64/kvm/arm.c              | 5 ++---
 arch/arm64/kvm/hyp/nvhe/switch.c  | 3 +++
 arch/arm64/kvm/hyp/vhe/switch.c   | 3 +++
 arch/arm64/kvm/pmu.c              | 8 ++++----
 6 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index e1a32c0707bb..a6d61a708056 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -574,7 +574,7 @@ void kvm_set_sei_esr(struct kvm_vcpu *vcpu, u64 syndrome);
 
 struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
 
-DECLARE_PER_CPU(kvm_host_data_t, kvm_host_data);
+DECLARE_KVM_HYP_PER_CPU(kvm_host_data_t, kvm_host_data);
 
 static inline void kvm_init_host_cpu_context(struct kvm_cpu_context *cpu_ctxt)
 {
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 034cf21e67ce..e23b044c4081 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -69,7 +69,6 @@ KVM_NVHE_ALIAS(kvm_patch_vector_branch);
 KVM_NVHE_ALIAS(kvm_update_va_mask);
 
 /* Global kernel state accessed by nVHE hyp code. */
-KVM_NVHE_ALIAS(kvm_host_data);
 KVM_NVHE_ALIAS(kvm_vgic_global_state);
 
 /* Kernel constant needed to compute idmap addresses. */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index a53e87305fa0..0700c3d21b23 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -46,7 +46,6 @@
 __asm__(".arch_extension	virt");
 #endif
 
-DEFINE_PER_CPU(kvm_host_data_t, kvm_host_data);
 static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
 
 /* The VMID used in the VTTBR */
@@ -1303,7 +1302,7 @@ static void cpu_hyp_reset(void)
 
 static void cpu_hyp_reinit(void)
 {
-	kvm_init_host_cpu_context(&this_cpu_ptr(&kvm_host_data)->host_ctxt);
+	kvm_init_host_cpu_context(&this_cpu_ptr_hyp(kvm_host_data)->host_ctxt);
 
 	cpu_hyp_reset();
 
@@ -1538,7 +1537,7 @@ static int init_hyp_mode(void)
 	for_each_possible_cpu(cpu) {
 		kvm_host_data_t *cpu_data;
 
-		cpu_data = per_cpu_ptr(&kvm_host_data, cpu);
+		cpu_data = per_cpu_ptr_hyp(kvm_host_data, cpu);
 		err = create_hyp_mappings(cpu_data, cpu_data + 1, PAGE_HYP);
 
 		if (err) {
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 8c2bd04df813..4488d14de1b5 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -30,6 +30,9 @@
 /* Non-VHE copy of the kernel symbol. */
 DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
 
+/* Non-VHE instance of kvm_host_data. */
+DEFINE_PER_CPU(kvm_host_data_t, kvm_host_data);
+
 static void __activate_traps(struct kvm_vcpu *vcpu)
 {
 	u64 val;
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 746fcc3974c7..7927a969eca4 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -28,6 +28,9 @@
 
 const char __hyp_panic_string[] = "HYP panic:\nPS:%08llx PC:%016llx ESR:%08llx\nFAR:%016llx HPFAR:%016llx PAR:%016llx\nVCPU:%p\n";
 
+/* VHE instance of kvm_host_data. */
+DEFINE_PER_CPU(kvm_host_data_t, kvm_host_data);
+
 static void __activate_traps(struct kvm_vcpu *vcpu)
 {
 	u64 val;
diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index b5ae3a5d509e..717941910723 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -31,7 +31,7 @@ static bool kvm_pmu_switch_needed(struct perf_event_attr *attr)
  */
 void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr)
 {
-	struct kvm_host_data *ctx = this_cpu_ptr(&kvm_host_data);
+	struct kvm_host_data *ctx = this_cpu_ptr_hyp(kvm_host_data);
 
 	if (!kvm_pmu_switch_needed(attr))
 		return;
@@ -47,7 +47,7 @@ void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr)
  */
 void kvm_clr_pmu_events(u32 clr)
 {
-	struct kvm_host_data *ctx = this_cpu_ptr(&kvm_host_data);
+	struct kvm_host_data *ctx = this_cpu_ptr_hyp(kvm_host_data);
 
 	ctx->pmu_events.events_host &= ~clr;
 	ctx->pmu_events.events_guest &= ~clr;
@@ -169,7 +169,7 @@ void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu)
 	if (!has_vhe())
 		return;
 
-	host = this_cpu_ptr(&kvm_host_data);
+	host = this_cpu_ptr_hyp(kvm_host_data);
 	events_guest = host->pmu_events.events_guest;
 	events_host = host->pmu_events.events_host;
 
@@ -188,7 +188,7 @@ void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu)
 	if (!has_vhe())
 		return;
 
-	host = this_cpu_ptr(&kvm_host_data);
+	host = this_cpu_ptr_hyp(kvm_host_data);
 	events_guest = host->pmu_events.events_guest;
 	events_host = host->pmu_events.events_host;
 
-- 
2.27.0

