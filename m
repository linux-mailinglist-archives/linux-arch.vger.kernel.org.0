Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193B86D4F71
	for <lists+linux-arch@lfdr.de>; Mon,  3 Apr 2023 19:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjDCRpz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Apr 2023 13:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjDCRot (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Apr 2023 13:44:49 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD0330E3;
        Mon,  3 Apr 2023 10:44:27 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so31369605pjt.5;
        Mon, 03 Apr 2023 10:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680543867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCnmOn8eALVJCVo8Tdsddc5boZ5t7pqgIErQC6wwwQk=;
        b=WOoo+RlPGJwCaMPKG0qkXj9WrFgkZ46HvLWXK0sYjrTLZ8Lwzu0U0g/fMyypNWxcXQ
         FUPM3xfOv36KkDEkGEF85kv9Qfqf6lFCG7LsgB/sS3S279Z4jeYfnv+ioZIYpRMh7b83
         bc6WFMUReZyqHbyPJgrzG9IRCqKgSSFsIAQcTf8zExx5SbQUMnr4rGdCkCKehIlcfZED
         XI0p/yBGVB1/ecEO0fGRPuOaj2cUumPYMbafYH4CIYFaUo8l6+TZz9p7SQv7Id0O/gpY
         yY/hqSZFPoh2rS6maguZFiNU+HdYjC2jUb16opx42XFP+cIqx9ILEpSS5Q9WI0OTsKpa
         TkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCnmOn8eALVJCVo8Tdsddc5boZ5t7pqgIErQC6wwwQk=;
        b=HrD6WfDCOtG1JclR9Jydy6mfqnpRa3Q9OJRCdix/8bW6BVQJl8zY8cFE37j2idumov
         WqrlPVabBhkwymLtXzAlWQOXoJK4dGpWMHs5Bx1N8nBxwz68qU7xiCyUElVizEBC1tui
         WdRCEPeXIAOXhPMrv6AxKodxcuWLm/62p9JcMqTFswQqpgdK92hbwGrlazwwccFBAlGD
         DI/tCXJndQsJQFfXJIm0qJkpzN9PutHuTXiVCANV3TH7aKOeipuPAZPJ7Y4/t1uTwgO6
         l6B5YnY4rqrjH9uqnkx7FzGAIYbOSI/TmyCgmLm1cN6nGDDaTUpLzq7nvnhlUMQUDPmE
         Dodg==
X-Gm-Message-State: AAQBX9eyz9Gz7hraYSz6pHe37ncd2aK+7CFtfPRyTGmToss9mlb/hMiH
        XYBPDR+QphlNxAJ9UQfHLGHuNMNHVSHrIBRB
X-Google-Smtp-Source: AKy350aca/70/Ld9Mf/GNADUkLESox8Os9PI7C3dj/wE46nTR0Ur/A2gUYAWlfJBUj25XGPUixH8Tw==
X-Received: by 2002:a17:903:283:b0:1a2:1922:9850 with SMTP id j3-20020a170903028300b001a219229850mr43163575plr.67.1680543867357;
        Mon, 03 Apr 2023 10:44:27 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:2:8635:6e96:35c1:c560])
        by smtp.gmail.com with ESMTPSA id jj21-20020a170903049500b001a19196af48sm6883803plb.64.2023.04.03.10.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:44:26 -0700 (PDT)
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
Subject: [RFC PATCH V4 13/17] x86/sev: Add Check of #HV event in path
Date:   Mon,  3 Apr 2023 13:44:01 -0400
Message-Id: <20230403174406.4180472-14-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230403174406.4180472-1-ltykernel@gmail.com>
References: <20230403174406.4180472-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 arch/x86/include/asm/irqflags.h | 11 ++++++++++
 arch/x86/kernel/sev.c           | 38 +++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index d877774c3141..efa56dfde19e 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1073,6 +1073,15 @@ SYM_CODE_END(paranoid_entry)
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
@@ -1197,6 +1206,15 @@ SYM_CODE_START(error_entry)
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
index 8c5ae649d2df..8368e3fe2d36 100644
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
@@ -40,12 +44,19 @@ static __always_inline void native_irq_disable(void)
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
 	asm volatile("sti; hlt": : :"memory");
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	check_hv_pending_irq_enable();
+#endif
 }
 
 static __always_inline void native_halt(void)
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 2684a45b50a6..6445f5356c45 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -179,6 +179,44 @@ void noinstr __sev_es_ist_enter(struct pt_regs *regs)
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

