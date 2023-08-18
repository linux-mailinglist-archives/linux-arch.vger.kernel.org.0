Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF973780A22
	for <lists+linux-arch@lfdr.de>; Fri, 18 Aug 2023 12:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376303AbjHRKaG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Aug 2023 06:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376264AbjHRK3g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2023 06:29:36 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01E4273C;
        Fri, 18 Aug 2023 03:29:34 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bcad794ad4so5849665ad.3;
        Fri, 18 Aug 2023 03:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692354574; x=1692959374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DnnhOE4bu9200LOu4wzMzLwwowVrfU+l1Oc5QLPUw0=;
        b=CrAew059PvN32BuoRfvYcuKsfaSnVYJFhk2X1KtHMoxYVRYGhcapVGspJ+hsqzYurl
         9mEhVWpizCYqCMXiRq2cCBXCKELlWyfR/ZLnsMMoFNaXcNMBKyWHpSXw8B0ujJzOtl00
         o2OQpkAeBzLMVSTC//xgOgFTntZJjRz7WltjdCQz/08eALqZeHftJAPJ1IcfkQfi5mel
         1rydKvUUGEU3xtLEmD0+48rc4xnumjkWdMt6acDA68f0eehTTGzF2orMcLJpeAwwZ5Y0
         vMnawIZJyF+0qKBcQIiNgbHloPrfPnUAwHJmIq0qdkaQgsk2lKHwUqBv2aWsJ1dyEnFe
         chPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692354574; x=1692959374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DnnhOE4bu9200LOu4wzMzLwwowVrfU+l1Oc5QLPUw0=;
        b=ZYCwlNOjDZ9zxY40zaEJa1KmNqVJ+u1yExnY0yo45V6wvIh4ZLJ/BQ2U8qOlvTfQ1k
         zblegFXHbqMzCu2+OwLPHbtrdyEWOjHQAAbgTMMMBRutaJkCQYEx6cptEgRDnaqZxJ33
         HuuVTnna0QpHLzLJWQ/6Hgki7duRsMCAH1rlUPEHYPKvBkMrapazMAg76WUTmMg8YnP4
         IkqEGlFj89YtWYPgLXV8H+0Kyb6VWsnFJTP+NwZdqPxOPOhUXZGjmHl4+we6vLcenL/K
         5j6K/OzGuN/dBm6muaFENPGUze/cnjiRNdMillrmfOfERUG5g69N2y4pzYEmz+zmIWSx
         LmQw==
X-Gm-Message-State: AOJu0Ywkzy4NFm8i/DtLFu2PncyyC5UFWKZCoPFM/NhQjwjO/geUg2g6
        oyl/BLs9yS8zec03OTJCOCY=
X-Google-Smtp-Source: AGHT+IF1laguaPanx0hW5wS9Lca+aCWhhfbxKDfUAuOHs6LmiTQMJdxrKmSDWZWa7UiJBoNpXoIfEw==
X-Received: by 2002:a17:902:da85:b0:1b0:3637:384e with SMTP id j5-20020a170902da8500b001b03637384emr2459356plx.25.1692354574109;
        Fri, 18 Aug 2023 03:29:34 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:7:4545:4938:97f0:2e1f])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090274c100b001b9be79729csm1386766plt.165.2023.08.18.03.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 03:29:33 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v7 8/8] x86/hyperv: Add hyperv-specific handling for VMMCALL under SEV-ES
Date:   Fri, 18 Aug 2023 06:29:18 -0400
Message-Id: <20230818102919.1318039-9-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818102919.1318039-1-ltykernel@gmail.com>
References: <20230818102919.1318039-1-ltykernel@gmail.com>
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

Reviewed-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index c56fc151b8db..26b9fcabd7d9 100644
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

