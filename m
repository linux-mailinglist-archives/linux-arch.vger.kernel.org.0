Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A5825BE4C
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 11:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgICJSo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 05:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbgICJR5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 05:17:57 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8B9C06125C
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 02:17:54 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id i22so2832632eja.5
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 02:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=22FDsG2iZpK/4rGNv58xs8DHFdUQri5Jr1UNE+6mylQ=;
        b=nMfWtLwFlKOKjnQRBR8B1Cf3oI5FbF7UZcTPADs/DolIRxiGjjVgPUhp7JOS4z2rbb
         uLLDsPat/+nF1SZHOeuqv5yof7xurbgnFAnWmj3y1LAP2D/M5cYjGuR2IZeoOizewrMx
         As1Q/GCznqtOImaDt++9UkE1rlwejNJlIG6W7mmQkxnFAUB/+oGZ+AzNTD8+1M2O2u1l
         6YB9EXX5DLq1CKv9EHKUc2KRxhJ5No1Nif9rprHTMGleWBjQkTyfMdntl43ps8v5kOYL
         AZtRLAWGSgk8M0FjnGtgsRo79ZO1DodIMFTJ6M/ysYHNSKNicuD5JrjRW334QcaIgx2R
         eYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=22FDsG2iZpK/4rGNv58xs8DHFdUQri5Jr1UNE+6mylQ=;
        b=jeqW16mO/soyskQ5jHamKt9CwbnH3266GzlgdCB5r38uTD4CFWv2VBnjcIhSViICeR
         DNNtK/vwWcsNcj2fkEQCnDUY28exGCNzczqwIldBcfWdPUVgD3VDGahDRJwE00IMmtvW
         Jlb5YagdEOuD39QoHCwdCYQHvxuKs6UHLmiyM2T63pOuqdGW0+slX9P20+UhwfJuvjhA
         ZjrleTdRzA4/oLc1FubQEDSRn+2cE2yk81yZql09JzVwFyvsIYfrXU/VtFa8UMYZbKzr
         sd80Op/qGwnNuJ5X7SIwrfmL9E8IPuGmHhq8wdMnCnV88aUf5DKdCB19D6VBVttkIR7c
         2jKQ==
X-Gm-Message-State: AOAM5336clIr0wZon+PYPBRijkjHWTs8MtMfMuwRrWPLLIkILG87QrZS
        Fw/wm0eAJGnLT+eQscK+WsexTQ==
X-Google-Smtp-Source: ABdhPJxyfhSRIDHpyvYf5FPIpo/5Aj41XM/FjbhFjdrBvNpmd3UNySmojerVgxx5Cn0qBhV+NQdlxA==
X-Received: by 2002:a17:906:f1cf:: with SMTP id gx15mr1090496ejb.241.1599124673252;
        Thu, 03 Sep 2020 02:17:53 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-919a-a06e-64ac-0036-822c-68d3.ipv6.broadband.iol.cz. [2a00:1028:919a:a06e:64ac:36:822c:68d3])
        by smtp.gmail.com with ESMTPSA id y8sm2587216ejd.57.2020.09.03.02.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 02:17:52 -0700 (PDT)
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
Subject: [PATCH v2 07/10] kvm: arm64: Create separate instances of kvm_host_data for VHE/nVHE
Date:   Thu,  3 Sep 2020 11:17:09 +0200
Message-Id: <20200903091712.46456-8-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903091712.46456-1-dbrazdil@google.com>
References: <20200903091712.46456-1-dbrazdil@google.com>
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
index e52c927aade5..964e05777fe3 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -565,7 +565,7 @@ void kvm_set_sei_esr(struct kvm_vcpu *vcpu, u64 syndrome);
 
 struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
 
-DECLARE_PER_CPU(kvm_host_data_t, kvm_host_data);
+DECLARE_KVM_HYP_PER_CPU(kvm_host_data_t, kvm_host_data);
 
 static inline void kvm_init_host_cpu_context(struct kvm_cpu_context *cpu_ctxt)
 {
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 5fc5eadfb3e6..21307e2db3fc 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -69,7 +69,6 @@ KVM_NVHE_ALIAS(kvm_patch_vector_branch);
 KVM_NVHE_ALIAS(kvm_update_va_mask);
 
 /* Global kernel state accessed by nVHE hyp code. */
-KVM_NVHE_ALIAS(kvm_host_data);
 KVM_NVHE_ALIAS(kvm_vgic_global_state);
 
 /* Kernel constant needed to compute idmap addresses. */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 1bb960812493..d437052c5481 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -46,7 +46,6 @@
 __asm__(".arch_extension	virt");
 #endif
 
-DEFINE_PER_CPU(kvm_host_data_t, kvm_host_data);
 static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
 
 /* The VMID used in the VTTBR */
@@ -1305,7 +1304,7 @@ static void cpu_hyp_reset(void)
 
 static void cpu_hyp_reinit(void)
 {
-	kvm_init_host_cpu_context(&this_cpu_ptr(&kvm_host_data)->host_ctxt);
+	kvm_init_host_cpu_context(&this_cpu_ptr_hyp(kvm_host_data)->host_ctxt);
 
 	cpu_hyp_reset();
 
@@ -1540,7 +1539,7 @@ static int init_hyp_mode(void)
 	for_each_possible_cpu(cpu) {
 		kvm_host_data_t *cpu_data;
 
-		cpu_data = per_cpu_ptr(&kvm_host_data, cpu);
+		cpu_data = per_cpu_ptr_hyp(kvm_host_data, cpu);
 		err = create_hyp_mappings(cpu_data, cpu_data + 1, PAGE_HYP);
 
 		if (err) {
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 4662df6330d7..a7e9b03bd9d1 100644
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
index 575e8054f116..0949fc97bf03 100644
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
index 3c224162b3dd..6d80ffe1ebfc 100644
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
@@ -173,7 +173,7 @@ void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu)
 		return;
 
 	preempt_disable();
-	host = this_cpu_ptr(&kvm_host_data);
+	host = this_cpu_ptr_hyp(kvm_host_data);
 	events_guest = host->pmu_events.events_guest;
 	events_host = host->pmu_events.events_host;
 
@@ -193,7 +193,7 @@ void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu)
 	if (!has_vhe())
 		return;
 
-	host = this_cpu_ptr(&kvm_host_data);
+	host = this_cpu_ptr_hyp(kvm_host_data);
 	events_guest = host->pmu_events.events_guest;
 	events_host = host->pmu_events.events_host;
 
-- 
2.28.0.402.g5ffc5be6b7-goog

