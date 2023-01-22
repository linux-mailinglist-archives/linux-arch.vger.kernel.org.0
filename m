Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1E8676AD6
	for <lists+linux-arch@lfdr.de>; Sun, 22 Jan 2023 03:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjAVCr0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Jan 2023 21:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjAVCrJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 21 Jan 2023 21:47:09 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872302448F;
        Sat, 21 Jan 2023 18:46:30 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id g68so6744438pgc.11;
        Sat, 21 Jan 2023 18:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLExipRMWfkYVFwFaKS7EfBjRw3kU6eyOtpQO4do6zs=;
        b=iZgUb5gxqddyVAL8PlrW9j86YWsLUoSzCYIsEOdBUV8FNwLHho4x+8GLjBGpp7Y3Io
         gXc8i/FXlz+NXrB/iNyudERtbb8Fbbv6k6pFIssUFbhmyNirqZrtSm7GqmGgQQqlcLLE
         cAM3njrwCkmre97UTS220uX4f16Av0jFoXRXeqSsS/ECFpzU9vdhrgXQ/t3Cnd5rPYre
         DV2PQChItvFyzYvjD0xnvEErsT08/vMc0+8qAN3Tdo+fRE/aYQ2CAPioFqwrQHsGjOnh
         TBlJ3tfNbqLe6LPCbe/7ZWu5WDOGFQLHRM311AUAUhoPY+1PMprugND60ElXbe+l4Oi3
         RH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLExipRMWfkYVFwFaKS7EfBjRw3kU6eyOtpQO4do6zs=;
        b=fAcDeV013+8CXCYVGQwohUPKGfVlmKKHOheQrsoRx8gGS80/8IE0cUjVg7YiJFkXJm
         Pw2BbDqHpCCNYkI7c4Y80MLnfgckHM649gyTREDUffLIz+6jcqbnitJnQn4rwwdga5t0
         Aow0Gv1p5+UKjMgSSrNvFFdeBf9frM7dhFwXAohir6Kt9UYx5boBLEHeBX4rVG0q1MT0
         CfUDifwlfbE8UDmNrIi8Y1J4zwqteUHxo8FlgUd6u+3YM/I2ray/6SffaGQ0RsMenGwa
         8CgY+G5P/uxu5iP9ZdFEE9/AZ/onSV5DQqvXD1YSlnLuNjCWYCZFPep/PTiC3p01kALk
         cnwg==
X-Gm-Message-State: AFqh2kpNMVGxgJcQK6CcGA9XlpGOHbEJrARxpHSSsEbY3zhyqWsDGJSj
        5P/Kt0ds7UVD0DVxchj6vLU=
X-Google-Smtp-Source: AMrXdXvhgf2d6Qr7Pg5vloeC44DEXttW6lAKPC/URQb2MP1owft/zq78EPqmeHOWdfGVjkrY6PhdnQ==
X-Received: by 2002:a05:6a00:44c5:b0:580:8c2c:d0ad with SMTP id cv5-20020a056a0044c500b005808c2cd0admr19676912pfb.13.1674355589646;
        Sat, 21 Jan 2023 18:46:29 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:36:d4:8b9d:a9e7:109b])
        by smtp.gmail.com with ESMTPSA id b75-20020a621b4e000000b0058ba53aaa75sm18523094pfb.99.2023.01.21.18.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 18:46:29 -0800 (PST)
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
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [RFC PATCH V3 13/16] x86/sev: Add Check of #HV event in path
Date:   Sat, 21 Jan 2023 21:46:03 -0500
Message-Id: <20230122024607.788454-14-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230122024607.788454-1-ltykernel@gmail.com>
References: <20230122024607.788454-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 arch/x86/entry/entry_64.S       | 18 +++++++++++++++
 arch/x86/include/asm/irqflags.h | 10 +++++++++
 arch/x86/kernel/sev.c           | 39 +++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 6baec7653f19..aec8dc4443d1 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1064,6 +1064,15 @@ SYM_CODE_END(paranoid_entry)
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
@@ -1188,6 +1197,15 @@ SYM_CODE_START(error_entry)
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
index 7793e52d6237..fe46e59168dd 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -14,6 +14,10 @@
 /*
  * Interrupt control:
  */
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+void check_hv_pending(struct pt_regs *regs);
+void check_hv_pending_irq_enable(void);
+#endif
 
 /* Declaration required for gcc < 4.9 to prevent -Werror=missing-prototypes */
 extern inline unsigned long native_save_fl(void);
@@ -43,12 +47,18 @@ static __always_inline void native_irq_disable(void)
 static __always_inline void native_irq_enable(void)
 {
 	asm volatile("sti": : :"memory");
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	check_hv_pending_irq_enable();
+#endif
 }
 
 static inline __cpuidle void native_safe_halt(void)
 {
 	mds_idle_clear_cpu_buffers();
 	asm volatile("sti; hlt": : :"memory");
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	check_hv_pending_irq_enable();
+#endif
 }
 
 static inline __cpuidle void native_halt(void)
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a8862a2eff67..fe5e5e41433d 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -179,6 +179,45 @@ void noinstr __sev_es_ist_enter(struct pt_regs *regs)
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
+	unsigned long flags;
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

