Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7906E777DD1
	for <lists+linux-arch@lfdr.de>; Thu, 10 Aug 2023 18:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbjHJQNJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Aug 2023 12:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbjHJQNE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Aug 2023 12:13:04 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7352703;
        Thu, 10 Aug 2023 09:04:45 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bbf8cb694aso9441665ad.3;
        Thu, 10 Aug 2023 09:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691683478; x=1692288278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oyq9KI3NurUC1G8S0DuY90VVqt2QiudPjei5bx+xe8I=;
        b=OzwLYJDBajWtJkd2M3jwwzEWK28bhXxlwnwqBRIBLdtT4DVYXxRwl66np/1CXRDtM7
         XOfC3IbH+t/NJNTBRfJMgMbo2FFxptaC717HHYel7YjhvxnB39xBE9K/aQoNdA2GmACM
         J5w7LFnEqVGJJJSqhEycc1sXyUFFps8+zGNZUMmqhO8Wi7wMB8E1kUUuhysD0RO79gFj
         vf8ah+BiwsCOcW28UWj5IQJM4iNWymQfqBOmZDtmKSeqs0ANsGfJsF5fpWpxkQ+Efboq
         gKULvGBR+8q4QDtX7cUVQuHNJRFof9C7TdWxyrO7cbKIXrH/jBKiLrcGq/YIXXcOx2ga
         Kw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691683478; x=1692288278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oyq9KI3NurUC1G8S0DuY90VVqt2QiudPjei5bx+xe8I=;
        b=UpLCvtMJx7ZIAZAGvDfp0SkgwGGdPFfkum3WRKc8fKsWIPeZAq5yGKj/mccp1Iy+Q5
         Uiy7WQ5L2ZiIsKzGzYiRKDDzqmmyGzUhcIaH28ZnNd68LZOEEUfiCSdlJnSJGNMm2EHI
         rsq9LmXRlyNCvt+6cfsoNEzA9DFAcTdwi/E8WPP1oSfw7WK+Ql6S41ic5awz+J2biASo
         E5yjbsMq2nEH5LGafiQPsICB22qiLjAhUqvfJYEnSE7NO7zfzOdQYTdzbZ7PNl305jC4
         QJEscB37pkUoAqsAGy680QcM2PHdUW5TVUX/Q2HZNldGRVYfQ5oWzV3AbI5uXsL6JIXx
         lQdQ==
X-Gm-Message-State: AOJu0YyqhCdE43bXdbYxqhtRwKd7kqwrXaFpLaMMv3E6+DOIJsZ1yKkG
        vpMQ8nKoVyjoaNiezTpNA2w=
X-Google-Smtp-Source: AGHT+IE4Xa4wOT0nieJaoHtOa/yBw1xJy7SkPhn6cJeu8e/icU8oDEov1HRquIfSibkVFGy5WzCGYg==
X-Received: by 2002:a17:902:8688:b0:1b9:c205:a876 with SMTP id g8-20020a170902868800b001b9c205a876mr2395865plo.29.1691683478550;
        Thu, 10 Aug 2023 09:04:38 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:0:c620:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id r4-20020a1709028bc400b001b895a17429sm1948821plo.280.2023.08.10.09.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:04:35 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH V5 8/8] x86/hyperv: Add hyperv-specific handling for VMMCALL under SEV-ES
Date:   Thu, 10 Aug 2023 12:04:11 -0400
Message-Id: <20230810160412.820246-9-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230810160412.820246-1-ltykernel@gmail.com>
References: <20230810160412.820246-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <tiala@microsoft.com>

Add Hyperv-specific handling for faults caused by VMMCALL
instructions.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index c2ccb49b49c2..b7d73f3107c6 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -32,6 +32,7 @@
 #include <asm/nmi.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/numa.h>
+#include <asm/svm.h>
 
 /* Is Linux running as the root partition? */
 bool hv_root_partition;
@@ -574,6 +575,22 @@ static bool __init ms_hyperv_msi_ext_dest_id(void)
 	return eax & HYPERV_VS_PROPERTIES_EAX_EXTENDED_IOAPIC_RTE;
 }
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
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
+#endif
+
 const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
 	.name			= "Microsoft Hyper-V",
 	.detect			= ms_hyperv_platform,
@@ -581,4 +598,8 @@ const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
 	.init.x2apic_available	= ms_hyperv_x2apic_available,
 	.init.msi_ext_dest_id	= ms_hyperv_msi_ext_dest_id,
 	.init.init_platform	= ms_hyperv_init_platform,
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	.runtime.sev_es_hcall_prepare = hv_sev_es_hcall_prepare,
+	.runtime.sev_es_hcall_finish = hv_sev_es_hcall_finish,
+#endif
 };
-- 
2.25.1

