Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15557676AD2
	for <lists+linux-arch@lfdr.de>; Sun, 22 Jan 2023 03:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjAVCrR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Jan 2023 21:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjAVCqn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 21 Jan 2023 21:46:43 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E414226865;
        Sat, 21 Jan 2023 18:46:27 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id s3so6543468pfd.12;
        Sat, 21 Jan 2023 18:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2L02B2A7h+GqVFqZYCULI5VizKi71tjYmMAIa783a5M=;
        b=GzAqv8fsChpPgHdpFS4rwUbNgCm/BnJAkCSh2+9Po0eYk5or0GObAloMD6l1wKgEZQ
         YFYeZMVxaavRp5loi8tZESQKY5KO99y79Yw0xeJnyZYJ78dhcp6gOO4yIrGqZnl6gHIw
         ZILDnGLmjCr2KyChGNbqos8Vxz/8qNaHOsQwiNSjgVL54l5dMht6UyQNu5IV4oA+QBt4
         vbAJt1pcmGY2s5PtsNgNeZ4IeP3DcdSK3MIAcIN7hCeNkuWdq3/bgPKa8rqDPQMNotu2
         wlXCgQ0AMI6cFBeTu2/Z1jbiVcAa8VPF/4HW8eLuLPDjIa7Y7PJZyjoqO2obSOBqpjp5
         VPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2L02B2A7h+GqVFqZYCULI5VizKi71tjYmMAIa783a5M=;
        b=bSdsiFJABDgrPFvt608yV76tB8Q08g8bClmxakR0BkR06ub8hvVQmhRJehcd/BSLuA
         yHa9FEEQ+nEJAW0W/Cwaoxfdt5Qw7VKtNbzwwkqQWcpzr8jKtOJu95Lr1/tayHk6DLeM
         Ny11WFksQeK/X14JQWd5jIfuhWDMD1GVlz9Z0wMrzBDcaknblzh7RMQ6jKkxZA3Ls3qj
         ufP5rhuborvDj2vtD55pbI5WeT1YjqoP3ItkotxeZFDFTeXXwi9DYQ127bsrxO4m1adh
         HdI5gxecHOdl9OalDu4dg3gknDqZmeCF7dLS2oS/azvdNDv/6oBOZj0P5Kj56nfbChGM
         Krzw==
X-Gm-Message-State: AFqh2kr9rSlkJo7gPhGKLRhlyaFbr0K/5y+N7bdWN3GvSNl7qgfH5TSZ
        sWV6SU9Boe9daKPxF8YqS2c=
X-Google-Smtp-Source: AMrXdXvPzm5jCpAu44quF4Axn/YToNU1y2zNLchkx1CozU9o+0R0H+kf4PfBM04pdt4cgbCmGjuRqg==
X-Received: by 2002:a05:6a00:190e:b0:58b:c1a1:4006 with SMTP id y14-20020a056a00190e00b0058bc1a14006mr25144615pfi.18.1674355586974;
        Sat, 21 Jan 2023 18:46:26 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:36:d4:8b9d:a9e7:109b])
        by smtp.gmail.com with ESMTPSA id b75-20020a621b4e000000b0058ba53aaa75sm18523094pfb.99.2023.01.21.18.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 18:46:26 -0800 (PST)
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
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [RFC PATCH V3 11/16] x86/hyperv: Add hyperv-specific hadling for VMMCALL under SEV-ES
Date:   Sat, 21 Jan 2023 21:46:01 -0500
Message-Id: <20230122024607.788454-12-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230122024607.788454-1-ltykernel@gmail.com>
References: <20230122024607.788454-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 arch/x86/kernel/cpu/mshyperv.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 9d547751a1a7..9f37b51ba94b 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -694,6 +694,20 @@ static bool __init ms_hyperv_msi_ext_dest_id(void)
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
@@ -701,4 +715,6 @@ const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
 	.init.x2apic_available	= ms_hyperv_x2apic_available,
 	.init.msi_ext_dest_id	= ms_hyperv_msi_ext_dest_id,
 	.init.init_platform	= ms_hyperv_init_platform,
+	.runtime.sev_es_hcall_prepare = hv_sev_es_hcall_prepare,
+	.runtime.sev_es_hcall_finish = hv_sev_es_hcall_finish,
 };
-- 
2.25.1

