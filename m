Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF357229D67
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 18:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbgGVQpW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 12:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731286AbgGVQpQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 12:45:16 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C504C0619DC
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 09:45:16 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f18so2576809wrs.0
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Zoc4jT5D/PnpX6Ge9Fh8+yTlt5xAHFadpjWGBF1q0w=;
        b=EHDURTcBkVhJJVi3ujf/kQeTfFBT7h/B9rxoO/V6rVCgVwVesI6SzZIa06WBR4XrFl
         EEc9WcBPE7DBmvVrqXAG2TZ6AgH9fDPkjcr/cpkZ3YeIKVPt1DBo+pvWJi6VB3G/JmeX
         fSgzbviAYvO/KtVcj8dE8gdhqC3wxBnOf4JlONMDO93pAlrrfS5v4nv9Avm7ELmCflWd
         3AltLvlQCDsboajAG8AeCOm8lC6ewgH11gH6xtNGdjO5UFpz3uUW8GRmqYaHIa02jYdR
         vH1wWLWsSKtXiU7d9T/LJrWMnSBWw2shzP30T5TVW0Z4QbYHatf6n/Uz3oyeSyz0QFKE
         7YXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Zoc4jT5D/PnpX6Ge9Fh8+yTlt5xAHFadpjWGBF1q0w=;
        b=FbjfXXRjpERFvAoGV7JBcC7A2zpfYADD6oXHh5PeiFH/4WqA40mpAdhcki/gh/wjgF
         znEluoHppvFm7Mf/YnKrXYOAdgB9oIrokIc+womuFvx5kGkcIASas79Wegkg3183NvlR
         40HjTcTq9DtTAiJ7as7nbfka1ZpGNHL3rd7N9nVIGgyirZ0e83IK1VJx22DRhjP5R/I6
         zomg0mABeBki0u/ztxrXZDfcigrNiiYj2n1YMCBr3lY+nD09t5C+JsTzW1LCIgAMfK+t
         bHoIiGwqrjkRL6dATaZGAmW+Vud7ALycc6P3ttrAKQ+zz2BV9xuZ+7AfIFVQtDYQLpIr
         tmkg==
X-Gm-Message-State: AOAM532B5oto1fBNHZLXPbYP7JcrhS1Xi8xpq0orPlfj/Ws3V79lXUrt
        qf4pa/bs5UvNssHBtDNEjsQ3sQ==
X-Google-Smtp-Source: ABdhPJzLKmKG9pub1HFuNdCsYrh8zqcSQp68qHq5cvDc4U/7vFwUWtKwLOPhPUQibgTF3FLak/t0vg==
X-Received: by 2002:a5d:548f:: with SMTP id h15mr365969wrv.331.1595436314869;
        Wed, 22 Jul 2020 09:45:14 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:b0ee:900a:e004:b9d0])
        by smtp.gmail.com with ESMTPSA id t2sm242165wma.43.2020.07.22.09.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 09:45:14 -0700 (PDT)
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
Subject: [PATCH 9/9] kvm: arm64: Remove unnecessary hyp mappings
Date:   Wed, 22 Jul 2020 17:44:24 +0100
Message-Id: <20200722164424.42225-10-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722164424.42225-1-dbrazdil@google.com>
References: <20200722164424.42225-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With all nVHE per-CPU variables being part of the hyp per-CPU region,
mapping them individual is not necessary any longer. They are mapped to hyp
as part of the overall per-CPU region.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 25 +++++++------------------
 arch/arm64/kvm/arm.c             | 17 +----------------
 2 files changed, 8 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index e9e5875274cb..1a66089cf4f4 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -531,28 +531,17 @@ static inline int kvm_map_vectors(void)
 DECLARE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
 DECLARE_KVM_NVHE_PER_CPU(u64, arm64_ssbd_callback_required);
 
-static inline int hyp_init_aux_data(void)
+static inline void hyp_init_aux_data(void)
 {
-	int cpu, err;
+	int cpu;
 
-	for_each_possible_cpu(cpu) {
-		u64 *ptr;
-
-		ptr = per_cpu_ptr_nvhe(arm64_ssbd_callback_required, cpu);
-		err = create_hyp_mappings(ptr, ptr + 1, PAGE_HYP);
-		if (err)
-			return err;
-
-		/* Copy value from kernel to hyp. */
-		*ptr = per_cpu(arm64_ssbd_callback_required, cpu);
-	}
-	return 0;
+	/* Copy arm64_ssbd_callback_required values from kernel to hyp. */
+	for_each_possible_cpu(cpu)
+		*(per_cpu_ptr_nvhe(arm64_ssbd_callback_required, cpu)) =
+			per_cpu(arm64_ssbd_callback_required, cpu);
 }
 #else
-static inline int hyp_init_aux_data(void)
-{
-	return 0;
-}
+static inline void hyp_init_aux_data(void) {}
 #endif
 
 #define kvm_phys_to_vttbr(addr)		phys_to_ttbr(addr)
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index bbbc5c1519a9..f2e537d99d2b 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1628,22 +1628,7 @@ static int init_hyp_mode(void)
 		}
 	}
 
-	for_each_possible_cpu(cpu) {
-		kvm_host_data_t *cpu_data;
-
-		cpu_data = per_cpu_ptr_hyp(kvm_host_data, cpu);
-		err = create_hyp_mappings(cpu_data, cpu_data + 1, PAGE_HYP);
-
-		if (err) {
-			kvm_err("Cannot map host CPU state: %d\n", err);
-			goto out_err;
-		}
-	}
-
-	err = hyp_init_aux_data();
-	if (err)
-		kvm_err("Cannot map host auxiliary data: %d\n", err);
-
+	hyp_init_aux_data();
 	return 0;
 
 out_err:
-- 
2.27.0

