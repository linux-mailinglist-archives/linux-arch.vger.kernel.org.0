Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E76D409DBF
	for <lists+linux-arch@lfdr.de>; Mon, 13 Sep 2021 22:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347939AbhIMUGA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Sep 2021 16:06:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:38692 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347790AbhIMUFr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Sep 2021 16:05:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="307336367"
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="307336367"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 13:04:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="469643915"
Received: from sohilbuildbox.sc.intel.com (HELO localhost.localdomain) ([172.25.110.4])
  by fmsmga007.fm.intel.com with ESMTP; 13 Sep 2021 13:04:30 -0700
From:   Sohil Mehta <sohil.mehta@intel.com>
To:     x86@kernel.org
Cc:     Sohil Mehta <sohil.mehta@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 05/13] x86/irq: Reserve a user IPI notification vector
Date:   Mon, 13 Sep 2021 13:01:24 -0700
Message-Id: <20210913200132.3396598-6-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913200132.3396598-1-sohil.mehta@intel.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A user interrupt notification vector is used on the receiver's cpu to
identify an interrupt as a user interrupt (and not a kernel interrupt).
Hardware uses the same notification vector to generate an IPI from a
sender's cpu core when the SENDUIPI instruction is executed.

Typically, the kernel shouldn't receive an interrupt with this vector.
However, it is possible that the kernel might receive this vector.

Scenario that can cause the spurious interrupt:

Step	cpu 0 (receiver task)		cpu 1 (sender task)
----	---------------------		-------------------
1	task is running
2					executes SENDUIPI
3					IPI sent
4	context switched out
5	IPI delivered
	(kernel interrupt detected)

A kernel interrupt can be detected, if a receiver task gets scheduled
out after the SENDUIPI-based IPI was sent but before the IPI was
delivered.

The kernel doesn't need to do anything in this case other than receiving
the interrupt and clearing the local APIC. The user interrupt is always
stored in the receiver's UPID before the IPI is generated. When the
receiver gets scheduled back the interrupt would be delivered based on
its UPID.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/include/asm/hardirq.h     |  3 +++
 arch/x86/include/asm/idtentry.h    |  4 ++++
 arch/x86/include/asm/irq_vectors.h |  5 ++++-
 arch/x86/kernel/idt.c              |  3 +++
 arch/x86/kernel/irq.c              | 33 ++++++++++++++++++++++++++++++
 5 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index 275e7fd20310..279afc01f1ac 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -19,6 +19,9 @@ typedef struct {
 	unsigned int kvm_posted_intr_ipis;
 	unsigned int kvm_posted_intr_wakeup_ipis;
 	unsigned int kvm_posted_intr_nested_ipis;
+#endif
+#ifdef CONFIG_X86_USER_INTERRUPTS
+	unsigned int uintr_spurious_count;
 #endif
 	unsigned int x86_platform_ipis;	/* arch dependent */
 	unsigned int apic_perf_irqs;
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 1345088e9902..5929a6f9eeee 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -671,6 +671,10 @@ DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_WAKEUP_VECTOR,	sysvec_kvm_posted_intr_wakeup
 DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,	sysvec_kvm_posted_intr_nested_ipi);
 #endif
 
+#ifdef CONFIG_X86_USER_INTERRUPTS
+DECLARE_IDTENTRY_SYSVEC(UINTR_NOTIFICATION_VECTOR,	sysvec_uintr_spurious_interrupt);
+#endif
+
 #if IS_ENABLED(CONFIG_HYPERV)
 DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_hyperv_callback);
 DECLARE_IDTENTRY_SYSVEC(HYPERV_REENLIGHTENMENT_VECTOR,	sysvec_hyperv_reenlightenment);
diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 43dcb9284208..d26faa504931 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -104,7 +104,10 @@
 #define HYPERV_STIMER0_VECTOR		0xed
 #endif
 
-#define LOCAL_TIMER_VECTOR		0xec
+/* Vector for User interrupt notifications */
+#define UINTR_NOTIFICATION_VECTOR       0xec
+
+#define LOCAL_TIMER_VECTOR		0xeb
 
 #define NR_VECTORS			 256
 
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index df0fa695bb09..d8c45e0728f0 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -147,6 +147,9 @@ static const __initconst struct idt_data apic_idts[] = {
 	INTG(POSTED_INTR_WAKEUP_VECTOR,		asm_sysvec_kvm_posted_intr_wakeup_ipi),
 	INTG(POSTED_INTR_NESTED_VECTOR,		asm_sysvec_kvm_posted_intr_nested_ipi),
 # endif
+#ifdef CONFIG_X86_USER_INTERRUPTS
+	INTG(UINTR_NOTIFICATION_VECTOR,		asm_sysvec_uintr_spurious_interrupt),
+#endif
 # ifdef CONFIG_IRQ_WORK
 	INTG(IRQ_WORK_VECTOR,			asm_sysvec_irq_work),
 # endif
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index e28f6a5d14f1..e3c35668c7c5 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -181,6 +181,12 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "%10u ",
 			   irq_stats(j)->kvm_posted_intr_wakeup_ipis);
 	seq_puts(p, "  Posted-interrupt wakeup event\n");
+#endif
+#ifdef CONFIG_X86_USER_INTERRUPTS
+	seq_printf(p, "%*s: ", prec, "UIS");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", irq_stats(j)->uintr_spurious_count);
+	seq_puts(p, "  User-interrupt spurious event\n");
 #endif
 	return 0;
 }
@@ -325,6 +331,33 @@ DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_kvm_posted_intr_nested_ipi)
 }
 #endif
 
+#ifdef CONFIG_X86_USER_INTERRUPTS
+/*
+ * Handler for UINTR_NOTIFICATION_VECTOR.
+ *
+ * The notification vector is used by the cpu to detect a User Interrupt. In
+ * the typical usage, the cpu would handle this interrupt and clear the local
+ * apic.
+ *
+ * However, it is possible that the kernel might receive this vector. This can
+ * happen if the receiver thread was running when the interrupt was sent but it
+ * got scheduled out before the interrupt was delivered. The kernel doesn't
+ * need to do anything other than clearing the local APIC. A pending user
+ * interrupt is always saved in the receiver's UPID which can be referenced
+ * when the receiver gets scheduled back.
+ *
+ * If the kernel receives a storm of these, it could mean an issue with the
+ * kernel's saving and restoring of the User Interrupt MSR state; Specifically,
+ * the notification vector bits in the IA32_UINTR_MISC_MSR.
+ */
+DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_uintr_spurious_interrupt)
+{
+	/* TODO: Add entry-exit tracepoints */
+	ack_APIC_irq();
+	inc_irq_stat(uintr_spurious_count);
+}
+#endif
+
 
 #ifdef CONFIG_HOTPLUG_CPU
 /* A cpu has been removed from cpu_online_mask.  Reset irq affinities. */
-- 
2.33.0

