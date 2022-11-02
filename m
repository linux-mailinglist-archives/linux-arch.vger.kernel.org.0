Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84C9616969
	for <lists+linux-arch@lfdr.de>; Wed,  2 Nov 2022 17:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiKBQmF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 12:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiKBQl1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 12:41:27 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AFF02EF6B;
        Wed,  2 Nov 2022 09:36:30 -0700 (PDT)
Received: from jinankjain-dranzer.zrrkmle5drku1h0apvxbr2u2ee.ix.internal.cloudapp.net (unknown [20.188.121.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id 159E020C333F;
        Wed,  2 Nov 2022 09:36:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 159E020C333F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667406990;
        bh=J4DNJwZlTDLqAsrM8lj5O6r1qnyNqnGW9RCCuM0lraM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aCDmfOGejL0g0dqhcXtMlxsRuk7MX18AmwVv1BIYx2gKTV3c4F+D27f0MLtNKgKyN
         2saSYeaem53OIlzxxPWOqvr0docvuCFSGa1iZh9/Y36gq0e4gIG12FKZUbZnHcYZae
         tbpDJweuMl0D1cx3jYbEK3PJRuY0oTB3u25JlOB4=
From:   Jinank Jain <jinankjain@linux.microsoft.com>
To:     jinankjain@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, arnd@arndb.de, peterz@infradead.org,
        jpoimboe@kernel.org, jinankjain@linux.microsoft.com,
        seanjc@google.com, kirill.shutemov@linux.intel.com,
        ak@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v2 5/5] hv, mshv : Change interrupt vector for nested root partition
Date:   Wed,  2 Nov 2022 16:36:02 +0000
Message-Id: <66eddd647536f7153462848c34958029e9e9caad.1667406350.git.jinankjain@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667406350.git.jinankjain@linux.microsoft.com>
References: <cover.1667406350.git.jinankjain@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Traditionally we have been using the HYPERVISOR_CALLBACK_VECTOR to relay
the VMBus interrupt. But this does not work in case of nested
hypervisor. Microsoft Hypervisor reserves 0x31 to 0x34 as the interrupt
vector range for VMBus and thus we have to use one of the vectors from
that range and setup the IDT accordingly.

Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
---
 arch/x86/include/asm/idtentry.h    |  2 ++
 arch/x86/include/asm/irq_vectors.h |  6 ++++++
 arch/x86/kernel/cpu/mshyperv.c     | 15 +++++++++++++++
 arch/x86/kernel/idt.c              |  9 +++++++++
 drivers/hv/vmbus_drv.c             |  3 ++-
 5 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 72184b0b2219..c0648e3e4d4a 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -686,6 +686,8 @@ DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,	sysvec_kvm_posted_intr_nested
 DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_hyperv_callback);
 DECLARE_IDTENTRY_SYSVEC(HYPERV_REENLIGHTENMENT_VECTOR,	sysvec_hyperv_reenlightenment);
 DECLARE_IDTENTRY_SYSVEC(HYPERV_STIMER0_VECTOR,	sysvec_hyperv_stimer0);
+DECLARE_IDTENTRY_SYSVEC(HYPERV_INTR_NESTED_VMBUS_VECTOR,
+			sysvec_hyperv_nested_vmbus_intr);
 #endif
 
 #if IS_ENABLED(CONFIG_ACRN_GUEST)
diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 43dcb9284208..729d19eab7f5 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -102,6 +102,12 @@
 #if IS_ENABLED(CONFIG_HYPERV)
 #define HYPERV_REENLIGHTENMENT_VECTOR	0xee
 #define HYPERV_STIMER0_VECTOR		0xed
+/*
+ * FIXME: Change this, once Microsoft Hypervisor changes its assumption
+ * around VMBus interrupt vector allocation for nested root partition.
+ * Or provides a better interface to detect this instead of hardcoding.
+ */
+#define HYPERV_INTR_NESTED_VMBUS_VECTOR	0x31
 #endif
 
 #define LOCAL_TIMER_VECTOR		0xec
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 2555535f5237..83aab88bf298 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -61,6 +61,21 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
 	set_irq_regs(old_regs);
 }
 
+DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_nested_vmbus_intr)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	inc_irq_stat(irq_hv_callback_count);
+
+	if (vmbus_handler)
+		vmbus_handler();
+
+	if (ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED)
+		ack_APIC_irq();
+
+	set_irq_regs(old_regs);
+}
+
 void hv_setup_vmbus_handler(void (*handler)(void))
 {
 	vmbus_handler = handler;
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index a58c6bc1cd68..ace648856a0b 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -160,6 +160,15 @@ static const __initconst struct idt_data apic_idts[] = {
 # endif
 	INTG(SPURIOUS_APIC_VECTOR,		asm_sysvec_spurious_apic_interrupt),
 	INTG(ERROR_APIC_VECTOR,			asm_sysvec_error_interrupt),
+#ifdef CONFIG_HYPERV
+	/*
+	 * This is a hack because we cannot install this interrupt handler via alloc_intr_gate
+	 * as it does not allow interrupt vector less than FIRST_SYSTEM_VECTORS. And hyperv
+	 * does not want anything other than 0x31-0x34 as the interrupt vector for vmbus
+	 * interrupt in case of nested setup.
+	 */
+	INTG(HYPERV_INTR_NESTED_VMBUS_VECTOR, asm_sysvec_hyperv_nested_vmbus_intr),
+#endif
 #endif
 };
 
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 2f0cf75e811b..e6fb77fb44b9 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2746,7 +2746,8 @@ static int __init hv_acpi_init(void)
 	 * normal Linux IRQ mechanism is not used in this case.
 	 */
 #ifdef HYPERVISOR_CALLBACK_VECTOR
-	vmbus_interrupt = HYPERVISOR_CALLBACK_VECTOR;
+	vmbus_interrupt = hv_nested ? HYPERV_INTR_NESTED_VMBUS_VECTOR :
+					    HYPERVISOR_CALLBACK_VECTOR;
 	vmbus_irq = -1;
 #endif
 
-- 
2.25.1

