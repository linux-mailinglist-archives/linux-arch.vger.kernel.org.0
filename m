Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B9E637237
	for <lists+linux-arch@lfdr.de>; Thu, 24 Nov 2022 07:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiKXGDZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Nov 2022 01:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiKXGDG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Nov 2022 01:03:06 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9CD664F1;
        Wed, 23 Nov 2022 22:02:41 -0800 (PST)
Received: from jinankjain-dranzer.zrrkmle5drku1h0apvxbr2u2ee.ix.internal.cloudapp.net (unknown [20.188.121.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1D85820B83DC;
        Wed, 23 Nov 2022 22:02:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1D85820B83DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1669269761;
        bh=GURa878M+ZD9GAsBMP6GkqmlRzba5bDM5ir2EFzDpPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GaZVuCxNLxaY+fK2KkO1a4Dl0WE9dz0ryOqMl0ufbN/hcUL+3Y9lWZRgGNoGoItd4
         Ppn7Bzo2ZjaKG/+xFpaDAFGCoQL9CSEXZ5klq6NMbvMqhKZFaJQ+KaxA3u6+LWfYoN
         FEHMNJeuyfMaUNpNgCkAg/GldZbKeBqfseU4j1V0=
From:   Jinank Jain <jinankjain@linux.microsoft.com>
To:     jinankjain@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, arnd@arndb.de, peterz@infradead.org,
        jpoimboe@kernel.org, jinankjain@linux.microsoft.com,
        seanjc@google.com, kirill.shutemov@linux.intel.com,
        ak@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, anrayabh@linux.microsoft.com,
        mikelley@microsoft.com
Subject: [PATCH v6 5/5] x86/hyperv: Change interrupt vector for nested root partition
Date:   Thu, 24 Nov 2022 06:02:10 +0000
Message-Id: <01cbde59aa3a80a184b535a9573857cf895df9a2.1669269377.git.jinankjain@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1669269377.git.jinankjain@linux.microsoft.com>
References: <cover.1669269377.git.jinankjain@linux.microsoft.com>
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
index 97d8ce744e47..8a692dd6d789 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -110,6 +110,21 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
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
index 0937877eade9..c1477f3a08dd 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2767,7 +2767,8 @@ static int __init hv_acpi_init(void)
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

