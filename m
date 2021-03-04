Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCC732DC85
	for <lists+linux-arch@lfdr.de>; Thu,  4 Mar 2021 22:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241072AbhCDVrx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Mar 2021 16:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241059AbhCDVri (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Mar 2021 16:47:38 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5CCC061574;
        Thu,  4 Mar 2021 13:46:58 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 354873FA28;
        Thu,  4 Mar 2021 21:39:26 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH v3 01/27] arm64: Cope with CPUs stuck in VHE mode
Date:   Fri,  5 Mar 2021 06:38:36 +0900
Message-Id: <20210304213902.83903-2-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210304213902.83903-1-marcan@marcan.st>
References: <20210304213902.83903-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

It seems that the CPU known as Apple M1 has the terrible habit
of being stuck with HCR_EL2.E2H==1, in violation of the architecture.

Try and work around this deplorable state of affairs by detecting
the stuck bit early and short-circuit the nVHE dance. It is still
unknown whether there are many more such nuggets to be found...

Reported-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kernel/head.S     | 33 ++++++++++++++++++++++++++++++---
 arch/arm64/kernel/hyp-stub.S | 28 ++++++++++++++++++++++++----
 2 files changed, 54 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 66b0e0b66e31..673002b11865 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -477,14 +477,13 @@ EXPORT_SYMBOL(kimage_vaddr)
  * booted in EL1 or EL2 respectively.
  */
 SYM_FUNC_START(init_kernel_el)
-	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
-	msr	sctlr_el1, x0
-
 	mrs	x0, CurrentEL
 	cmp	x0, #CurrentEL_EL2
 	b.eq	init_el2
 
 SYM_INNER_LABEL(init_el1, SYM_L_LOCAL)
+	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
+	msr	sctlr_el1, x0
 	isb
 	mov_q	x0, INIT_PSTATE_EL1
 	msr	spsr_el1, x0
@@ -504,6 +503,34 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 	msr	vbar_el2, x0
 	isb
 
+	/*
+	 * Fruity CPUs seem to have HCR_EL2.E2H set to RES1,
+	 * making it impossible to start in nVHE mode. Is that
+	 * compliant with the architecture? Absolutely not!
+	 */
+	mrs	x0, hcr_el2
+	and	x0, x0, #HCR_E2H
+	cbz	x0, 1f
+
+	/* Switching to VHE requires a sane SCTLR_EL1 as a start */
+	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
+	msr_s	SYS_SCTLR_EL12, x0
+
+	/*
+	 * Force an eret into a helper "function", and let it return
+	 * to our original caller... This makes sure that we have
+	 * initialised the basic PSTATE state.
+	 */
+	mov	x0, #INIT_PSTATE_EL2
+	msr	spsr_el1, x0
+	adr_l	x0, stick_to_vhe
+	msr	elr_el1, x0
+	eret
+
+1:
+	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
+	msr	sctlr_el1, x0
+
 	msr	elr_el2, lr
 	mov	w0, #BOOT_CPU_MODE_EL2
 	eret
diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 5eccbd62fec8..c7601030ee82 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -27,12 +27,12 @@ SYM_CODE_START(__hyp_stub_vectors)
 	ventry	el2_fiq_invalid			// FIQ EL2t
 	ventry	el2_error_invalid		// Error EL2t
 
-	ventry	el2_sync_invalid		// Synchronous EL2h
+	ventry	elx_sync			// Synchronous EL2h
 	ventry	el2_irq_invalid			// IRQ EL2h
 	ventry	el2_fiq_invalid			// FIQ EL2h
 	ventry	el2_error_invalid		// Error EL2h
 
-	ventry	el1_sync			// Synchronous 64-bit EL1
+	ventry	elx_sync			// Synchronous 64-bit EL1
 	ventry	el1_irq_invalid			// IRQ 64-bit EL1
 	ventry	el1_fiq_invalid			// FIQ 64-bit EL1
 	ventry	el1_error_invalid		// Error 64-bit EL1
@@ -45,7 +45,7 @@ SYM_CODE_END(__hyp_stub_vectors)
 
 	.align 11
 
-SYM_CODE_START_LOCAL(el1_sync)
+SYM_CODE_START_LOCAL(elx_sync)
 	cmp	x0, #HVC_SET_VECTORS
 	b.ne	1f
 	msr	vbar_el2, x1
@@ -71,7 +71,7 @@ SYM_CODE_START_LOCAL(el1_sync)
 
 9:	mov	x0, xzr
 	eret
-SYM_CODE_END(el1_sync)
+SYM_CODE_END(elx_sync)
 
 // nVHE? No way! Give me the real thing!
 SYM_CODE_START_LOCAL(mutate_to_vhe)
@@ -243,3 +243,23 @@ SYM_FUNC_START(switch_to_vhe)
 #endif
 	ret
 SYM_FUNC_END(switch_to_vhe)
+
+SYM_FUNC_START(stick_to_vhe)
+	/*
+	 * Make sure the switch to VHE cannot fail, by overriding the
+	 * override. This is hilarious.
+	 */
+	adr_l	x1, id_aa64mmfr1_override
+	add	x1, x1, #FTR_OVR_MASK_OFFSET
+	dc 	civac, x1
+	dsb	sy
+	isb
+	ldr	x0, [x1]
+	bic	x0, x0, #(0xf << ID_AA64MMFR1_VHE_SHIFT)
+	str	x0, [x1]
+
+	mov	x0, #HVC_VHE_RESTART
+	hvc	#0
+	mov	x0, #BOOT_CPU_MODE_EL2
+	ret
+SYM_FUNC_END(stick_to_vhe)
-- 
2.30.0

