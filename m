Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC11C623514
	for <lists+linux-arch@lfdr.de>; Wed,  9 Nov 2022 21:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiKIUyi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Nov 2022 15:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiKIUyS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Nov 2022 15:54:18 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C7C27FC2;
        Wed,  9 Nov 2022 12:54:17 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso3077077pjc.2;
        Wed, 09 Nov 2022 12:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dn38defXSzafrqFyjuRL6cm4llsqPTH+TKtsPBjqhmM=;
        b=lfZRX5NGow153M4vN3Z4ZCj49elmfXjCWv5nxlpmQjd0I/CYXnOpbtegjARAeJ3SJg
         xn7rmQO5a5P7JpbRe6+pWM1PfdDxN+TIkfVPNg9mqrJP4CgpkIrHE/hzMuQLbpFpR7hN
         HE/BKsy6gB7wwxHParnSkaocSnsnzpWlkZGMRI479Z9BBKdD2pg7449H68LpexccROn0
         MgGqBvVh7XvKS/IohwBiV4JQjP0fn7Yk2xK24Al16fQ45VIZ1+oLPZ73nnnJd1oz8E3g
         XCGMAQzAOI1PddmTVAjA2v0vmGEUwL2j/xgwEtLHSExoWT89y0WQM/zCxi7sjcxqr5nf
         VMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dn38defXSzafrqFyjuRL6cm4llsqPTH+TKtsPBjqhmM=;
        b=jwbU9J3JgXK9Ke6lTuwWgR+3WLHQpJNDE8XZ5HgbvkpecHTcI2dxvMByPJlXW3gXhJ
         qctz1yUHTOroVP1btNF9WvF3qrOp7AIhNagD2lDYx/aY8M3O0YV8BoGd+QnMXZSyRs7h
         9xVIYIIq6gTf0x4TitGxsEs5PnikQwxj3vXwiKN1Qi3qrzzhOKeVZlM2YmzgzyK39T35
         4mjFhQdt5iCGWNYJ2jHVAocugVXnJh/09jOzQUQhoHarGQec9HSVyWZTRj2cwk8Y+cFE
         aCSJXlCL0vHteL4m94se5Ny0ZZ38NLa8+KOCdCgysSUlHP3iRO65dyWZrIlfNDUVafSz
         4/lA==
X-Gm-Message-State: ACrzQf2BWzgFmj6yLFLzmbnYmcZwvhANM2c/veom05ELVPA4jRZBWwgu
        pvMOquTFLrrn8GTaY/H/UIw=
X-Google-Smtp-Source: AMsMyM7oRzgrO8TTJgQW/ccS2UAoreul+XZbUOvsQD/Z5T3CeksjRX87V1DABGERO8mjy/ZPYyu17w==
X-Received: by 2002:a17:90a:b383:b0:216:df8f:3c3 with SMTP id e3-20020a17090ab38300b00216df8f03c3mr31977635pjr.8.1668027257135;
        Wed, 09 Nov 2022 12:54:17 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:a:c616:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090a108200b002137d3da760sm1633984pja.39.2022.11.09.12.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:54:16 -0800 (PST)
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
Subject: [RFC PATCH 15/17] x86/hyperv: Add hyperv-specific hadling for VMMCALL under SEV-ES
Date:   Wed,  9 Nov 2022 15:53:50 -0500
Message-Id: <20221109205353.984745-16-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109205353.984745-1-ltykernel@gmail.com>
References: <20221109205353.984745-1-ltykernel@gmail.com>
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

