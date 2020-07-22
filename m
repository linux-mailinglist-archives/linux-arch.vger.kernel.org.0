Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B6B229D6D
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 18:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbgGVQpb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 12:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731120AbgGVQpJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 12:45:09 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5CAC0619E1
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 09:45:09 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so2628091wml.3
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 09:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WoKr+d4xzFa2q5doiKo+Ma/Mr0IRgGSBGk/CKLNfxgY=;
        b=ktMgAg7h984Iz5zq71o5DN+J0+FK13F2J9HPBy4DmLuxJ090jgw+CMnoSZwyQY49Ma
         f6yJhxgSogcgx3bETDFW+KqXCwbYzTtFr6O5sgMkcsR2Hq6w19IrrZuEIpXicZJ3EGVV
         U78Tpy9fh1G98eE0Ys41it7n1SVaRQbQTvPQg94IRPQEXLYEtTYwgo1TOaoUoep+eDoZ
         H8rq8GLCnQ+9r8ihbCiMv+byr7bxzMtmDd5XPLTWCHHOKBCD5MR8gklAapKIjdYlZp+I
         wtYhzP8MLjT3vX1DeAvbZBQhzDpQKV5uegI4SY3ESoosnDFzNvhkcvlbO6uy2d3oSVQM
         fH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WoKr+d4xzFa2q5doiKo+Ma/Mr0IRgGSBGk/CKLNfxgY=;
        b=RuVR0LG2nLroiqIxO1gn43KQsi0R1iqVLbSxSIQ7kM08v3bG6hjd7+DCHX9exZeqA9
         0I5HX5zNViwhsLKkkZT9+6qYe8k4qjgOJQTBcPIrtRoPgaDxKXW64gM3HoIs2Fc8XlU7
         Xi2Xa3J+UuYeenIqoF7S7YO7aidoHAG8ECv0aaHB1an/MpiuKBZdzl3kWdITnEoqmVSb
         6DN6SOyd4M/vpNFzN+dUpZD2xdg4y4u2VUeECjWQJfadpqJXt22yy4XAqlrTtxxvdc2I
         PkO9dFUgbzj7BffT1YWAvXwINwMBydnongrvzdIHZCEVkNiKutj0OOeizLuRbICfKNlJ
         rsuQ==
X-Gm-Message-State: AOAM531ohLlnxpsB9qu4b5LMq01852vO3sFsB+2tD109F44J7vQfZJ+r
        VftvEiJz90saza1Jtx1JAk6VAg==
X-Google-Smtp-Source: ABdhPJxouZ/81xeqagm6vGSDX+SrQHkz8Q+jvvRw7wYTEIvvg6ju/O9IEPfOIvKPbqVtxczJyAFxwg==
X-Received: by 2002:a1c:d8:: with SMTP id 207mr432561wma.81.1595436307978;
        Wed, 22 Jul 2020 09:45:07 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:b0ee:900a:e004:b9d0])
        by smtp.gmail.com with ESMTPSA id g14sm538679wrw.83.2020.07.22.09.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 09:45:07 -0700 (PDT)
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
Subject: [PATCH 5/9] kvm: arm64: Duplicate arm64_ssbd_callback_required for nVHE hyp
Date:   Wed, 22 Jul 2020 17:44:20 +0100
Message-Id: <20200722164424.42225-6-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722164424.42225-1-dbrazdil@google.com>
References: <20200722164424.42225-1-dbrazdil@google.com>
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
index 22157ded04ca..e9e5875274cb 100644
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
index 9e897c500237..034cf21e67ce 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -69,7 +69,6 @@ KVM_NVHE_ALIAS(kvm_patch_vector_branch);
 KVM_NVHE_ALIAS(kvm_update_va_mask);
 
 /* Global kernel state accessed by nVHE hyp code. */
-KVM_NVHE_ALIAS(arm64_ssbd_callback_required);
 KVM_NVHE_ALIAS(kvm_host_data);
 KVM_NVHE_ALIAS(kvm_vgic_global_state);
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 98f05bdac3c1..a53e87305fa0 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1547,7 +1547,7 @@ static int init_hyp_mode(void)
 		}
 	}
 
-	err = hyp_map_aux_data();
+	err = hyp_init_aux_data();
 	if (err)
 		kvm_err("Cannot map host auxiliary data: %d\n", err);
 
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index ddb602ffb022..8c2bd04df813 100644
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
2.27.0

