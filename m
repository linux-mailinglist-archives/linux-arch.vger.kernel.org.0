Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D116F2F9D
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 11:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjEAI7P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 04:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbjEAI6c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 04:58:32 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F979199C;
        Mon,  1 May 2023 01:57:45 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aae5c2423dso14849775ad.3;
        Mon, 01 May 2023 01:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682931464; x=1685523464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmY2ej1hy4vAs/f4OlrbKuvNcHo8SUtv7o8IcsrQg3U=;
        b=FkdkRUE+5Whsuw9r5s2/iWsKbU/238MR7HewzSR5rax2e+7VF1hr07JmScnAgDk7q3
         gAhLUKyzqNEdJdYeZE0fkNqi9yaMLkzh2HXJw5gu/7bcHq1G7yRtdb25eKpzZBRCGXEr
         Ry0POxQUAC94s/D4zrTPqm0IBW8XHtVkuFAxDnSEGRZ7r6cvn/JwhelO2wV8BR7n+kAN
         Xc+fE37JIJDG0Zwh1Jx1hthKpihB6QbBAp2WpouNoABBPjsjS8hR3a3yBfZglZEocvCr
         8yTkcHReqMNJPO0UJHHUmhW3ZE+XvW2GjR7NQvFIO3W2XMam462PRMmG0h7MwYe7RIyL
         p+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682931464; x=1685523464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmY2ej1hy4vAs/f4OlrbKuvNcHo8SUtv7o8IcsrQg3U=;
        b=XRAk8+jJHyzPa6YtOCu+hVYDfTJvEFOZ8R/QlWJSf4cMuN191BvrEFLj6zVLTQb/na
         Qdy7AM15uxjgx1Dfj9VrdJwCybo52y71JNuM6wzURX7By2PKg0l9t+7NDNI6bhJW/puH
         CXTuREZ6bI2An+vUwNmsyoecRKiqsVaGUGegBy8AXPatSHg0uRIyX6GHcerpNzYQ/tIo
         oDw74KwKXIWUlqnHxCbAxOapVV/K2M0cGu6DwHhxpUHf7gOlxrU4vqrrchNEG2mO3xqW
         DhIcTPcp1CjJiS2rB4O6O1riNj/WKtnUUrVWNwdJJOzftxY8tVfhlvk+5MRtMfkMSnv9
         X0vw==
X-Gm-Message-State: AC+VfDwkWhZwlXT8iclTkru+/PFJe09xec5cA0Y8oOqQPi1wWxbXbwPA
        tJDkplA8Ym49fiM3ouH/4L4=
X-Google-Smtp-Source: ACHHUZ4ZH8PKEVHrfl+mAnYFuvD/XiRq5X7wX2j3kcUWhPydZMXAHdnw2f3GWKNJVeq0TJG4FCa0cg==
X-Received: by 2002:a17:902:ce05:b0:1a9:2ae4:6c1e with SMTP id k5-20020a170902ce0500b001a92ae46c1emr13396216plg.4.1682931464296;
        Mon, 01 May 2023 01:57:44 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:b:e11b:15ea:ad44:bde7])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709028c8d00b001a4fe00a8d4sm17407070plo.90.2023.05.01.01.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 01:57:43 -0700 (PDT)
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
Subject: [RFC PATCH V5 10/15] x86/hyperv: Add hyperv-specific handling for VMMCALL under SEV-ES
Date:   Mon,  1 May 2023 04:57:20 -0400
Message-Id: <20230501085726.544209-11-ltykernel@gmail.com>
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

