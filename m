Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF92B757244
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jul 2023 05:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjGRDYq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jul 2023 23:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjGRDYA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jul 2023 23:24:00 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18538172B;
        Mon, 17 Jul 2023 20:23:22 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a426e70575so2813334b6e.0;
        Mon, 17 Jul 2023 20:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689650602; x=1692242602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0I/GN1swVut2u8gwwzCTgr8mdA5BefsHiacF2Dh1Kwk=;
        b=Xb4B6R3ynym2umsUFxuGCu0WcTP+WZwAHDaNB8j84egirjurOsbBigr1Itn8O1ZkU0
         jTMsLxxogjG6KtbyeVEZ2nbAarYn7CZURH08pmB3LYfXLk3UKASx1PwFfNJqDquKS5qL
         B2jxGQeXj9EO/a1FtDb/2mdHkFy9usUNCBUyA9BCy1x0+/bFCvSj4GjENlwoqe0J9M8m
         zdyl/6+Q8HgB6NGZBWBj01uHxYn6GJ1IRdXtRr+lHd7AC1b7qPpCKWYHR8QHGgEkBjlK
         lylWiLkEfil0sXZejoJWePv5gJOeGP5KiJxJuN9lx1F3oaQ9zC3s6+D1S1NOm7/8MPdV
         paaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689650602; x=1692242602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0I/GN1swVut2u8gwwzCTgr8mdA5BefsHiacF2Dh1Kwk=;
        b=XmUN7X6bp8asqXojQ2sKiBSSETcc+eqNo2NOZiGzAOiWmCCxat7+sltKVfsN5XegNp
         /ZFMRMnNf6Do8YgAbEtF+6eMX6XILvr7BdVOYQT0BOUfIpubx8KFfww8QymQ/s85FAnQ
         9nFgAGeZCB3YVSGduIDLiaoAiC0koObqWIfJH5xFav5OKLjOygNepXbkBgdXSqMB3doD
         Neov4ce/IVVFFy8hiw32DC2SNwVAh3fL0QozNkKLLYGUDjuotG1OSMiwNtPuJdB6t7ji
         COXtzYo7XqmPzLr/BoM4RZ6SMNNLIsFOXuNs3sIwTh6F2puKqfgUYHZEAv/K69J3ngUc
         cbtg==
X-Gm-Message-State: ABy/qLa8S7Sgpf+tI1mxPaN6UFt/2YxctWw20IDO/MI7vYUlBGGLGJc3
        vwUvPKMfTd275CbIYCPjKlQ=
X-Google-Smtp-Source: APBJJlGnK3nLoRwNnXojGTfSDgadrI983B8Sf+lYUd5Dmv/nYJ57v9JGON04uf6naKUnlKHxZa44Pw==
X-Received: by 2002:a05:6808:13cf:b0:3a3:820e:2f05 with SMTP id d15-20020a05680813cf00b003a3820e2f05mr14716706oiw.1.1689650602206;
        Mon, 17 Jul 2023 20:23:22 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:37:c5e9:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id s92-20020a17090a2f6500b00263f41a655esm504040pjd.43.2023.07.17.20.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 20:23:21 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH V3 9/9] x86/hyperv: Add hyperv-specific handling for VMMCALL under SEV-ES
Date:   Mon, 17 Jul 2023 23:23:03 -0400
Message-Id: <20230718032304.136888-10-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230718032304.136888-1-ltykernel@gmail.com>
References: <20230718032304.136888-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

