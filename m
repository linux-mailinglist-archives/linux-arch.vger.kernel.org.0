Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CE925BE41
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 11:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgICJSB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 05:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbgICJRr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 05:17:47 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93256C061247
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 02:17:46 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n22so1935773edt.4
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 02:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QisZTdt2TL1FFTIx3f7MU7jGvA7bpKi0v1t83QtatC8=;
        b=Uw5/3FrzMA18Q3Hr8bbsY/elC1IYtbQMCmA2A1rm0P1TwtZ0HUJ3+Lkb6GHUz/KfyT
         5Al3hHDQuNzPO3OeXgaWJfxewKIYqv4MKaFVppm/Z/TcAZfbOgiQ4zYQxjLikS2PukDB
         eddkTC6h0wqw6WxN7MJlFEOae5fT5x7v3eWNKPT2CfUJ1fHB3Cd5E0hq+uPMBEc83KPG
         7U6q8+wSN+z9aq3qXwyi1FejKiLD1Gpj7p/VuJsVIpVoihNVXCgu7KkkYPjGDpN0WPhY
         IF/SUzyo608sod7cU3tL38lq+aGlpUqVnUKjU3x2oKB72hrYza4FntfToHRguFg1IgDJ
         +80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QisZTdt2TL1FFTIx3f7MU7jGvA7bpKi0v1t83QtatC8=;
        b=iQ2vzChCjYrGD2rqop+4LB5/XJgJmcddH6Or/nKTR8rgIel2h5j5ATt5SG8mmfQlq2
         0tFVCBLpsrAvB6eHAqF3+cnziGsiRVRSUxmuaIsbiw+0Lx4Dc6aPQjg+C1uMA2/XH4hf
         IL+2jXNIq2JkFDhPjtzgU8u2oUgGLj/E4h7jlrLqpMYPlSrooBhFU32pILLYB+8biumP
         E24MAujp8qYNRxyvkQ87XciH0nX50+dFQuNgsYB0CejW8faWnOFd3yxYldli4ZKkwfax
         sVpejQQWZZlMyYbj3h7KIH00TKVE8gpjv4MRPxW+kNNZzSEAe9fD3tiCSWb8XWhFPv/4
         iABw==
X-Gm-Message-State: AOAM533MXpNKbfUpzmfUpsxeToyxJeygyPOksrDjTIAFpo9wWFkHyoKm
        MQa0GIJgTGWsFcyuXrUCBS+R5g==
X-Google-Smtp-Source: ABdhPJyZQ+B3hRMDuLLmB1WZ72xdRkglhDJaUzjBZFK8sPqN0Tzw3VvIDM0m15Hpqcb86+xd083gjw==
X-Received: by 2002:a05:6402:486:: with SMTP id k6mr2060104edv.83.1599124665051;
        Thu, 03 Sep 2020 02:17:45 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-919a-a06e-64ac-0036-822c-68d3.ipv6.broadband.iol.cz. [2a00:1028:919a:a06e:64ac:36:822c:68d3])
        by smtp.gmail.com with ESMTPSA id m4sm2829132ejn.31.2020.09.03.02.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 02:17:44 -0700 (PDT)
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
Subject: [PATCH v2 04/10] kvm: arm64: Remove hyp_adr/ldr_this_cpu
Date:   Thu,  3 Sep 2020 11:17:06 +0200
Message-Id: <20200903091712.46456-5-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903091712.46456-1-dbrazdil@google.com>
References: <20200903091712.46456-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The hyp_adr/ldr_this_cpu helpers were introduced for use in hyp code
because they always needed to use TPIDR_EL2 for base, while
adr/ldr_this_cpu from kernel proper would select between TPIDR_EL2 and
_EL1 based on VHE/nVHE.

Simplify this now that the nVHE hyp mode case can be handled using the
__KVM_NVHE_HYPERVISOR__ macro. VHE selects _EL2 with alternatives.

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
index 9149079f0269..469c0662f7f3 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -179,20 +179,8 @@ extern char __smccc_workaround_1_smc[__SMCCC_WORKAROUND_1_SMC_SZ];
 
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
index 46b4dab933d0..fba91c2ab410 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -132,7 +132,7 @@ alternative_cb_end
 	str	x0, [x2, #VCPU_WORKAROUND_FLAGS]
 
 	/* Check that we actually need to perform the call */
-	hyp_ldr_this_cpu x0, arm64_ssbd_callback_required, x2
+	ldr_this_cpu x0, arm64_ssbd_callback_required, x2
 	cbz	x0, wa2_end
 
 	mov	w0, #ARM_SMCCC_ARCH_WORKAROUND_2
-- 
2.28.0.402.g5ffc5be6b7-goog

