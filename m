Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD5071A24C
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 17:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbjFAPRS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jun 2023 11:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbjFAPQ5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 11:16:57 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBD4E2;
        Thu,  1 Jun 2023 08:16:39 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d18d772bdso1147379b3a.3;
        Thu, 01 Jun 2023 08:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685632599; x=1688224599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jE+k1UTIit7JT0AsPVhsyBlvHXp2Xy2teL4EcNLD10=;
        b=T43yoxLQeZsGBa0LF/z1Zz8gR4MDHsXWysyPasZASl2BGpsDCiIrQJUlMT/IpkUTGD
         QjtbfPJFmp1KmpDgc1eknNAK/dJsSdYLxSbFW4V7bdayqtLILQdHHTLhi5EC8VwEqHqd
         TMtosofs7NXCQ/O65ydHOJ1YhjmYl3HVU1sxWuj9SH0Ycbr4Ipz3KQIjQ60HkednKruY
         q5FrRg4MApwH3VJA45648peiKQMMqciE8UwU5TruVs01Fr2KOM0Am8PKibLEA/5jTyV2
         G6too/CUHm3pfYIz0O6PGMq6mklfRUicrrQQF5cE+cBROkl9NgriH+6REjRJ0RaCwfhK
         +flg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685632599; x=1688224599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jE+k1UTIit7JT0AsPVhsyBlvHXp2Xy2teL4EcNLD10=;
        b=cvhSglHXm7Gqub9TAXGY85YvD9IktwtfEm/Zj0coqQUgnEmIdSPXTh9wDrDiCeCRm4
         lhieB0FLPHtWLQBIJREQvynIwKTF2kLJvxomWsOd1u32z5YmE8pKTxJwMOLEHk23qqc+
         gqmCP2roC+oRzQW5QzENopNnwe4CMe7eay5dDPeCJa/Cx6LQM48Hj9aMAmr4++iwIIrR
         dYWjd3+ZP9mjEcSWO9Z7mzdsz90VTdm8DSdOnQ1Bg80uidbAAiCFTsp3X1zejuW9VMPq
         I371/dMRS7IldSR8F+jXV1MR61N69+j/W+ADlJAWdPwatWSJZh2WY5sYO2GAWmMEr2fy
         TsIg==
X-Gm-Message-State: AC+VfDz89ZSfnNjVFMKWW3YiSItgWycbfY/d8JHd/KLEDMPXArmNCZTC
        K1Monhp1PvAlGOBNNOGRGGU=
X-Google-Smtp-Source: ACHHUZ63mBt8AeJI0ha3qrB3e8ysWv/PWDRVOIO61LLiFPoJ/OwV5gynTcTBpY4JrrNegn6A2RAjZw==
X-Received: by 2002:a05:6a00:1144:b0:64d:4412:9923 with SMTP id b4-20020a056a00114400b0064d44129923mr10244426pfm.3.1685632599182;
        Thu, 01 Jun 2023 08:16:39 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:9:e0c3:5ec1:4a35:2168])
        by smtp.gmail.com with ESMTPSA id f3-20020a635543000000b0051b460fd90fsm3282639pgm.8.2023.06.01.08.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 08:16:38 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH 9/9] x86/hyperv: Add hyperv-specific handling for VMMCALL under SEV-ES
Date:   Thu,  1 Jun 2023 11:16:22 -0400
Message-Id: <20230601151624.1757616-10-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601151624.1757616-1-ltykernel@gmail.com>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
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
index fd37f47de134..eaa98100f354 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -32,6 +32,7 @@
 #include <asm/nmi.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/numa.h>
+#include <asm/svm.h>
 
 /* Is Linux running as the root partition? */
 bool hv_root_partition;
@@ -576,6 +577,20 @@ static bool __init ms_hyperv_msi_ext_dest_id(void)
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
@@ -583,4 +598,6 @@ const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
 	.init.x2apic_available	= ms_hyperv_x2apic_available,
 	.init.msi_ext_dest_id	= ms_hyperv_msi_ext_dest_id,
 	.init.init_platform	= ms_hyperv_init_platform,
+	.runtime.sev_es_hcall_prepare = hv_sev_es_hcall_prepare,
+	.runtime.sev_es_hcall_finish = hv_sev_es_hcall_finish,
 };
-- 
2.25.1

