Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CC235E2A5
	for <lists+linux-arch@lfdr.de>; Tue, 13 Apr 2021 17:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346620AbhDMPW7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Apr 2021 11:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346610AbhDMPW5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Apr 2021 11:22:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABECC061574;
        Tue, 13 Apr 2021 08:22:36 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id i4so8643327pjk.1;
        Tue, 13 Apr 2021 08:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iz6kQKmaAStJz2j939/tUEj2NIuTRDYIEtDill+C7IA=;
        b=kPgGShid5KtLdAcFrxnSdrTQ/LbNOifiNeCDVvStk5TPMNbaVeqB0A4C9dJM6BaSgi
         CsrgfmqhC+wVq0PA/+TrV7yVroifmywSMb/s4vV5zdt1ZO5dF7SnTsZZ6S3J54eZq+dZ
         1nap+lP5B7a0E0Zl/TzH4+gs7R76sFtw/YnvNcJTHpVy6lPjaT5mBsHpoIlWhYX2Iu1x
         GZjiAjVOiUHOuWIk6ohqk2lG0kCL4gNFmRNPqKAQQj47DyWuPqoT+yiHh6I4FIDYZFwU
         cC6qcyJh4rmx1onn0MoSYQtGSaEkd5thkDyS3R/eMtQ/XywZymCssTOkPtUH2Aikh4OM
         yQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iz6kQKmaAStJz2j939/tUEj2NIuTRDYIEtDill+C7IA=;
        b=cKW8QpLm3RZbayU6mAc5Kox3VOEoYkmtMgP3ekLYS/F0R1wnoyFgD8q8AfLTQ7rwig
         EQXkWUTOHYBSK8BSy7MzLsiGjag9D+Lg9cbEi3sq/7sbNEpVPIznZFDzNsUf4ytnCTGP
         HY309YQ4liP2dB74IVg1AKbuXJC34AXWs/OhWyVzdGKdecvtZtPfSxUweZJVSQwvZXPP
         I+x1M/3Req+YIELRGHgrpk7X9PhHSwNZgGg27WnPAj5RyVdEi3FsqvpMgiNEby48N2L5
         J/rmMcevtRG6dfJMaUwFFx3JGzHEkB4VQ6CABKmN7DYGrlxfpMwownsKwp2imP/UJznB
         Cngw==
X-Gm-Message-State: AOAM53154lJk/N1A0DZrypAgfa2oLTthYZtUsoEqxvfDpdRmyHRQqYCS
        MlQ1zBMyXotgLDubOMqhLJw=
X-Google-Smtp-Source: ABdhPJwF6x+dCEgMGkpNtT/LK3yQhlUypo9k1WRbpOfhNSHgmT3dnzCHLCpU6JCRmpg9ooV2lxKDgA==
X-Received: by 2002:a17:90b:4d05:: with SMTP id mw5mr559318pjb.236.1618327355626;
        Tue, 13 Apr 2021 08:22:35 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:36:5b29:fe1a:45c9:c61c])
        by smtp.gmail.com with ESMTPSA id y3sm12882026pfg.145.2021.04.13.08.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 08:22:35 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, arnd@arndb.de
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, vkuznets@redhat.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com,
        sunilmut@microsoft.com
Subject: [RFC V2 PATCH 2/12] x86/HV: Initialize shared memory boundary in Isolation VM
Date:   Tue, 13 Apr 2021 11:22:07 -0400
Message-Id: <20210413152217.3386288-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210413152217.3386288-1-ltykernel@gmail.com>
References: <20210413152217.3386288-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V exposes shared memory boundary via cpuid HYPERV_
CPUID_ISOLATION_CONFIG and store it in the shared_gpa_
boundary of ms_hyperv struct. This prepares to share
memory with host for AMD SEV SNP guest.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c |  2 ++
 include/asm-generic/mshyperv.h | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e88bc296afca..aeafd4017c89 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -328,6 +328,8 @@ static void __init ms_hyperv_init_platform(void)
 	if (ms_hyperv.features_b & HV_ISOLATION) {
 		ms_hyperv.isolation_config_a = cpuid_eax(HYPERV_CPUID_ISOLATION_CONFIG);
 		ms_hyperv.isolation_config_b = cpuid_ebx(HYPERV_CPUID_ISOLATION_CONFIG);
+		ms_hyperv.shared_gpa_boundary =
+			(u64)1 << ms_hyperv.shared_gpa_boundary_bits;
 
 		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
 			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index c6f4c5c20fb8..b73e201abc70 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -34,8 +34,19 @@ struct ms_hyperv_info {
 	u32 max_vp_index;
 	u32 max_lp_index;
 	u32 isolation_config_a;
-	u32 isolation_config_b;
+	union
+	{
+		u32 isolation_config_b;
+		struct {
+			u32 cvm_type : 4;
+			u32 Reserved11 : 1;
+			u32 shared_gpa_boundary_active : 1;
+			u32 shared_gpa_boundary_bits : 6;
+			u32 Reserved12 : 20;
+		};
+	};
 	void  __percpu **ghcb_base;
+	u64 shared_gpa_boundary;
 };
 extern struct ms_hyperv_info ms_hyperv;
 
-- 
2.25.1

