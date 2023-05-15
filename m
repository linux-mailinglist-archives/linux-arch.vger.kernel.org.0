Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2972B703580
	for <lists+linux-arch@lfdr.de>; Mon, 15 May 2023 18:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243327AbjEOQ7b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 May 2023 12:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243336AbjEOQ72 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2023 12:59:28 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B275BA3;
        Mon, 15 May 2023 09:59:27 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-51f6461af24so9045850a12.2;
        Mon, 15 May 2023 09:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684169967; x=1686761967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvibDiw0YAeqW1tnLVhywXPW6u1gg+0sroPN7cRMLpI=;
        b=A/mTC3tAK9hBc18irOO6lZqLzOlnjfLlO8KVk95Rz7Z4FMLapsm9Prd389aAN3n1eb
         Lzw4jSKT2sy/+tUf6QX4WZXqjCxVpt5u82bs8Sukawkz+HFcIZgmZRgAMtzAzZk0aTPJ
         zOZXFYS/hN90Q9lCCQeRDAuOoQWW266Xj59pjkM/TEvP5k6c22tMyu1oq7WyixHY27dA
         LgYAmUGJOX+0s1WMQAE/zzwyZpGO12zLGkoPwlx9rq0aw73ERL4mdOgysIuzcdkQW222
         Sj5PI4vMBlYTkvL7JMWWRcdgh8KFG8jo289qQnl5glKeFyvHkOC90qlj0zBG8hUSrX26
         Hb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684169967; x=1686761967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvibDiw0YAeqW1tnLVhywXPW6u1gg+0sroPN7cRMLpI=;
        b=AOz7vPHt73BAMLQ8v1HJ2crgd7icnr+rIWZxGj6+H43R7ZQE5WhPO/f8K21PXcevET
         CpoypfI/boAxPXJCnFm0S2SlO4pf6CiJWC94MCIOYLIfyTAiJx4PGlAgO1GLOfmzfzjt
         hBzZSKq02HrdgGVXorsPBpcm+02/BU7IPok4nAdZM83rRi8eDd801iOiBqWFv2ND6IoH
         xxOj4s17YF+jHUcUeLkwG3B41udoi6eBfGa49MZ9Jsr2YiSuF1KFug4br03PYwMcsXHF
         KdW8eiLVOoLM8xSDVhE9sasVeSwAaj7Gm1eVo8hCLvHermzEJtLHOMo3zZmF4YjfNfb5
         BwzA==
X-Gm-Message-State: AC+VfDzxYtIjUqxk8QDCjbraRKVq+C89QoVXalDvEigfBsy0btrstLlB
        ML7Hkhr8atO9VWKU0/C41dk=
X-Google-Smtp-Source: ACHHUZ77ANULLGa98E4kXzxRUlLt7WwKp+4kBtzghIEtv72dmk6DaSQiqgYdhWvKNzfBY3W2lsVdxg==
X-Received: by 2002:a17:90a:890a:b0:250:ce6a:cf1a with SMTP id u10-20020a17090a890a00b00250ce6acf1amr19255279pjn.38.1684169966607;
        Mon, 15 May 2023 09:59:26 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:f:85bb:dfc8:391f:ff73])
        by smtp.gmail.com with ESMTPSA id x13-20020a17090aa38d00b0024df6bbf5d8sm2151pjp.30.2023.05.15.09.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 09:59:25 -0700 (PDT)
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
Subject: [RFC PATCH V6 02/14] x86/sev: Add Check of #HV event in path
Date:   Mon, 15 May 2023 12:59:04 -0400
Message-Id: <20230515165917.1306922-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515165917.1306922-1-ltykernel@gmail.com>
References: <20230515165917.1306922-1-ltykernel@gmail.com>
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
index e25445de0957..ff5eab48bfe2 100644
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

