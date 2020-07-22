Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAECE229D6B
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 18:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbgGVQpH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 12:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730661AbgGVQpG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 12:45:06 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134EFC0619E0
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 09:45:06 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a14so2558854wra.5
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 09:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UzkCazi9IF2R2fovvI4XRbgeSUfI2aZOTLYWCOQmH7Y=;
        b=MVr23i9EY3adsavlnzqKlwywAbRQmWnYu/O0PqHFO5h2mZINEVU5vdwtCNcmVIzmqc
         HuDpvw4REHKGW2v9gawHMWOspu7nYKIcm7m1oe8P0DG0AG/jVj8RQJM+fncEU8eAoeFW
         Q4grx48wtHAnOBBbFmFB/F65EWt+ytE4kp9aCo51/gz5p+jKu5T4002eOYPYmq7uEzE1
         NJ+zdUhBvFRvtHM/RZLaDZ3LPvYeZlJRJrm4vb3JYln4uQgm1YmjZZ9WkIcvE4+s0QMo
         wpBITPMxNDcLOEuTS6TvgjT2x1TCzG34+CS/lKZmQkI5ELNGsHGz5y5Vo26RHLtMkgdF
         k+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UzkCazi9IF2R2fovvI4XRbgeSUfI2aZOTLYWCOQmH7Y=;
        b=Az0JATb1W6NqEifW+iGkfRBAs1FmLt+uatHjXOEH0/4XJvISh/KcVFuTC46ytmZwlr
         v9J1FEmcM/8eVFy1J1KtN4FyXX4JGVUSpJujPnhF/rXnLzLLy8iywAxKIzXPL5OOvlBq
         tvb9Inf7avnMl7imIVFxtYwmSEU2dvk7iD0f+bmVArGb3GEgsyPOgo5O1N+FkPqf25uk
         CBmVlKLP/uFX+n3a91OmQdY3CcyrtfsKb8DCqm9nNCfF0kIg1R6dV6bXdDIbuM+nxQCa
         rYJN/PHM3tk2xHx89lYfMxkekVd0klYSiH4+HgyMqJJ93Z4ApuGtGC0020asJzYcw5gI
         vCbQ==
X-Gm-Message-State: AOAM532lcWl243VLez4lUqn2kbj9+k0T7uV35AT3jvA+Qz3gehizUakB
        v44FArhB0dsWgJQiwwn6MrtLOQ==
X-Google-Smtp-Source: ABdhPJx/qEkJrXuwujIJYy6c8DcTNrb907z4XGsmWjlpmktsrboRRdsmuZeU2BTNkn5zyZPYZ1dJqQ==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr417138wrs.228.1595436304534;
        Wed, 22 Jul 2020 09:45:04 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:b0ee:900a:e004:b9d0])
        by smtp.gmail.com with ESMTPSA id 2sm250421wmo.44.2020.07.22.09.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 09:45:03 -0700 (PDT)
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
Subject: [PATCH 3/9] kvm: arm64: Remove hyp_adr/ldr_this_cpu
Date:   Wed, 22 Jul 2020 17:44:18 +0100
Message-Id: <20200722164424.42225-4-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722164424.42225-1-dbrazdil@google.com>
References: <20200722164424.42225-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The hyp_adr/ldr_this_cpu helpers were introduced for use in hyp code because
they always needed to use TPIDR_EL2 for base, while adr/ldr_this_cpu from
kernel proper would select between TPIDR_EL2 and _EL1 based on VHE/nVHE.

Simplify this now that the nVHE hyp mode case can be handled using the
__KVM_NVHE_HYPERVISOR__ macro. VHE hyp code selects _EL2 with alternatives.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/assembler.h | 27 +++++++++++++++++----------
 arch/arm64/include/asm/kvm_asm.h   | 14 +-------------
 arch/arm64/kvm/hyp/hyp-entry.S     |  2 +-
 3 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 54d181177656..b392a977efb6 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -218,6 +218,21 @@ lr	.req	x30		// link register
 	str	\src, [\tmp, :lo12:\sym]
 	.endm
 
+	/*
+	 * @dst: destination register (32 or 64 bit wide)
+	 */
+	.macro	this_cpu_offset, dst
+#ifdef __KVM_NVHE_HYPERVISOR__
+	mrs	\dst, tpidr_el2
+#else
+alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
+	mrs	\dst, tpidr_el1
+alternative_else
+	mrs	\dst, tpidr_el2
+alternative_endif
+#endif
+	.endm
+
 	/*
 	 * @dst: Result of per_cpu(sym, smp_processor_id()) (can be SP)
 	 * @sym: The name of the per-cpu variable
@@ -226,11 +241,7 @@ lr	.req	x30		// link register
 	.macro adr_this_cpu, dst, sym, tmp
 	adrp	\tmp, \sym
 	add	\dst, \tmp, #:lo12:\sym
-alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
-	mrs	\tmp, tpidr_el1
-alternative_else
-	mrs	\tmp, tpidr_el2
-alternative_endif
+	this_cpu_offset \tmp
 	add	\dst, \dst, \tmp
 	.endm
 
@@ -241,11 +252,7 @@ alternative_endif
 	 */
 	.macro ldr_this_cpu dst, sym, tmp
 	adr_l	\dst, \sym
-alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
-	mrs	\tmp, tpidr_el1
-alternative_else
-	mrs	\tmp, tpidr_el2
-alternative_endif
+	this_cpu_offset \tmp
 	ldr	\dst, [\dst, \tmp]
 	.endm
 
diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index da4a0826cacd..bbd14e205aba 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -151,20 +151,8 @@ extern char __smccc_workaround_1_smc[__SMCCC_WORKAROUND_1_SMC_SZ];
 
 #else /* __ASSEMBLY__ */
 
-.macro hyp_adr_this_cpu reg, sym, tmp
-	adr_l	\reg, \sym
-	mrs	\tmp, tpidr_el2
-	add	\reg, \reg, \tmp
-.endm
-
-.macro hyp_ldr_this_cpu reg, sym, tmp
-	adr_l	\reg, \sym
-	mrs	\tmp, tpidr_el2
-	ldr	\reg,  [\reg, \tmp]
-.endm
-
 .macro get_host_ctxt reg, tmp
-	hyp_adr_this_cpu \reg, kvm_host_data, \tmp
+	adr_this_cpu \reg, kvm_host_data, \tmp
 	add	\reg, \reg, #HOST_DATA_CONTEXT
 .endm
 
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index 689fccbc9de7..0a0cb1d3acd3 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -108,7 +108,7 @@ alternative_cb_end
 	str	x0, [x2, #VCPU_WORKAROUND_FLAGS]
 
 	/* Check that we actually need to perform the call */
-	hyp_ldr_this_cpu x0, arm64_ssbd_callback_required, x2
+	ldr_this_cpu x0, arm64_ssbd_callback_required, x2
 	cbz	x0, wa2_end
 
 	mov	w0, #ARM_SMCCC_ARCH_WORKAROUND_2
-- 
2.27.0

