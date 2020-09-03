Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8609425BE46
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 11:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgICJS3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 05:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbgICJSD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 05:18:03 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A43C061249
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 02:18:02 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a26so2863779ejc.2
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 02:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NQv+tl4uppeFkb8OE5qw190d9LgQJYKQj0zpEykuMCM=;
        b=WGeAJLDMsRVumT9Q9ux6Nast3r0JswgFOC70ZutZNZBpf4GDOxF1Vq6GaxB6cpDZ45
         Ubq1CjFd9RyDJye5zoVo0+QI21IJuR8D5K5NTSCX0bfI9NOKTkGvpRSdqjbbeU8lOgnD
         tJC8vPxb//wpf1qUbLuSg0l8hrW/1r/jrioS74dOFucWmTNYEf6D0j0FI538lwVoZMfU
         6nmWYHKuc7tfuY983RwJ7bm/dKm2mVyjPAIdqZoonp/ofsHcYNliONbyDgPpLGYp45Oa
         CHQHOnDIGMvH+AX91mPbZluIWwNyPlz47HjPqLMi0Ot2VIwY+bVwfHvG9y4br0BODeiC
         d9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NQv+tl4uppeFkb8OE5qw190d9LgQJYKQj0zpEykuMCM=;
        b=UJXPgGczBjHnL2vw044/e1phXu7SOE4uiHJdaGlyDi7DVMkru4P6mn3O8tzMBZAAvs
         /CFNP7STw9Ajp/YtIFmtqYOmVNW3F87R+B3jlgSWM43YOEEkWMS8ooWwgykExRu9lSsY
         WZw+zFAJ8RB0x5JdCtofXHXI/Z2laW/SYD5uq4O2KUxHmr50R8jeVTJr0vMbq+sZlCRL
         Q9TYVr5bvJJc6BR6fQt7BPyWnU/aB+6FuH2ySV3sgCMOzufdKxpqOdUlcSWzXviV17Hf
         ssabaNDJFFzJWkOTOzxI85qBof0Le2nzms759JioxZtWeHcHgUbk0IjdYU9Wd9mqM4F1
         +6Ww==
X-Gm-Message-State: AOAM5317XKij2JwKp5AShF/v84DshAmyvmA6qWt0Y63DOuWzIV/PrKof
        jY8pDmoFiFyLsMOv2LokZyckCQ==
X-Google-Smtp-Source: ABdhPJwKWw1WUu0SdgKqUcKkconNR0zceARFGVkjySt2UpxXg4FXus55KxeqDNsvsTsSugbaugIAoQ==
X-Received: by 2002:a17:906:3ac4:: with SMTP id z4mr1065800ejd.65.1599124681204;
        Thu, 03 Sep 2020 02:18:01 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-919a-a06e-64ac-0036-822c-68d3.ipv6.broadband.iol.cz. [2a00:1028:919a:a06e:64ac:36:822c:68d3])
        by smtp.gmail.com with ESMTPSA id x25sm2429769edv.42.2020.09.03.02.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 02:18:00 -0700 (PDT)
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
Subject: [PATCH v2 10/10] kvm: arm64: Remove unnecessary hyp mappings
Date:   Thu,  3 Sep 2020 11:17:12 +0200
Message-Id: <20200903091712.46456-11-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903091712.46456-1-dbrazdil@google.com>
References: <20200903091712.46456-1-dbrazdil@google.com>
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
index 9db93da35606..bbe9df76ff42 100644
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
index df7d133056ce..dfe1baa5bbb7 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1631,22 +1631,7 @@ static int init_hyp_mode(void)
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
2.28.0.402.g5ffc5be6b7-goog

