Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB08630B77
	for <lists+linux-arch@lfdr.de>; Sat, 19 Nov 2022 04:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbiKSDsh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 22:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiKSDra (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 22:47:30 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFF5BF803;
        Fri, 18 Nov 2022 19:46:58 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d192so6681472pfd.0;
        Fri, 18 Nov 2022 19:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dn38defXSzafrqFyjuRL6cm4llsqPTH+TKtsPBjqhmM=;
        b=U9SmzWmMPdi+GTCOWAVMDuYMa2ra4/VmRWt71/144RtiJ/lAeGqiEUf9zUG9O851GN
         TJTrQSmKkbDgG/zbFAqoVnUE47fp9hSqWBdJQ6Fv//j/0fK8ihzrAneaDGhjiq7frp5M
         BsyLUZGfsDZWfuQ0XBXbjpn/lAcw+PpQBFDlfCq/3XnaRu4NVibrG5xg2/87bDApaG+M
         MZI+e9CkPlIpOjgQ6vQELW1E1GVk/PdEN1xDcCy9P/gOPJJkUxelSA9qe3lJOc0FMnq+
         6Jl2i1NzBcSaiRzkNyEIKXum6edHYgSDykoZklpFl2nInrceTYIdMfvfSOpN3HutCEGK
         moWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dn38defXSzafrqFyjuRL6cm4llsqPTH+TKtsPBjqhmM=;
        b=HhbLCJDiTGgDWgmMaQQoZIjDmE0h6Dngl4GQDTTe457bmZvDlwoG2vGgmizjtZ0koa
         iuVssxUCUtTGfEJ+lDFwZXn8bb9s+jwdn/D7r5HzdY1erC/QnpNF2nyh21VBAb+r3Kbd
         NtNxtXhozTjxEGeuRWQ9kncrOEc930VnGYeHhSQfdJFvstAdyIKnk/4K5XhuygYQ7YCJ
         252yYFxjS3vSCMfswDYKD2ttsUg7WVGwdhLwgvhCxu6vI2ADHYmWRL9UGRyeqFoeHlQn
         wtNcfXx/9iVy/qAclBNd+3CNAMc+YEXMwB4fDygCwwMbpDeMwoQRusSrH+7Z8ylYt1Be
         DWZg==
X-Gm-Message-State: ANoB5pkfK+wjjK36MbohjrCeu7D0FZv4AcfuBVkERGIXMMUHs1ubhSbl
        XIkL/RclgllYCt8tAdlKmVc=
X-Google-Smtp-Source: AA0mqf5+5sUTrnmfWZqryMJVyu9lhL8pbYtiSGhKCtpMEVtjuBaAVD20Qoa02B7aO8gczuxUSv/olg==
X-Received: by 2002:a63:48b:0:b0:43b:f6df:3356 with SMTP id 133-20020a63048b000000b0043bf6df3356mr9461903pge.352.1668829617938;
        Fri, 18 Nov 2022 19:46:57 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:38:f087:1794:92c5:f8f0])
        by smtp.gmail.com with ESMTPSA id e5-20020a056a0000c500b005360da6b26bsm3913892pfj.159.2022.11.18.19.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:46:57 -0800 (PST)
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
Subject: [RFC PATCH V2 14/18] x86/hyperv: Add hyperv-specific hadling for VMMCALL under SEV-ES
Date:   Fri, 18 Nov 2022 22:46:28 -0500
Message-Id: <20221119034633.1728632-15-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221119034633.1728632-1-ltykernel@gmail.com>
References: <20221119034633.1728632-1-ltykernel@gmail.com>
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
index b266f648e5cd..a4e526378603 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -725,6 +725,20 @@ static bool __init ms_hyperv_msi_ext_dest_id(void)
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
@@ -732,4 +746,6 @@ const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
 	.init.x2apic_available	= ms_hyperv_x2apic_available,
 	.init.msi_ext_dest_id	= ms_hyperv_msi_ext_dest_id,
 	.init.init_platform	= ms_hyperv_init_platform,
+	.runtime.sev_es_hcall_prepare = hv_sev_es_hcall_prepare,
+	.runtime.sev_es_hcall_finish = hv_sev_es_hcall_finish,
 };
-- 
2.25.1

