Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814C473F2BC
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 05:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjF0D3I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 23:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjF0D2W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 23:28:22 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8392126;
        Mon, 26 Jun 2023 20:23:05 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-54fb23ff7d3so1993391a12.0;
        Mon, 26 Jun 2023 20:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687836184; x=1690428184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOH4gSPEIhpTW98QIj0wv6cpCR35fy8xVOmhHBHDwaY=;
        b=ANaNPobi1LlQxW0wdCG0Glnw3AHYwUIa8Qg4DBjBLvScG0WBKr8qCsf7Mz+18u/WU3
         6dnIcVY47eOtyjpkaJW2cwyZTRkxtt7WjcP/1r2C0JYR4nlZbgTajeasbRLIeXdjnpSr
         pgJH+0iCGnFXJZLFj9ubxwQZlVh4ApQop/80AwlYke3TSc+1HoTIcvK2Zd16Aa9T/UoJ
         aGzVTEb5uixiEWDzFa45ZsAj19OfxlC6Vgvv3g8/E5CrvvsVDH0Uf6cISC2eKl79G1MX
         o8q2alCiD3y1+06C69O4r2j5dX0F85D1sY52ObLUgxLFJWE3Iw+tDzOboKE2N/izIfNQ
         1juQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687836184; x=1690428184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOH4gSPEIhpTW98QIj0wv6cpCR35fy8xVOmhHBHDwaY=;
        b=QozppQlYoYy/1RyqNBMof2wLBCn+nw5LmSRh44AhD92KPT3+IBF/tJYRB3kf0yQg2T
         szVu3GVp4kTnXIO2gCv+Q6NPKi6WZd3nECeUPeKj8MR+7gQU72AVo836OOytkcEdWjo1
         ynR6f+5vrVfVessoJcDIlUICmr8G0LPw51XCIbCepNC2qb4mwPJs1PEJq+f9AONuhLQX
         HsQSmK7wIIZKyvEMozc/993M/qvMAh4ATrLkG/Uvn/Md9UwA4opkHmK+F/R6xp4ov49g
         QK/Fniw/pjWHQLCWk41EYnE2gnb2t3uIrLoPWD4/PiGhjzxqG62yr9zZrt+e2WKjiG3F
         qvlQ==
X-Gm-Message-State: AC+VfDxCTL7rGs6XmZCFC7L296/xXnXxsCn9jLGANa2wjt0QtsY3cG7R
        /qlxkRsKJsAQMMSWAePurQA=
X-Google-Smtp-Source: ACHHUZ649XFt14nTD0RKbS7T8HGDXk/ibxTGnSCTsUZF4ntA/4vA54PzrAunHYoMJoD3+SXkrRSECw==
X-Received: by 2002:a17:90a:1906:b0:25e:ae0f:7311 with SMTP id 6-20020a17090a190600b0025eae0f7311mr20920818pjg.23.1687836184513;
        Mon, 26 Jun 2023 20:23:04 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:37:c5e9:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id mm12-20020a17090b358c00b0025ec54be16asm618756pjb.2.2023.06.26.20.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:23:04 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V2 9/9] x86/hyperv: Add hyperv-specific handling for VMMCALL under SEV-ES
Date:   Mon, 26 Jun 2023 23:22:47 -0400
Message-Id: <20230627032248.2170007-10-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230627032248.2170007-1-ltykernel@gmail.com>
References: <20230627032248.2170007-1-ltykernel@gmail.com>
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
index 8e1d9ed6a1e0..ba9a3a65f664 100644
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

