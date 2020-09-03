Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEB025BE51
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 11:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgICJSo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 05:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbgICJR4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 05:17:56 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E836CC061251
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 02:17:51 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gr14so1708041ejb.1
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 02:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mwdRMAavqdTzOvo7Ir5BJvWRsG9Q05qSRw6OHtvkMgg=;
        b=fSryvZypFiRayJ6qbXdHAuS+6FDnue70hvCWNO7yOK8m0hMkAwkbG1pA/JeNI0g4bP
         6BM7jhcArJY2rH/F2rySk6k1pOyCgrpB3aynRg2CWQT9D+5Gdy/9FaJUCJgmN9O/SF3N
         4+pQVl03npehC5dbcL3VFetoYyKoZjOs1/SuBZd8+sE6LrP6fd+64/cDg6RMPEfAHBdj
         yJWNrZ4eV4GH5S84SAX+WO2Nk68D36mOzVejo4YmLFm+B0tkHmYZu33yKfcuj2dtUon6
         DM77MiypYG43OUNr5/rK0Bs6MkABNFfbRrRvyezu9uc+d9VeuHmo81HSmvyhD1Ku4Qg2
         NVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mwdRMAavqdTzOvo7Ir5BJvWRsG9Q05qSRw6OHtvkMgg=;
        b=TNsJuzuTLtgwNS3pGTYYLer8REHZCWVerCMYIuiaMfaKu/x/ve+saRBfPtrPbxhU89
         goEuLxgirEMiAXzZFnMPUWAexbCzjZmWuAsHsoAapezU+BLDefj0rCCS1P4EH8qnOl4C
         tnTiuODRercHpfJPE7YXRYFOMJR6vH/9IiH5gd2zRwoR6iyHTOcdNFjJOiPwLKnEelip
         uGxqP+cnnALHmGpyrnIF5sZ2CPZjcEOcfhYHzQ7xQaYiQjndXO76SruyyXnUCrX0Il4P
         DWok1RBrxjQ4C6vhJxBhf7WnkgoBGb8Pz9Sm1WfKSz/t3/AZu4owzu+6PLeiozEuXvNl
         ux7Q==
X-Gm-Message-State: AOAM530LOVkMDf70vUVKnECkhIlbvqFY1zVvJpuP3TD9OL+S7B4ueD8z
        e/edqXUP6yrb8orc7xlJN8viag==
X-Google-Smtp-Source: ABdhPJyIo0tfIVl9zQQOPILZ6Iv+dAifCx9Hj7ENqoQaHZteaS0OleBiI3IwVUhr2OYIrgj5J+SKnQ==
X-Received: by 2002:a17:906:a1d8:: with SMTP id bx24mr1085448ejb.161.1599124670371;
        Thu, 03 Sep 2020 02:17:50 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-919a-a06e-64ac-0036-822c-68d3.ipv6.broadband.iol.cz. [2a00:1028:919a:a06e:64ac:36:822c:68d3])
        by smtp.gmail.com with ESMTPSA id l19sm2594526ejn.67.2020.09.03.02.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 02:17:49 -0700 (PDT)
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
Subject: [PATCH v2 06/10] kvm: arm64: Duplicate arm64_ssbd_callback_required for nVHE hyp
Date:   Thu,  3 Sep 2020 11:17:08 +0200
Message-Id: <20200903091712.46456-7-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903091712.46456-1-dbrazdil@google.com>
References: <20200903091712.46456-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hyp keeps track of which cores require SSBD callback by accessing a
kernel-proper global variable. Create an nVHE symbol of the same name
and copy the value from kernel proper to nVHE at KVM init time.

Done in preparation for separating percpu memory owned by kernel
proper and nVHE.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 10 +++++++---
 arch/arm64/kernel/image-vars.h   |  1 -
 arch/arm64/kvm/arm.c             |  2 +-
 arch/arm64/kvm/hyp/nvhe/switch.c |  3 +++
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 189839c3706a..9db93da35606 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -529,23 +529,27 @@ static inline int kvm_map_vectors(void)
 
 #ifdef CONFIG_ARM64_SSBD
 DECLARE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
+DECLARE_KVM_NVHE_PER_CPU(u64, arm64_ssbd_callback_required);
 
-static inline int hyp_map_aux_data(void)
+static inline int hyp_init_aux_data(void)
 {
 	int cpu, err;
 
 	for_each_possible_cpu(cpu) {
 		u64 *ptr;
 
-		ptr = per_cpu_ptr(&arm64_ssbd_callback_required, cpu);
+		ptr = per_cpu_ptr_nvhe(arm64_ssbd_callback_required, cpu);
 		err = create_hyp_mappings(ptr, ptr + 1, PAGE_HYP);
 		if (err)
 			return err;
+
+		/* Copy value from kernel to hyp. */
+		*ptr = per_cpu(arm64_ssbd_callback_required, cpu);
 	}
 	return 0;
 }
 #else
-static inline int hyp_map_aux_data(void)
+static inline int hyp_init_aux_data(void)
 {
 	return 0;
 }
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 8982b68289b7..5fc5eadfb3e6 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -69,7 +69,6 @@ KVM_NVHE_ALIAS(kvm_patch_vector_branch);
 KVM_NVHE_ALIAS(kvm_update_va_mask);
 
 /* Global kernel state accessed by nVHE hyp code. */
-KVM_NVHE_ALIAS(arm64_ssbd_callback_required);
 KVM_NVHE_ALIAS(kvm_host_data);
 KVM_NVHE_ALIAS(kvm_vgic_global_state);
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 46dc3d75cf13..1bb960812493 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1549,7 +1549,7 @@ static int init_hyp_mode(void)
 		}
 	}
 
-	err = hyp_map_aux_data();
+	err = hyp_init_aux_data();
 	if (err)
 		kvm_err("Cannot map host auxiliary data: %d\n", err);
 
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index cc4f8e790fb3..4662df6330d7 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -27,6 +27,9 @@
 #include <asm/processor.h>
 #include <asm/thread_info.h>
 
+/* Non-VHE copy of the kernel symbol. */
+DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
+
 static void __activate_traps(struct kvm_vcpu *vcpu)
 {
 	u64 val;
-- 
2.28.0.402.g5ffc5be6b7-goog

