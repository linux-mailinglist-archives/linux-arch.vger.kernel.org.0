Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAFA77E5DC
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 18:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344500AbjHPP7j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Aug 2023 11:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344518AbjHPP7S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 11:59:18 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0E72D4B;
        Wed, 16 Aug 2023 08:59:05 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf078d5f33so2084575ad.3;
        Wed, 16 Aug 2023 08:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692201544; x=1692806344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oyq9KI3NurUC1G8S0DuY90VVqt2QiudPjei5bx+xe8I=;
        b=fn+7szNFLJ7B2fCHmXj5A4B26YXulifd8l00n5xECuLXlR17RuT0pUyQCeu+hgdOyZ
         mSr8sqlY8jlKb8nfNMQsuodtAhmfxO6kcc1SQhj07kOEO/rXiJGyCb6fBuIflmXAAHlp
         1fJo36kOa1d4EliCgoanxELBXZiPJWQQCQ3jrVRAM0gGdusUlbENb2punRgWE9M6kead
         j96dhPuTzsgk7ip81LZo1j6LKAx+5vbNLBzpOy/ygQccZDnmw9dyqYWI7tjjXGUG648A
         JaRJvIInTc/1nohyw0NEn9lur76Aharvhk8tA3m5vPFhkskPbsioSTFmxuGW+ZmU8lAg
         Q7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692201544; x=1692806344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oyq9KI3NurUC1G8S0DuY90VVqt2QiudPjei5bx+xe8I=;
        b=ckEhQGDO1Mx0KiOy2ZkQTaR1Wz6dQS6+0p3F0vdQYKx9YvJg4jkuLCO0yeUVt6kWIP
         Mp5kk5sw1AtSzIRDUEaWk8zmA+Z1rA2Jl3R1CIIS4NMkd2TcCMZwSm9kPZOBgg1fsYO+
         Iwm/q49jqg5sqYzANARtOd6MOa3MwPCcRpbp1iZJub55iItGGisFTy/OEt0jdKeFPJv9
         j/dIgZFzlyATOQ2CrhuJRQOnrkzQ6s58PKFZ99M1RqA6zr+H6NPUSVAAr2rvBQwsoQ5h
         +G1uTkh7XBsNzljLh2SzCcUPoPpuZFgi3TaP4lDvIEvbwPlEvFW/Yq6iBnajaR4cpP6U
         r62A==
X-Gm-Message-State: AOJu0YwNesamHm/eSgiOJZ60kFZEhrd/Gx0DX/gv8dS7Pg6BDLrcuxMt
        5MMTjIqR5CeIKiWQaMANwso=
X-Google-Smtp-Source: AGHT+IGPm8/54I+WSetL6xPW3f3htkirKcOG2+oU3Oqcm4g01axknIbIaWIbfIb1hwrIskZZicQ0qw==
X-Received: by 2002:a17:902:bd89:b0:1bb:77a2:edda with SMTP id q9-20020a170902bd8900b001bb77a2eddamr2150365pls.36.1692201544645;
        Wed, 16 Aug 2023 08:59:04 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:0:e588:8d80:9ae5:5adc])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f7d100b001bc930d4517sm13366973plw.42.2023.08.16.08.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:59:04 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v6 8/8] x86/hyperv: Add hyperv-specific handling for VMMCALL under SEV-ES
Date:   Wed, 16 Aug 2023 11:58:49 -0400
Message-Id: <20230816155850.1216996-9-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816155850.1216996-1-ltykernel@gmail.com>
References: <20230816155850.1216996-1-ltykernel@gmail.com>
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

