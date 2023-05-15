Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7C77035B8
	for <lists+linux-arch@lfdr.de>; Mon, 15 May 2023 19:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243544AbjEORBW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 May 2023 13:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243456AbjEOQ7z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2023 12:59:55 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130E683CE;
        Mon, 15 May 2023 09:59:47 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ab032d9266so120602405ad.0;
        Mon, 15 May 2023 09:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684169986; x=1686761986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmY2ej1hy4vAs/f4OlrbKuvNcHo8SUtv7o8IcsrQg3U=;
        b=llobHjZ8CaIv83lisuWYuHqNS76/tNXm2lgpfFKCeP6ap94oN1gkuO+vAaGen3l7Zf
         /5N9F6v7G42Et49vEQ4VYj0iNh3BUmWx45NHrOwY6DFCAIrau+ZWoft2KLtHIvm+J6M9
         GjXehqZjYbmt+TDyDM0qFuICTBIMGYCZJjMeAojhXpVR0uqz0+acO0YybhbjaQSHPA55
         7cMs9Y+n6PFLSzYGnlLM4tkK5Vg0NZFew5KLtO3NBkZ3+zlJQIsyO86fR30/uLY0m003
         iDD9GC0tTbV8Lpcm8XbGD1Cds3XMYs+m+DcjhoIwNKfuS9Tb7GXTMDNPUoFoWObxFFES
         E3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684169986; x=1686761986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmY2ej1hy4vAs/f4OlrbKuvNcHo8SUtv7o8IcsrQg3U=;
        b=UU5Q0/y4zuhNb40+zmiO122y1xSm3PTXBHhnMmuanAiuFU+fM1awCsG5UFzduwuyuc
         pmrsxW29Ke1Dh7f9FYzXRE+WJnNOHklGwFEj8B5gVO8ge5nGdMsgrmnlH6x19SmDxs57
         Y7tZKDYR8E4GD/Irb+SKRx0M/nYbCuKPW6/w27EkMaM1wLwgCn3QnuRlfIVTRD7lIPuq
         6fU46eph2U+oISgx+oTGa1uA+8gHNutTp9iXGQiFfqaCD4BhmCQiqX93h4aemCSHq8VG
         A8O2wZssfxR11/14fBBm9SIOHZplswKVA0kWPUWusTUcJKtgfOHIp5AY3Vr2LxuXEqjI
         L4Lw==
X-Gm-Message-State: AC+VfDybsvqnf7wuu+SprOO44lBFmaDNjzPe2VBrLL2ogorXsSyDVUEq
        kz30QyUI46bC3MGvKvfJTs0=
X-Google-Smtp-Source: ACHHUZ5ax8PMzMJyb4JE01QgIu1eN/8WniJ6gslKo//Mqlo5UEC9KUHdakOZkvioQ2T6mK0YMaHGpQ==
X-Received: by 2002:a17:90a:e50d:b0:247:6a31:d59d with SMTP id t13-20020a17090ae50d00b002476a31d59dmr33951385pjy.1.1684169986489;
        Mon, 15 May 2023 09:59:46 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:f:85bb:dfc8:391f:ff73])
        by smtp.gmail.com with ESMTPSA id x13-20020a17090aa38d00b0024df6bbf5d8sm2151pjp.30.2023.05.15.09.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 09:59:46 -0700 (PDT)
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
Subject: [RFC PATCH V6 14/14] x86/hyperv: Add hyperv-specific handling for VMMCALL under SEV-ES
Date:   Mon, 15 May 2023 12:59:16 -0400
Message-Id: <20230515165917.1306922-15-ltykernel@gmail.com>
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

Add Hyperv-specific handling for faults caused by VMMCALL
instructions.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 0c5f9f7bd7ba..3469b369e627 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -32,6 +32,7 @@
 #include <asm/nmi.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/numa.h>
+#include <asm/svm.h>
 
 /* Is Linux running as the root partition? */
 bool hv_root_partition;
@@ -577,6 +578,20 @@ static bool __init ms_hyperv_msi_ext_dest_id(void)
 	return eax & HYPERV_VS_PROPERTIES_EAX_EXTENDED_IOAPIC_RTE;
 }
 
+static void hv_sev_es_hcall_prepare(struct ghcb *ghcb, struct pt_regs *regs)
+{
+	/* RAX and CPL are already in the GHCB */
+	ghcb_set_rcx(ghcb, regs->cx);
+	ghcb_set_rdx(ghcb, regs->dx);
+	ghcb_set_r8(ghcb, regs->r8);
+}
+
+static bool hv_sev_es_hcall_finish(struct ghcb *ghcb, struct pt_regs *regs)
+{
+	/* No checking of the return state needed */
+	return true;
+}
+
 const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
 	.name			= "Microsoft Hyper-V",
 	.detect			= ms_hyperv_platform,
@@ -584,4 +599,6 @@ const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
 	.init.x2apic_available	= ms_hyperv_x2apic_available,
 	.init.msi_ext_dest_id	= ms_hyperv_msi_ext_dest_id,
 	.init.init_platform	= ms_hyperv_init_platform,
+	.runtime.sev_es_hcall_prepare = hv_sev_es_hcall_prepare,
+	.runtime.sev_es_hcall_finish = hv_sev_es_hcall_finish,
 };
-- 
2.25.1

