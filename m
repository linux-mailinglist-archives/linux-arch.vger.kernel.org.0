Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0CF35E2A0
	for <lists+linux-arch@lfdr.de>; Tue, 13 Apr 2021 17:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346607AbhDMPW5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Apr 2021 11:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346590AbhDMPWz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Apr 2021 11:22:55 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3F2C061756;
        Tue, 13 Apr 2021 08:22:35 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so10885244pjb.0;
        Tue, 13 Apr 2021 08:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OsFA5UjGBBz+WpI+wHtQ7Mb2J7cYrRLymhsyTS1f9mI=;
        b=JrcobaZDDwC9TB1ZnbPW35j8Vme+SwTlWiFYuy59XcI87a/DvDQgx5pbrraPfhV/kU
         uV2sY9oBmeqq0R71Qj5gq/HQOowmpKwwvK3anuoL0oJydWOEIOajZN3KWoA3ZB5kHMSs
         HR1mzue6YbH5Jk1HhfeNFQ/zcfTQMoaiCxN2SVkYSskhRCdDn2O0t5O1VvA3HmmdlXQq
         4PNFYGO8KNhLVmy6da90D0Q82K7H6kDjkH07ogundriqUFZHxMR/S8VyV8vhjU3P8nxH
         X24b18DXbVhuxM8W7iPMlU3ijzck9wnFV182D2NM9w0EIMiUTuU8GerB1r36MFoqCJad
         Kn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OsFA5UjGBBz+WpI+wHtQ7Mb2J7cYrRLymhsyTS1f9mI=;
        b=WCx3F7o/NENh+MQzIm3wJpSSiLdjpuKlOkjT0bHEeluvxEOxcVJ+KVa0nsvmNPRnl7
         xaDxsXuXNf1sqNEAkWvUAHaOv4dFRlfoJnFjMUIuHcVQs+WPhwr2Qh9Pl5DyIELHclEC
         mMhY5Aw0ngst3EnQV7JR8mhST30rjWBmVBY19zCYFwRL+wb2zcaDo/9kM6UZuHhabORW
         OUHpDEG7PZ0Z/Brg7yKBkUSXPUwNjqDb+hyvuueVer39G48dlonk3qnj9V4SN7zdSKj2
         8+AFB00NLnczqd51TmR5C/OwGZRxrtfIveiaUuld4sIeqr+sxQVvv/Rnc20cXpQp2ylS
         WHKQ==
X-Gm-Message-State: AOAM531q+/jCXe/WQ27SNBohbiQQG0rj2SYLz1f4xqvP+7TEmPm9s3nA
        xNLn3ZyG1vV1vEUpgq29M9E=
X-Google-Smtp-Source: ABdhPJyhplndaR4BCEof1JxWUG16TVe7ZB4+7tqGiS85BUIgMxeHMO9r+DG0kEYpyhF8yic69dVBnw==
X-Received: by 2002:a17:902:e8c1:b029:e9:3c98:2dd2 with SMTP id v1-20020a170902e8c1b02900e93c982dd2mr32763689plg.17.1618327354633;
        Tue, 13 Apr 2021 08:22:34 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:36:5b29:fe1a:45c9:c61c])
        by smtp.gmail.com with ESMTPSA id y3sm12882026pfg.145.2021.04.13.08.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 08:22:34 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, arnd@arndb.de
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, vkuznets@redhat.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com,
        sunilmut@microsoft.com
Subject: [RFC V2 PATCH 1/12] x86/HV: Initialize GHCB page in Isolation VM
Date:   Tue, 13 Apr 2021 11:22:06 -0400
Message-Id: <20210413152217.3386288-2-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210413152217.3386288-1-ltykernel@gmail.com>
References: <20210413152217.3386288-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V exposes GHCB page via SEV ES GHCB MSR for SNP guest
to communicate with hypervisor. Map GHCB page for all
cpus to read/write MSR register and submit hvcall request
via GHCB.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 arch/x86/hyperv/hv_init.c      | 52 +++++++++++++++++++++++++++++++---
 include/asm-generic/mshyperv.h |  1 +
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 0db5137d5b81..90e65fbf4c58 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -82,6 +82,9 @@ static int hv_cpu_init(unsigned int cpu)
 	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
 	void **input_arg;
 	struct page *pg;
