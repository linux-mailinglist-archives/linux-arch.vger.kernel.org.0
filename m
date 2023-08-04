Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EB577046C
	for <lists+linux-arch@lfdr.de>; Fri,  4 Aug 2023 17:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjHDPX4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Aug 2023 11:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjHDPX3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Aug 2023 11:23:29 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7A34C1C;
        Fri,  4 Aug 2023 08:23:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8ad907ba4so16168495ad.0;
        Fri, 04 Aug 2023 08:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691162590; x=1691767390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/yjG/PXeGWCnCPze9ZC5SK1hTOJifDNU3KSq+GeaZI=;
        b=pQ5JeQT0gkKlesiR3SfkcGZoESOHrjYICqueH+rLk2diLzhzUtwBpj19beaCMMPVPD
         aMx6NVTRUUSi4CoWMJA1S/jcIEknZ5g0wBCR3/t0MPUGmVbYgqv7lECvDc4lqfIuQVgt
         DNnLVr/j08uynTSuupzrYxxawblH7P1s1mwMw8EO6QYEiIwL3P2FZ1X4FdZNALv73FyF
         RKHnsUhJjrgc4QZVCKSDGGQbKc5t3Zr2RWQ4eewfTf+yc+FrVw/cIcHSjKdwtk3yBPmp
         AKFdpwYqMD17LoEPsEcUh3mOpKqvWmuciQnEMF16bkl0BZ5qv9u0hlqDpwBi8mJcEK2q
         GBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691162590; x=1691767390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/yjG/PXeGWCnCPze9ZC5SK1hTOJifDNU3KSq+GeaZI=;
        b=OhSu8Bp8J2f90B0gArx1J6LuL3CbP1lchVKXFwK4Xh16Fpi0j0uyTyrS7CWWmqtNFG
         yCbZ90D6m6qKqtnSro/tIdZzlqT4BOzKYWposnGJixBSH/uA1JgCkHjh2yx+5fAAhyqt
         tGrHz42B5hM6SUPooZgmwzNykCSbah/g+hbfCZPEsFp2gzJ9xBQz9h+w4gDIEHdWyAPi
         L9nhPEOKb2r792NowBklnWeBw+EJLYW1gVFJCCpYRBN5XuLeDFJD7m6B1CNiiZJxc6O3
         ubKLbuKtQL0jPVjEAfEwG2DKRxqOJPfst/adQs8n9VWy63hnCyZlfCBT0buP5cWbL43n
         phBw==
X-Gm-Message-State: AOJu0YykO0qCGfKQBZRcJDnTEHA6fBy3HLF7Ua1B/vCxYH17reraKPo4
        2Ux13P3Kuz+hOg4pAWgaIU0=
X-Google-Smtp-Source: AGHT+IHHZBPuuGgTSzCmC7wOFpK7Iovcvz6mHzS8HZhgpOaiNDGO+g/ZRyI4flrVaIhF+J53/41UTA==
X-Received: by 2002:a17:902:c405:b0:1bb:a85f:4645 with SMTP id k5-20020a170902c40500b001bba85f4645mr2389099plk.15.1691162590133;
        Fri, 04 Aug 2023 08:23:10 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:f:a0bf:7946:90be:721b])
        by smtp.gmail.com with ESMTPSA id s21-20020a170902989500b001aaf2e8b1eesm1891325plp.248.2023.08.04.08.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 08:23:09 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH V4 8/9] x86/hyperv: Add hyperv-specific handling for VMMCALL under SEV-ES
Date:   Fri,  4 Aug 2023 11:22:52 -0400
Message-Id: <20230804152254.686317-9-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230804152254.686317-1-ltykernel@gmail.com>
References: <20230804152254.686317-1-ltykernel@gmail.com>
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
 arch/x86/kernel/cpu/mshyperv.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index c2ccb49b49c2..29e836b950e1 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -32,6 +32,7 @@
 #include <asm/nmi.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/numa.h>
+#include <asm/svm.h>
 
 /* Is Linux running as the root partition? */
 bool hv_root_partition;
@@ -574,6 +575,20 @@ static bool __init ms_hyperv_msi_ext_dest_id(void)
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
@@ -581,4 +596,6 @@ const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
 	.init.x2apic_available	= ms_hyperv_x2apic_available,
 	.init.msi_ext_dest_id	= ms_hyperv_msi_ext_dest_id,
 	.init.init_platform	= ms_hyperv_init_platform,
+	.runtime.sev_es_hcall_prepare = hv_sev_es_hcall_prepare,
+	.runtime.sev_es_hcall_finish = hv_sev_es_hcall_finish,
 };
-- 
2.25.1

