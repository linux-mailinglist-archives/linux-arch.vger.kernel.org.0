Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6326F2F81
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 11:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjEAI7Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 04:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjEAI6e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 04:58:34 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518771BF2;
        Mon,  1 May 2023 01:57:48 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64115e652eeso25489956b3a.0;
        Mon, 01 May 2023 01:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682931467; x=1685523467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKHSp+qB5n2IMDCOI0freKMV1FWlMhZLNei9eLWDXIY=;
        b=RPUtxnqwKOqhdKOMYjaJwr7KrrCzqPH4C19gxi/1Vrapte1tatU2mG1zjhlzWI2rWr
         e9E0aKKTCmyFr9EZhuiQ/pzle/s9SeI6ye0LC0czbwRkxiomXr3xaV0XP4tT/lph4PHI
         pLhEzuvKd9zK6/B3rGjOSP0E1Kg9fEtPcuzy7hqLgxewEfnGVbtr6hWXhXeoH8BwSI28
         R3HnyQ/bCFkiFQ1124pcBpA3rmk3Mvmp4fsqNjBxnTKkSzEHdMJdbp8e6cuNkzVHL263
         CKV4SGmEdi/W6fNcl2MFK52xvc410QSH7dxz9OoyAVqj7ctvPatkeWfmdEgBar4I45bt
         +N6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682931467; x=1685523467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKHSp+qB5n2IMDCOI0freKMV1FWlMhZLNei9eLWDXIY=;
        b=LXtbcodl/CUHuq48Zf+9gVsSRAR1+7l/yilBysyBZml4MasVsu+219O1+Gh948rFaW
         p5BYB0CB50li/8r4wwpFMFCf7DN2tp64V0JKioJzQmUuGp4tuKRG2QabNY27pUdUCj9r
         2LXc4uvJfDA0q0j8828zUc9ffVarx0p9Gz/DB9uuGrwpddk7Sr8WGjD6IY+talTUsKe+
         d1Yfb632ltrfWHFCoWlqSHovjqNMU3KkKYhvs7jRzguFgaZHYJF1eIhBxaKL4/15HQfs
         qSERsCveCJ3oseRimxyIefvxvrte7bRLYOVt+1Xf0VgJ9kHZh7tob2UbzsGp9ce7dGge
         9ndg==
X-Gm-Message-State: AC+VfDxd3Tf8Uk0s4Zfj9GdYWQXb2j+juCygWnYF2njh+nAqu/sJ2elJ
        pOvhsnTKvCveIk9+LZgmKV8=
X-Google-Smtp-Source: ACHHUZ78Uss3sSCiMytfrzlQgjq0ll+TtRKA/S+jPmjFzZZxnumpdFOVJclVjYbA5VDIi94zFOKsGg==
X-Received: by 2002:a17:903:22c7:b0:1a9:98ae:5975 with SMTP id y7-20020a17090322c700b001a998ae5975mr21653299plg.30.1682931466962;
        Mon, 01 May 2023 01:57:46 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:b:e11b:15ea:ad44:bde7])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709028c8d00b001a4fe00a8d4sm17407070plo.90.2023.05.01.01.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 01:57:46 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com
Cc:     pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [RFC PATCH V5 12/15] x86/sev: Add Check of #HV event in path
Date:   Mon,  1 May 2023 04:57:22 -0400
Message-Id: <20230501085726.544209-13-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230501085726.544209-1-ltykernel@gmail.com>
References: <20230501085726.544209-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <tiala@microsoft.com>

Add check_hv_pending() and check_hv_pending_after_irq() to
check queued #HV event when irq is disabled.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/entry/entry_64.S       | 18 ++++++++++++++++
 arch/x86/include/asm/irqflags.h | 14 +++++++++++-
 arch/x86/kernel/sev.c           | 38 +++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 653b1f10699b..147b850babf6 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1019,6 +1019,15 @@ SYM_CODE_END(paranoid_entry)
  * R15 - old SPEC_CTRL
  */
 SYM_CODE_START_LOCAL(paranoid_exit)
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	/*
+	 * If a #HV was delivered during execution and interrupts were
+	 * disabled, then check if it can be handled before the iret
+	 * (which may re-enable interrupts).
+	 */
+	mov     %rsp, %rdi
+	call    check_hv_pending
+#endif
 	UNWIND_HINT_REGS
 
 	/*
@@ -1143,6 +1152,15 @@ SYM_CODE_START(error_entry)
 SYM_CODE_END(error_entry)
 
 SYM_CODE_START_LOCAL(error_return)
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	/*
+	 * If a #HV was delivered during execution and interrupts were
+	 * disabled, then check if it can be handled before the iret
+	 * (which may re-enable interrupts).
+	 */
+	mov     %rsp, %rdi
+	call    check_hv_pending
+#endif
 	UNWIND_HINT_REGS
 	DEBUG_ENTRY_ASSERT_IRQS_OFF
 	testb	$3, CS(%rsp)
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 8c5ae649d2df..d09ec6d76591 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -11,6 +11,10 @@
 /*
  * Interrupt control:
  */
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+void check_hv_pending(struct pt_regs *regs);
+void check_hv_pending_irq_enable(void);
+#endif
 
 /* Declaration required for gcc < 4.9 to prevent -Werror=missing-prototypes */
 extern inline unsigned long native_save_fl(void);
@@ -40,12 +44,20 @@ static __always_inline void native_irq_disable(void)
 static __always_inline void native_irq_enable(void)
 {
 	asm volatile("sti": : :"memory");
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	check_hv_pending_irq_enable();
+#endif
 }
 
 static __always_inline void native_safe_halt(void)
 {
 	mds_idle_clear_cpu_buffers();
-	asm volatile("sti; hlt": : :"memory");
+	asm volatile("sti": : :"memory");
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	check_hv_pending_irq_enable();
+#endif
+	asm volatile("hlt": : :"memory");
 }
 
 static __always_inline void native_halt(void)
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 7b06d7c0914f..e2bb19605a46 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -181,6 +181,44 @@ void noinstr __sev_es_ist_enter(struct pt_regs *regs)
 	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], new_ist);
 }
 
+static void do_exc_hv(struct pt_regs *regs)
+{
+	/* Handle #HV exception. */
+}
+
+void check_hv_pending(struct pt_regs *regs)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	if ((regs->flags & X86_EFLAGS_IF) == 0)
+		return;
+
+	do_exc_hv(regs);
+}
+
+void check_hv_pending_irq_enable(void)
+{
+	struct pt_regs regs;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	memset(&regs, 0, sizeof(struct pt_regs));
+	asm volatile("movl %%cs, %%eax;" : "=a" (regs.cs));
+	asm volatile("movl %%ss, %%eax;" : "=a" (regs.ss));
+	regs.orig_ax = 0xffffffff;
+	regs.flags = native_save_fl();
+
+	/*
+	 * Disable irq when handle pending #HV events after
+	 * re-enabling irq.
+	 */
+	asm volatile("cli" : : : "memory");
+	do_exc_hv(&regs);
+	asm volatile("sti" : : : "memory");
+}
+
 void noinstr __sev_es_ist_exit(void)
 {
 	unsigned long ist;
-- 
2.25.1