+	u64 ghcb_gpa;
+	void *ghcb_va;
+	void **ghcb_base;
 
 	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
 	pg = alloc_pages(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL, hv_root_partition ? 1 : 0);
@@ -128,6 +131,17 @@ static int hv_cpu_init(unsigned int cpu)
 		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, val);
 	}
 
+	if (ms_hyperv.ghcb_base) {
+		rdmsrl(MSR_AMD64_SEV_ES_GHCB, ghcb_gpa);
+
+		ghcb_va = ioremap_cache(ghcb_gpa, HV_HYP_PAGE_SIZE);
+		if (!ghcb_va)
+			return -ENOMEM;
+
+		ghcb_base = (void **)this_cpu_ptr(ms_hyperv.ghcb_base);
+		*ghcb_base = ghcb_va;
+	}
+
 	return 0;
 }
 
@@ -223,6 +237,7 @@ static int hv_cpu_die(unsigned int cpu)
 	unsigned long flags;
 	void **input_arg;
 	void *pg;
+	void **ghcb_va = NULL;
 
 	local_irq_save(flags);
 	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
@@ -236,6 +251,13 @@ static int hv_cpu_die(unsigned int cpu)
 		*output_arg = NULL;
 	}
 
+	if (ms_hyperv.ghcb_base) {
+		ghcb_va = (void **)this_cpu_ptr(ms_hyperv.ghcb_base);
+		if (*ghcb_va)
+			iounmap(*ghcb_va);
+		*ghcb_va = NULL;
+	}
+
 	local_irq_restore(flags);
 
 	free_pages((unsigned long)pg, hv_root_partition ? 1 : 0);
@@ -372,6 +394,9 @@ void __init hyperv_init(void)
 	u64 guest_id, required_msrs;
 	union hv_x64_msr_hypercall_contents hypercall_msr;
 	int cpuhp, i;
+	u64 ghcb_gpa;
+	void *ghcb_va;
+	void **ghcb_base;
 
 	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
 		return;
@@ -432,9 +457,24 @@ void __init hyperv_init(void)
 			VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_ROX,
 			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
 			__builtin_return_address(0));
-	if (hv_hypercall_pg == NULL) {
-		wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
-		goto remove_cpuhp_state;
+	if (hv_hypercall_pg == NULL)
+		goto clean_guest_os_id;
+
+	if (hv_isolation_type_snp()) {
+		ms_hyperv.ghcb_base = alloc_percpu(void *);
+		if (!ms_hyperv.ghcb_base)
+			goto clean_guest_os_id;
+
+		rdmsrl(MSR_AMD64_SEV_ES_GHCB, ghcb_gpa);
+		ghcb_va = ioremap_cache(ghcb_gpa, HV_HYP_PAGE_SIZE);
+		if (!ghcb_va) {
+			free_percpu(ms_hyperv.ghcb_base);
+			ms_hyperv.ghcb_base = NULL;
+			goto clean_guest_os_id;
+		}
+
+		ghcb_base = (void **)this_cpu_ptr(ms_hyperv.ghcb_base);
+		*ghcb_base = ghcb_va;
 	}
 
 	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
@@ -499,7 +539,8 @@ void __init hyperv_init(void)
 
 	return;
 
-remove_cpuhp_state:
+clean_guest_os_id:
+	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
 	cpuhp_remove_state(cpuhp);
 free_vp_assist_page:
 	kfree(hv_vp_assist_page);
@@ -528,6 +569,9 @@ void hyperv_cleanup(void)
 	 */
 	hv_hypercall_pg = NULL;
 
+	if (ms_hyperv.ghcb_base)
+		free_percpu(ms_hyperv.ghcb_base);
+
 	/* Reset the hypercall page */
 	hypercall_msr.as_uint64 = 0;
 	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index dff58a3db5d5..c6f4c5c20fb8 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -35,6 +35,7 @@ struct ms_hyperv_info {
 	u32 max_lp_index;
 	u32 isolation_config_a;
 	u32 isolation_config_b;
+	void  __percpu **ghcb_base;
 };
 extern struct ms_hyperv_info ms_hyperv;
 
-- 
2.25.1

